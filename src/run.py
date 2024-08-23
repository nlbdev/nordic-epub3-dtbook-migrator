#!/bin/env python3

import enum
import sys
import os
import logging
import tempfile
from typing import Generator
import re
import epub
import shutil


logging.basicConfig(stream=sys.stdout, level=logging.DEBUG, format="%(asctime)s %(levelname)-8s %(message)s")


def test() -> None:
    logging.error("test(): Not implemented")
    # TODO: rewrite xprocspec tests into python tests


def main() -> None:
    print(sys.argv)
    source = sys.argv[1] if len(sys.argv) >= 2 else ""
    target = sys.argv[2] if len(sys.argv) >= 3 else ""

    if len(sys.argv) < 3 or not source or not target:
        logging.error("Usage: run.py <source> <target> [options]")
        logging.error("Options:")
        logging.error("  --fix-heading-levels=true|false (default: true)")
        logging.error("  --add-header-element=true|false (default: true)")
        sys.exit(1)

    fix_heading_levels = True
    add_header_element = True
    for arg in sys.argv[3:]:
        if arg.startswith("--fix-heading-levels="):
            fix_heading_levels = arg.split("=", 1)[1].lower() == "true"
        elif arg.startswith("--add-header-element="):
            add_header_element = arg.split("=", 1)[1].lower() == "true"
        else:
            logging.error(f"Unknown option: {arg}")

    convert(source, target, fix_heading_levels=fix_heading_levels, add_header_element=add_header_element)


# declare literal type of strings for content types
class ContentType(enum.Enum):
    HEAD = "head"
    LINK_TAG = "link_tag"
    BODY_TAG = "body_tag"
    CONTENT = "content"
    HEADING = "heading"
    HREF_ATTRIBUTE = "href_attribute"
    TAIL = "tail"


def iterate_content_file(source: str) -> Generator[tuple[ContentType, str], None, None]:
    with open(source, 'r', encoding="utf-8") as content_file:
        current_type: ContentType = ContentType.HEAD
        line: str
        for file_line in content_file:
            for line_type, line in iterate_content_file_line(current_type, file_line):
                current_type = line_type
                yield line_type, line


def iterate_content_file_line(current_type: ContentType, line: str) -> Generator[tuple[ContentType, str], None, None]:
    # find the body opening tag
    if current_type == ContentType.HEAD and "<body" in line:
        before_body, body_tag = line.split("<body", 1)
        yield from iterate_content_file_line(current_type, before_body)

        body_tag, after_body_tag = body_tag.split(">", 1)
        yield ContentType.BODY_TAG, f"<body{body_tag}>"

        yield from iterate_content_file_line(ContentType.CONTENT, after_body_tag)

    # find link tags in head
    elif current_type == ContentType.HEAD and "<link" in line:
        before_link, link_tag = line.split("<link", 1)
        yield from iterate_content_file_line(current_type, before_link)

        link_tag, after_link_tag = link_tag.split(">", 1)
        yield ContentType.LINK_TAG, f"<link{link_tag}>"

        yield from iterate_content_file_line(current_type, after_link_tag)

    # find headline start tags
    elif current_type == ContentType.CONTENT and re.match(r".*<h[1-6]", line):
        parts = line.split("<h")
        yield from iterate_content_file_line(current_type, parts[0])

        for part in parts[1:]:
            tag, rest = part.split(">", 1)
            if tag[0].isnumeric():
                yield ContentType.HEADING, f"<h{tag}>"
            else:
                yield current_type, f"<h{tag}>"

            yield from iterate_content_file_line(current_type, rest)

    # find headline end tags
    elif current_type == ContentType.CONTENT and re.match(r".*</h[1-6]", line):
        parts = line.split("</h")
        yield from iterate_content_file_line(current_type, parts[0])

        for part in parts[1:]:
            tag, rest = part.split(">", 1)
            if tag[0].isnumeric():
                yield ContentType.HEADING, f"</h{tag}>"
            else:
                yield current_type, f"</h{tag}>"

            yield from iterate_content_file_line(current_type, rest)

    # find href attributes
    # NOTE: We don't move images, so no need to handle @src, @altimg or object/@data.
    #       Also, we ignore @xlink:href for now as we don't use it.
    elif current_type == ContentType.CONTENT and ' href="' in line:
        before_href, href = line.split(' href="', 1)
        href, after_href = href.split('"', 1)
        href = f'href="{href}"'
        before_href += " "
        yield from iterate_content_file_line(current_type, before_href)
        yield ContentType.HREF_ATTRIBUTE, href
        yield from iterate_content_file_line(current_type, after_href)

    # find the body closing tag
    elif "</body" in line:
        content, html_tail = line.split("</body", 1)
        yield from iterate_content_file_line(current_type, content)
        yield ContentType.TAIL, f"</body{html_tail}"

    else:
        yield current_type, line


