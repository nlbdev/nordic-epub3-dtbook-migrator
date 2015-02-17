<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" xmlns:px="http://www.daisy.org/ns/pipeline/xproc" xmlns:d="http://www.daisy.org/ns/pipeline/data"
    type="px:nordic-dtbook-validate.step" name="main" version="1.0" xmlns:epub="http://www.idpf.org/2007/ops" xmlns:html="http://www.w3.org/1999/xhtml" xmlns:opf="http://www.idpf.org/2007/opf"
    xmlns:pxi="http://www.daisy.org/ns/pipeline/xproc/internal/nordic-epub3-dtbook-migrator" xmlns:l="http://xproc.org/library">

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

    <p:option name="fail-on-error" select="'true'"/>
    <p:option name="check-images" required="false" select="'true'"/>
    <p:option name="allow-legacy" required="false" select="'true'"/>

    <!-- option supporting convert to DTBook 1.1.0 -->
    <p:option name="dtbook2005" required="false" select="'true'"/>

    <p:import href="validation-status.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/common-utils/library.xpl"/>
    <p:import href="../upstream/fileset-utils/fileset-load.xpl"/>
    <!--<p:import href="../upstream/fileset-utils/fileset-add-entry.xpl"/>-->
    <p:import href="http://www.daisy.org/pipeline/modules/fileset-utils/library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/dtbook-utils/library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/dtbook-validator/dtbook-validator.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/mediatype-utils/library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/validation-utils/library.xpl"/>

    <px:assert message="'fail-on-error' should be either 'true' or 'false'. was: '$1'. will default to 'true'.">
        <p:with-option name="param1" select="$fail-on-error"/>
        <p:with-option name="test" select="$fail-on-error = ('true','false')"/>
    </px:assert>
    <px:assert message="'check-images' should be either 'true' or 'false'. was: '$1'. will default to 'false'.">
        <p:with-option name="param1" select="$check-images"/>
        <p:with-option name="test" select="$check-images = ('true','false')"/>
    </px:assert>
    <px:assert message="'allow-legacy' should be either 'true' or 'false'. was: '$1'. will default to 'true'.">
        <p:with-option name="param1" select="$allow-legacy"/>
        <p:with-option name="test" select="$allow-legacy = ('true','false')"/>
    </px:assert>

    <p:choose name="choose">
        <p:xpath-context>
            <p:pipe port="status.in" step="main"/>
        </p:xpath-context>
        <p:when test="/*/@result='ok' or $fail-on-error = 'false'">
            <p:output port="fileset.out" primary="true">
                <p:pipe port="fileset.out" step="choose.inner"/>
            </p:output>
            <p:output port="in-memory.out" sequence="true">
                <p:pipe port="in-memory.out" step="choose.inner"/>
            </p:output>
            <p:output port="report.out" sequence="true">
                <p:pipe port="report.out" step="choose.inner"/>
            </p:output>

            <px:message severity="DEBUG" message="Validating DTBook according to DTBook specification..."/>
            <px:dtbook-validator name="validate.input-dtbook.generic">
                <p:with-option name="input-dtbook" select="(/*/*[@media-type='application/x-dtbook+xml']/resolve-uri(@href,base-uri(.)))[1]"/>
                <p:with-option name="check-images" select="$check-images"/>
            </px:dtbook-validator>

            <p:choose name="choose.inner">
                <p:xpath-context>
                    <p:pipe port="validation-status" step="validate.input-dtbook.generic"/>
                </p:xpath-context>
                <p:when test="not(/*/@result='ok')">
                    <p:output port="fileset.out">
                        <p:pipe port="fileset.in" step="main"/>
                    </p:output>
                    <p:output port="in-memory.out" sequence="true">
                        <p:pipe port="in-memory.in" step="main"/>
                    </p:output>
                    <p:output port="report.out" sequence="true">
                        <p:pipe port="report" step="validate.input-dtbook.generic"/>
                    </p:output>

                    <p:sink>
                        <p:input port="source">
                            <p:empty/>
                        </p:input>
                    </p:sink>
                </p:when>

                <p:otherwise>
                    <p:output port="fileset.out">
                        <p:pipe port="result" step="input-dtbook.fileset"/>
                    </p:output>
                    <p:output port="in-memory.out" sequence="true">
                        <p:pipe port="in-memory.out" step="input-dtbook.in-memory"/>
                    </p:output>
                    <p:output port="report.out" sequence="true">
                        <p:pipe port="report" step="validate.input-dtbook.generic"/>
                        <p:pipe port="result" step="validate.input-dtbook.nordic"/>
                    </p:output>

                    <px:fileset-filter media-types="application/x-dtbook+xml">
                        <p:input port="source">
                            <p:pipe port="fileset.in" step="main"/>
                        </p:input>
                    </px:fileset-filter>
                    <px:assert message="There should be exactly one DTBook (was: $1)">
                        <p:with-option name="test" select="count(/*/*) = 1"/>
                        <p:with-option name="param1" select="count(/*/*)"/>
                    </px:assert>
                    <p:delete match="/*/*[position() &gt; 1]"/>
                    <pxi:fileset-load media-types="application/x-dtbook+xml">
                        <p:input port="in-memory">
                            <p:pipe port="in-memory.in" step="main"/>
                        </p:input>
                    </pxi:fileset-load>
                    <p:choose>
                        <p:when test="$allow-legacy='true' and $dtbook2005='true'">
                            <px:upgrade-dtbook>
                                <p:input port="parameters">
                                    <p:empty/>
                                </p:input>
                            </px:upgrade-dtbook>
                            <px:message severity="DEBUG" message="Cleaning up legacy markup"/>
                            <p:xslt>
                                <p:input port="parameters">
                                    <p:empty/>
                                </p:input>
                                <p:input port="stylesheet">
                                    <p:document href="../../xslt/dtbook-legacy-fix.xsl"/>
                                </p:input>
                            </p:xslt>
                            <p:identity/>
                        </p:when>
                        <p:otherwise>
                            <p:identity/>
                        </p:otherwise>
                    </p:choose>
                    <p:identity name="input-dtbook"/>

                    <p:choose>
                        <p:when test="$dtbook2005='true'">
                            <p:output port="result" sequence="true"/>

                            <px:message message="Validating DTBook according to Nordic specification..."/>
                            <l:relax-ng-report name="validate.input-dtbook.nordic.validation">
                                <p:input port="schema">
                                    <p:document href="../../schema/nordic-dtbook-2005-3.rng"/>
                                </p:input>
                                <p:with-option name="dtd-attribute-values" select="'false'"/>
                                <p:with-option name="dtd-id-idref-warnings" select="'false'"/>
                            </l:relax-ng-report>
                            <p:sink/>

                            <p:validate-with-schematron name="validate.input-dtbook.tpb.validation" assert-valid="false">
                                <p:input port="parameters">
                                    <p:empty/>
                                </p:input>
                                <p:input port="source">
                                    <p:pipe step="input-dtbook" port="result"/>
                                </p:input>
                                <p:input port="schema">
                                    <p:document href="../../schema/mtm2015-1.sch"/>
                                </p:input>
                            </p:validate-with-schematron>
                            <p:sink/>

                            <px:combine-validation-reports document-type="Nordic DTBook">
                                <p:input port="source">
                                    <p:pipe port="report" step="validate.input-dtbook.nordic.validation"/>
                                    <p:pipe port="report" step="validate.input-dtbook.tpb.validation"/>
                                </p:input>
                                <p:with-option name="document-name" select="replace((/*/*[@media-type='application/x-dtbook+xml']/@href)[1],'.*/','')">
                                    <p:pipe port="fileset.in" step="main"/>
                                </p:with-option>
                                <p:with-option name="document-path" select="(/*/*[@media-type='application/x-dtbook+xml']/resolve-uri(@href,base-uri()))[1]">
                                    <p:pipe port="fileset.in" step="main"/>
                                </p:with-option>
                            </px:combine-validation-reports>

                        </p:when>
                        <p:otherwise>
                            <p:output port="result" sequence="true"/>

                            <!-- DTBook 1.1.0 => no validation -->
                            <p:identity>
                                <p:input port="source">
                                    <p:empty/>
                                </p:input>
                            </p:identity>
                        </p:otherwise>
                    </p:choose>
                    <p:identity name="validate.input-dtbook.nordic"/>

                    <px:dtbook-load name="input-dtbook.in-memory">
                        <p:input port="source">
                            <p:pipe port="result" step="input-dtbook"/>
                        </p:input>
                    </px:dtbook-load>
                    <p:viewport match="/*/*">
                        <px:message message="setting original-href for $1 to $2">
                            <p:with-option name="param1" select="/*/@href"/>
                            <p:with-option name="param2" select="if (/*/@original-href) then /*/@original-href else resolve-uri(/*/@href, base-uri(/*))"/>
                        </px:message>
                        <p:add-attribute match="/*" attribute-name="original-href">
                            <p:with-option name="attribute-value" select="if (/*/@original-href) then /*/@original-href else resolve-uri(/*/@href, base-uri(/*))"/>
                        </p:add-attribute>
                    </p:viewport>
                    <px:mediatype-detect name="input-dtbook.fileset"/>
                    <p:sink/>

                </p:otherwise>
            </p:choose>

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

    <p:choose>
        <p:xpath-context>
            <p:pipe port="status.in" step="main"/>
        </p:xpath-context>
        <p:when test="/*/@result='ok'">
            <px:nordic-validation-status>
                <p:input port="source">
                    <p:pipe port="report.out" step="choose"/>
                </p:input>
            </px:nordic-validation-status>
        </p:when>
        <p:otherwise>
            <p:identity>
                <p:input port="source">
                    <p:pipe port="status.in" step="main"/>
                </p:input>
            </p:identity>
        </p:otherwise>
    </p:choose>
    <p:identity name="status"/>

</p:declare-step>
