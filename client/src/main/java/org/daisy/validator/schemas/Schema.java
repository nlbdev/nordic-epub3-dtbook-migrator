package org.daisy.validator.schemas;

import java.util.function.Supplier;

public class Schema {
    private String filename;
    private String document_type;
    private String description;
    private Supplier<String> versionFunction = null;

    public Schema(String filename, String document_type, String description) {
        this.filename = filename;
        this.document_type = document_type;
        this.description = description;
    }

    public Schema(String filename, String document_type, String description, Supplier<String> versionFunction) {
        this(filename, document_type, description);
        this.versionFunction = versionFunction;
    }

    public String getFilename() {
        return filename;
    }

    public String getDocumentType() {
        return document_type;
    }

    public String getDescription() {
        if(versionFunction != null) {
            return description + " " + versionFunction.get();
        }
        return description;
    }
}
