<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" xmlns:px="http://www.daisy.org/ns/pipeline/xproc" xmlns:d="http://www.daisy.org/ns/pipeline/data"
    type="px:nordic-dtbook-validate" name="main" version="1.0" xmlns:epub="http://www.idpf.org/2007/ops" xmlns:pxp="http://exproc.org/proposed/steps" xmlns:cx="http://xmlcalabash.com/ns/extensions">

    <p:documentation xmlns="http://www.w3.org/1999/xhtml">
        <h1 px:role="name">Nordic DTBook Validator</h1>
        <p px:role="desc">Validates an dtbook publication according to the nordic markup guidelines.</p>
        <a px:role="homepage" href="https://github.com/josteinaj/nordic-epub3-dtbook-migrator">https://github.com/josteinaj/nordic-epub3-dtbook-migrator</a>
        <div px:role="author maintainer">
            <p px:role="name">Jostein Austvik Jacobsen</p>
            <a px:role="contact" href="mailto:josteinaj@gmail.com">josteinaj@gmail.com</a>
            <p px:role="organization">NLB - Norwegian library of talking books and braille</p>
        </div>
    </p:documentation>

    <p:documentation xmlns="http://www.w3.org/1999/xhtml">
        <h1 px:role="name">Nordic DTBook Validator</h1>
        <p px:role="desc">Validates an dtbook publication according to the nordic markup guidelines.</p>
    </p:documentation>

    <p:option name="dtbook" required="true" px:type="anyFileURI" px:media-type="application/x-dtbook+xml">
        <p:documentation xmlns="http://www.w3.org/1999/xhtml">
            <h2 px:role="name">DTBook</h2>
            <p px:role="desc">DTBook marked up according to the nordic markup guidelines.</p>
        </p:documentation>
    </p:option>

    <p:option name="ignore-missing-images" required="false" px:type="boolean" select="'true'">
        <p:documentation xmlns="http://www.w3.org/1999/xhtml">
            <h2 px:role="name">Ignore non-existing images</h2>
            <p px:role="desc">Whether or not to see that referenced images exist on disk.</p>
        </p:documentation>
    </p:option>
    
    <p:option name="no-legacy" required="false" px:type="boolean" select="'true'">
        <p:documentation xmlns="http://www.w3.org/1999/xhtml">
            <h2 px:role="name">Disallow legacy markup</h2>
            <p px:role="desc">If set to false, will upgrade DTBook versions earlier than 2005-3 to 2005-3, and fix some non-standard practices that appear in older DTBooks.</p>
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

    <p:import href="step/dtbook.validate.xpl"/>
    <p:import href="step/format-html-report.step.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/validation-utils/library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/common-utils/library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/fileset-utils/library.xpl"/>

    <px:message message="$1" name="nordic-version-message">
        <p:with-option name="param1" select="/*">
            <p:document href="../version-description.xml"/>
        </p:with-option>
    </px:message>

    <px:nordic-dtbook-validate.step name="validate" cx:depends-on="nordic-version-message">
        <p:with-option name="dtbook" select="$dtbook"/>
        <p:with-option name="check-images" select="if ($ignore-missing-images='false') then 'true' else 'false'"/>
        <p:with-option name="allow-legacy" select="if ($no-legacy='false') then 'true' else 'false'"/>
    </px:nordic-dtbook-validate.step>
    <px:fileset-load media-types="application/x-dtbook+xml">
        <p:input port="in-memory">
            <p:pipe port="in-memory.out" step="validate"/>
        </p:input>
    </px:fileset-load>
    <p:xslt>
        <p:input port="parameters">
            <p:empty/>
        </p:input>
        <p:input port="stylesheet">
            <p:document href="../xslt/info-report.xsl"/>
        </p:input>
    </p:xslt>
    <p:identity name="report.nordic"/>
    <p:sink/>

    <px:nordic-format-html-report.step name="html">
        <p:input port="source">
            <p:pipe port="result" step="report.nordic"/>
            <p:pipe port="report.out" step="validate"/>
        </p:input>
    </px:nordic-format-html-report.step>

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

</p:declare-step>
