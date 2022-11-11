package org.daisy.validator;

import org.daisy.validator.report.Issue;
import org.daisy.validator.schemas.Guideline;
import com.thaiopensource.relaxng.jaxp.XMLSyntaxSchemaFactory;
import com.thaiopensource.validation.Schema2;
import com.thaiopensource.validation.Validator2;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.Callable;
import javax.xml.transform.stream.StreamSource;

public class ValidateFile implements Callable<List<Issue>> {
    private final Validator2 validator;
    private final File file;
    private final String filename;

    public ValidateFile(File epubDir, String filename, File validatorFile) throws Exception {
        XMLSyntaxSchemaFactory rngFactory = new XMLSyntaxSchemaFactory();
        Schema2 rngSchema = rngFactory.newSchema(validatorFile);
        validator = rngSchema.newValidator();
        validator.setErrorHandler(new ValidationErrorHandler(filename));

        this.file = new File(epubDir, filename);
        this.filename = filename;
    }

    @Override
    public List<Issue> call() {
        List<Issue> errorList = new ArrayList<>();
        try {
            validator.validate(new StreamSource(file));
        } catch (Exception ioe) {
            errorList.add(new Issue("", "[" +Guideline.XHTML + "] " + ioe.getMessage(), filename, Guideline.XHTML, Issue.ERROR_FATAL));
        }

        errorList.addAll(((ValidationErrorHandler) validator.getErrorHandler()).getErrorList());

        return errorList;
    }
}
