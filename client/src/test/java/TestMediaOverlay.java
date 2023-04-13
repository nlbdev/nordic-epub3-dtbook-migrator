import org.daisy.validator.EPUBFiles;
import org.daisy.validator.NordicValidator;
import org.junit.Test;

import java.io.File;
import java.util.zip.ZipFile;

import static org.junit.Assert.assertTrue;

public class TestMediaOverlay {
    @Test
    public void testMediaOverlay2020() throws Exception {
        File tmpFile = new File("src/test/resources/media_overlay_test.epub");
        EPUBFiles epubFiles = NordicValidator.getEPUBFiles(new ZipFile(tmpFile), 1, null);
        epubFiles.validateWithAce(tmpFile);
        epubFiles.validateWithEpubCheck(tmpFile);
        epubFiles.validate();
        epubFiles.cleanUp();
        assertTrue(
            "Verify that a correct epub with media overlay don't generate any errors",
            epubFiles.getErrorList().size() == 0
        );
    }
}
