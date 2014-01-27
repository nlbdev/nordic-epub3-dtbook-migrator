<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" xmlns:px="http://www.daisy.org/ns/pipeline/xproc" xmlns:d="http://www.daisy.org/ns/pipeline/data"
    type="px:nordic-epub3-validate" name="main" version="1.0" xmlns:epub="http://www.idpf.org/2007/ops" xmlns:pxp="http://exproc.org/proposed/steps">

    <p:documentation xmlns="http://www.w3.org/1999/xhtml">
        <h1 px:role="name">Nordic EPUB3 Validator</h1>
        <p px:role="desc">Validates an EPUB3 publication according to the nordic markup guidelines.</p>
    </p:documentation>

    <p:option name="epub" required="true" px:type="anyFileURI" px:media-type="application/epub+zip">
        <p:documentation xmlns="http://www.w3.org/1999/xhtml">
            <h2 px:role="name">EPUB3 Publication</h2>
            <p px:role="desc">EPUB3 Publication marked up according to the nordic markup guidelines.</p>
        </p:documentation>
    </p:option>

    <p:option name="temp-dir" required="true" px:output="temp" px:type="anyDirURI">
        <p:documentation xmlns="http://www.w3.org/1999/xhtml">
            <h2 px:role="name">Temporary directory</h2>
            <p px:role="desc">Temporary directory for use by the script.</p>
        </p:documentation>
    </p:option>

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

    <p:import href="step/epub3.validate.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/fileset-utils/library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/validation-utils/library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/common-utils/library.xpl"/>
    
    <!-- TODO: use epubcheck to validate the epub here -->
    
    <px:fileset-create>
        <p:with-option name="base" select="replace($epub,'[^/]+$','')"/>
    </px:fileset-create>
    <px:fileset-add-entry media-type="application/epub+zip">
        <p:with-option name="href" select="replace($epub,'^.*/([^/]*)$','$1')"/>
    </px:fileset-add-entry>
    
    <px:message message="Remember to also validate the EPUB using epubcheck." severity="WARN"/>
    <px:nordic-epub3-validate.step name="validate.nordic">
        <p:with-option name="temp-dir" select="concat($temp-dir,'validate/')"/>
    </px:nordic-epub3-validate.step>
    <p:sink/>

    <px:validation-report-to-html name="html">
        <p:input port="source">
            <p:pipe port="report.out" step="validate.nordic"/>
        </p:input>
        <p:with-option name="toc" select="'false'">
            <p:empty/>
        </p:with-option>
    </px:validation-report-to-html>

    <p:group name="status">
        <p:output port="result"/>
        <p:for-each>
            <p:iteration-source select="/d:document-validation-report/d:document-info/d:error-count">
                <p:pipe port="report.out" step="validate.nordic"/>
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

</p:declare-step>
