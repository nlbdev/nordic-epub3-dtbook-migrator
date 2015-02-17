<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" xmlns:px="http://www.daisy.org/ns/pipeline/xproc" xmlns:d="http://www.daisy.org/ns/pipeline/data"
    type="px:nordic-html-to-dtbook" name="main" version="1.0" xmlns:epub="http://www.idpf.org/2007/ops" xmlns:pxp="http://exproc.org/proposed/steps" xmlns:html="http://www.w3.org/1999/xhtml"
    xmlns:pxi="http://www.daisy.org/ns/pipeline/xproc/internal/nordic-epub3-dtbook-migrator" xmlns:cx="http://xmlcalabash.com/ns/extensions">

    <p:documentation xmlns="http://www.w3.org/1999/xhtml">
        <h1 px:role="name">Nordic HTML5 to DTBook</h1>
        <p px:role="desc">Transforms a HTML5 document into a DTBook according to the nordic markup guidelines.</p>
    </p:documentation>

    <p:output port="validation-status" px:media-type="application/vnd.pipeline.status+xml">
        <p:documentation xmlns="http://www.w3.org/1999/xhtml">
            <h1 px:role="name">Validation status</h1>
            <p px:role="desc">Validation status (http://code.google.com/p/daisy-pipeline/wiki/ValidationStatusXML).</p>
        </p:documentation>
        <p:pipe port="status.out" step="html-validate"/>
    </p:output>

    <p:option name="html" required="true" px:type="anyFileURI" px:media-type="application/xhtml+xml">
        <p:documentation xmlns="http://www.w3.org/1999/xhtml">
            <h2 px:role="name">HTML Publication</h2>
            <p px:role="desc">HTML Publication marked up according to the nordic markup guidelines.</p>
        </p:documentation>
    </p:option>

    <p:option name="check-images" required="false" px:type="boolean" select="'true'">
        <p:documentation xmlns="http://www.w3.org/1999/xhtml">
            <h2 px:role="name">Check that images exist on disk</h2>
            <p px:role="desc">Whether or not to see that referenced images exist on disk.</p>
        </p:documentation>
    </p:option>

    <p:option name="html-report" required="true" px:output="result" px:type="anyDirURI" px:media-type="application/vnd.pipeline.report+xml">
        <p:documentation xmlns="http://www.w3.org/1999/xhtml">
            <h1 px:role="name">HTML Report</h1>
            <p px:role="desc">An HTML-formatted version of the validation report.</p>
        </p:documentation>
    </p:option>

    <p:option name="fail-on-error" required="false" select="'true'" px:type="boolean">
        <p:documentation xmlns="http://www.w3.org/1999/xhtml">
            <h2 px:role="name">Stop processing on validation error</h2>
            <p px:role="desc">Whether or not to stop the conversion when a validation error occurs. Setting this to false may be useful for debugging or if the validation error is a minor one. The
                output is not guaranteed to be valid if this option is set to false.</p>
        </p:documentation>
    </p:option>

    <p:option name="output-dir" required="true" px:output="result" px:type="anyDirURI">
        <p:documentation xmlns="http://www.w3.org/1999/xhtml">
            <h2 px:role="name">DTBook</h2>
            <p px:role="desc">Output directory for the DTBook.</p>
        </p:documentation>
    </p:option>

    <!-- option supporting convert to DTBook 1.1.0 -->
    <p:option name="dtbook2005" required="false" select="'true'" px:type="boolean">
        <p:documentation xmlns="http://www.w3.org/1999/xhtml">
            <h2 px:role="name">DTBook 2005</h2>
            <p px:role="desc">Whether or not to keep the DTBook 2005-3 output or downgrade to DTBook 1.1.0. Set to false to convert to DTBook 1.1.0.</p>
        </p:documentation>
    </p:option>

    <p:import href="step/html-validate.step.xpl"/>
    <p:import href="step/html-store.step.xpl"/>
    <p:import href="step/html-to-dtbook.step.xpl"/>
    <p:import href="step/dtbook-validate.step.xpl"/>
    <p:import href="step/format-html-report.xpl"/>
    <!--<p:import href="upstream/fileset-utils/fileset-load.xpl"/>-->
    <p:import href="upstream/fileset-utils/fileset-add-entry.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/fileset-utils/library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/file-utils/library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/validation-utils/library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/html-utils/library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/common-utils/library.xpl"/>

    <p:variable name="html-href" select="resolve-uri($html,static-base-uri())"/>

    <px:message message="$1" name="nordic-version-message">
        <p:with-option name="param1" select="/*">
            <p:document href="../version-description.xml"/>
        </p:with-option>
    </px:message>

    <px:fileset-create>
        <p:with-option name="base" select="replace($html-href,'[^/]+$','')"/>
    </px:fileset-create>
    <pxi:fileset-add-entry media-type="application/xhtml+xml">
        <p:with-option name="href" select="replace($html-href,'.*/','')"/>
    </pxi:fileset-add-entry>
    <p:identity name="html-fileset.no-resources"/>

    <px:check-files-wellformed name="check-html-wellformed"/>

    <p:choose name="html-load">
        <p:xpath-context>
            <p:pipe port="validation-status" step="check-html-wellformed"/>
        </p:xpath-context>
        <p:when test="/*/@result='ok' or $fail-on-error = 'false'">
            <p:output port="fileset.out" primary="true">
                <p:pipe port="result" step="html-load.fileset"/>
            </p:output>
            <p:output port="in-memory.out" sequence="true">
                <p:pipe port="result" step="html-load.load"/>
            </p:output>
            <p:output port="report.out" sequence="true">
                <p:empty/>
            </p:output>

            <p:load name="html-load.load">
                <p:with-option name="href" select="$html-href"/>
            </p:load>

            <px:html-to-fileset name="html-load.resource-fileset"/>
            <px:fileset-join name="html-load.fileset">
                <p:input port="source">
                    <p:pipe port="result" step="html-fileset.no-resources"/>
                    <p:pipe port="fileset.out" step="html-load.resource-fileset"/>
                </p:input>
            </px:fileset-join>

        </p:when>
        <p:otherwise>
            <p:output port="fileset.out" sequence="true" primary="true">
                <p:pipe port="result" step="html-fileset.no-resources"/>
            </p:output>
            <p:output port="in-memory.out" sequence="true">
                <p:empty/>
            </p:output>
            <p:output port="report.out" sequence="true">
                <p:pipe port="report" step="check-html-wellformed"/>
            </p:output>

            <p:sink>
                <p:input port="source">
                    <p:empty/>
                </p:input>
            </p:sink>
        </p:otherwise>
    </p:choose>

    <px:message message="Validating HTML"/>
    <px:nordic-html-validate.step name="html-validate">
        <p:with-option name="fail-on-error" select="$fail-on-error"/>
        <p:with-option name="check-images" select="$check-images"/>
        <p:input port="in-memory.in">
            <p:pipe step="html-load" port="in-memory.out"/>
        </p:input>
        <p:input port="report.in">
            <p:pipe step="html-load" port="report.out"/>
        </p:input>
        <p:input port="status.in">
            <p:pipe port="validation-status" step="check-html-wellformed"/>
        </p:input>
    </px:nordic-html-validate.step>

    <px:message message="Converting from HTML to DTBook"/>
    <px:nordic-html-to-dtbook.step name="html-to-dtbook">
        <!-- call with dtbook2005 option whether to convert to a DTBook 2005 or DTBook 1.1.0 -->
        <p:with-option name="dtbook2005" select="$dtbook2005"/>
        <p:input port="in-memory.in">
            <p:pipe port="in-memory.out" step="html-validate"/>
        </p:input>
        <p:input port="report.in">
            <p:pipe port="report.out" step="html-validate"/>
        </p:input>
        <p:input port="status.in">
            <p:pipe port="status.out" step="html-validate"/>
        </p:input>
    </px:nordic-html-to-dtbook.step>

    <px:fileset-move name="dtbook-move">
        <p:with-option name="new-base" select="concat($output-dir,(//d:file[@media-type='application/x-dtbook+xml'])[1]/replace(replace(@href,'.*/',''),'^(.[^\.]*).*?$','$1/'))"/>
        <p:input port="in-memory.in">
            <p:pipe port="in-memory.out" step="html-to-dtbook"/>
        </p:input>
    </px:fileset-move>
    <px:fileset-store name="fileset-store">
        <p:input port="in-memory.in">
            <p:pipe port="in-memory.out" step="dtbook-move"/>
        </p:input>
    </px:fileset-store>
    <p:identity>
        <p:input port="source">
            <p:pipe port="fileset.out" step="fileset-store"/>
        </p:input>
    </p:identity>

    <px:message message="Validating DTBook"/>
    <px:nordic-dtbook-validate.step name="dtbook-validate">
        <p:with-option name="fail-on-error" select="$fail-on-error"/>
        <!-- call with dtbook2005 option whether to validate a DTBook 2005 or DTBook 1.1.0 -->
        <p:with-option name="dtbook2005" select="$dtbook2005"/>
        <p:input port="report.in">
            <p:pipe port="report.out" step="html-to-dtbook"/>
        </p:input>
        <p:input port="status.in">
            <p:pipe port="status.out" step="html-to-dtbook"/>
        </p:input>
    </px:nordic-dtbook-validate.step>
    <p:sink/>

    <p:identity>
        <p:input port="source">
            <p:pipe port="report.out" step="dtbook-validate"/>
        </p:input>
    </p:identity>
    <px:message message="Building report"/>
    <px:nordic-format-html-report/>

    <p:store include-content-type="false" method="xhtml" omit-xml-declaration="false" name="store-report">
        <p:with-option name="href" select="concat($html-report,if (ends-with($html-report,'/')) then '' else '/','report.xhtml')"/>
    </p:store>
    <px:set-doctype doctype="&lt;!DOCTYPE html&gt;">
        <p:with-option name="href" select="/*/text()">
            <p:pipe port="result" step="store-report"/>
        </p:with-option>
    </px:set-doctype>
    <p:sink/>

</p:declare-step>
