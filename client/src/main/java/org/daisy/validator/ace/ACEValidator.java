package org.daisy.validator.ace;

import org.daisy.validator.DevelopmentFlags;
import org.daisy.validator.Util;
import org.daisy.validator.report.Issue;
import org.daisy.validator.schemas.Guideline;
import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.Callable;

public class ACEValidator implements Callable<List<Issue>> {
    private static final Logger logger = Logger.getLogger(ACEValidator.class.getName());

    private static String version = null;
    private File epubFile;
    private static String acePath;

    static {
        acePath = System.getenv("ACE_PATH");
        if (acePath == null) {
           acePath = "ace";
        }

        try {
            Process process = runCommand(acePath + " --version");
            if (process.exitValue() == 0) {
                version = getResults(process);
            }
        } catch (Exception e) {}

        if (version == null) {
            System.err.println(
                "Ace not installed, to run Ace validation visit " +
                "https://daisy.github.io/ace/getting-started/installation/"
            );
        }
    }

    public ACEValidator(File epubFile) {
        this.epubFile = epubFile;
    }

    @Override
    public List<Issue> call() {
        return validate(epubFile);
    }

    public static Process runCommand(String cmd) throws Exception {
        Process process;
        if (System.getProperty("os.name").startsWith("Windows")) {
             process = Runtime.getRuntime().exec("cmd.exe /c " + cmd);
        } else {
             process = Runtime.getRuntime().exec(cmd);
        }
        int count = 0;
        while(process.isAlive() && count < 10 * 60) {
            Thread.sleep(1000);
            count++;
        }
        return process;
    }

    public static List<Issue> validate(File epubFile) {
        List<Issue> errorList = new ArrayList<>();
        if (DevelopmentFlags.ONLY_NORDIC_RULES) return errorList;
        try {
            File tempDir = Util.createTempDirectory();
            Process process = runCommand(acePath + " -o " + tempDir.getAbsolutePath() + " " + epubFile.getAbsolutePath());
            if (process.exitValue() == 0) {
                errorList = parseReport(new File(tempDir, "report.json"));
            }
            if(DevelopmentFlags.CLEAN_UP_ACE_DIR) {
                Util.deleteDirectory(tempDir);
            }
        } catch (Exception e) {
            logger.fatal(e.getMessage(), e);
            errorList.add(new Issue("", "[" +Guideline.ACE + "] " + e.getMessage(), epubFile.getName(), Guideline.ACE, Issue.ERROR_FATAL));
        }
        return errorList;
    }

    private static List<Issue> parseReport(File file) throws FileNotFoundException {
        List<Issue> errorList = new ArrayList<>();
        JSONObject report = (JSONObject) JSONValue.parse(new FileReader(file));

        if (!report.containsKey("assertions")) return errorList;
        JSONArray asserts = (JSONArray) report.get("assertions");

        for(Object issueObj : asserts) {
            JSONObject issue = (JSONObject) issueObj;
            if (!issue.containsKey("earl:testSubject")) continue;
            JSONObject fileDesc = (JSONObject) issue.get("earl:testSubject");
            if (!fileDesc.containsKey("url")) continue;
            String fileName = (String) fileDesc.get("url");
            if (!issue.containsKey("assertions")) continue;
            errorList.addAll(parseAssertions(fileName, (JSONArray) issue.get("assertions")));
        }

        return errorList;
    }

    private static List<Issue> parseAssertions(String fileName, JSONArray assertions) {
        List<Issue> errorList = new ArrayList<>();

        for(Object assertObj : assertions) {
            JSONObject issue = (JSONObject) assertObj;

            if (!issue.containsKey("earl:result")) continue;
            JSONObject resultTag = (JSONObject) issue.get("earl:result");

            if (!resultTag.containsKey("dct:description")) continue;
            String description = (String) resultTag.get("dct:description");

            if (resultTag.containsKey("html")) {
                String html = (String) resultTag.get("html");
                html = html.replaceAll("<!--##-->", "\n");
                description += "\n\n" + html;
            }

            errorList.add(new Issue(
                "", "[" +Guideline.ACE + "] " + description, fileName, Guideline.ACE, Issue.ERROR_ERROR
            ));
        }
        return errorList;
    }

    public static String getResults(Process process) throws IOException {
        BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()));
        String line = "";
        while ((line = reader.readLine()) != null) {
            return line;
        }
        return null;
    }

    public static String getVersion() {
        return version;
    }

    public static boolean isAvailable() {
        return version != null;
    }
}
