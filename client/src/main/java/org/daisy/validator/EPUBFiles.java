package org.daisy.validator;

import org.daisy.validator.ace.ACEValidator;
import org.daisy.validator.epubcheck.EPUBCheckValidator;
import org.daisy.validator.report.Issue;
import org.daisy.validator.schemas.Guideline;
import org.daisy.validator.schemas.Guideline2015;
import org.daisy.validator.schemas.Guideline2020;
import net.sf.saxon.s9api.Processor;
import net.sf.saxon.s9api.XsltCompiler;
import net.sf.saxon.s9api.XsltExecutable;
import net.sf.saxon.s9api.XsltTransformer;
import org.apache.log4j.Logger;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStreamWriter;
import java.io.StringWriter;
import java.net.URISyntaxException;
import java.net.URL;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.CompletionService;
import java.util.concurrent.ExecutorCompletionService;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;
import java.util.jar.JarEntry;
import java.util.jar.JarFile;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.zip.ZipEntry;
import java.util.zip.ZipFile;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.Result;
import javax.xml.transform.Source;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;

public class EPUBFiles {
    private static final Logger logger = Logger.getLogger(Logger.class.getName());

    private static final String EPUB_REFERENCE_NAV_NCX_FILE = "nordic-nav-ncx.xml";
    private static final String EPUB_OBF_AND_HTML_FILE = "nordic-obf-and-html.xml";
    private static final String EPUB_NAV_AND_LINKS_FILE = "nordic-nav-and-links.xml";

    public static final Map<String, String> SPECIAL_NAMES_MAP = new HashMap<>();
    static {
        SPECIAL_NAMES_MAP.put(EPUB_REFERENCE_NAV_NCX_FILE, "EPUB/nav.xhtml and EPUB/nav.ncx");
        SPECIAL_NAMES_MAP.put(EPUB_OBF_AND_HTML_FILE, "EPUB/package.obf and content files");
        SPECIAL_NAMES_MAP.put(EPUB_NAV_AND_LINKS_FILE, "EPUB/nav.xhtml and content files");
    }

    private String packageOBF;
    private String ncxFile;
    private String navFile;
    private List<String> contentFiles = new ArrayList<>();
    private Set<Issue> errorList = new HashSet<>();
    private final ExecutorService executor;
    private final CompletionService<List<Issue>> completionService;
    private int submittedWork = 0;
    private final File epubDir = Util.createTempDirectory();
    private final File schemaDir = Util.createTempDirectory();
    private final Guideline guideline;

    public EPUBFiles(String filename, String issue) throws Exception {
        executor = null;
        completionService = null;
        guideline = null;
        errorList.add(new Issue("", issue, filename, Guideline.EPUB, Issue.ERROR_FATAL));
    }

