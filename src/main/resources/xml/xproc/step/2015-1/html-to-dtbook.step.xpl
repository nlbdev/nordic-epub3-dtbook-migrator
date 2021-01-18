<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" version="1.0"
                xmlns:px="http://www.daisy.org/ns/pipeline/xproc"
                xmlns:d="http://www.daisy.org/ns/pipeline/data"
                type="px:nordic-html-to-dtbook.step" name="main">

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

    <!-- option supporting convert to DTBook 1.1.0 -->
    <p:option name="dtbook2005" required="false" select="'true'"/>
    <p:option name="fail-on-error" required="true"/>

    <p:import href="../validation-status.xpl">
        <p:documentation>
            px:nordic-validation-status
        </p:documentation>
    </p:import>
    <p:import href="../pretty-print.xpl">
        <p:documentation>
            px:nordic-pretty-print
        </p:documentation>
    </p:import>
    <p:import href="http://www.daisy.org/pipeline/modules/common-utils/library.xpl">
        <p:documentation>
            px:assert
        </p:documentation>
    </p:import>
    <p:import href="http://www.daisy.org/pipeline/modules/fileset-utils/library.xpl">
        <p:documentation>
            px:fileset-filter
            px:fileset-load
            px:fileset-update
            px:fileset-copy
            px:fileset-join
            px:fileset-rebase
        </p:documentation>
    </p:import>
    <p:import href="http://www.daisy.org/pipeline/modules/html-to-dtbook/library.xpl">
        <p:documentation>
            px:html-to-dtbook
        </p:documentation>
    </p:import>
    <p:import href="http://www.daisy.org/pipeline/modules/dtbook-utils/library.xpl">
        <p:documentation>
            px:dtbook-update-links
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
                <p:pipe step="html-to-dtbook.step.dtbook.processed.in-memory" port="result"/>
            </p:output>
            <p:output port="report.out" sequence="true">
                <p:empty/>
            </p:output>


            <!--
                Pre-process HTML
            -->
            <px:fileset-load media-types="application/xhtml+xml" name="html-to-dtbook.step.load-xhtml">
                <p:input port="in-memory">
                    <p:pipe port="in-memory.in" step="main"/>
                </p:input>
            </px:fileset-load>
            <px:assert test-count-max="1" message="There are multiple HTML files in the fileset; only the first one will be converted."/>
            <px:assert test-count-min="1" message="There must be a HTML file in the fileset." error-code="NORDICDTBOOKEPUB005"/>
            <p:split-sequence initial-only="true" test="position()=1" name="html-to-dtbook.step.split-sequence-only-first"/>
            <px:assert message="The HTML file must have a file extension." error-code="NORDICDTBOOKEPUB006">
                <p:with-option name="test" select="matches(base-uri(/*),'.*[^\.]\.[^\.]*$')"/>
            </px:assert>
            <!-- Make sure only sections corresponding to html:h[1-6] are used. -->
            <p:xslt name="html-to-dtbook.step.deep-level-grouping">
                <p:with-param name="name" select="'section article'"/>
                <p:with-param name="namespace" select="'http://www.w3.org/1999/xhtml'"/>
                <p:with-param name="max-depth" select="6"/>
                <p:with-param name="copy-wrapping-elements-into-result" select="true()"/>
                <p:input port="stylesheet">
                    <p:document href="../../../xslt/deep-level-grouping.xsl"/>
                </p:input>
            </p:xslt>
            <!-- Nordic HTML to generic HTML -->
            <p:xslt name="html-to-dtbook.step.nordic-to-generic-epub3">
                <p:input port="stylesheet">
                    <p:document href="../../../xslt/nordic-to-generic-epub3.xsl"/>
                </p:input>
                <p:input port="parameters">
                    <p:empty/>
                </p:input>
            </p:xslt>
            <px:fileset-update name="html-to-dtbook.step.html.processed">
                <p:input port="source.fileset">
                    <p:pipe step="main" port="fileset.in"/>
                </p:input>
                <p:input port="source.in-memory">
                    <p:pipe step="main" port="in-memory.in"/>
                </p:input>
                <p:input port="update.fileset">
                    <p:pipe step="html-to-dtbook.step.load-xhtml" port="result.fileset"/>
                </p:input>
                <p:input port="update.in-memory">
                    <p:pipe step="html-to-dtbook.step.nordic-to-generic-epub3" port="result"/>
                </p:input>
            </px:fileset-update>

            <!--
                HTML to DTBook
            -->
            <px:html-to-dtbook name="html-to-dtbook.step.generic">
                <p:input port="source.in-memory">
                    <p:pipe step="html-to-dtbook.step.html.processed" port="result.in-memory"/>
                </p:input>
            </px:html-to-dtbook>

            <!--
                Post-process DTBook
            -->
            <px:fileset-filter media-types="application/x-dtbook+xml" name="html-to-dtbook.step.dtbook">
                <p:input port="source.in-memory">
                    <p:pipe step="html-to-dtbook.step.generic" port="result.in-memory"/>
                </p:input>
            </px:fileset-filter>
            <px:fileset-load name="html-to-dtbook.step.dtbook.load">
                <p:input port="in-memory">
                    <p:pipe step="html-to-dtbook.step.generic" port="result.in-memory"/>
                </p:input>
            </px:fileset-load>
            <!--
                generic DTBook to Nordic DTBook
            -->
            <p:xslt>
                <p:input port="stylesheet">
                    <p:document href="../../../xslt/generic-to-nordic-dtbook.xsl"/>
                </p:input>
                <p:input port="parameters">
                    <p:empty/>
                </p:input>
            </p:xslt>
            <!--
                update relative links to images
            -->
            <px:dtbook-update-links>
                <p:input port="mapping">
                    <p:pipe step="html-to-dtbook.step.move-images" port="mapping"/>
                </p:input>
            </px:dtbook-update-links>
            <!--
                optionally downgrade DTBook
            -->
            <p:group name="html-to-dtbook.step.choose-convert-to-dtbook110">
                <p:output port="fileset">
                    <p:pipe step="html-to-dtbook.step.choose-convert-to-dtbook110.choose" port="fileset"/>
                </p:output>
                <p:output port="in-memory" sequence="true" primary="true"/>
                <p:choose name="html-to-dtbook.step.choose-convert-to-dtbook110.choose">
                    <p:when test="$dtbook2005='true'">
                        <!--
                            keep DTBook 2005-3
                        -->
                        <p:output port="fileset">
                            <p:pipe step="html-to-dtbook.step.dtbook" port="result"/>
                        </p:output>
                        <p:output port="in-memory" sequence="true" primary="true"/>
                        <p:identity/>
                    </p:when>
                    <p:otherwise>
                        <!--
                            downgrade to DTBook 1.1.0
                        -->
                        <p:output port="fileset">
                            <p:pipe step="fileset" port="result"/>
                        </p:output>
                        <p:output port="in-memory" sequence="true" primary="true">
                            <p:pipe step="html-to-dtbook.step.choose-convert-to-dtbook110.dtbook2005-to-dtbook110" port="result"/>
                        </p:output>
                        <p:xslt name="html-to-dtbook.step.choose-convert-to-dtbook110.dtbook2005-to-dtbook110">
                            <p:input port="parameters">
                                <p:empty/>
                            </p:input>
                            <p:input port="stylesheet">
                                <p:document href="../../../xslt/dtbook2005-to-dtbook110.xsl"/>
                            </p:input>
                        </p:xslt>
                        <p:sink/>
                        <p:identity>
                            <p:input port="source">
                                <p:pipe step="html-to-dtbook.step.dtbook" port="result"/>
                            </p:input>
                        </p:identity>
                        <!--
                            add standalone 'yes' to DTBook 1.1.0
                        -->
                        <p:add-attribute match="d:file" attribute-name="standalone" attribute-value="true"/>
                        <!--
                            remove doctype
                        -->
                        <p:delete match="d:file/@doctype-public|
                                         d:file/@doctype-system"/>
                        <p:identity name="fileset"/>
                    </p:otherwise>
                </p:choose>
            </p:group>
            <!--
                pretty print DTBook
            -->
            <px:nordic-pretty-print name="html-to-dtbook.step.pretty-print-dtbook">
                <!-- FIXME: remove all pretty-printing to improve performance -->
            </px:nordic-pretty-print>
            <p:sink/>

            <!--
                Move images out of 'images/' subdirectory
            -->
            <px:fileset-filter name="html-to-dtbook.step.filter-images">
                <p:with-option name="href" select="resolve-uri('images/*',base-uri(/*))">
                    <p:pipe step="html-to-dtbook.step.dtbook.load" port="result"/>
                </p:with-option>
                <p:input port="source">
                    <p:pipe step="html-to-dtbook.step.dtbook" port="not-matched"/>
                </p:input>
                <p:input port="source.in-memory">
                    <p:pipe step="html-to-dtbook.step.generic" port="result.in-memory"/>
                </p:input>
            </px:fileset-filter>
            <px:fileset-rebase>
                <p:with-option name="new-base" select="resolve-uri('images/',base-uri(/*))">
                    <p:pipe step="html-to-dtbook.step.dtbook.load" port="result"/>
                </p:with-option>
            </px:fileset-rebase>
            <px:fileset-copy name="html-to-dtbook.step.move-images">
                <p:with-option name="target" select="resolve-uri('../',base-uri(/*))"/>
                <p:input port="source.in-memory">
                    <p:pipe step="html-to-dtbook.step.filter-images" port="result.in-memory"/>
                </p:input>
            </px:fileset-copy>
            <p:sink/>

            <!--
                Update DTBook in fileset
            -->
            <p:identity name="html-to-dtbook.step.dtbook.processed.in-memory">
                <p:input port="source">
                    <p:pipe step="html-to-dtbook.step.pretty-print-dtbook" port="result"/>
                    <p:pipe step="html-to-dtbook.step.filter-images" port="not-matched.in-memory"/>
                    <p:pipe step="html-to-dtbook.step.move-images" port="result.in-memory"/>
                </p:input>
            </p:identity>
            <p:sink/>
            <px:fileset-join>
                <p:input port="source">
                    <p:pipe step="html-to-dtbook.step.choose-convert-to-dtbook110" port="fileset"/>
                    <p:pipe step="html-to-dtbook.step.filter-images" port="not-matched"/>
                    <p:pipe step="html-to-dtbook.step.move-images" port="result.fileset"/>
                </p:input>
            </px:fileset-join>
            <px:nordic-pretty-print preserve-empty-whitespace="false">
                <!-- FIXME: remove all pretty-printing to improve performance -->
            </px:nordic-pretty-print>



        </p:when>
        <p:otherwise>
            <p:output port="fileset.out" primary="true"/>
            <p:output port="in-memory.out" sequence="true">
                <p:pipe port="fileset.in" step="main"/>
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
