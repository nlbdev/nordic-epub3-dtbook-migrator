package org.daisy.validator;

import org.daisy.validator.report.Issue;
import org.xml.sax.ErrorHandler;
import org.xml.sax.SAXException;
import org.xml.sax.SAXParseException;

import java.util.ArrayList;
import java.util.List;

public class ValidationErrorHandler implements ErrorHandler {
    private static final String PLACEMENT_FORMAT = "(Line: %05d Column: %05d) ";
    private final String filename;
    private final String validationType;
    private final List<Issue> errorList = new ArrayList<>();

    public ValidationErrorHandler(String filename, String validationType) {
        this.filename = filename;
        this.validationType = validationType;
    }

    @Override
    public void warning(SAXParseException saxEx) throws SAXException {
        String lineIn = String.format(PLACEMENT_FORMAT, saxEx.getLineNumber(), saxEx.getColumnNumber());
        errorList.add(new Issue("", "[" + validationType + "] " + lineIn + saxEx.getMessage(), filename, validationType, Issue.ERROR_WARN));
    }

    @Override
    public void error(SAXParseException saxEx) throws SAXException {
        String lineIn = String.format(PLACEMENT_FORMAT, saxEx.getLineNumber(), saxEx.getColumnNumber());
        errorList.add(new Issue("", "[" + validationType + "] " + lineIn + saxEx.getMessage(), filename, validationType, Issue.ERROR_ERROR));
    }

    @Override
    public void fatalError(SAXParseException saxEx) throws SAXException {
        String lineIn = String.format(PLACEMENT_FORMAT, saxEx.getLineNumber(), saxEx.getColumnNumber());
        errorList.add(new Issue("", "[" + validationType + "] " + lineIn + saxEx.getMessage(), filename, validationType, Issue.ERROR_FATAL));
    }

    public List<Issue> getErrorList() {
        return errorList;
    }
}
