# -*- coding: utf-8 -*-

import os
import pathlib
import re
import tempfile
import zipfile
import logging
import subprocess

from typing import Union, List, Dict
from lxml import etree as ElementTree

namespaces = {"opf": "http://www.idpf.org/2007/opf", "epub": "http://www.idpf.org/2007/ops", "html": "http://www.w3.org/1999/xhtml"}


def epub_as_file(source: str) -> Union[tempfile._TemporaryFileWrapper, str]:
    """Return the EPUB as a temporary file

    Args:
        source (str): The source of the epub. Either a directory or a file.

    Returns:
        tempfile._TemporaryFileWrapper | str | None: The path of the generated epub file, the original epub file, or None if the source is not a valid epub.
    """

    if os.path.isfile(source):
        if not is_epub(source):
            raise ValueError(f"{source} is a file but it is not an EPUB file")
        else:
            return source

    # create the temporary directory for the file
    temp_obj_file = tempfile.NamedTemporaryFile(suffix=".epub")

    # source as a Path object
    dirpath = pathlib.Path(source)

    # zip directory according to the EPUB OCF specification
    with zipfile.ZipFile(temp_obj_file.name, "w") as archive:
        mimetype = dirpath / 'mimetype'
        if not os.path.isfile(str(mimetype)):
            with open(str(mimetype), "w", encoding="us-ascii") as mimetype_file:
                logging.debug("creating mimetype file")
                mimetype_file.write("application/epub+zip")
        logging.debug("zipping: mimetype")
        archive.write(str(mimetype), 'mimetype', compress_type=zipfile.ZIP_STORED)
        for path in dirpath.rglob('*'):
            relative = str(path.relative_to(dirpath))
            if relative == "mimetype":
                continue
            logging.debug("zipping: " + relative)
            archive.write(str(path), relative, compress_type=zipfile.ZIP_DEFLATED)

    return temp_obj_file


def epub_as_directory(source: str) -> Union[tempfile.TemporaryDirectory, str]:
    """Return the EPUB as a temporary directory

    Args:
        source (str): The source of the epub. Either a directory or a file.

    Returns:
        tempfile.TemporaryDirectory | str | None: The path of the generated epub directory, the original epub directory, or None if the source is not a valid epub.
    """
    if os.path.isdir(source):
        if not is_epub(source):
            raise ValueError(f"{source} is a directory but it is not a EPUB fileset")
        else:
            logging.info(f"{source} is a directory")
            return source

    temp_obj_dir = tempfile.TemporaryDirectory()

    with zipfile.ZipFile(source, "r") as zip_ref:
        try:
            logging.info(f"Extracting {source} to {temp_obj_dir.name}")
            zip_ref.extractall(temp_obj_dir.name)
        except EOFError:
            logging.exception("An error occured when reading the ZIP file")

    return temp_obj_dir


def is_epub(source: str) -> bool:
    logging.info("Checking that the input seems to be a nordic EPUB…")

    required_files = ["META-INF/container.xml", "mimetype", "EPUB/package.opf", "EPUB/nav.xhtml"]

    actual_files = []
    mimetype_contents = ""

    if os.path.isdir(source):
        for root, _, files in os.walk(source):
            actual_files.extend([os.path.relpath(os.path.join(root, file), source) for file in files])

        with open(os.path.join(source, "mimetype"), encoding="us-ascii") as mimetype:
            mimetype_contents = mimetype.read()

    elif os.path.isfile(source):
        try:
            with zipfile.ZipFile(source, "r") as archive:
                actual_files = [item.filename for item in archive.filelist]
                mimetype_contents = archive.read("mimetype").decode("us-ascii")

        except zipfile.BadZipfile:
            logging.warning("This is not a ZIP file, which means it is not an EPUB")
            return False

    else:
        logging.error(f"{source} is neither a file nor a directory")
        return False

    # check for the required files
    for path in required_files:
        if path not in actual_files:
            logging.error(f"'{path}' not found")
            return False

    # check contents of mimetype file
    if mimetype_contents != "application/epub+zip":
        logging.error("The mimetype file does not start with the text 'application/epub+zip', this is not an EPUB")
        return False

    return True


