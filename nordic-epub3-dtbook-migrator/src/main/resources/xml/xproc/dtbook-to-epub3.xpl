<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" xmlns:px="http://www.daisy.org/ns/pipeline/xproc" xmlns:d="http://www.daisy.org/ns/pipeline/data"
    type="px:nordic-dtbook-to-epub3" name="main" version="1.0" xmlns:epub="http://www.idpf.org/2007/ops" xmlns:l="http://xproc.org/library" xmlns:dtbook="http://www.daisy.org/z3986/2005/dtbook/"
    xmlns:html="http://www.w3.org/1999/xhtml" xmlns:cx="http://xmlcalabash.com/ns/extensions">

    <p:documentation xmlns="http://www.w3.org/1999/xhtml">
        <h1 px:role="name">Nordic DTBook to EPUB3</h1>
        <p px:role="desc">Transforms a DTBook document into an EPUB3 publication according to the nordic markup guidelines.</p>
    </p:documentation>

    <p:output port="html-report" px:media-type="application/vnd.pipeline.report+xml">
        <p:documentation xmlns="http://www.w3.org/1999/xhtml">
            <h1 px:role="name">HTML Report</h1>
            <p px:role="desc">An HTML-formatted version of the validation report.</p>
        </p:documentation>
        <p:pipe port="result" step="html"/>
    </p:output>

    <p:output port="validation-status" px:media-type="application/vnd.pipeline.status+xml">
        <p:documentation xmlns="http://www.w3.org/1999/xhtml">
            <h1 px:role="name">Validation status</h1>
            <p px:role="desc">Validation status (http://code.google.com/p/daisy-pipeline/wiki/ValidationStatusXML).</p>
        </p:documentation>
        <p:pipe port="result" step="status"/>
    </p:output>

    <p:option name="input-dtbook" required="true" px:type="anyFileURI" px:media-type="application/x-dtbook+xml">
        <p:documentation xmlns="http://www.w3.org/1999/xhtml">
            <h2 px:role="name">DTBook</h2>
            <p px:role="desc">Input DTBook to be converted.</p>
        </p:documentation>
    </p:option>

    <p:option name="temp-dir" required="true" px:output="temp" px:type="anyDirURI">
        <p:documentation xmlns="http://www.w3.org/1999/xhtml">
            <h2 px:role="name">Temporary directory</h2>
            <p px:role="desc">Temporary directory for use by the script.</p>
        </p:documentation>
    </p:option>

    <p:option name="output-dir" required="true" px:output="result" px:type="anyDirURI">
        <p:documentation xmlns="http://www.w3.org/1999/xhtml">
            <h2 px:role="name">Output directory</h2>
            <p px:role="desc">Output directory for the EPUB publication.</p>
        </p:documentation>
    </p:option>

    <p:import href="step/dtbook.validate.xpl"/>
    <p:import href="step/dtbook-to-epub3.convert.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/fileset-utils/library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/dtbook-utils/library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/mediatype-utils/library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/common-utils/library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/epub3-ocf-utils/library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/dtbook-validator/dtbook-validator.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/validation-utils/library.xpl"/>

    <px:nordic-dtbook-validate.validate name="validate">
        <p:with-option name="input-dtbook" select="$input-dtbook"/>
    </px:nordic-dtbook-validate.validate>
    
    <px:validation-report-to-html name="html">
        <p:input port="source">
            <p:pipe port="report.out" step="validate"/>
        </p:input>
        <p:with-option name="toc" select="'false'">
            <p:empty/>
        </p:with-option>
    </px:validation-report-to-html>
    
    <p:group name="status">
        <p:output port="result"/>
        <p:for-each>
            <p:iteration-source select="/d:document-validation-report/d:document-info/d:error-count">
                <p:pipe port="report.out" step="validate"/>
            </p:iteration-source>
            <p:identity/>
        </p:for-each>
        <p:wrap-sequence wrapper="d:validation-status"/>
        <p:add-attribute attribute-name="result" match="/*">
            <p:with-option name="attribute-value" select="if (sum(/*/*/number(.))&gt;0) then 'error' else 'ok'"/>
        </p:add-attribute>
        <p:delete match="/*/node()"/>
    </p:group>
    <p:sink/>

    <p:choose>
        <p:xpath-context>
            <p:pipe port="result" step="status"/>
        </p:xpath-context>
        <p:when test="not(/*/@result='ok')">
            <p:sink>
                <p:input port="source">
                    <p:empty/>
                </p:input>
            </p:sink>
        </p:when>
        
        <p:otherwise>
            
            <px:nordic-dtbook-to-epub3-convert name="convert">
                <p:input port="fileset.in">
                    <p:pipe port="fileset.out" step="validate"/>
                </p:input>
                <p:input port="in-memory.in">
                    <p:pipe port="in-memory.out" step="validate"/>
                </p:input>
                <p:with-option name="temp-dir" select="$temp-dir"/>
                <p:with-option name="output-dir" select="$output-dir"/>
            </px:nordic-dtbook-to-epub3-convert>
            
            <px:epub3-store>
                <p:input port="fileset.in">
                    <p:pipe port="fileset.out" step="convert"/>
                </p:input>
                <p:input port="in-memory.in">
                    <p:pipe port="in-memory.out" step="convert"/>
                </p:input>
                <p:with-option name="href"
                    select="concat($output-dir,replace(normalize-space((//dtbook:meta[lower-case(@name)=('dtb:uid','dc:identifier','dct:identifier')]/string(@content),'missing-identifier')[1]),'[^\s\w_\-\.]',''),'.epub')">
                    <p:pipe port="result" step="identifier"/>
                </p:with-option>
            </px:epub3-store>
            
            
            <!-- get metadata (used to determine the filename) -->
            <p:group name="identifier">
                <p:output port="result"/>
                <px:fileset-load media-types="application/x-dtbook+xml">
                    <p:input port="fileset">
                        <p:pipe port="fileset.out" step="validate"/>
                    </p:input>
                    <p:input port="in-memory">
                        <p:pipe port="in-memory.out" step="validate"/>
                    </p:input>
                </px:fileset-load>
                <px:assert message="There must be exactly one DTBook in the input fileset" test-count-min="1" test-count-max="1"/>
                <p:for-each>
                    <p:iteration-source select="//dtbook:head"/>
                    <p:identity/>
                </p:for-each>
            </p:group>
            <p:sink/>

        </p:otherwise>
    </p:choose>
    
    

</p:declare-step>
