<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" version="1.0"
                xmlns:px="http://www.daisy.org/ns/pipeline/xproc"
                xmlns:d="http://www.daisy.org/ns/pipeline/data"
                xmlns:dtbook="http://www.daisy.org/z3986/2005/dtbook/"
                xmlns:html="http://www.w3.org/1999/xhtml"
                type="px:nordic-dtbook-to-html.step" name="main">

    <p:input port="fileset.in" primary="true"/>
    <p:input port="in-memory.in" sequence="true">
        <p:empty/>
    </p:input>
    <p:input port="report.in" sequence="true">
        <p:empty/>
    </p:input>
    <p:input port="status.in">
        <p:inline>
            <d:validation-status result="ok"/>
        </p:inline>
    </p:input>

    <p:output port="fileset.out" primary="true">
        <p:pipe port="fileset.out" step="choose"/>
    </p:output>
    <p:output port="in-memory.out" sequence="true">
        <p:pipe port="in-memory.out" step="choose"/>
    </p:output>
    <p:output port="report.out" sequence="true">
        <p:pipe port="report.in" step="main"/>
        <p:pipe port="report.out" step="choose"/>
    </p:output>
    <p:output port="status.out">
        <p:pipe port="result" step="status"/>
    </p:output>

    <p:option name="fail-on-error" required="true"/>
    <p:option name="temp-dir" required="true"/>

    <p:import href="pretty-print.xpl">
        <p:documentation>
            px:nordic-pretty-print
        </p:documentation>
    </p:import>
    <p:import href="validation-status.xpl">
        <p:documentation>
            px:nordic-validation-status
        </p:documentation>
    </p:import>
    <p:import href="update-epub-prefixes.xpl">
        <p:documentation>
            px:nordic-update-epub-prefixes
        </p:documentation>
    </p:import>
    <p:import href="http://www.daisy.org/pipeline/modules/fileset-utils/library.xpl">
        <p:documentation>
            px:fileset-load
            px:fileset-filter
            px:fileset-copy
            px:fileset-add-entry
            px:fileset-join
        </p:documentation>
    </p:import>
    <p:import href="http://www.daisy.org/pipeline/modules/file-utils/library.xpl">
        <p:documentation>
            px:set-base-uri
            px:add-xml-base
        </p:documentation>
    </p:import>
    <p:import href="http://www.daisy.org/pipeline/modules/common-utils/library.xpl">
        <p:documentation>
            px:assert
        </p:documentation>
    </p:import>

    <px:assert message="'fail-on-error' should be either 'true' or 'false'. was: '$1'. will default to 'true'.">
        <p:with-option name="param1" select="$fail-on-error"/>
        <p:with-option name="test" select="$fail-on-error = ('true','false')"/>
    </px:assert>

    <p:choose name="choose">
        <p:xpath-context>
            <p:pipe port="status.in" step="main"/>
        </p:xpath-context>
        <p:when test="/*/@result='ok' or $fail-on-error = 'false'">
            <p:output port="fileset.out" primary="true">
                <p:pipe step="dtbook-to-html.step.add-html-to-fileset" port="result"/>
            </p:output>
            <p:output port="in-memory.out" sequence="true">
                <p:pipe step="dtbook-to-html.step.add-html-to-fileset" port="result.in-memory"/>
            </p:output>
            <p:output port="report.out" sequence="true">
                <p:empty/>
            </p:output>

            <px:fileset-load media-types="application/x-dtbook+xml" name="dtbook-to-html.step.load-dtbook">
                <p:input port="in-memory">
                    <p:pipe port="in-memory.in" step="main"/>
                </p:input>
            </px:fileset-load>
            <px:assert test-count-max="1" message="There are multiple DTBooks in the fileset; only the first one will be converted."/>
            <px:assert test-count-min="1" message="There must be a DTBook file in the fileset." error-code="NORDICDTBOOKEPUB004"/>
            <p:split-sequence initial-only="true" test="position()=1" name="dtbook-to-html.step.only-use-first-dtbook"/>
            <p:identity name="dtbook-to-html.step.dtbook"/>

            <p:xslt>
                <p:input port="parameters">
                    <p:empty/>
                </p:input>
                <p:input port="stylesheet">
                    <p:document href="http://www.daisy.org/pipeline/modules/dtbook-to-html/dtbook-to-epub3.xsl"/>
                </p:input>
            </p:xslt>
            <px:set-base-uri>
                <p:with-option name="base-uri" select="concat($temp-dir,(//dtbook:meta[@name='dtb:uid']/@content,'missing-uid')[1],'.xhtml')">
                    <p:pipe port="result" step="dtbook-to-html.step.dtbook"/>
                </p:with-option>
            </px:set-base-uri>
            <px:add-xml-base root="false"/>
            <p:identity name="dtbook-to-html.step.dtbook-to-epub3"/>
            <!--
                Update relative links to images
            -->
            <p:xslt>
                <p:input port="source">
                    <p:pipe step="dtbook-to-html.step.dtbook-to-epub3" port="result"/>
                    <p:pipe step="dtbook-to-html.step.move-images" port="mapping"/>
                </p:input>
                <p:input port="parameters">
                    <p:empty/>
                </p:input>
                <p:input port="stylesheet">
                    <p:document href="../../xslt/update-links.xsl"/>
                </p:input>
            </p:xslt>

            <!--
                Merge all epub:prefix attributes into a single one and declare missing prefixes
            -->
            <px:nordic-update-epub-prefixes/>

            <!--
                Pretty-print head
            -->
            <p:viewport match="/html:html/html:head" name="dtbook-to-html.step.viewport-html-head">
                <!-- TODO: consider dropping this if it causes performance issues -->
                <px:nordic-pretty-print preserve-empty-whitespace="false"/>
            </p:viewport>
            <!-- TODO: add ASCIIMathML.js if there are asciimath elements -->

            <p:identity name="dtbook-to-html.step.html.in-memory"/>
            <p:sink/>

            <!--
                Move resources to $temp-dir
            -->
            <px:fileset-filter not-media-types="application/x-dtbook+xml text/css" name="dtbook-to-html.step.filter-resources">
                <p:input port="source">
                    <p:pipe port="fileset.in" step="main"/>
                </p:input>
            </px:fileset-filter>
            <px:fileset-copy name="dtbook-to-html.step.move-resources">
                <p:with-option name="target" select="$temp-dir"/>
                <p:input port="source.in-memory">
                    <p:pipe step="main" port="in-memory.in"/>
                </p:input>
            </px:fileset-copy>
            <!--
                Move images to 'images/' subdirectory
            -->
            <px:fileset-filter media-types="image/*" name="dtbook-to-html.step.filter-images"/>
            <px:fileset-copy name="dtbook-to-html.step.move-images">
                <p:with-option name="target" select="concat($temp-dir,'images/')"/>
                <p:input port="source.in-memory">
                    <p:pipe step="dtbook-to-html.step.move-resources" port="result.in-memory"/>
                </p:input>
            </px:fileset-copy>
            <p:sink/>
            <!--
                Combine HTML with resources
            -->
            <px:fileset-join>
                <p:input port="source">
                    <p:pipe step="dtbook-to-html.step.filter-images" port="not-matched"/>
                    <p:pipe step="dtbook-to-html.step.move-images" port="result.fileset"/>
                </p:input>
            </px:fileset-join>
            <px:fileset-add-entry media-type="application/xhtml+xml" name="dtbook-to-html.step.add-html-to-fileset">
                <p:input port="entry">
                    <p:pipe step="dtbook-to-html.step.html.in-memory" port="result"/>
                </p:input>
                <p:input port="source.in-memory">
                    <p:pipe step="dtbook-to-html.step.move-resources" port="result.in-memory"/>
                    <p:pipe step="dtbook-to-html.step.move-images" port="result.in-memory"/>
                </p:input>
                <p:with-param port="file-attributes" name="omit-xml-declaration" select="'false'"/>
                <p:with-param port="file-attributes" name="version" select="'1.0'"/>
                <p:with-param port="file-attributes" name="encoding" select="'utf-8'"/>
            </px:fileset-add-entry>
        </p:when>
        <p:otherwise>
            <p:output port="fileset.out" primary="true"/>
            <p:output port="in-memory.out" sequence="true">
                <p:pipe port="in-memory.in" step="main"/>
            </p:output>
            <p:output port="report.out" sequence="true">
                <p:empty/>
            </p:output>

            <p:identity/>
        </p:otherwise>
    </p:choose>

    <p:choose name="status">
        <p:xpath-context>
            <p:pipe port="status.in" step="main"/>
        </p:xpath-context>
        <p:when test="/*/@result='ok' and $fail-on-error='true'">
            <p:output port="result"/>
            <px:nordic-validation-status>
                <p:input port="source">
                    <p:pipe port="report.out" step="choose"/>
                </p:input>
            </px:nordic-validation-status>
        </p:when>
        <p:otherwise>
            <p:output port="result"/>
            <p:identity>
                <p:input port="source">
                    <p:pipe port="status.in" step="main"/>
                </p:input>
            </p:identity>
        </p:otherwise>
    </p:choose>

</p:declare-step>
