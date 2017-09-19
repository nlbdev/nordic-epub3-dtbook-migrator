import org.daisy.pipeline.junit.AbstractXSpecAndXProcSpecTest; 
 
import static org.daisy.pipeline.pax.exam.Options.*; 
 
import org.ops4j.pax.exam.Configuration; 
import static org.ops4j.pax.exam.CoreOptions.composite; 
import static org.ops4j.pax.exam.CoreOptions.options; 
import org.ops4j.pax.exam.Option; 
 
public class XProcSpecTest extends AbstractXSpecAndXProcSpecTest { 
     
    @Override 
    protected String[] testDependencies() { 
        return new String[] { 
            pipelineModule("asciimath-utils"),
            pipelineModule("common-utils"),
            pipelineModule("dtbook-utils"),
            pipelineModule("dtbook-validator"),
            pipelineModule("epub3-nav-utils"),
            pipelineModule("epub3-ocf-utils"),
            pipelineModule("epub3-pub-utils"),
            pipelineModule("epubcheck-adapter"),
            pipelineModule("file-utils"),
            pipelineModule("fileset-utils"),
            pipelineModule("html-utils"),
            pipelineModule("mediatype-utils"),
            pipelineModule("validation-utils")
        }; 
    } 
     
    @Override @Configuration 
    public Option[] config() { 
        return options( 
            composite(super.config()), 
            mavenBundlesWithDependencies( 
                mavenBundle("com.google.guava:guava:?")
            ), 
             
            // for org.apache.httpcomponents:httpclient (<-- xmlcalabash): 
            mavenBundle("org.slf4j:jcl-over-slf4j:1.7.2") 
        ); 
    } 
} 
