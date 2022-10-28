package org.daisy.validator;

import org.daisy.validator.report.Issue;
import org.daisy.validator.report.ReportGenerator;
import org.daisy.validator.schemas.Guideline;
import org.daisy.validator.schemas.Guideline2015;
import org.daisy.validator.schemas.Guideline2020;
import org.apache.commons.cli.CommandLine;
import org.apache.commons.cli.CommandLineParser;
import org.apache.commons.cli.DefaultParser;
import org.apache.commons.cli.HelpFormatter;
import org.apache.commons.cli.Option;
import org.apache.commons.cli.Options;
import org.apache.commons.cli.ParseException;
import org.apache.log4j.ConsoleAppender;
import org.apache.log4j.Level;
import org.apache.log4j.Logger;
import org.apache.log4j.PatternLayout;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;

import java.io.File;
import java.io.PrintWriter;
import java.time.Duration;
import java.time.Instant;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Enumeration;
import java.util.List;
import java.util.Set;
import java.util.zip.ZipEntry;
import java.util.zip.ZipFile;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

public class NordicValidator {
    private static final Logger logger = Logger.getLogger(NordicValidator.class.getName());

    private static final Option ARG_ORIGINAL_FILE = new Option(null, "original-file", true, "The original filename");
    private static final Option ARG_SCHEMA = new Option("s", "schema", true, "Schema to validate against. (default 2020-1)");
    private static final Option ARG_THREADS = new Option("t", "threads", true, "Number of threads to use for validation (default 3)");
    private static final Option ARG_OUTPUT_HTML = new Option("h", "output-html", true, "Output an HTML report");
    private static final Option ARG_OUTPUT_JSON = new Option("j", "output-json", true, "Output validation information as JSON");
    private static final Option ARG_NO_EPUBCHECK = new Option(null, "no-epubcheck", false, "Don't validate with EPUBCheck");
    private static final Option ARG_NO_ACE = new Option(null, "no-ace", false, "Don't validate with Ace");


    private static void printHelp(Options options) {
        HelpFormatter formatter = new HelpFormatter();
        PrintWriter pw = new PrintWriter(System.out);
        pw.println("NordicValidator " + NordicValidator.class.getPackage().getImplementationVersion());
        pw.println();
        formatter.printUsage(pw, 100, "java -jar NordicValidator.jar [options] [inputfile]");
        formatter.printOptions(pw, 100, options, 2, 5);
        pw.close();
    }

    public static void exitWithError(String s, Options options) {
        System.out.println(s);
        System.out.println();
        printHelp(options);
        System.exit(1);
    }

