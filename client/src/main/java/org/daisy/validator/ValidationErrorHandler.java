package org.daisy.validator;

import org.daisy.validator.report.Issue;
import org.daisy.validator.schemas.Guideline;
import org.xml.sax.ErrorHandler;
import org.xml.sax.SAXException;
import org.xml.sax.SAXParseException;

import java.util.ArrayList;
import java.util.List;

public class ValidationErrorHandler implements ErrorHandler {
    private static final String PLACEMENT_FORMAT = "(Line: %05d Column: %05d) ";
    private final String filename;
    private final List<Issue> errorList = new ArrayList<>();

    public ValidationErrorHandler(String filename) {
        this.filename = filename;
    }

    @Override
    public void warning(SAXParseException saxEx) throws SAXException {
        String lineIn = String.format(PLACEMENT_FORMAT, saxEx.getLineNumber(), saxEx.getColumnNumber());
        errorList.add(new Issue("", "[" + Guideline.XHTML + "] " + lineIn + saxEx.getMessage(), filename, Guideline.XHTML, Issue.ERROR_WARN));
    }

    @Override
    public void error(SAXParseException saxEx) throws SAXException {
        String lineIn = String.format(PLACEMENT_FORMAT, saxEx.getLineNumber(), saxEx.getColumnNumber());
        errorList.add(new Issue("", "[" + Guideline.XHTML + "] " + lineIn + saxEx.getMessage(), filename, Guideline.XHTML, Issue.ERROR_ERROR));
    }

    @Override
    public void fatalError(SAXParseException saxEx) throws SAXException {
        String lineIn = String.format(PLACEMENT_FORMAT, saxEx.getLineNumber(), saxEx.getColumnNumber());
        errorList.add(new Issue("", "[" + Guideline.XHTML + "] " + lineIn + saxEx.getMessage(), filename, Guideline.XHTML, Issue.ERROR_FATAL));
    }

    public List<Issue> getErrorList() {
        return errorList;
    }
}
