<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" xmlns:px="http://www.daisy.org/ns/pipeline/xproc" xmlns:d="http://www.daisy.org/ns/pipeline/data"
    type="px:nordic-epub3-validate" name="main" version="1.0" xmlns:epub="http://www.idpf.org/2007/ops" xmlns:pxp="http://exproc.org/proposed/steps" xmlns:html="http://www.w3.org/1999/xhtml"
    xmlns:opf="http://www.idpf.org/2007/opf" xmlns:cx="http://xmlcalabash.com/ns/extensions">

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
    
    <p:option name="check-images" required="false" select="'true'" px:type="boolean">
        <p:documentation xmlns="http://www.w3.org/1999/xhtml">
            <h2 px:role="name">Check image file signatures</h2>
            <p px:role="desc">Check the "magic numbers" of the image files to make sure that they are as expected.</p>
        </p:documentation>
    </p:option>
    
    <p:option name="use-epubcheck" required="false" select="'true'" px:type="boolean">
        <p:documentation xmlns="http://www.w3.org/1999/xhtml">
            <h2 px:role="name">Validate with Epubcheck</h2>
            <p px:role="desc">Whether or not to run Epubcheck validation in addition to the nordic validation rules.</p>
        </p:documentation>
    </p:option>
    
    <p:option name="use-ace" required="false" select="'false'" px:type="boolean">
        <p:documentation xmlns="http://www.w3.org/1999/xhtml">
            <h2 px:role="name">Validate with Ace by DAISY</h2>
            <p px:role="desc">Whether or not to run Ace by DAISY validation in addition to the nordic validation rules. Ace violations with a critical or serious severity will result in a validation error.</p>
        </p:documentation>
    </p:option>
    
    <p:option name="organization-specific-validation" required="false" px:type="string" select="''">
        <p:documentation xmlns="http://www.w3.org/1999/xhtml">
            <h2 px:role="name">Organization-specific validation</h2>
            <p px:role="desc">Leave blank for the default validation schemas. Use 'nota' to validate using Nota-specific validation rules.</p>
        </p:documentation>
    </p:option>

    <p:option name="temp-dir" required="true" px:output="temp" px:type="anyDirURI">
        <p:documentation xmlns="http://www.w3.org/1999/xhtml">
            <h2 px:role="name">Temporary directory</h2>
            <p px:role="desc">Temporary directory for use by the script.</p>
        </p:documentation>
    </p:option>

    <p:option name="html-report" required="true" px:output="result" px:type="anyDirURI" px:media-type="application/vnd.pipeline.report+xml">
        <p:documentation xmlns="http://www.w3.org/1999/xhtml">
            <h1 px:role="name">HTML Report</h1>
            <p px:role="desc">An HTML-formatted version of the validation report.</p>
        </p:documentation>
    </p:option>

    <p:output port="validation-status" px:media-type="application/vnd.pipeline.status+xml">
        <p:documentation xmlns="http://www.w3.org/1999/xhtml">
            <h1 px:role="name">Validation status</h1>
            <p px:role="desc">Validation status (http://code.google.com/p/daisy-pipeline/wiki/ValidationStatusXML).</p>
        </p:documentation>
        <p:pipe port="status" step="guidelines-version.choose"/>
    </p:output>

    <p:import href="step/2015-1/epub3-validate.step.xpl"/>
    <p:import href="step/2020-1/epub3-validate.step.xpl"/>
    <p:import href="step/determine-guidelines-version.xpl"/>
    <p:import href="step/validation-status.xpl"/>
    <p:import href="step/format-html-report.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/file-utils/library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/fileset-utils/library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/common-utils/library.xpl"/>

    <px:message message="$1">
        <p:with-option name="param1" select="/*">
            <p:document href="../version-description.xml"/>
        </p:with-option>
    </px:message>
    
    <px:normalize-uri name="epub">
        <p:with-option name="href" select="resolve-uri($epub,static-base-uri())"/>
    </px:normalize-uri>
    <px:normalize-uri name="temp-dir">
        <p:with-option name="href" select="resolve-uri($temp-dir,static-base-uri())"/>
    </px:normalize-uri>
    <px:normalize-uri name="html-report">
        <p:with-option name="href" select="resolve-uri($html-report,static-base-uri())"/>
    </px:normalize-uri>
    <p:identity name="epub3-validate.nordic-version-message-and-variables"/>
    <p:sink/>
    
    <px:nordic-determine-guidelines-version name="guidelines-version">
        <p:with-option name="href" select="/*/text()">
            <p:pipe port="normalized" step="epub"/>
        </p:with-option>
    </px:nordic-determine-guidelines-version>
    <px:message message="Guidelines version: $1">
        <p:with-option name="param1" select="/*/text()"/>
    </px:message>
    <p:sink/>
    
    <px:fileset-create cx:depends-on="epub3-validate.nordic-version-message-and-variables" name="epub3-validate.create-epub-fileset">
        <p:with-option name="base" select="replace(/*/text(),'[^/]+$','')">
            <p:pipe port="normalized" step="epub"/>
        </p:with-option>
    </px:fileset-create>
    <px:fileset-add-entry media-type="application/epub+zip" name="epub3-validate.add-epub-to-fileset">
        <p:with-option name="href" select="replace(/*/text(),'^.*/([^/]*)$','$1')">
            <p:pipe port="normalized" step="epub"/>
        </p:with-option>
    </px:fileset-add-entry>
    
    <p:choose name="guidelines-version.choose">
        <p:xpath-context>
            <p:pipe port="result" step="guidelines-version"/>
        </p:xpath-context>
        <p:when test="/*/text() = '2015-1'">
            <p:output port="status">
                <p:pipe port="result" step="status.2015-1"/>
            </p:output>
        
            <px:nordic-epub3-validate.step name="epub3-validate.validate.nordic" fail-on-error="true">
                <p:with-option name="temp-dir" select="concat(/*/text(),'validate/')">
                    <p:pipe port="normalized" step="temp-dir"/>
                </p:with-option>
                <p:with-option name="check-images" select="$check-images"/>
                <p:with-option name="use-epubcheck" select="$use-epubcheck"/>
                <p:with-option name="use-ace" select="$use-ace"/>
                <p:with-option name="organization-specific-validation" select="$organization-specific-validation"/>
            </px:nordic-epub3-validate.step>
            <px:fileset-load media-types="application/xhtml+xml" name="epub3-validate.load-epub-xhtml">
                <p:input port="in-memory">
                    <p:pipe port="in-memory.out" step="epub3-validate.validate.nordic"/>
                </p:input>
            </px:fileset-load>
            <p:xslt name="epub3-validate.info-report">
                <p:input port="parameters">
                    <p:empty/>
                </p:input>
                <p:input port="stylesheet">
                    <p:document href="../xslt/info-report.xsl"/>
                </p:input>
            </p:xslt>
            <p:identity name="epub3-validate.report.nordic"/>
            <p:sink/>
        
            <px:nordic-format-html-report name="epub3-validate.html">
                <p:input port="source">
                    <p:pipe port="report.out" step="epub3-validate.validate.nordic"/>
                    <p:pipe port="result" step="epub3-validate.report.nordic"/>
                </p:input>
            </px:nordic-format-html-report>
            <p:store include-content-type="false" method="xhtml" omit-xml-declaration="false" name="epub3-validate.store-report">
                <p:with-option name="href" select="concat(/*/text(),if (ends-with(/*/text(),'/')) then '' else '/','report.xhtml')">
                    <p:pipe port="normalized" step="html-report"/>
                </p:with-option>
            </p:store>
            <px:set-doctype doctype="&lt;!DOCTYPE html&gt;" name="epub3-validate.set-report-doctype">
                <p:with-option name="href" select="/*/text()">
                    <p:pipe port="result" step="epub3-validate.store-report"/>
                </p:with-option>
            </px:set-doctype>
            <p:sink/>
        
            <px:nordic-validation-status name="status.2015-1">
                <p:input port="source">
                    <p:pipe port="report.out" step="epub3-validate.validate.nordic"/>
                </p:input>
            </px:nordic-validation-status>
            <p:sink/>
            
        </p:when>
        <p:when test="/*/text() = '2020-1'">
            <p:output port="status">
                <p:pipe port="result" step="status.2020-1"/>
            </p:output>
            
            <px:nordic-epub3-validate.step.2020-1 name="epub3-validate.2020-1.validate.nordic" fail-on-error="true">
                <p:with-option name="temp-dir" select="concat(/*/text(),'validate/')">
                    <p:pipe port="normalized" step="temp-dir"/>
                </p:with-option>
                <p:with-option name="check-images" select="$check-images"/>
                <p:with-option name="use-epubcheck" select="$use-epubcheck"/>
                <p:with-option name="use-ace" select="$use-ace"/>
            </px:nordic-epub3-validate.step.2020-1>
            <p:sink/>
            
            <px:nordic-format-html-report name="epub3-validate.2020-1.html">
                <p:input port="source">
                    <p:pipe port="report.out" step="epub3-validate.2020-1.validate.nordic"/>
                </p:input>
            </px:nordic-format-html-report>
            <p:store include-content-type="false" method="xhtml" omit-xml-declaration="false" name="epub3-validate.2020-1.store-report">
                <p:with-option name="href" select="concat(/*/text(),if (ends-with(/*/text(),'/')) then '' else '/','report.xhtml')">
                    <p:pipe port="normalized" step="html-report"/>
                </p:with-option>
            </p:store>
            
            <px:nordic-validation-status name="status.2020-1">
                <p:input port="source">
                    <p:pipe port="report.out" step="epub3-validate.2020-1.validate.nordic"/>
                </p:input>
            </px:nordic-validation-status>
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