    public static void main(String[] args) {
        try {
            final String PATTERN = "%d [%p|%c|%C{1}] %m%n";
            ConsoleAppender console = new ConsoleAppender();
            console.setLayout(new PatternLayout(PATTERN));
            console.setThreshold(Level.INFO);
            console.activateOptions();
            Logger.getRootLogger().addAppender(console);

            CommandLineParser parser = new DefaultParser();
            Options options = new Options();
            options.addOption(ARG_SCHEMA);
            options.addOption(ARG_THREADS);
            options.addOption(ARG_OUTPUT_HTML);
            options.addOption(ARG_OUTPUT_JSON);
            options.addOption(ARG_ORIGINAL_FILE);
            options.addOption(ARG_NO_EPUBCHECK);
            options.addOption(ARG_NO_ACE);

            CommandLine cmd = null;
            try {
                cmd = parser.parse(options, args);
            } catch (ParseException e) {
                exitWithError(e.getMessage(), options);
            }

            if (cmd == null || cmd.getArgList().size() != 1) {
                exitWithError("Input file required", options);
            }

            String inputFile = cmd.getArgList().get(0);
            ZipFile zipFile = new ZipFile(inputFile);

            Guideline guideline = null;
            if (
                cmd.hasOption(ARG_SCHEMA.getLongOpt()) &&
                "2015-1".equals(cmd.getOptionValue(ARG_SCHEMA.getLongOpt()))
            ) {
                guideline = new Guideline2015();
            }
            if (
                cmd.hasOption(ARG_SCHEMA.getLongOpt()) &&
                "2020-1".equals(cmd.getOptionValue(ARG_SCHEMA.getLongOpt()))
            ) {
                guideline = new Guideline2020();
            }

            int threads = 3;
            if (cmd.hasOption(ARG_THREADS.getLongOpt())) {
                threads = Integer.parseInt(cmd.getOptionValue(ARG_THREADS.getLongOpt()));
            }

            EPUBFiles epubFiles = getEPUBFiles(zipFile, threads, guideline);

            Instant epubValidate = Instant.now();
            if (!cmd.hasOption(ARG_NO_ACE.getLongOpt())) {
                epubFiles.validateWithAce(new File(inputFile));
            }
            if (!cmd.hasOption(ARG_NO_EPUBCHECK.getLongOpt())) {
                epubFiles.validateWithEpubCheck(new File(inputFile));
            }

            epubFiles.validate();
            printDuration("EPUB Validate", epubValidate, Instant.now());
            epubFiles.cleanUp();

            Set<Issue> errorList = epubFiles.getErrorList();

            List<Issue> issueList = new ArrayList<>();
            issueList.addAll(errorList);

            if (cmd.hasOption(ARG_ORIGINAL_FILE.getLongOpt())) {
                inputFile = cmd.getOptionValue(ARG_ORIGINAL_FILE.getLongOpt());
            }
            if (cmd.hasOption(ARG_OUTPUT_HTML.getLongOpt())) {
                ReportGenerator rg = new ReportGenerator();
                rg.generateHTMLReport(epubFiles.getGuideline(), inputFile, cmd.getOptionValue(ARG_OUTPUT_HTML.getLongOpt()), issueList);
            }
            if (cmd.hasOption(ARG_OUTPUT_JSON.getLongOpt())) {
                ReportGenerator rg = new ReportGenerator();
                rg.generateJSONReport(epubFiles.getGuideline(), inputFile, cmd.getOptionValue(ARG_OUTPUT_JSON.getLongOpt()), issueList);
            }

            if (!cmd.hasOption(ARG_OUTPUT_HTML.getLongOpt()) && !cmd.hasOption(ARG_OUTPUT_JSON.getLongOpt())) {
                List<Issue> listOfIssues = new ArrayList<>();
                listOfIssues.addAll(issueList);

                Collections.sort(listOfIssues, Comparator.comparing(Issue::getDescription));

                for(Issue i : listOfIssues) {
                    System.out.println(i.getDescription() + " (" + i.getFilename() + ")");
                }
            }

            if (errorList.size() > 0) {
                System.exit(1);
            }
            System.exit(0);
            System.exit(0);
        } catch (Exception e) {
            logger.fatal(e.getMessage(), e);
            System.exit(1);
        }
    }

    private static void printDuration(String label, Instant before, Instant after) {
        Duration dur = Duration.between(before, after);
        System.out.println(label + "\t\t" + String.format("%02d:%02d:%02d:%03d", dur.toHoursPart(), dur.toMinutesPart(),dur.toSecondsPart(), dur.toMillisPart()));
    }

    public static EPUBFiles getEPUBFiles(ZipFile zipFile, int threads, Guideline guideline) throws Exception {
        Enumeration<? extends ZipEntry> entries = zipFile.entries();
        ZipEntry mimetypeEntry = zipFile.getEntry("mimetype");
        if (mimetypeEntry == null) {
            return new EPUBFiles(zipFile.getName(), "Not a EPUB file (missing mimetype)");
        }
        String mimetype = Util.readStreamText(zipFile.getInputStream(mimetypeEntry));
        if (!"application/epub+zip".equals(mimetype.trim())) {
            return new EPUBFiles(zipFile.getName(), "Not a EPUB file (wrong mimetype)");
        }

        ZipEntry containerEntry = zipFile.getEntry("META-INF/container.xml");
        if (containerEntry == null) {
            return new EPUBFiles(zipFile.getName(), "Not a EPUB file (missing container)");
        }

        DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
        DocumentBuilder db = dbf.newDocumentBuilder();
        Document doc = db.parse(zipFile.getInputStream(containerEntry));
        doc.getDocumentElement().normalize();
        NodeList nodeList = doc.getElementsByTagName("rootfile");
        if (nodeList.getLength() != 1) {
            return new EPUBFiles(zipFile.getName(), "Not a EPUB file (missing rootfile)");
        }
        Element rootFile = (Element)nodeList.item(0);

        if (!rootFile.hasAttribute("full-path")) {
            return new EPUBFiles(zipFile.getName(), "Not a EPUB file (missing root path)");
        }

        return new EPUBFiles(rootFile.getAttribute("full-path"), threads, zipFile, guideline);
    }
}