def convert(source: str, target: str, fix_heading_levels: bool, add_header_element: bool) -> None:
    success = True

    source = os.path.abspath(source)
    target = os.path.abspath(target)

    if not os.path.exists(source):
        logging.error(f"Input '{source}' does not exist")
        sys.exit(1)
    if os.path.exists(target) and not os.path.isdir(target):
        logging.error(f"Output '{target}' already exists and is not a directory")
        sys.exit(1)
    if not success:
        logging.error("Aborting due to errors")
        sys.exit(1)

    if not epub.is_epub(source):
        logging.error("The input does not seem to be a nordic EPUB")
        sys.exit(1)

    # If the input is a file, convert it to a directory
    epub_dir_obj = epub.epub_as_directory(source)
    epub_dir: str = epub_dir_obj if isinstance(epub_dir_obj, str) else epub_dir_obj.name

    logging.info("Listing spine items…")
    spine = epub.get_spine(epub_dir)
    if not spine:
        logging.error("Could not get spine")
        sys.exit(1)

    metadata = epub.get_metadata(epub_dir)
    identifiers = metadata.get('dc:identifier', [])
    titles = metadata.get('dc:title', [])
    authors = metadata.get('dc:creator', [])
    if not identifiers:
        logging.error("Could not get dc:identifier from OPF metadata")
        sys.exit(1)
    if not titles:
        logging.error("Could not get dc:title from OPF metadata")
        sys.exit(1)
    if not authors:
        logging.warning("Could not get dc:creator from OPF metadata")
    identifier = identifiers[0]
    title = titles[0]

    target_dir = os.path.join(target, identifier)
    target_file = os.path.join(target, f"{identifier}.epub")

    if os.path.exists(target_dir):
        logging.error(f"Output directory '{target_dir}' already exists")
        sys.exit(1)
    if os.path.exists(target_file):
        logging.error(f"Output file '{target_file}' already exists")
        sys.exit(1)

    logging.info(f"Copying files to target/{identifier}/…")
    os.makedirs(target_dir, exist_ok=True)
    for root, _, files in os.walk(epub_dir):
        for file in files:
            source_path = os.path.join(root, file)
            relpath = os.path.relpath(source_path, epub_dir)
            target_path = os.path.join(target_dir, relpath)
            if relpath in [item["href"] for item in spine]:
                continue  # skip spine items (we are replacing them with a single HTML file)
            if relpath in ["EPUB/package.opf", "EPUB/nav.xhtml", "EPUB/nav.ncx"]:
                continue  # skip package.opf, nav.xhtml and nav.ncx (we are building updated versions of them, and discard nav.ncx)
            os.makedirs(os.path.dirname(target_path), exist_ok=True)
            shutil.copy(source_path, target_path)

    logging.info("Creating single HTML file…")
    with create_single_html(epub_dir, spine, title, authors, fix_heading_levels, add_header_element) as single_html_obj:
        shutil.copy(single_html_obj.name, os.path.join(target_dir, f"EPUB/{identifier}.xhtml"))

    logging.info("Creating updated navigation document…")
    with create_updated_navigation_document(epub_dir, spine, identifier) as updated_nav_obj:
        shutil.copy(updated_nav_obj.name, os.path.join(target_dir, "EPUB/nav.xhtml"))

    properties = get_content_file_properties(os.path.join(target_dir, f"EPUB/{identifier}.xhtml"))
    with create_updated_package_document(epub_dir, spine, identifier, properties) as updated_opf_obj:
        shutil.copy(updated_opf_obj.name, os.path.join(target_dir, "EPUB/package.opf"))

    # we zip the EPUB before validating it since epubcheck works better that way
    result_as_file_obj = epub.epub_as_file(target_dir)
    result_as_file = result_as_file_obj if isinstance(result_as_file_obj, str) else result_as_file_obj.name
    shutil.copy(result_as_file, target_file)
    if result_as_file and not epub.epubcheck(target_file):
        logging.error("Validation failed")
        sys.exit(1)

    logging.info("Conversion successful")