    public EPUBFiles(String rootFile, int threads, ZipFile zipFile, Guideline guideline) throws Exception {
        this.packageOBF = rootFile;
        ZipEntry packageEntry = zipFile.getEntry(rootFile);

        if (packageEntry == null) {
            this.executor = null;
            this.completionService = null;
            this.guideline = null;
            this.errorList.add(new Issue(
                "",
                "Not a EPUB file (missing package file)",
                zipFile.getName(),
                Guideline.EPUB,
                Issue.ERROR_FATAL
            ));
            return;
        }

        File packageFile = new File(packageEntry.getName());
        String path = packageFile.getParentFile().getPath();
        InputStream is = zipFile.getInputStream(packageEntry);

        executor = Executors.newFixedThreadPool(threads);
        this.completionService = new ExecutorCompletionService<>(executor);

        DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
        DocumentBuilder db = dbf.newDocumentBuilder();
        Document doc = db.parse(is);
        doc.getDocumentElement().normalize();

        if (guideline == null) {
            NodeList metaList = doc.getElementsByTagName("meta");
            String guidelineName = null;

            for (int i = 0; i < metaList.getLength(); i++) {
                Element item = (Element) metaList.item(i);
                if (item.hasAttribute("property")) {
                    if (!"nordic:guidelines".equals(item.getAttribute("property"))) continue;
                    guidelineName = item.getTextContent();
                    break;
                }
                if (item.hasAttribute("name")) {
                    if (!"nordic:guidelines".equals(item.getAttribute("name"))) continue;
                    guidelineName = item.getAttribute("content");
                    break;
                }
            }

            if ("2015-1".equals(guidelineName)) {
                guideline = new Guideline2015();
            } else if ("2020-1".equals(guidelineName)) {
                guideline = new Guideline2020();
            } else {
                String errDesc = guidelineName == null ?
                        "Guideline not specified." :
                        "Unknown guideline version (" + guidelineName + ")";

                errorList.add(new Issue(
                    "",
                    errDesc,
                    zipFile.getName(),
                    Guideline.EPUB,
                    Issue.ERROR_FATAL
                ));
                this.guideline = null;
                return;
            }
        }

        this.guideline = guideline;

        NodeList nodeList = doc.getElementsByTagName("item");
        for (int i = 0; i < nodeList.getLength(); i++) {
            Element item = (Element)nodeList.item(i);
            if (!item.hasAttribute("media-type")) continue;
            if (!item.hasAttribute("href")) continue;

            String filePath = path + "/" + item.getAttribute("href");

            if (zipFile.getEntry(filePath) != null) {
                Util.writeFile(new File(epubDir, filePath), zipFile.getInputStream(zipFile.getEntry(filePath)));
            }

            if ("application/x-dtbncx+xml".equals(item.getAttribute("media-type"))) {
                ncxFile = filePath;
                continue;
            }

            if (!"application/xhtml+xml".equals(item.getAttribute("media-type"))) continue;

            if (item.hasAttribute("properties") && "nav".equals(item.getAttribute("properties"))) {
                navFile = filePath;
                continue;
            }

            if (zipFile.getEntry(filePath) != null) {
                contentFiles.add(filePath);
            } else {
                errorList.add(new Issue("", "File missing", filePath, Guideline.OPF, Issue.ERROR_ERROR));
            }
        }

        Util.writeFile(new File(epubDir, packageOBF), zipFile.getInputStream(packageEntry));

        FileOutputStream fos;
        BufferedWriter bw;
        if (ncxFile == null || zipFile.getEntry(ncxFile) == null) {
            ncxFile = ncxFile == null ? "nav.ncx" : ncxFile;
        } else if (navFile == null || zipFile.getEntry(navFile) == null) {
            navFile = navFile == null ? "nav.xhtml" : navFile;
            errorList.add(new Issue("", "File missing", navFile, Guideline.NAV_REFERENCES, Issue.ERROR_WARN));
        } else {
            fos = new FileOutputStream(new File(epubDir, EPUB_REFERENCE_NAV_NCX_FILE));
            bw = new BufferedWriter(new OutputStreamWriter(fos));
            bw.write("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
            bw.newLine();
            bw.write("<c:result xmlns:c=\"http://www.w3.org/ns/xproc-step\">");
            bw.newLine();
            bw.flush();
            Util.appendXML(bw, zipFile.getInputStream(zipFile.getEntry(ncxFile)));
            bw.flush();
            bw.flush();
            Util.appendXML(bw, zipFile.getInputStream(zipFile.getEntry(navFile)));
            bw.flush();
            bw.write("</c:result>");
            bw.close();
        }

        fos = new FileOutputStream(new File(epubDir, EPUB_OBF_AND_HTML_FILE));
        bw = new BufferedWriter(new OutputStreamWriter(fos, "UTF-8"));
        bw.write("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
        bw.newLine();
        bw.write("<wrapper xmlns:html=\"http://www.w3.org/1999/xhtml\" xmlns:opf=\"http://www.idpf.org/2007/opf\">");
        bw.newLine();
        Util.appendXML(bw, zipFile.getInputStream(zipFile.getEntry(packageOBF)));
        bw.newLine();
        for (String contentFile : contentFiles) {
            Util.appendXML(bw, zipFile.getInputStream(zipFile.getEntry(contentFile)));
            bw.newLine();
            bw.flush();
        }
        bw.write("</wrapper>");
        bw.flush();
        bw.close();

        if  (navFile != null) {
            String htmlData = createData();
            String navData = Util.readStreamText(new FileInputStream(new File(epubDir, navFile)));

            navData = insertBeforeHeader(navData, htmlData);

            FileOutputStream fos2 = new FileOutputStream(new File(epubDir, EPUB_NAV_AND_LINKS_FILE));
            BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(fos2, "UTF-8"));
            writer.write(navData);
            writer.flush();
            writer.close();
        }

        unpackSchemaDir(guideline.getSchemaPath());
        unpackSchemaDir("mathml3");
    }

    private static String insertBeforeHeader(String navData, String htmlData) {
        Pattern findHead = Pattern.compile("<head[^>]*");
        Matcher matcher = findHead.matcher(navData);
        if(matcher.find()) {
            String fixStr = navData.substring(0, matcher.start());
            fixStr += htmlData + "\n";
            fixStr += navData.substring(matcher.start());
            return fixStr;
        } else {
            logger.fatal("Head tag not found.");
        }
        return navData;
    }

    public void unpackSchemaDir(String schemaResource) throws Exception {
        final File jarFile = new File(getClass().getProtectionDomain().getCodeSource().getLocation().getPath());

        if(jarFile.isFile()) {  // Run with JAR file
            final JarFile jar = new JarFile(jarFile);
            final Enumeration<JarEntry> entries = jar.entries();
            while(entries.hasMoreElements()) {
                final String name = entries.nextElement().getName();
                if (name.startsWith(schemaResource + "/")) {
                    Util.writeFile(
                        new File(schemaDir, new File(name).getName()),
                        EPUBFiles.class.getResourceAsStream(
                            "/" + schemaResource + "/" + new File(name).getName()
                        )
                    );
                }
            }
            jar.close();
        } else {
            final URL url = EPUBFiles.class.getResource("/" + schemaResource);
            if (url != null) {
                try {
                    final File apps = new File(url.toURI());
                    for (File app : apps.listFiles()) {
                        Util.writeFile(
                            new File(schemaDir, app.getName()),
                            EPUBFiles.class.getResourceAsStream(
                                "/" + schemaResource + "/" + app.getName()
                            )
                        );
                    }
                } catch (URISyntaxException ex) {
                    logger.fatal(ex.getMessage(), ex);
                }
            }
        }
    }

    public XsltTransformer getTransformer(String filename) throws Exception {
        InputStream in = EPUBFiles.class.getResourceAsStream(filename);

        Processor processor = new Processor(false);
        XsltCompiler compiler = processor.newXsltCompiler();
        XsltExecutable xslt = compiler.compile(new StreamSource(in));
        return xslt.load();
    }

    public void validate() throws Exception {
        if(guideline == null) return;
        validateContent(
            new File(schemaDir, guideline.getSchema(Guideline.CONTENT_FILES).getFilename()),
            new File(schemaDir, guideline.getSchema(Guideline.XHTML).getFilename())
        );

        if(new File(epubDir, EPUB_NAV_AND_LINKS_FILE).exists()) {
            transformFile(
                EPUB_NAV_AND_LINKS_FILE,
                new File(schemaDir, guideline.getSchema(Guideline.NAV_REFERENCES).getFilename()),
                Guideline.NAV_REFERENCES,
                false
            );
        }
        if(new File(epubDir, EPUB_REFERENCE_NAV_NCX_FILE).exists()) {
            transformFile(
                EPUB_REFERENCE_NAV_NCX_FILE,
                new File(schemaDir, guideline.getSchema(Guideline.NAV_NCX).getFilename()),
                Guideline.NAV_NCX,
                false
            );
        }
        transformFile(
            EPUB_OBF_AND_HTML_FILE,
            new File(schemaDir, guideline.getSchema(Guideline.OPF_AND_HTML).getFilename()),
            Guideline.OPF_AND_HTML,
            false
        );
        transformFile(
            packageOBF,
            new File(schemaDir, guideline.getSchema(Guideline.OPF).getFilename()),
            Guideline.OPF,
            false
        );

        int received = 0;
        boolean errors = false;
        while(received < submittedWork && !errors) {
            Future<List<Issue>> resultFuture = completionService.take();
            try {
                errorList.addAll(resultFuture.get());
                received++;
            } catch(Exception e) {
                e.printStackTrace();
                errors = true;
            }
        }
        executor.shutdownNow();
    }

    private String createData() throws Exception {
        InputStream in = EPUBFiles.class.getResourceAsStream(guideline.getNavReferenceTransformation());
        Transformer transformer = TransformerFactory.newInstance().newTransformer(new StreamSource(in));

        StringBuilder data = new StringBuilder("<c:result xmlns:c=\"http://www.w3.org/ns/xproc-step\">");
        for (String filename : contentFiles) {
            Source xmlInput = new StreamSource(new File(epubDir, filename));
            StringWriter writer = new StringWriter();
            Result xmlOutput = new StreamResult(writer);
            transformer.transform(xmlInput, xmlOutput);
            data.append(cleanUpResult(writer.toString(), filename));
        }
        data.append("</c:result>");
        return data.toString();
    }

    private String cleanUpResult(String s, String filename) {
        s = s.trim();
        s = s.replace("<?xml version=\"1.0\" encoding=\"UTF-8\"?>", "");
        s = s.replace("<c:result xmlns:c=\"http://www.w3.org/ns/xproc-step\">", "");
        s = s.substring(0, s.length() - ("</c:result>".length() + 1));
        return s;
    }

    private void validateContent(File transformer, File validator) throws Exception {
        validateFile(navFile, validator, Guideline.XHTML);
        transformFile(navFile, transformer, Guideline.CONTENT_FILES, false);

        for (String filename : contentFiles) {
            validateFile(filename, validator, Guideline.XHTML);
            transformFile(filename, transformer, Guideline.CONTENT_FILES, false);
        }
    }

    private void transformFile(String filename, File transformer, String schemaType, boolean dontPrintFile) throws Exception {
        if(completionService == null) return;
        completionService.submit(new TransformFile(epubDir, filename, transformer, schemaType, dontPrintFile));
        submittedWork++;
    }

    public void validateWithEpubCheck(File epub) throws Exception {
        if(completionService == null) return;
        completionService.submit(new EPUBCheckValidator(epub));
        submittedWork++;
    }

    public void validateWithAce(File epub) {
        if(completionService == null) return;
        if(ACEValidator.isAvailable()) {
            completionService.submit(new ACEValidator(epub));
            submittedWork++;
        }
    }

    private void validateFile(String filename, File validator, String validatorType) throws Exception {
        if(completionService == null) return;
        completionService.submit(new ValidateFile(epubDir, filename, validator, validatorType));
        submittedWork++;
    }

    public Set<Issue> getErrorList() {
        return errorList;
    }

    public void cleanUp() {
        if(DevelopmentFlags.CLEAN_UP_EPUB_DIR) {
            Util.deleteDirectory(epubDir);
        }
        if(DevelopmentFlags.CLEAN_UP_SCHEMA_DIR) {
            Util.deleteDirectory(schemaDir);
        }
    }

    public Guideline getGuideline() {
        if (this.guideline == null) {
            return new Guideline2015();
        }
        return this.guideline;
    }

    public File getSchemaDir() {
        return schemaDir;
    }
}