def get_opf_path(source: str) -> Union[str, None]:
    container = None

    if os.path.isdir(source):
        container = ElementTree.parse(os.path.join(source, "META-INF/container.xml")).getroot()

    elif os.path.isfile(source):
        with zipfile.ZipFile(source, 'r') as archive:
            container = archive.read("META-INF/container.xml")
            container = ElementTree.XML(container)

    else:
        logging.error(f"Could not find the OPF path for {source}")
        return None

    rootfiles = container.findall('{urn:oasis:names:tc:opendocument:xmlns:container}rootfiles')[0]
    rootfile = rootfiles.findall('{urn:oasis:names:tc:opendocument:xmlns:container}rootfile')[0]
    opf = rootfile.attrib.get("full-path")
    return str(opf) if opf else None


def get_opf_package_element(source: str) -> Union[ElementTree._Element, None]:
    opf_path = get_opf_path(source)

    if not opf_path:
        return None

    if os.path.isdir(source):
        return ElementTree.parse(os.path.join(source, opf_path)).getroot()

    elif os.path.isfile(source):
        with zipfile.ZipFile(source, 'r') as archive:
            opf = archive.read(opf_path)
            return ElementTree.XML(opf)

    else:
        logging.error(f"Could not find the OPF package element for {source}")
        return None


def get_nav_path(source: str) -> Union[str, None]:
    opf_path = get_opf_path(source)
    opf = get_opf_package_element(source)

    if opf_path is None or opf is None:
        return None

    manifest = opf.findall('{http://www.idpf.org/2007/opf}manifest')[0]
    items = manifest.findall("*")
    for item in items:
        properties = item.attrib.get("properties", "")
        href = item.attrib.get("href", "")
        if "nav" in re.split(r'\s+', properties):
            return os.path.join(os.path.dirname(opf_path), href)

    return None


def get_nav_toc(source: str) -> List[Dict[str, Union[str, int]]]:
    nav_path = get_nav_path(source)

    if not nav_path:
        return []

    nav_relpath = os.path.dirname(nav_path)

    document: ElementTree._Element

    if os.path.isdir(source):
        document = ElementTree.parse(os.path.join(source, nav_path)).getroot()

    elif os.path.isfile(source):
        with zipfile.ZipFile(source, "r") as archive:
            opf = archive.read(nav_path)
            document = ElementTree.XML(opf)

    else:
        logging.error(f"Could not find the OPF package element for {source}")
        return []

    # tokenize(@epub:type, '\\s+')='toc' not supported by lxml, so we use contains(…) instead. As long as there's no weird epub:type values, this will work.
    nav_elements: List[ElementTree._Element] = document.xpath("//html:nav[contains(@epub:type, 'toc')]", namespaces=namespaces)  # type: ignore
    nav_element = nav_elements[0] if nav_elements else None
    if nav_element is None:
        logging.error(f"Could not find the TOC nav element in {source}")
        return []

    result: List[Dict[str, Union[str, int]]] = []
    list_item: ElementTree._Element
    for list_item in nav_element.xpath("html:ol/html:li", namespaces=namespaces):  # type: ignore
        result.extend(parse_nav_toc_list_item(list_item, 1, nav_relpath))

    return result


def parse_nav_toc_list_item(list_item: ElementTree._Element, level: int, nav_relpath: str) -> List[Dict[str, Union[str, int]]]:
    links: List[ElementTree._Element] = list_item.xpath("html:a", namespaces=namespaces)  # type: ignore
    href = links[0].attrib.get("href", "") if len(links) else ""
    href = href.split("#")[0]
    href = os.path.join(nav_relpath, href)
    title = "Untitled"
    if len(links):
        title = " ".join(links[0].xpath("html:a//text() | html:span//text()", namespaces=namespaces))  # type: ignore
    title = title.strip()

    result: List[Dict[str, Union[str, int]]] = [{"level": level, "title": title, "href": href}]

    sub_list_item: ElementTree._Element
    for sub_list_item in list_item.xpath("html:ol/html:li", namespaces=namespaces):  # type: ignore
        result.extend(parse_nav_toc_list_item(sub_list_item, level + 1, nav_relpath))

    return result


