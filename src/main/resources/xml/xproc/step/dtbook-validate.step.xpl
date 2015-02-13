<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" xmlns:px="http://www.daisy.org/ns/pipeline/xproc" xmlns:d="http://www.daisy.org/ns/pipeline/data"
    type="px:nordic-dtbook-validate.step" name="main" version="1.0" xmlns:epub="http://www.idpf.org/2007/ops" xmlns:html="http://www.w3.org/1999/xhtml" xmlns:opf="http://www.idpf.org/2007/opf"
    xmlns:pxi="http://www.daisy.org/ns/pipeline/xproc/internal/nordic-epub3-dtbook-migrator" xmlns:l="http://xproc.org/library">

    <p:documentation>Validates and loads the DTBook at the href $dtbook according to generic and nordic guidelines.</p:documentation>

    <p:input port="fileset.in" primary="true">
        <p:empty/>
    </p:input>
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
    <p:option name="dtbook" required="true"/>
    <p:option name="check-images" required="false" select="'false'"/>
    <p:option name="allow-legacy" required="false" select="'false'"/>

    <!-- option supporting convert to DTBook 1.1.0 -->
    <p:option name="dtbook2005" required="false" select="'true'"/>

    <p:import href="validation-status.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/common-utils/library.xpl"/>
    <!--<p:import href="../upstream/fileset-utils/fileset-load.xpl"/>-->
    <p:import href="../upstream/fileset-utils/fileset-add-entry.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/fileset-utils/library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/dtbook-utils/library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/dtbook-validator/dtbook-validator.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/mediatype-utils/library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/validation-utils/library.xpl"/>

    <px:assert message="'fail-on-error' whould be either 'true' or 'false'. was: '$1'. will default to 'true'.">
        <p:with-option name="param1" select="$fail-on-error"/>
        <p:with-option name="test" select="$fail-on-error = ('true','false')"/>
    </px:assert>

    <p:choose name="choose">
        <p:xpath-context>
            <p:pipe port="status.in" step="main"/>
        </p:xpath-context>
        <p:when test="/* and /*/@result='ok' or $fail-on-error = 'false'">
            <p:output port="fileset.out" primary="true">
                <p:pipe port="fileset.out" step="choose.inner"/>
            </p:output>
            <p:output port="in-memory.out" sequence="true">
                <p:pipe port="in-memory.out" step="choose.inner"/>
            </p:output>
            <p:output port="report.out" sequence="true">
                <p:pipe port="report.out" step="choose.inner"/>
            </p:output>

            <px:message message="Validating DTBook according to DTBook specification..."/>
            <px:dtbook-validator name="validate.input-dtbook.generic">
                <p:with-option name="input-dtbook" select="$dtbook"/>
                <p:with-option name="check-images" select="$check-images"/>
            </px:dtbook-validator>

            <p:choose name="choose.inner">
                <p:xpath-context>
                    <p:pipe port="validation-status" step="validate.input-dtbook.generic"/>
                </p:xpath-context>
                <p:when test="not(/*/@result='ok')">
                    <p:output port="report.out" sequence="true">
                        <p:pipe port="report" step="validate.input-dtbook.generic"/>
                    </p:output>
                    <p:output port="in-memory.out" sequence="true">
                        <p:empty/>
                    </p:output>
                    <p:output port="fileset.out">
                        <p:pipe port="result" step="invalid-fileset"/>
                    </p:output>

                    <px:fileset-create>
                        <p:with-option name="base" select="replace($dtbook,'[^/]+$','')"/>
                    </px:fileset-create>
                    <pxi:fileset-add-entry media-type="application/x-dtbook+xml">
                        <p:with-option name="href" select="$dtbook"/>
                        <p:with-option name="original-href" select="$dtbook"/>
                    </pxi:fileset-add-entry>
                    <p:identity name="invalid-fileset"/>
                </p:when>

                <p:otherwise>
                    <p:output port="report.out" sequence="true">
                        <p:pipe port="report" step="validate.input-dtbook.generic"/>
                        <p:pipe port="result" step="validate.input-dtbook.nordic"/>
                    </p:output>
                    <p:output port="in-memory.out" sequence="true">
                        <p:pipe port="in-memory.out" step="input-dtbook.in-memory"/>
                    </p:output>
                    <p:output port="fileset.out">
                        <p:pipe port="result" step="input-dtbook.fileset"/>
                    </p:output>

                    <p:load>
                        <p:with-option name="href" select="$dtbook"/>
                    </p:load>
                    <p:choose>
                        <p:when test="$allow-legacy='true' and $dtbook2005='true'">
                            <px:upgrade-dtbook>
                                <p:input port="parameters">
                                    <p:empty/>
                                </p:input>
                            </px:upgrade-dtbook>
                            <p:xslt>
                                <p:input port="parameters">
                                    <p:empty/>
                                </p:input>
                                <p:input port="stylesheet">
                                    <p:document href="../../xslt/dtbook-legacy-fix.xsl"/>
                                </p:input>
                            </p:xslt>
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

                            <px:combine-validation-reports name="validate.input-dtbook.nordic" document-type="Nordic DTBook">
                                <p:input port="source">
                                    <p:pipe port="report" step="validate.input-dtbook.nordic.validation"/>
                                    <p:pipe port="report" step="validate.input-dtbook.tpb.validation"/>
                                </p:input>
                                <p:with-option name="document-name" select="replace($dtbook,'.*/','')"/>
                                <p:with-option name="document-path" select="$dtbook"/>
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

                </p:otherwise>
            </p:choose>



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
