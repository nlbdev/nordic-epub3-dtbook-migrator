package org.daisy.validator.epubcheck;

import com.adobe.epubcheck.api.EPUBLocation;
import com.adobe.epubcheck.messages.Message;
import com.adobe.epubcheck.messages.Severity;
import com.adobe.epubcheck.util.DefaultReportImpl;
import com.adobe.epubcheck.util.PathUtil;
import org.daisy.validator.report.Issue;
import org.daisy.validator.schemas.Guideline;

import java.util.ArrayList;
import java.util.List;

public class NordicReportImpl extends DefaultReportImpl {
    private List<Issue> errorList = new ArrayList<>();

    public NordicReportImpl(String ePubName) {
        super(ePubName);
    }

    @Override
    public void message(Message message, EPUBLocation location, Object... args) {
        String fileName = PathUtil.removeWorkingDirectory(location.getPath());
        String lineIn = "Line: " + location.getLine() + " Col: " + location.getColumn() + " ";

        Severity severity = message.getSeverity();
        int errorCode = Issue.ERROR_WARN;
        if (severity.equals(Severity.FATAL)) {
            errorCode = Issue.ERROR_FATAL;
        } else if (severity.equals(Severity.ERROR)) {
            errorCode = Issue.ERROR_ERROR;
        }

        String messageStr = fixMessage(args != null && args.length > 0 ? message.getMessage(args) : message.getMessage());
        errorList.add(new Issue("", "[" + Guideline.EPUBCHECK + "] " + lineIn + messageStr, fileName, Guideline.EPUBCHECK, errorCode));
    }


    String fixMessage(String message) {
        if (message == null)
        {
            return "";
        }
        return message.replaceAll("[\\s]+", " ");
    }

    public List<Issue> getErrorList() {
        return errorList;
    }
}
