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
    <p:option name="indent" required="true"/>
    <p:option name="temp-dir" required="true"/>

    <p:import href="../pretty-print.xpl">
        <p:documentation>
            px:nordic-pretty-print
        </p:documentation>
    </p:import>
    <p:import href="../validation-status.xpl">
        <p:documentation>
            px:nordic-validation-status
        </p:documentation>
    </p:import>
    <p:import href="../update-epub-prefixes.xpl">
        <p:documentation>
            px:nordic-update-epub-prefixes
        </p:documentation>
    </p:import>
    <p:import href="../html-add-accessibility.step.xpl">
        <p:documentation>
            px:nordic-html-add-accessibility-css.step
        </p:documentation>
    </p:import>
    <p:import href="http://www.daisy.org/pipeline/modules/fileset-utils/library.xpl">
        <p:documentation>
            px:fileset-load
            px:fileset-filter
            px:fileset-copy
            px:fileset-update
            px:fileset-join
        </p:documentation>
    </p:import>
    <p:import href="http://www.daisy.org/pipeline/modules/file-utils/library.xpl">
        <p:documentation>
            px:add-xml-base
        </p:documentation>
    </p:import>
    <p:import href="http://www.daisy.org/pipeline/modules/html-utils/library.xpl">
        <p:documentation>
            px:html-update-links
        </p:documentation>
    </p:import>
    <p:import href="http://www.daisy.org/pipeline/modules/common-utils/library.xpl">
        <p:documentation>
            px:assert
        </p:documentation>
    </p:import>
    <p:import href="dtbook-to-html/library.xpl">
        <p:documentation>
            px:dtbook-to-html
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
            <p:output port="fileset.out" primary="true"/>
            <p:output port="in-memory.out" sequence="true">
                <p:pipe step="dtbook-to-html.step.add-css" port="in-memory.out"/>
            </p:output>
            <p:output port="report.out" sequence="true">
                <p:empty/>
            </p:output>

            <!--
                Generic conversion
            -->
            <px:dtbook-to-html name="dtbook-to-html.step.generic">
                <p:input port="source.in-memory">
                    <p:pipe step="main" port="in-memory.in"/>
                </p:input>
                <p:with-option name="output-dir" select="$temp-dir"/>
            </px:dtbook-to-html>

            <!--
                Move images to 'images/' subdirectory
            -->
            <px:fileset-filter media-types="image/*" name="dtbook-to-html.step.filter-images">
                <p:input port="source.in-memory">
                    <p:pipe step="dtbook-to-html.step.generic" port="result.in-memory"/>
                </p:input>
            </px:fileset-filter>
            <px:fileset-copy name="dtbook-to-html.step.move-images">
                <p:with-option name="target" select="concat($temp-dir,'images/')"/>
                <p:input port="source.in-memory">
                    <p:pipe step="dtbook-to-html.step.filter-images" port="result.in-memory"/>
                </p:input>
            </px:fileset-copy>
            <p:sink/>

            <!--
                Post-process HTML file
            -->
            <p:group name="dtbook-to-html.step.post-process-html">
                <p:output port="fileset" primary="true"/>
                <p:output port="in-memory" sequence="true">
                    <p:pipe step="update" port="result.in-memory"/>
                </p:output>

                <px:fileset-load media-types="application/xhtml+xml" name="load-html">
                    <p:input port="fileset">
                        <p:pipe step="dtbook-to-html.step.generic" port="result.fileset"/>
                    </p:input>
                    <p:input port="in-memory">
                        <p:pipe step="dtbook-to-html.step.generic" port="result.in-memory"/>
                    </p:input>
                </px:fileset-load>
                <px:add-xml-base root="false"/>
                <!--
                    Update relative links to images
                -->
                <px:html-update-links>
                    <p:input port="mapping">
                        <p:pipe step="dtbook-to-html.step.move-images" port="mapping"/>
                    </p:input>
                </px:html-update-links>
                <!--
                    Declare missing prefixes (note that this does not merge any epub:prefix
                    attributes because no epub:prefix attributes are created in px:dtbook-to-html)
                -->
                <px:nordic-update-epub-prefixes/>
                <!--
                    Pretty-print head
                -->
                <p:viewport match="/html:html/html:head" name="dtbook-to-html.step.viewport-html-head">
                    <!-- TODO: consider dropping this if it causes performance issues -->
                    <px:nordic-pretty-print preserve-empty-whitespace="false"/>
                </p:viewport>
                <p:identity name="dtbook-to-html.step.html.processed"/>
                <p:sink/>

                <!--
                    Update HTML in fileset
                -->
                <px:fileset-join>
                    <p:input port="source">
                        <p:pipe step="dtbook-to-html.step.filter-images" port="not-matched"/>
                        <p:pipe step="dtbook-to-html.step.move-images" port="result.fileset"/>
                    </p:input>
                </px:fileset-join>
                <px:fileset-update name="update">
                    <p:input port="update.fileset">
                        <p:pipe step="load-html" port="result.fileset"/>
                    </p:input>
                    <p:input port="update.in-memory">
                        <p:pipe step="dtbook-to-html.step.html.processed" port="result"/>
                    </p:input>
                    <p:input port="source.in-memory">
                        <p:pipe step="dtbook-to-html.step.filter-images" port="not-matched.in-memory"/>
                        <p:pipe step="dtbook-to-html.step.move-images" port="result.in-memory"/>
                    </p:input>
                </px:fileset-update>
            </p:group>

            <!--
                Add CSS
            -->
            <px:nordic-html-add-accessibility-css.step name="dtbook-to-html.step.add-css">
                <p:input port="in-memory.in">
                    <p:pipe step="dtbook-to-html.step.post-process-html" port="in-memory"/>
                </p:input>
            </px:nordic-html-add-accessibility-css.step>

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
