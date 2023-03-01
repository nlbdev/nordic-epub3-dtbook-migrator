package org.daisy.validator.schemas;

import com.adobe.epubcheck.api.EpubCheck;
import org.daisy.validator.ace.ACEValidator;

public class GuidelinePEF extends Guideline {

    public GuidelinePEF() {
        schemaMap.put(XHTML, new Schema("pef-validation.rng", "", ""));
    }

    @Override
    public String getSchemaPath() {
        return "pef";
    }

    @Override
    public String getGuidelineName() {
        return "PEF 1.0 - Portable Embosser Format";
    }

    @Override
    public String getNavReferenceTransformation() {
        return null;
    }
}
