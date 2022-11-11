package org.daisy.validator.epubcheck;

import com.adobe.epubcheck.api.EpubCheck;
import org.daisy.validator.DevelopmentFlags;
import org.daisy.validator.report.Issue;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.Callable;

public class EPUBCheckValidator implements Callable<List<Issue>> {
    private final File epub;

    public EPUBCheckValidator(File epub) throws Exception {
        this.epub = epub;
    }

    @Override
    public List<Issue> call() {
        if (DevelopmentFlags.ONLY_NORDIC_RULES) return new ArrayList<>();
        NordicReportImpl nordicReport = new NordicReportImpl(epub.getName());
        EpubCheck epubCheck = new EpubCheck(epub, nordicReport);
        epubCheck.doValidate();

        return nordicReport.getErrorList();
    }
}
