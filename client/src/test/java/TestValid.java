import org.daisy.validator.DevelopmentFlags;
import org.daisy.validator.EPUBFiles;
import org.daisy.validator.TransformFile;
import org.daisy.validator.Util;
import org.daisy.validator.ValidateFile;
import org.daisy.validator.report.Issue;
import org.daisy.validator.schemas.Guideline;
import org.daisy.validator.schemas.Guideline2020;
import org.junit.Assert;
import org.junit.Ignore;
import org.junit.Test;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStreamWriter;
import java.io.StringWriter;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.xml.transform.Result;
import javax.xml.transform.Source;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

public class TestValid {
    @Test
    public void testOPF() throws Exception {
        Guideline guideline = new Guideline2020();

        TransformFile tf = new TransformFile(
            new File("src/test/resources/valid2020"),
            "EPUB/package.opf",
            new File("src/main/resources/2020-1", guideline.getSchema(Guideline.OPF).getFilename()),
            Guideline.OPF,
            false
        );
        Set<Issue> issues = new HashSet<>();
        issues.addAll(tf.call());

        for(Issue i : issues) {
            System.out.println(i.getDescription());
        }

        assertEquals(0, issues.size());
    }

    @Test
    public void testCoverPNG_OPF() throws Exception {
        Guideline guideline = new Guideline2020();

        TransformFile tf = new TransformFile(
                new File("src/test/resources/coverpng"),
                "EPUB/package.opf",
                new File("src/main/resources/2020-1", guideline.getSchema(Guideline.OPF).getFilename()),
                Guideline.OPF,
                false
        );
        Set<Issue> issues = new HashSet<>();
        issues.addAll(tf.call());

        for (Issue i : issues) {
            System.out.println(i.getDescription());
        }

        assertEquals(0, issues.size());
    }

    @Test
    public void testDocType() throws Exception {
        Assert.assertFalse(
            "Check that we can not find a doctype in file",
            Util.checkIfContainsDoctype(new FileInputStream("src/test/resources/without-doctype.xhtml"))
        );
        Assert.assertTrue(
            "Check that we can find a doctype in file",
            Util.checkIfContainsDoctype(new FileInputStream("src/test/resources/with-doctype.xhtml"))
        );
    }

    @Test
    public void testTOC() throws Exception {
        Guideline guideline = new Guideline2020();

        File tmp = File.createTempFile("Test", ".xml");

        String htmlData = createData(guideline);
        String navData = Util.readStreamText(new FileInputStream("src/test/resources/valid2020/EPUB/nav.xhtml"));

        navData = insertBeforeHeader(navData, htmlData);

        FileOutputStream fos2 = new FileOutputStream(tmp);
        BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(fos2, "UTF-8"));
        writer.write(navData);
        writer.flush();
        writer.close();

        TransformFile tf = new TransformFile(
                new File(tmp.getParent()),
                tmp.getName(),
                new File("src/main/resources/2020-1", guideline.getSchema(Guideline.NAV_REFERENCES).getFilename()),
                Guideline.NAV_REFERENCES,
                false
        );
        Set<Issue> issues = new HashSet<>();
        issues.addAll(tf.call());

        for(Issue i : issues) {
            System.out.println(i.getDescription().replaceAll("&quot;", "\""));
        }

