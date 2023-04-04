package org.daisy.validator;

import com.thaiopensource.relaxng.jaxp.XMLSyntaxSchemaFactory;
import com.thaiopensource.validation.Schema2;
import com.thaiopensource.validation.Validator2;
import org.daisy.validator.report.Issue;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.Callable;
import javax.xml.transform.stream.StreamSource;

public class ValidateFile implements Callable<List<Issue>> {
    private final Validator2 validator;
    private final File file;
    private final String filename;
    private final String validationType;

    public ValidateFile(File epubDir, String filename, File validatorFile, String validationType) throws Exception {
        XMLSyntaxSchemaFactory rngFactory = new XMLSyntaxSchemaFactory();
        Schema2 rngSchema = rngFactory.newSchema(validatorFile);
        validator = rngSchema.newValidator();
        validator.setErrorHandler(new ValidationErrorHandler(filename, validationType));

        this.file = new File(epubDir, filename);
        this.filename = filename;
        this.validationType = validationType;
    }

    @Override
    public List<Issue> call() {
        List<Issue> errorList = new ArrayList<>();

        try {
            validator.validate(new StreamSource(file));
        } catch (Exception ioe) {
            errorList.add(new Issue(
                "",
                "[" + validationType + "] " + ioe.getMessage(),
                filename,
                validationType,
                Issue.ERROR_FATAL
            ));
        }

        errorList.addAll(((ValidationErrorHandler) validator.getErrorHandler()).getErrorList());

        return errorList;
    }
}