def create_single_html(epub_dir: str, spine: list[dict[str, str | int]], title: str, authors: list[str], fix_heading_levels: bool, add_header_element: bool) -> tempfile._TemporaryFileWrapper:
    single_html_obj = tempfile.NamedTemporaryFile()
    with open(single_html_obj.name, 'w', encoding="utf-8") as single_html_file:
        # Get the head content from the first spine item
        path = os.path.join(epub_dir, str(spine[0]["href"]))
        for content_type, text in iterate_content_file(path):
            if content_type == ContentType.HEAD:
                single_html_file.write(text)

            elif content_type == ContentType.LINK_TAG:
                # skip link tags that reference other XHTML files (i.e. rel=next/prev)
                if '.xhtml"' not in text:
                    single_html_file.write(text)

            else:
                break  # break after having exhausted HEAD and LINK_TAG

        single_html_file.write("\n<body>\n")

        if add_header_element:
            single_html_file.write("\n<header>\n")
            single_html_file.write(f'    <h1 epub:type="fulltitle" class="title">{title}</h1>\n')
            for author in authors:
                single_html_file.write(f'    <p epub:type="z3998:author" class="docauthor">{author}</p>\n')
            single_html_file.write("</header>\n")

        # Add all spine items, while:
        # - converting the body tag to a section tag
        # - fixing the section hierarchy
        for i, item in enumerate(spine):
            path = os.path.join(epub_dir, str(item["href"]))
            root_level: int = int(item["root_level"])
            next_root_level = int(spine[i + 1]["root_level"]) if i < len(spine) - 1 else int(spine[0]["root_level"])

            for content_type, text in iterate_content_file(path):
                if content_type == ContentType.BODY_TAG:
                    single_html_file.write(text.replace("<body", "<section"))

                elif fix_heading_levels and content_type == ContentType.HEADING:
                    end = text[1] == "/"
                    if not end:
                        # start tag <hX>
                        depth, rest = text[2], text[3:]
                    else:
                        # end tag </hX>
                        depth, rest = text[3], text[4:]
                    logging.debug(f"{text} is a {'start' if not end else 'end'} tag with depth {depth}")
                    if not depth.isnumeric():
                        logging.error(f"Could not parse heading level from '{text}'")
                    else:
                        depth = str(max(1, min(6, int(depth) + root_level - 1)))
                    single_html_file.write(f"<{'/' if end else ''}h{depth}{rest}")

                elif not fix_heading_levels and content_type == ContentType.HEADING:
                    single_html_file.write(text)

                elif content_type == ContentType.HREF_ATTRIBUTE:
                    value = text.split('"')[1]
                    reference = "EPUB/" + value.split("#")[0]
                    if reference in [spine_item["href"] for spine_item in spine]:
                        # reference to a spine item
                        if "#" in value:
                            value = "#" + value.split("#", 1)[1]
                        else:
                            logging.warning(f"Reference to spine item '{reference}' without anchor found in '{path}': '{text}'")
                            value = ""
                        single_html_file.write(f'href="{value}"')
                    else:
                        single_html_file.write(text)

                elif content_type == ContentType.CONTENT:
                    single_html_file.write(text)

            # close with </section> for each level difference, i.e.:
            # part -> chapter: no closing tag
            # chapter -> chapter: a single closing tag
            # chapter -> part: two closing tags
            single_html_file.write("\n</section>\n" * (root_level - next_root_level + 1))

        # Finally, close the body and html tags
        single_html_file.write("\n</body>\n</html>\n")

    return single_html_obj


def get_content_file_properties(path: str) -> list[str]:
    properties = []
    with open(path, "r", encoding="utf-8") as f:
        for line in f:
            if "<math" in line or "<m:math" in line or "<math:math" in line:
                properties.append("mathml")

            if ("<script" in line or "<form" in line or "<button" in line or "<fieldset" in line or "<input" in line or
                    "<object" in line or "<output" in line or "<select" in line or "<textarea" in line):
                properties.append("scripted")
                # could also check for onclick attributes and similar, and should ideally ignore
                # input elements if they have the type attribute is "image"

            if "<svg" in line:
                properties.append("svg")
                # we could also check img/@src and iframe/@src for .svg files but it would require XML parsing or a regex.
                # object elements could also contain SVG but are even more complex and probably very uncommon in the wild.

            if "<epub:switch" in line:
                properties.append("switch")
                # this is deprecated in EPUB 3.2 but can be useful during production if we want to include for instance MusicXML

    return list(set(properties))


