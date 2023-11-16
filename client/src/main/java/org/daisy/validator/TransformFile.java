package org.daisy.validator;

import net.sf.saxon.trans.XPathException;
import org.daisy.validator.report.Issue;
import net.sf.saxon.Configuration;
import net.sf.saxon.lib.FeatureKeys;
import net.sf.saxon.s9api.Processor;
import net.sf.saxon.s9api.SaxonApiException;
import net.sf.saxon.s9api.Serializer;
import net.sf.saxon.s9api.Xslt30Transformer;
import net.sf.saxon.s9api.XsltCompiler;
import net.sf.saxon.s9api.XsltExecutable;
import org.daisy.validator.schemas.Guideline;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;
import org.xml.sax.SAXParseException;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.Callable;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.sax.SAXSource;
import javax.xml.transform.stream.StreamSource;

public class TransformFile implements Callable<List<Issue>> {
    private final Xslt30Transformer transformer;
    private final ByteArrayOutputStream resultStream = new ByteArrayOutputStream();
    private final File file;
    private final String schemaType;
    private final Serializer serializer;
    private String filename;

    public TransformFile(File epubDir, String filename, String schemaType, File transformer) throws Exception {
        Processor processor = new Processor(false);
        XsltCompiler compiler = processor.newXsltCompiler();
        XsltExecutable xslt = compiler.compile(new StreamSource(transformer));
        this.transformer = xslt.load30();
        this.serializer = processor.newSerializer(resultStream);
        this.file = new File(epubDir, filename);
        this.filename = filename;
        this.schemaType = schemaType;
    }

    private InputSource getConfigurationAsInputSource() {
        // see http://www.saxonica.com/documentation9.5/configuration/configuration%2Dfile
        return new InputSource(new ByteArrayInputStream((
                "<configuration xmlns='http://saxon.sf.net/ns/configuration'>" +
                        "   <global expandAttributeDefaults='false'" +
                        "           lineNumbering='true'" +
                        "           suppressXsltNamespaceCheck='true'/>" +
                        "</configuration>\n"
                ).getBytes(StandardCharsets.UTF_8)));
    }

    private void setConfiguration(Processor processor) throws Exception {
        Configuration config = Configuration.readConfiguration(new SAXSource(getConfigurationAsInputSource()));
        processor.setConfigurationProperty(FeatureKeys.CONFIGURATION, config);
        config.setProcessor(processor);
    }

    public TransformFile(File epubDir, String filename, File transformer, String schemaType, boolean dontPrintFile) throws Exception {
        this(epubDir, filename, schemaType, transformer);
        if (dontPrintFile) {
            this.filename = "";
        }
    }

    @Override
    public List<Issue> call() throws Exception {
        List<Issue> errorList = new ArrayList<>();

        StreamSource source = new StreamSource(file);

        try {
            transformer.applyTemplates(source, serializer);
        } catch (SaxonApiException sae) {
            sae.printStackTrace();
            Throwable saxEx = sae;
            if (saxEx.getCause() instanceof XPathException) {
                saxEx = saxEx.getCause();
            }
            if (saxEx.getCause() instanceof SAXParseException) {
                saxEx = saxEx.getCause();
            }
            if (saxEx instanceof SAXParseException) {
                SAXParseException saxExp = (SAXParseException) saxEx;
                String lineIn = String.format("(Line: %05d Column: %05d) ", saxExp.getLineNumber(), saxExp.getColumnNumber());
                errorList.add(
                new Issue("", "[" + schemaType + "] " + lineIn + saxExp.getMessage(),
                    filename,
                    schemaType,
                    Issue.ERROR_ERROR
                ));
            } else {
                errorList.add(
                    new Issue(
                        "",
                        "Line: " + sae.getLineNumber() + " " + sae.getMessage(),
                        filename,
                        schemaType,
                        Issue.ERROR_ERROR
                    )
                );
            }
            return errorList;
        } catch (Exception e) {
            if (e.getCause() instanceof SAXParseException) {
                SAXParseException saxEx = (SAXParseException) e.getCause();
                String lineIn = String.format("(Line: %05d Column: %05d) ", saxEx.getLineNumber(), saxEx.getColumnNumber());
                errorList.add(
                    new Issue("", "[" + Guideline.XHTML + "] " + lineIn + saxEx.getMessage(),
                        filename,
                        Guideline.OPF,
                        Issue.ERROR_ERROR
                    ));
                e.printStackTrace();
            }
            errorList.add(new Issue("", e.getMessage(), filename, schemaType, Issue.ERROR_ERROR));
            return errorList;
        }

        DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
        DocumentBuilder db = dbf.newDocumentBuilder();
        Document doc = db.parse(new ByteArrayInputStream(resultStream.toByteArray()));

        NodeList failedList = doc.getElementsByTagName("svrl:failed-assert");
        for(int i = 0; i < failedList.getLength(); i++) {
            Element element = (Element)failedList.item(i);
            String res = element.getElementsByTagName("svrl:text").item(0).getTextContent();
            errorList.add(new Issue(removeQualifier(element.getAttribute("location")), trim(res), filename, schemaType, Issue.ERROR_ERROR));
        }

        NodeList successList = doc.getElementsByTagName("svrl:successful-report");
        for(int i = 0; i < successList.getLength(); i++) {
            Element element = (Element)successList.item(i);
            String res = element.getElementsByTagName("svrl:text").item(0).getTextContent();
            errorList.add(new Issue(removeQualifier(element.getAttribute("location")), trim(res), filename, schemaType, Issue.ERROR_WARN));
        }

        return errorList;
    }

    private String removeQualifier(String s) {
        s = s.replaceAll("Q\\{[^}]+}", "");
        s = s.replace("Q{}", "");
        return s;
    }

    private String trim(String s) {
        s = s.replaceAll("\n", "").replaceAll("\t", " ");
        while (s.indexOf("  ") != -1) {
            s = s.replaceAll("  ", " ");
        }
        return s;
    }
}
