package org.daisy.validator.report;

import org.daisy.validator.EPUBFiles;
import org.daisy.validator.NordicValidator;
import org.daisy.validator.schemas.Guideline;
import org.daisy.validator.schemas.Guideline2015;
import org.daisy.validator.schemas.Schema;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.w3c.dom.Document;
import org.w3c.dom.NodeList;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathFactory;

public class ReportGenerator {
    public void generateJSONReport(Guideline guideline, String inputFile, String output, List<Issue> issueList) throws Exception {
        JSONObject report = new JSONObject();

        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        report.put("created", dateFormat.format(new Date()));
        report.put("filename", inputFile);

        String errorStatus = "SUCCESS";
        if (issueList.size() > 0) {
            errorStatus = "FAIL";
        }

        report.put("status", errorStatus);
        report.put("issue-count", issueList.size());
        report.put("guideline", guideline.getGuidelineName());

        JSONArray issuesJSON = new JSONArray();

        for (Issue i : issueList) {
            JSONObject issueJSON = new JSONObject();
            issueJSON.put("description", i.getDescription());
            issueJSON.put("filename", i.getFilename());
            issueJSON.put("location", i.getLocation());
            issueJSON.put("validation-type", i.getValidationType());
            issuesJSON.add(issueJSON);
        }

        report.put("issues", issuesJSON);
        report.put("schema-info", guideline.getSchemaInformationJSON());

        FileWriter fw = new FileWriter(output);
        report.writeJSONString(fw);
        fw.close();
    }

    public void generateHTMLReport(Guideline guideline, String input, String output, List<Issue> issues) throws Exception {
        InputStream inputStream = ReportGenerator.class.getResourceAsStream("/templates/document.html");
        String text = new BufferedReader(new InputStreamReader(inputStream, StandardCharsets.UTF_8))
                .lines().collect(Collectors.joining("\n"));

        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm:ss");

        text = text.replace("[DATE]", dateFormat.format(new Date()));
        text = text.replace("[TIME]", timeFormat.format(new Date()));
        text = text.replace("[SOFTWARE]", "NordicValidator " + getVersion());
        text = text.replace("[FILENAME]", input);
        String guidelineName = guideline == null ? "Unknown" : guideline.getGuidelineName();
        text = text.replace("[GUIDELINE]", guidelineName);

        String issueClass = issues.size() > 0 ? "error" : "success";
        text = text.replace("[ISSUES_FOUND]", String.format("<p class='%s'>%d issues found.</p>", issueClass, issues.size()));

        Map<String, List<Issue>> issuePerFile = sortByFile(issues);
        String report = "";

        List<String> filenamesList = new ArrayList<>(issuePerFile.keySet());
        Collections.sort(filenamesList);
        for(String key : filenamesList) {
            report += generateReportData(guideline, key, issuePerFile.get(key));
        }

        text = text.replace("[REPORTS]", report);

        BufferedWriter writer = new BufferedWriter(new FileWriter(output));
        writer.write(text);

        writer.close();
    }

    private String getVersion() {
        String version = NordicValidator.class.getPackage().getImplementationVersion();
        if (version == null) {
            version = "Unknown";
            try {
                DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
                DocumentBuilder db = dbf.newDocumentBuilder();
                Document doc = db.parse("pom.xml");
                XPath xPath = XPathFactory.newInstance().newXPath();
                NodeList nodeList = (NodeList) xPath.compile("/project/version")
                    .evaluate(doc, XPathConstants.NODESET);
                return nodeList.item(0).getTextContent();
            } catch (Exception e) {}
        }
        return version;
    }

    private String generateReportData(Guideline guideline, String filename, List<Issue> issues) {
        InputStream inputStream = ReportGenerator.class.getResourceAsStream("/templates/report.html");
        String text = new BufferedReader(new InputStreamReader(inputStream, StandardCharsets.UTF_8))
                .lines().collect(Collectors.joining("\n"));

        Schema s = new Guideline2015().getSchema(issues.get(0).getValidationType());
        if(guideline != null) {
            s = guideline.getSchema(issues.get(0).getValidationType());
        }

        File file = new File(filename);
        text = text.replace("[DESCRIPTION]", s.getDescription().isEmpty() ? file.getName() : s.getDescription());
        text = text.replace("[VALIDATION_TYPE]", s.getDocumentType());
        text = text.replace("[FILENAME]", replaceSpecialNames(filename));

        InputStream issueInputStream = ReportGenerator.class.getResourceAsStream("/templates/issue.html");
        String issueTemplate = new BufferedReader(new InputStreamReader(issueInputStream, StandardCharsets.UTF_8))
                .lines().collect(Collectors.joining("\n"));

        String issuesText = "";
        int issuesFound = 0;

        Collections.sort(issues, Comparator.comparing(Issue::getDescription));

        for (Issue i : issues) {
            String issueText = issueTemplate;
            String issueType = "warning";
            if(i.getErrorLevel() == Issue.ERROR_ERROR) {
                issueType = "error";
                issuesFound++;
            } else if(i.getErrorLevel() == Issue.ERROR_FATAL) {
                issueType = "fatal";
                issuesFound++;
            }
            issueText = issueText.replace("[TYPE]", issueType);
            issueText = issueText.replace("[LOCATION]", i.getLocation());
            issueText = issueText.replace("[TEXT]", i.getDescription());
            issuesText += issueText;
        }

        String issueClass = issuesFound > 0 ? "error" : "success";
        text = text.replace("[ISSUES_FOUND]", String.format("<p class='%s'>%d issues found.</p>", issueClass, issuesFound));

        text = text.replace("[ISSUE_LIST]", issuesText);

        return text;
    }

    private CharSequence replaceSpecialNames(String filename) {
        if (EPUBFiles.SPECIAL_NAMES_MAP.containsKey(filename)) {
            return EPUBFiles.SPECIAL_NAMES_MAP.get(filename);
        }
        return filename;
    }

    private Map<String, List<Issue>> sortByFile(List<Issue> issues) {
        Map<String, List<Issue>> issuesPerFile = new HashMap<>();
        for (Issue i : issues) {
            if(!issuesPerFile.containsKey(i.getFilename())) {
                issuesPerFile.put(i.getFilename(), new ArrayList<>());
            }
            issuesPerFile.get(i.getFilename()).add(i);
        }
        return issuesPerFile;
    }
}
