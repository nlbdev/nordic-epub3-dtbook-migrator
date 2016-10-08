<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" xmlns:px="http://www.daisy.org/ns/pipeline/xproc" xmlns:d="http://www.daisy.org/ns/pipeline/data"
    type="px:nordic-html-validate" name="main" version="1.0" xmlns:epub="http://www.idpf.org/2007/ops" xmlns:pxp="http://exproc.org/proposed/steps" xmlns:html="http://www.w3.org/1999/xhtml"
    xmlns:cx="http://xmlcalabash.com/ns/extensions">

    <p:documentation xmlns="http://www.w3.org/1999/xhtml">
        <h1 px:role="name">Nordic HTML5 Validator</h1>
        <p px:role="desc">Validates a single-document HTML publication according to the nordic markup guidelines.</p>
    </p:documentation>

    <p:output port="validation-status" px:media-type="application/vnd.pipeline.status+xml">
        <p:documentation xmlns="http://www.w3.org/1999/xhtml">
            <h1 px:role="name">Validation status</h1>
            <p px:role="desc">Validation status (http://code.google.com/p/daisy-pipeline/wiki/ValidationStatusXML).</p>
        </p:documentation>
        <p:pipe port="status.out" step="html-validate.html-validate"/>
    </p:output>

    <p:option name="html" required="true" px:type="anyFileURI" px:media-type="application/xhtml+xml">
        <p:documentation xmlns="http://www.w3.org/1999/xhtml">
            <h2 px:role="name">HTML Publication</h2>
            <p px:role="desc">HTML Publication marked up according to the nordic markup guidelines.</p>
        </p:documentation>
    </p:option>

    <p:option name="check-images" required="false" px:type="boolean" select="'true'">
        <p:documentation xmlns="http://www.w3.org/1999/xhtml">
            <h2 px:role="name">Validate images</h2>
            <p px:role="desc">Whether or not to check that referenced images exist and has the right file signatures.</p>
        </p:documentation>
    </p:option>
    
    <p:option name="organization-specific-validation" required="false" px:type="string" select="''">
        <p:documentation xmlns="http://www.w3.org/1999/xhtml">
            <h2 px:role="name">Organization-specific validation</h2>
            <p px:role="desc">Leave blank for the default validation schemas. Use 'nota' to validate using Nota-specific validation rules.</p>
        </p:documentation>
    </p:option>

    <p:option name="html-report" required="true" px:output="result" px:type="anyDirURI" px:media-type="application/vnd.pipeline.report+xml">
        <p:documentation xmlns="http://www.w3.org/1999/xhtml">
            <h1 px:role="name">HTML Report</h1>
            <p px:role="desc">An HTML-formatted version of the validation report.</p>
        </p:documentation>
    </p:option>

    <p:import href="step/validation-status.xpl"/>
    <p:import href="step/html-validate.step.xpl"/>
    <p:import href="step/format-html-report.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/validation-utils/library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/file-utils/library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/fileset-utils/library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/common-utils/library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/html-utils/library.xpl"/>

    <p:variable name="html-href" select="resolve-uri($html,static-base-uri())"/>

    <px:message message="$1" name="nordic-version-message">
        <p:with-option name="param1" select="/*">
            <p:document href="../version-description.xml"/>
        </p:with-option>
    </px:message>

    <px:fileset-create name="html-validate.create-html-fileset">
        <p:with-option name="base" select="replace($html-href,'[^/]+$','')"/>
    </px:fileset-create>
    <px:fileset-add-entry media-type="application/xhtml+xml" name="html-validate.add-html-to-fileset">
        <p:with-option name="href" select="replace($html-href,'.*/','')"/>
    </px:fileset-add-entry>
    <p:identity name="html-validate.html-fileset.no-resources"/>

    <px:check-files-wellformed name="html-validate.check-html-wellformed"/>

    <p:choose name="html-validate.html-load">
        <p:xpath-context>
            <p:pipe port="validation-status" step="html-validate.check-html-wellformed"/>
        </p:xpath-context>
        <p:when test="/*/@result='ok'">
            <p:output port="fileset.out" primary="true">
                <p:pipe port="result" step="html-validate.html-load.fileset"/>
            </p:output>
            <p:output port="in-memory.out" sequence="true">
                <p:pipe port="result" step="html-validate.html-load.load"/>
            </p:output>
            <p:output port="report.out" sequence="true">
                <p:empty/>
            </p:output>

            <p:load name="html-validate.html-load.load">
                <p:with-option name="href" select="$html-href"/>
            </p:load>

            <px:html-to-fileset name="html-validate.html-load.resource-fileset"/>
            <px:fileset-join name="html-validate.html-load.fileset">
                <p:input port="source">
                    <p:pipe port="result" step="html-validate.html-fileset.no-resources"/>
                    <p:pipe port="fileset.out" step="html-validate.html-load.resource-fileset"/>
                </p:input>
            </px:fileset-join>

        </p:when>
        <p:otherwise>
            <p:output port="fileset.out" sequence="true" primary="true">
                <p:pipe port="result" step="html-validate.html-fileset.no-resources"/>
            </p:output>
            <p:output port="in-memory.out" sequence="true">
                <p:empty/>
            </p:output>
            <p:output port="report.out" sequence="true">
                <p:pipe port="report" step="html-validate.check-html-wellformed"/>
            </p:output>

            <p:sink>
                <p:input port="source">
                    <p:empty/>
                </p:input>
            </p:sink>
        </p:otherwise>
    </p:choose>

    <px:nordic-html-validate.step name="html-validate.html-validate" fail-on-error="true">
        <p:with-option name="check-images" select="$check-images"/>
        <p:with-option name="organization-specific-validation" select="$organization-specific-validation"/>
        <p:input port="in-memory.in">
            <p:pipe step="html-validate.html-load" port="in-memory.out"/>
        </p:input>
        <p:input port="report.in">
            <p:pipe step="html-validate.html-load" port="report.out"/>
        </p:input>
        <p:input port="status.in">
            <p:pipe port="validation-status" step="html-validate.check-html-wellformed"/>
        </p:input>
    </px:nordic-html-validate.step>
    <p:sink/>
    
    <p:xslt name="html-validate.info-report">
        <p:input port="source">
            <p:pipe port="in-memory.out" step="html-validate.html-validate"/>
        </p:input>
        <p:input port="parameters">
            <p:empty/>
        </p:input>
        <p:input port="stylesheet">
            <p:document href="../xslt/info-report.xsl"/>
        </p:input>
    </p:xslt>
    <p:identity name="html-validate.report.nordic"/>
    <p:sink/>

    <px:nordic-format-html-report name="html-validate.nordic-format-html-report">
        <p:input port="source">
            <p:pipe port="result" step="html-validate.report.nordic"/>
            <p:pipe port="report.out" step="html-validate.html-validate"/>
        </p:input>
    </px:nordic-format-html-report>
    <p:store include-content-type="false" method="xhtml" omit-xml-declaration="false" name="html-validate.store-report">
        <p:with-option name="href" select="concat($html-report,if (ends-with($html-report,'/')) then '' else '/','report.xhtml')"/>
    </p:store>
    <px:set-doctype doctype="&lt;!DOCTYPE html&gt;" name="html-validate.set-report-doctype">
        <p:with-option name="href" select="/*/text()">
            <p:pipe port="result" step="html-validate.store-report"/>
        </p:with-option>
    </px:set-doctype>
    <p:sink/>

</p:declare-step>