def create_updated_navigation_document(epub_dir: str, spine: list[dict[str, str | int]], identifier: str) -> tempfile._TemporaryFileWrapper:
    nav_path = os.path.join(epub_dir, epub.get_nav_path(epub_dir) or "EPUB/nav.xhtml")
    nav_obj = tempfile.NamedTemporaryFile()
    with open(nav_obj.name, "w", encoding="utf-8") as nav_file:
        path = os.path.join(epub_dir, nav_path)
        for content_type, text in iterate_content_file(path):
            if content_type == ContentType.HREF_ATTRIBUTE:
                value = text.split('"')[1]
                reference = "EPUB/" + value.split("#")[0]
                if reference in [spine_item["href"] for spine_item in spine]:
                    # reference to a spine item
                    if "#" in value:
                        value = f"{identifier}.xhtml#" + value.split("#", 1)[1]
                    else:
                        logging.warning(f"Reference to spine item '{reference}' without anchor found in '{path}': '{text}'")
                        value = ""
                    nav_file.write(f'href="{value}"')
                else:
                    nav_file.write(text)
            else:
                nav_file.write(text)

    return nav_obj


def create_updated_package_document(epub_dir: str, spine: list[dict[str, str | int]], identifier: str, properties: list[str]) -> tempfile._TemporaryFileWrapper:
    opf_path = os.path.join(epub_dir, epub.get_opf_path(epub_dir) or "EPUB/package.opf")
    path = os.path.join(epub_dir, opf_path)
    source_opf = ""
    with open(path, "r", encoding="utf-8") as opf_source:
        source_opf = opf_source.read()
    before_manifest, source_opf = source_opf.split("<manifest", 2)
    before_manifest = before_manifest.strip()
    source_opf = "<manifest" + source_opf
    source_opf_tags = source_opf.split("<")[1:]
    source_opf_tags = [value.split(">")[0] for value in source_opf_tags]
    source_opf_tags = [f"<{value}>" for value in source_opf_tags]
    opf_obj = tempfile.NamedTemporaryFile()
    with open(opf_obj.name, "w", encoding="utf-8") as opf_file:
        # There are text nodes in metadata, so we just write everything up until the manifest start tag as-is.
        # From the manifest start tag and onwards, we only need to care about the actual tags, not text nodes.
        opf_file.write(before_manifest + "\n")

        indentation_depth = 1  # start at 1 since we start at the manifest tag
        indentation_text = "    "
        spine_ids: list[str] = []
        for tag in source_opf_tags:
            if tag.startswith("<item "):
                item_href = re.sub(r'.*href="(.*?)".*', r"\1", tag)
                item_id = re.sub(r'.*id="(.*?)".*', r"\1", tag)
                item_href = "EPUB/" + item_href
                if item_href == "EPUB/nav.ncx":
                    continue  # skip nav.ncx
                elif item_href in [spine_item["href"] for spine_item in spine]:
                    # reference to a spine item
                    if not spine_ids:
                        # this is the first spine item in the manifest; replace it with the single HTML file
                        opf_file.write(indentation_text * indentation_depth)
                        opf_file.write(f'<item id="{item_id}" media-type="application/xhtml+xml" href="{identifier}.xhtml"')
                        if properties:
                            opf_file.write(' properties="' + " ".join(properties) + '"')
                        opf_file.write('/>\n')
                        spine_ids.append(item_id)
                else:
                    opf_file.write(indentation_text * indentation_depth)
                    opf_file.write(tag + "\n")

            elif tag.startswith("<spine"):
                opf_file.write(indentation_text * indentation_depth + "<spine>\n")
                opf_file.write(indentation_text * (indentation_depth + 1))
                opf_file.write(f'<itemref idref="{spine_ids[0]}" id="itemref"/>\n')
                opf_file.write(indentation_text * indentation_depth + "</spine>\n")
                indentation_depth -= 1

            elif tag.startswith("<itemref ") or tag.startswith("</spine"):
                pass  # skip itemref tags and the spine closing tag since we are replacing them

            else:
                opf_file.write(indentation_text * indentation_depth + tag + "\n")

            # update indentation depth
            if tag.startswith("<?"):
                pass  # don't change indentation depth for XML processing instructions
            elif tag.startswith("</"):
                indentation_depth -= 1
            elif not tag.endswith("/>"):
                indentation_depth += 1

    return opf_obj


if __name__ == '__main__':
    if len(sys.argv) >= 2 and sys.argv[1] == 'test':
        test()
    else:
        main()
