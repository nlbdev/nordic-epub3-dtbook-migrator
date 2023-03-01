package org.daisy.validator.schemas;

import org.json.simple.JSONObject;

import java.util.HashMap;
import java.util.Map;

public abstract class Guideline {
    public static final String PEF = "pef";
    public static final String CONTENT_FILES = "content_files_schema";
    public static final String NAV_NCX = "nav_ncx";
    public static final String NAV_REFERENCES = "nav_references";
    public static final String OPF = "opf";
    public static final String OPF_AND_HTML = "opf_and_html";
    public static final String XHTML = "xhtml";
    public static final String EPUB = "epub";
    public static final String EPUBCHECK = "epubcheck";
    public static final String ACE = "ace";

    protected Map<String, Schema> schemaMap = new HashMap<>();

    public Schema getSchema(String schema) {
        return schemaMap.get(schema);
    }

    public abstract String getSchemaPath();

    public abstract String getGuidelineName();

    public JSONObject getSchemaInformationJSON() {
        String[] schemaFiles = new String[] {
            CONTENT_FILES, NAV_NCX, NAV_REFERENCES, OPF, OPF_AND_HTML, XHTML, EPUB, EPUBCHECK, ACE
        };
        JSONObject allSchemas = new JSONObject();
        for (String schemaName : schemaFiles) {
            Schema schema = getSchema(schemaName);
            JSONObject schemaJSON = new JSONObject();
            schemaJSON.put("filename", schema.getFilename());
            schemaJSON.put("description", schema.getDescription());
            schemaJSON.put("document-type", schema.getDocumentType());
            allSchemas.put(schemaName, schemaJSON);
        }
        return allSchemas;
    }

    public abstract String getNavReferenceTransformation();
}
