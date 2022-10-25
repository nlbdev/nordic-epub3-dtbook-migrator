package org.daisy.validator.report;

import java.util.Objects;

public class Issue {
    public static final int ERROR_WARN = 0;
    public static final int ERROR_ERROR = 1;
    public static final int ERROR_FATAL = 2;

    private final String location;
    private final String description;
    private final String filename;
    private final String validation_type;
    private final int errorLevel;

    public Issue(String location, String description, String filename, String validation_type, int errorLevel) {
        this.location = location;
        this.description = escapeXML(description);
        this.filename = filename;
        this.validation_type = validation_type;
        this.errorLevel = errorLevel;
    }

    private String escapeXML(String s) {
        s = s.replaceAll("&", "&amp;");
        s = s.replaceAll("<", "&lt;");
        s = s.replaceAll(">", "&gt;");
        s = s.replaceAll("\"", "&quot;");
        s = s.replaceAll("'", "&apos;");
        return s;
    }

    public String getLocation() {
        return location;
    }

    public String getDescription() {
        return description.replaceAll("\n", "<br/>");
    }

    public String getFilename() {
        return filename;
    }

    public String getValidationType() {
        return validation_type;
    }

    public int getErrorLevel() {
        return errorLevel;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Issue)) return false;
        Issue issue = (Issue) o;
        return Objects.equals(location, issue.location) && Objects.equals(description, issue.description) && Objects.equals(filename, issue.filename) && Objects.equals(validation_type, issue.validation_type);
    }

    @Override
    public int hashCode() {
        return Objects.hash(location, description, filename, validation_type);
    }
}
