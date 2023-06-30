package org.daisy.validator;

import org.daisy.validator.ace.ACEValidator;
import org.daisy.validator.epubcheck.EPUBCheckValidator;
import org.daisy.validator.report.Issue;
import org.daisy.validator.schemas.Guideline;
import org.daisy.validator.schemas.Guideline2015;
import org.daisy.validator.schemas.Guideline2020;
import org.apache.log4j.Logger;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXParseException;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
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
import javax.sound.sampled.AudioFileFormat;
import javax.sound.sampled.AudioSystem;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.Result;
import javax.xml.transform.Source;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpression;
import javax.xml.xpath.XPathFactory;

public class EPUBFiles {
    private static final Logger logger = Logger.getLogger(Logger.class.getName());

    private static final String EPUB_REFERENCE_NAV_NCX_FILE = "nordic-nav-ncx.xml";
    private static final String EPUB_OPF_AND_HTML_FILE = "nordic-opf-and-html.xml";
    private static final String EPUB_NAV_AND_LINKS_FILE = "nordic-nav-and-links.xml";

    public static final Map<String, String> SPECIAL_NAMES_MAP = new HashMap<>();
    static {
        SPECIAL_NAMES_MAP.put(EPUB_REFERENCE_NAV_NCX_FILE, "EPUB/nav.xhtml and EPUB/nav.ncx");
        SPECIAL_NAMES_MAP.put(EPUB_OPF_AND_HTML_FILE, "EPUB/package.opf and content files");
        SPECIAL_NAMES_MAP.put(EPUB_NAV_AND_LINKS_FILE, "EPUB/nav.xhtml and content files");
    }

    private String packageOPF;
    private String ncxFile;
    private String navFile;
    private List<String> smilFiles = new ArrayList<>();
    private List<String> contentFiles = new ArrayList<>();
    private Map<String, Long> audioFiles = new HashMap<>();

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
        this.packageOPF = rootFile;
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


            if (item.hasAttribute("properties") && "nav".equals(item.getAttribute("properties"))) {
                navFile = filePath;
                continue;
            }

