package org.daisy.validator.schemas;

import com.adobe.epubcheck.api.EpubCheck;
import org.daisy.validator.ace.ACEValidator;

public class Guideline2015 extends Guideline {

    public Guideline2015() {
        schemaMap.put(CONTENT_FILES, new Schema("nordic2015-1.xsl", "Nordic HTML (EPUB3 Content Document)", ""));
        schemaMap.put(NAV_NCX, new Schema("nordic2015-1.nav-ncx.xsl", "Nordic EPUB3 NCX and Navigation Document", ""));
        schemaMap.put(NAV_REFERENCES, new Schema("nordic2015-1.nav-references.xsl",
            "Nordic EPUB3 Navigation Document References",
            "References from the navigation document to the content documents"
        ));
        schemaMap.put(OPF, new Schema("nordic2015-1.opf.xsl", "Nordic EPUB3 Package Document", ""));
        schemaMap.put(OPF_AND_HTML, new Schema("nordic2015-1.opf-and-html.xsl", "Nordic EPUB3 OPF+HTML", "Cross-document references and metadata"));
        schemaMap.put(XHTML, new Schema("nordic-html5.rng", "Nordic HTML (EPUB3 Content Document)", ""));
        schemaMap.put(EPUB, new Schema("", "Nordic EPUB3", "General EPUB requirements"));
        schemaMap.put(EPUBCHECK, new Schema("", "EPUBCheck EPUB3", "Validating with EPUBCheck " + EpubCheck.version()));
        schemaMap.put(ACE, new Schema("", "DAISY Accessibility Checker for EPUB", "Validating with ACE " + ACEValidator.getVersion()));
    }

    @Override
    public String getSchemaPath() {
        return "2015-1";
    }

    @Override
    public String getGuidelineName() {
        return "Nordic EPUB Guideline 2015-1";
    }

    @Override
    public String getNavReferenceTransformation() {
        return "/xslt/2015-1/list-heading-and-pagebreak-references.xsl";
    }
}
