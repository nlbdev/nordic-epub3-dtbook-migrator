<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" xmlns:px="http://www.daisy.org/ns/pipeline/xproc" xmlns:d="http://www.daisy.org/ns/pipeline/data"
    type="px:nordic-html-to-dtbook" name="main" version="1.0" xmlns:epub="http://www.idpf.org/2007/ops" xmlns:pxp="http://exproc.org/proposed/steps" xmlns:html="http://www.w3.org/1999/xhtml"
    xmlns:cx="http://xmlcalabash.com/ns/extensions" xmlns:opf="http://www.idpf.org/2007/opf">

    <p:documentation xmlns="http://www.w3.org/1999/xhtml">
        <h1 px:role="name">Nordic HTML5 to DTBook</h1>
        <p px:role="desc">Transforms a HTML5 document into a DTBook according to the nordic markup guidelines.</p>
    </p:documentation>

    <p:output port="validation-status" px:media-type="application/vnd.pipeline.status+xml">
        <p:documentation xmlns="http://www.w3.org/1999/xhtml">
            <h1 px:role="name">Validation status</h1>
            <p px:role="desc">Validation status (http://code.google.com/p/daisy-pipeline/wiki/ValidationStatusXML).</p>
        </p:documentation>
        <p:pipe port="status" step="guidelines-version.choose"/>
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
    
    <p:option name="indent" required="false" px:type="boolean" select="'true'">
        <p:documentation xmlns="http://www.w3.org/1999/xhtml">
            <h2 px:role="name">Indent XML</h2>
            <p px:role="desc">If 'true', will automatically indent HTML and XML documents.</p>
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

    <p:import href="step/2015-1/html-validate.step.xpl"/>
    <p:import href="step/2015-1/html-to-dtbook.step.xpl"/>
    <p:import href="step/2015-1/dtbook-validate.step.xpl"/>
    <p:import href="step/html-store.step.xpl"/>
    <p:import href="step/dtbook-store.step.xpl"/>
    <p:import href="step/determine-guidelines-version.xpl"/>
    <p:import href="step/format-html-report.xpl"/>
    <p:import href="step/fail-on-error-status.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/fileset-utils/library.xpl">
        <p:documentation>
            px:fileset-create
            px:fileset-add-entry
            px:fileset-join
            px:fileset-copy
        </p:documentation>
    </p:import>
    <p:import href="http://www.daisy.org/pipeline/modules/file-utils/library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/validation-utils/library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/html-utils/library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/common-utils/library.xpl"/>

    <px:message message="$1">
        <p:with-option name="param1" select="/*">
            <p:document href="../version-description.xml"/>
        </p:with-option>
    </px:message>
    
    <px:normalize-uri name="html">
        <p:with-option name="href" select="resolve-uri($html,static-base-uri())"/>
    </px:normalize-uri>
    <px:normalize-uri name="html-report">
        <p:with-option name="href" select="resolve-uri($html-report,static-base-uri())"/>
    </px:normalize-uri>
    <px:normalize-uri name="output-dir">
        <p:with-option name="href" select="resolve-uri($output-dir,static-base-uri())"/>
    </px:normalize-uri>
    <p:identity name="nordic-version-message-and-variables"/>
    <p:sink/>
    
    <px:nordic-determine-guidelines-version name="guidelines-version">
        <p:with-option name="href" select="/*/text()">
            <p:pipe port="normalized" step="html"/>
        </p:with-option>
    </px:nordic-determine-guidelines-version>
    <px:message message="Guidelines version: $1">
        <p:with-option name="param1" select="/*/text()"/>
    </px:message>
    <p:sink/>
    
    <px:fileset-create name="html-to-dtbook.create-html-fileset">
        <p:with-option name="base" select="replace(/*/text(),'[^/]+$','')">
            <p:pipe port="normalized" step="html"/>
        </p:with-option>
    </px:fileset-create>
    <px:fileset-add-entry media-type="application/xhtml+xml" name="html-to-dtbook.add-html-to-fileset">
        <p:with-option name="href" select="replace(/*/text(),'.*/','')">
            <p:pipe port="normalized" step="html"/>
        </p:with-option>
    </px:fileset-add-entry>
    <p:identity name="html-to-dtbook.html-fileset.no-resources"/>

    <p:choose name="guidelines-version.choose">
        <p:xpath-context>
            <p:pipe port="result" step="guidelines-version"/>
        </p:xpath-context>
        <p:when test="/*/text() = '2015-1'">
            <p:output port="status">
                <p:pipe port="result" step="status.2015-1"/>
            </p:output>
            
            <px:check-files-wellformed name="html-to-dtbook.check-html-wellformed"/>
            
            <p:choose name="html-to-dtbook.html-load">
                <p:xpath-context>
                    <p:pipe port="validation-status" step="html-to-dtbook.check-html-wellformed"/>
                </p:xpath-context>
                <p:when test="/*/@result='ok' or $fail-on-error = 'false'">
                    <p:output port="fileset.out" primary="true">
                        <p:pipe port="result.fileset" step="html-to-dtbook.html-load.html-load"/>
                    </p:output>
                    <p:output port="in-memory.out" sequence="true">
                        <p:pipe port="result.in-memory" step="html-to-dtbook.html-load.html-load"/>
                    </p:output>
                    <p:output port="report.out" sequence="true">
                        <p:empty/>
                    </p:output>
                    
                    <px:html-load name="html-to-dtbook.html-load.html-load">
                        <p:input port="source.fileset">
                            <p:pipe port="result" step="html-to-dtbook.html-fileset.no-resources"/>
                        </p:input>
                    </px:html-load>
                </p:when>
                <p:otherwise>
                    <p:output port="fileset.out" sequence="true" primary="true">
                        <p:pipe port="result" step="html-to-dtbook.html-fileset.no-resources"/>
                    </p:output>
                    <p:output port="in-memory.out" sequence="true">
                        <p:empty/>
                    </p:output>
                    <p:output port="report.out" sequence="true">
                        <p:pipe port="report" step="html-to-dtbook.check-html-wellformed"/>
                    </p:output>
                    
                    <p:sink>
                        <p:input port="source">
                            <p:empty/>
                        </p:input>
                    </p:sink>
                </p:otherwise>
            </p:choose>
            
            <px:message message="Validating HTML"/>
            <px:nordic-html-validate.step name="html-to-dtbook.html-validate">
                <p:with-option name="fail-on-error" select="$fail-on-error"/>
                <p:with-option name="check-images" select="$check-images"/>
                <p:with-option name="organization-specific-validation" select="$organization-specific-validation"/>
                <p:input port="in-memory.in">
                    <p:pipe step="html-to-dtbook.html-load" port="in-memory.out"/>
                </p:input>
                <p:input port="report.in">
                    <p:pipe step="html-to-dtbook.html-load" port="report.out"/>
                </p:input>
                <p:input port="status.in">
                    <p:pipe port="validation-status" step="html-to-dtbook.check-html-wellformed"/>
                </p:input>
            </px:nordic-html-validate.step>
            
            <px:message message="Converting from HTML to DTBook"/>
            <px:nordic-html-to-dtbook.step name="html-to-dtbook.html-to-dtbook">
                <p:with-option name="fail-on-error" select="$fail-on-error"/>
                <p:with-option name="indent" select="$indent"/>
                <!-- call with dtbook2005 option whether to convert to a DTBook 2005 or DTBook 1.1.0 -->
                <p:with-option name="dtbook2005" select="$dtbook2005"/>
                <p:input port="in-memory.in">
                    <p:pipe port="in-memory.out" step="html-to-dtbook.html-validate"/>
                </p:input>
                <p:input port="report.in">
                    <p:pipe port="report.out" step="html-to-dtbook.html-validate"/>
                </p:input>
                <p:input port="status.in">
                    <p:pipe port="status.out" step="html-to-dtbook.html-validate"/>
                </p:input>
            </px:nordic-html-to-dtbook.step>
            
            <px:message message="Storing DTBook"/>
            <p:group name="html-to-dtbook.dtbook-move">
                <p:output port="fileset.out" primary="true"/>
                <p:output port="in-memory.out" sequence="true">
                    <p:pipe step="html-to-dtbook.dtbook-move.inner" port="result.in-memory"/>
                </p:output>
                <p:variable name="dirname" select="(//d:file[@media-type='application/x-dtbook+xml'], //d:file[@media-type='application/xhtml+xml'])[1]/replace(replace(@href,'.*/',''),'^(.+)\..*?$','$1')"/>
                <px:fileset-copy name="html-to-dtbook.dtbook-move.inner">
                    <p:with-option name="target" select="concat(if (ends-with(/*/text(),'/')) then /*/text() else concat(/*/text(),'/'), $dirname, '/')">
                        <p:pipe port="normalized" step="output-dir"/>
                    </p:with-option>
                    <p:input port="source.in-memory">
                        <p:pipe port="in-memory.out" step="html-to-dtbook.html-to-dtbook"/>
                    </p:input>
                </px:fileset-copy>
            </p:group>
            <px:nordic-dtbook-store.step name="html-to-dtbook.dtbook-store">
                <p:with-option name="fail-on-error" select="$fail-on-error"/>
                <p:input port="in-memory.in">
                    <p:pipe port="in-memory.out" step="html-to-dtbook.dtbook-move"/>
                </p:input>
                <p:input port="report.in">
                    <p:pipe port="report.out" step="html-to-dtbook.html-to-dtbook"/>
                </p:input>
                <p:input port="status.in">
                    <p:pipe port="status.out" step="html-to-dtbook.html-to-dtbook"/>
                </p:input>
            </px:nordic-dtbook-store.step>
            
            <px:message message="Validating DTBook"/>
            <px:nordic-dtbook-validate.step name="html-to-dtbook.dtbook-validate">
                <p:with-option name="fail-on-error" select="$fail-on-error"/>
                <p:with-option name="check-images" select="$check-images"/>
                <!-- call with dtbook2005 option whether to validate a DTBook 2005 or DTBook 1.1.0 -->
                <p:with-option name="dtbook2005" select="$dtbook2005"/>
                <p:with-option name="organization-specific-validation" select="$organization-specific-validation"/>
                <p:input port="report.in">
                    <p:pipe port="report.out" step="html-to-dtbook.dtbook-store"/>
                </p:input>
                <p:input port="status.in">
                    <p:pipe port="status.out" step="html-to-dtbook.dtbook-store"/>
                </p:input>
            </px:nordic-dtbook-validate.step>
            <p:sink/>
            
            <p:identity>
                <p:input port="source">
                    <p:pipe port="report.out" step="html-to-dtbook.dtbook-validate"/>
                </p:input>
            </p:identity>
            <px:message message="Building report"/>
            <px:nordic-format-html-report name="html-to-dtbook.nordic-format-html-report"/>
            
            <p:store include-content-type="false" method="xhtml" omit-xml-declaration="false" name="html-to-dtbook.store-report" encoding="us-ascii">
                <p:with-option name="href" select="concat(/*/text(),if (ends-with(/*/text(),'/')) then '' else '/','report.xhtml')">
                    <p:pipe port="normalized" step="html-report"/>
                </p:with-option>
            </p:store>
            <px:set-doctype doctype="&lt;!DOCTYPE html&gt;" name="html-to-dtbook.set-report-doctype">
                <p:with-option name="href" select="/*/text()">
                    <p:pipe port="result" step="html-to-dtbook.store-report"/>
                </p:with-option>
            </px:set-doctype>
            <p:sink/>
            
            <px:nordic-fail-on-error-status name="status.2015-1">
                <p:with-option name="fail-on-error" select="$fail-on-error"/>
                <p:with-option name="output-dir" select="if (ends-with(/*/text(),'/')) then /*/text() else concat(/*/text(),'/')">
                    <p:pipe port="normalized" step="output-dir"/>
                </p:with-option>
                <p:input port="source">
                    <p:pipe port="status.out" step="html-to-dtbook.dtbook-validate"/>
                </p:input>
            </px:nordic-fail-on-error-status>
            <p:sink/>
            
        </p:when>
        <p:otherwise>
            <p:output port="status"/>
            
            <p:identity>
                <p:input port="source">
                    <p:inline exclude-inline-prefixes="#all">
                        <d:validation-status result="error"/>
                    </p:inline>
                </p:input>
            </p:identity>
            <px:message message="Unknown guidelines version"/>
        </p:otherwise>
    </p:choose>

</p:declare-step>