            if (zipFile.getEntry(filePath) != null) {
                if ("application/xhtml+xml".equals(item.getAttribute("media-type"))) {
                    contentFiles.add(filePath);
                } else if ("application/smil+xml".equals(item.getAttribute("media-type"))) {
                    smilFiles.add(filePath);
                } else {
                    if (filePath.endsWith(".mp3") || filePath.endsWith(".mp2") || filePath.endsWith(".wav")) {
                        AudioFileFormat audioFormat = AudioSystem.getAudioFileFormat(new File(epubDir, filePath));
                        // Audio can be longer then the last frame upto another, so therefor +1.
                        long frames = audioFormat.getFrameLength() + 1;
                        long durationInMilliSeconds = Math.round((frames * 1000) / audioFormat.getFormat().getFrameRate());
                        audioFiles.put(filePath, durationInMilliSeconds);
                    }
                }
            } else {
                errorList.add(new Issue("", "File missing", filePath, Guideline.OPF, Issue.ERROR_ERROR));
            }
        }

        Util.writeFile(new File(epubDir, packageOPF), zipFile.getInputStream(packageEntry));

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

        fos = new FileOutputStream(new File(epubDir, EPUB_OPF_AND_HTML_FILE));
        bw = new BufferedWriter(new OutputStreamWriter(fos, "UTF-8"));
        bw.write("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
        bw.newLine();
        bw.write("<wrapper xmlns:html=\"http://www.w3.org/1999/xhtml\" xmlns:opf=\"http://www.idpf.org/2007/opf\">");
        bw.newLine();
        Util.appendXML(bw, zipFile.getInputStream(zipFile.getEntry(packageOPF)));
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
            EPUB_OPF_AND_HTML_FILE,
            new File(schemaDir, guideline.getSchema(Guideline.OPF_AND_HTML).getFilename()),
            Guideline.OPF_AND_HTML,
            false
        );
        transformFile(
            packageOPF,
            new File(schemaDir, guideline.getSchema(Guideline.OPF).getFilename()),
            Guideline.OPF,
            false
        );

        validateAudio();

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

    private void validateAudio() throws Exception {
        DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
        DocumentBuilder db = dbf.newDocumentBuilder();
        XPath xPath = XPathFactory.newInstance().newXPath();
        XPathExpression xPathExpMediaDuration = xPath.compile("//meta[@property='media:duration']");

        Document xmlDocument = null;
        try {
            xmlDocument = db.parse(new File(epubDir, packageOPF));
        } catch (SAXParseException saxEx) {
            String lineIn = String.format("(Line: %05d Column: %05d) ", saxEx.getLineNumber(), saxEx.getColumnNumber());
            errorList.add(
                    new Issue("", "[" + Guideline.OPF + "] " + lineIn + saxEx.getMessage(),
                            packageOPF,
                            Guideline.OPF,
                            Issue.ERROR_ERROR
                    ));
            return;
        }

        NodeList nodeList = (NodeList) xPathExpMediaDuration.evaluate(xmlDocument, XPathConstants.NODESET);
        Map<String, Long> smilFiles = new HashMap<>();
        long totalTime = 0;
        for (int i = 0; i < nodeList.getLength(); i++) {
            Element el = (Element)nodeList.item(i);
            if (el.hasAttribute("refines")) {
                smilFiles.put(el.getAttribute("refines"), Util.parseMilliSeconds(el.getTextContent()));
            } else {
                totalTime = Util.parseMilliSeconds(el.getTextContent());
            }
        }

        XPathExpression xPathExpAudio = xPath.compile(
                "//audio[@clip-begin] | //audio[@clip-end] | //audio[@clipBegin] | //audio[@clipEnd]"
        );

        long elapsedTime = 0;
        XPathExpression xPathExpSmilFiles = xPath.compile("//item[@media-type='application/smil+xml']");
        nodeList = (NodeList) xPathExpSmilFiles.evaluate(xmlDocument, XPathConstants.NODESET);
        for (int i = 0; i < nodeList.getLength(); i++) {
            Element el = (Element)nodeList.item(i);
            if (!smilFiles.containsKey("#" + el.getAttribute("id"))) {
                continue;
            }

            String filename = Util.getRelativeFilename(packageOPF, el.getAttribute("href"));

            Document smilDocument = null;
            try {
                smilDocument = db.parse(new File(epubDir, filename));
            } catch (SAXParseException saxEx) {
                String lineIn = String.format("(Line: %05d Column: %05d) ", saxEx.getLineNumber(), saxEx.getColumnNumber());
                errorList.add(
                        new Issue("", "[" + Guideline.XHTML + "] " + lineIn + saxEx.getMessage(),
                                packageOPF,
                                Guideline.XHTML,
                                Issue.ERROR_ERROR
                        ));
                continue;
            }

            elapsedTime = validateSmilFile(
                smilDocument,
                filename,
                xPathExpAudio,
                elapsedTime,
                smilFiles.get("#" + el.getAttribute("id"))
            );
        }

        if (Math.abs(elapsedTime - totalTime) > 500) {
            errorList.add(new Issue(
                    "",
                    "[" +Guideline.SMIL + "] Total time in metadata " + Util.formatTime(totalTime) +
                            " does not equal total elapsed time " + Util.formatTime(elapsedTime),
                    packageOPF,
                    Guideline.SMIL,
                    Issue.ERROR_ERROR
            ));
        }
    }

    private long validateSmilFile(
        Document smilDocument,
        String smilFile,
        XPathExpression xPathExpAudio,
        long elapsedTime,
        long timeInThisSmil
    ) throws Exception {
        long timeInThisSmilFile = 0;

        NodeList nodeList = (NodeList) xPathExpAudio.evaluate(smilDocument, XPathConstants.NODESET);
        for (int i = 0; i < nodeList.getLength(); i++) {
            Element el = (Element) nodeList.item(i);
            long beginning = 0;
            long ending = 0;
            if (el.hasAttribute("clipBegin") || el.hasAttribute("clipEnd")) {
                if (!el.hasAttribute("clipBegin") || !el.hasAttribute("clipEnd")) {
                    createSmilError(smilFile, "Missing clip beginning or end at " + el.getAttribute("src"));
                    continue;
                }
                beginning = Util.parseMilliSeconds(el.getAttribute("clipBegin"));
                ending = Util.parseMilliSeconds(el.getAttribute("clipEnd"));
            } else {
                if (!el.hasAttribute("clip-begin") || !el.hasAttribute("clip-end")) {
                    createSmilError(smilFile, "Missing clip beginning or end at " + el.getAttribute("src"));
                    continue;
                }
                beginning = Util.parseMilliSeconds(el.getAttribute("clip-begin"));
                ending = Util.parseMilliSeconds(el.getAttribute("clip-end"));
            }

            String filename = Util.getRelativeFilename(smilFile, el.getAttribute("src"));

            if (beginning > audioFiles.get(filename)) {
                createSmilError(
                    smilFile,
                    "Beginning of clip " + el.getAttribute("id") + " (" +
                    Util.formatTime(beginning) + ") is not in audio " + el.getAttribute("src") + " (" +
                    Util.formatTime(audioFiles.get(filename)) + ")"
                );
            }
            if (ending > audioFiles.get(filename)) {
                createSmilError(
                    smilFile,
                    "Ending of clip " + el.getAttribute("id") + " (" +
                    Util.formatTime(ending) + ") is not in audio " + el.getAttribute("src") + " (" +
                    Util.formatTime(audioFiles.get(filename)) + ")"
                );
            }
            timeInThisSmilFile += ending - beginning;
        }

        if (Math.abs(timeInThisSmil - timeInThisSmilFile) > 500) {
            createSmilError(smilFile,
                    "Total time in this smil file " + Util.formatTime(timeInThisSmilFile) +
                            " does not match the time in metadata " + Util.formatTime(timeInThisSmil)
            );
        }

        return elapsedTime + timeInThisSmilFile;
    }

    private void createSmilError(String smilFile, String msg) {
        errorList.add(new Issue(
                "",
                "[" +Guideline.SMIL + "] " + msg,
                smilFile,
                Guideline.SMIL,
                Issue.ERROR_ERROR
        ));
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
            if (!Util.checkIfContainsDoctype(new FileInputStream(new File(epubDir, filename)))) {
                errorList.add(new Issue(
                    "",
                    "[" +Guideline.XHTML + "] <!DOCTYPE html> must be present in " + filename,
                    filename,
                    Guideline.XHTML,
                    Issue.ERROR_ERROR
                ));
            }
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

    public File getEpubDir() {
        return epubDir;
    }

    public String getPackageFile() {
        return this.packageOPF;
    }
}