def get_spine(source: str) -> List[Dict[str, Union[str, int]]]:
    opf_path = get_opf_path(source)
    opf = get_opf_package_element(source)
    nav = get_nav_toc(source)

    if opf_path is None:
        return []

    if opf is None:
        return []

    if nav is None:
        return []

    opf_relpath = os.path.dirname(opf_path)
    # opf_path relative to the source
    root_levels: Dict[str, int] = {}
    for toc_item in nav:
        if toc_item["href"] not in root_levels:
            root_levels[str(toc_item["href"])] = int(toc_item["level"])

    itemrefs: List[ElementTree._Element] = opf.xpath("//opf:spine/opf:itemref", namespaces=namespaces)  # type: ignore
    spine_items = []
    for itemref in itemrefs:
        idref = itemref.attrib.get("idref", "")
        items: List[ElementTree._Element] = opf.xpath(f"//opf:manifest/opf:item[@id = '{idref}']", namespaces=namespaces)  # type: ignore
        # combine all attributes from the itemref and the item elements into a single dictionary
        attributes: Dict[str, Union[str, int]] = {str(key): str(itemref.attrib[key]) for key in itemref.attrib}  # use dict comprehension to make the attributes into a dict
        for key in items[0].attrib:
            attributes[str(key)] = str(items[0].attrib[key])
        attributes["href"] = os.path.join(opf_relpath, str(attributes["href"]))
        if attributes["href"] not in root_levels:
            logging.debug(f'{attributes["href"]} not in {root_levels}')
            logging.warning(f"Could not find the root level for {attributes['href']}. Will default to 1")
        attributes["root_level"] = int(root_levels.get(str(attributes["href"]), 1))
        spine_items.append(attributes)

    return spine_items


def get_metadata(source: str) -> Dict[str, List[str]]:
    """Read OPF metadata"""
    opf = get_opf_package_element(source)

    if opf is None:
        return {}

    metadata: Dict[str, List[str]] = {}
    opf_metadata = opf.findall('{http://www.idpf.org/2007/opf}metadata')[0]
    for meta_element in opf_metadata.findall("*"):
        if "refines" in meta_element.attrib:
            continue
        name = meta_element.attrib.get("property") or meta_element.attrib.get("name") or meta_element.tag
        name = name.replace("{http://purl.org/dc/elements/1.1/}", "dc:")
        value = meta_element.attrib.get("content") or meta_element.text or ""
        if name not in metadata:
            metadata[name] = []
        metadata[name].append(value)

    return metadata


def epubcheck(path: str) -> bool:
    options = []
    if os.path.isdir(path):
        options = ["--mode", "exp"]
    elif not os.path.isfile(path):
        raise FileNotFoundError(f"{path} is neither a file nor a directory")

    epubcheck_home = os.getenv("EPUBCHECK_HOME")
    if not epubcheck_home:
        logging.error("The environment variable EPUBCHECK_HOME is not set, using default: /opt/epubcheck")
        epubcheck_home = "/opt/epubcheck"

    command = ["java", "-Xss4096k", "-jar", f"{epubcheck_home}/epubcheck.jar", *options, path]

    logging.debug("Running Epubcheck")

    process: Union[subprocess.CompletedProcess, subprocess.CalledProcessError]
    try:
        process = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=False, cwd=epubcheck_home, timeout=600, check=True)
    except subprocess.CalledProcessError as e:
        logging.exception("Epubcheck failed")
        process = e

    logging.debug("---- stdout: ----")
    logging.info(process.stdout.decode("utf-8"))
    logging.debug("-----------------")
    logging.debug("---- stderr: ----")
    logging.info(process.stderr.decode("utf-8"))
    logging.debug("-----------------")

    return process.returncode == 0