        assertEquals(0, issues.size());
    }

    private String createData(Guideline guideline) throws Exception {

        InputStream in = EPUBFiles.class.getResourceAsStream(guideline.getNavReferenceTransformation());
        Transformer transformer = TransformerFactory.newInstance().newTransformer(new StreamSource(in));

        StringBuilder data = new StringBuilder("<c:result xmlns:c=\"http://www.w3.org/ns/xproc-step\">");
        List<String> list = List.of(
            "C00000-01-cover.xhtml",
            "C00000-02-toc.xhtml",
            "C00000-03-frontmatter.xhtml",
            "C00000-04-chapter.xhtml",
            "C00000-05-chapter.xhtml",
            "C00000-06-chapter.xhtml",
            "C00000-07-rearnotes.xhtml",
            "C00000-08-chapter.xhtml",
            "C00000-09-part.xhtml",
            "C00000-10-chapter.xhtml",
            "C00000-11-conclusion.xhtml",
            "C00000-12-toc.xhtml",
            "C00000-13-part.xhtml",
            "C00000-14-chapter.xhtml",
            "C00000-15-chapter.xhtml",
            "C00000-16-part.xhtml",
            "C00000-17-chapter.xhtml"
        );

        for (String filename : list) {
            Source xmlInput = new StreamSource(new File("src/test/resources/valid2020/EPUB/", filename));
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

    private static String insertBeforeHeader(String navData, String htmlData) {
        Pattern findHead = Pattern.compile("<head[^>]*");
        Matcher matcher = findHead.matcher(navData);
        if(matcher.find()) {
            String fixStr = navData.substring(0, matcher.start());
            fixStr += htmlData + "\n";
            fixStr += navData.substring(matcher.start());
            return fixStr;
        } else {
            System.out.println("DID NOT FIND HEAD TAG.");
        }
        return navData;
    }

    @Test
    public void testNavNcx() throws Exception {
        Guideline guideline = new Guideline2020();

        File tmp = File.createTempFile("Test", ".xml");

        FileOutputStream fos = new FileOutputStream(tmp);
        FileInputStream ncxInput = new FileInputStream("src/test/resources/valid2020/EPUB/nav.ncx");
        FileInputStream navInput = new FileInputStream("src/test/resources/valid2020/EPUB/nav.xhtml");
        BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(fos));
        bw.write("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
        bw.newLine();
        bw.write("<c:result xmlns:c=\"http://www.w3.org/ns/xproc-step\">");
        bw.newLine();
        bw.flush();
        Util.appendXML(bw, ncxInput);
        bw.flush();
        bw.flush();
        Util.appendXML(bw, navInput);
        bw.flush();
        bw.write("</c:result>");
        bw.close();

        TransformFile tf = new TransformFile(
                new File(tmp.getParent()),
                tmp.getName(),
                new File("src/main/resources/2020-1", guideline.getSchema(Guideline.NAV_NCX).getFilename()),
                Guideline.NAV_NCX,
                false
        );
        Set<Issue> issues = new HashSet<>();
        issues.addAll(tf.call());

        for(Issue i : issues) {
            System.out.println(i.getDescription());
        }

        assertEquals(0, issues.size());
    }

    @Test
    public void testContentChapter() throws Exception {
        Guideline guideline = new Guideline2020();

        TransformFile tf = new TransformFile(
                new File("src/test/resources/valid2020"),
                "EPUB/C00000-04-chapter.xhtml",
                new File("src/main/resources/2020-1", guideline.getSchema(Guideline.CONTENT_FILES).getFilename()),
                Guideline.CONTENT_FILES,
                false
        );
        Set<Issue> issues = new HashSet<>();
        issues.addAll(tf.call());

        for(Issue i : issues) {
            System.out.println(i.getDescription());
        }

        assertEquals(0, issues.size());
    }

    @Test
    public void testContentBackmatter() throws Exception {
        Guideline guideline = new Guideline2020();

        TransformFile tf = new TransformFile(
                new File("src/test/resources/valid2020"),
                "EPUB/C00000-12-toc.xhtml",
                new File("src/main/resources/2020-1", guideline.getSchema(Guideline.CONTENT_FILES).getFilename()),
                Guideline.CONTENT_FILES,
                false
        );
        Set<Issue> issues = new HashSet<>();
        issues.addAll(tf.call());

        for(Issue i : issues) {
            System.out.println(i.getDescription());
        }

        assertEquals(0, issues.size());
    }

    public void verifyRelaxDoc(String doc) throws Exception {
        Guideline guideline = new Guideline2020();

        EPUBFiles epubFiles = new EPUBFiles(doc, "");
        epubFiles.unpackSchemaDir(guideline.getSchemaPath());
        epubFiles.unpackSchemaDir("mathml3");

        ValidateFile vf = new ValidateFile(
                new File("src/test/resources/valid2020"),
                doc,
                new File(epubFiles.getSchemaDir(), guideline.getSchema(Guideline.XHTML).getFilename()),
                Guideline.XHTML
        );
        Set<Issue> issues = new HashSet<>();
        issues.addAll(vf.call());

        for(Issue i : issues) {
            System.out.println(i.getDescription());
        }

        assertEquals(0, issues.size());
    }

    @Test
    public void testRelaxNGContentChapter() throws Exception {
        verifyRelaxDoc("EPUB/C00000-04-chapter.xhtml");
    }

    @Test
    public void testRelaxNote() throws Exception {
        verifyRelaxDoc("EPUB/C00000-07-rearnotes.xhtml");
    }

    @Test
    public void testX50525() throws Exception {
        verifyRelaxDoc("EPUB/X50525A-06-chapter.xhtml");
    }

    @Test
    public void testX60352() throws Exception {
        verifyRelaxDoc("EPUB/X60352A-01-cover.xhtml");
        verifyRelaxDoc("EPUB/X60352A-02-titlepage.xhtml");
    }


    @Test
    public void testDevelopmentFlagNotSet() {
        assertFalse(
            "The flag ONLY_NORDIC_RULES should never be true when building a release",
            DevelopmentFlags.ONLY_NORDIC_RULES
        );
        assertTrue(
            "The flag CLEAN_UP_SCHEMA_DIR should never be false when building a release",
            DevelopmentFlags.CLEAN_UP_SCHEMA_DIR
        );
        assertTrue(
            "The flag CLEAN_UP_EPUB_DIR should never be false when building a release",
            DevelopmentFlags.CLEAN_UP_EPUB_DIR
        );
        assertTrue(
                "The flag CLEAN_UP_ACE_DIR should never be false when building a release",
                DevelopmentFlags.CLEAN_UP_ACE_DIR
        );
    }

}
