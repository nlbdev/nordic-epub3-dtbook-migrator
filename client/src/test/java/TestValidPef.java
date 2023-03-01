import org.daisy.validator.ValidateFile;
import org.daisy.validator.report.Issue;
import org.daisy.validator.schemas.Guideline;
import org.junit.Assert;
import org.junit.Test;

import java.io.File;
import java.util.List;

public class TestValidPef {

    @Test
    public void testValidation() throws Exception {
        ValidateFile validateFile = new ValidateFile(
            new File("src/test/resources/pef"),
            "X50525A.pef",
            new File("src/main/resources/pef", "pef-validation.rng")
        );
        List<Issue> issueList = validateFile.call();
        Assert.assertEquals("We don't expect any issues",0, issueList.size());
    }
}
