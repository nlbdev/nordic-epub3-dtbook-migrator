<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" xmlns:px="http://www.daisy.org/ns/pipeline/xproc" xmlns:d="http://www.daisy.org/ns/pipeline/data"
    type="px:nordic-dtbook-validate.step" name="main" version="1.0" xmlns:epub="http://www.idpf.org/2007/ops" xmlns:html="http://www.w3.org/1999/xhtml" xmlns:opf="http://www.idpf.org/2007/opf"
    xmlns:pxi="http://www.daisy.org/ns/pipeline/xproc/internal/nordic-epub3-dtbook-migrator" xmlns:l="http://xproc.org/library">

    <p:documentation>Validates and loads the DTBook at the href $dtbook according to generic and nordic guidelines.</p:documentation>

    <p:input port="report.in" primary="false" sequence="true">
        <p:empty/>
    </p:input>

    <p:output port="fileset.out" primary="true">
        <p:pipe port="fileset" step="choose"/>
    </p:output>
    <p:output port="in-memory.out" sequence="true">
        <p:pipe port="in-memory" step="choose"/>
    </p:output>
    <p:output port="report.out" sequence="true">
        <p:pipe port="report.in" step="main"/>
        <p:pipe port="report" step="choose"/>
    </p:output>

    <p:option name="dtbook" required="true"/>
    <p:option name="check-images" required="false" select="'false'"/>

    <p:import href="http://www.daisy.org/pipeline/modules/common-utils/library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/fileset-utils/library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/dtbook-utils/library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/dtbook-validator/dtbook-validator.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/mediatype-utils/library.xpl"/>
    <!--    <p:import href="http://www.daisy.org/pipeline/modules/epub3-ocf-utils/library.xpl"/>-->
    <!--    <p:import href="http://www.daisy.org/pipeline/modules/dtbook-validator/dtbook-validator.xpl"/>-->
    <p:import href="http://www.daisy.org/pipeline/modules/validation-utils/library.xpl"/>

    <px:message message="Validating DTBook according to DTBook specification..."/>
    <px:dtbook-validator name="validate.input-dtbook.generic">
        <p:with-option name="input-dtbook" select="$dtbook"/>
        <p:with-option name="check-images" select="$check-images"/>
    </px:dtbook-validator>

    <p:choose name="choose">
        <p:xpath-context>
            <p:pipe port="validation-status" step="validate.input-dtbook.generic"/>
        </p:xpath-context>
        <p:when test="not(/*/@result='ok')">
            <p:output port="report" sequence="true">
                <p:pipe port="report" step="validate.input-dtbook.generic"/>
            </p:output>
            <p:output port="in-memory" sequence="true">
                <p:empty/>
            </p:output>
            <p:output port="fileset">
                <p:pipe port="result" step="invalid-fileset"/>
            </p:output>

            <px:fileset-create>
                <p:with-option name="base" select="replace($dtbook,'[^/]+$','')"/>
            </px:fileset-create>
            <px:fileset-add-entry media-type="application/x-dtbook+xml">
                <p:with-option name="href" select="$dtbook"/>
            </px:fileset-add-entry>
            <p:identity name="invalid-fileset"/>
        </p:when>

        <p:otherwise>
            <p:output port="report" sequence="true">
                <p:pipe port="report" step="validate.input-dtbook.generic"/>
                <p:pipe port="result" step="validate.input-dtbook.nordic"/>
            </p:output>
            <p:output port="in-memory" sequence="true">
                <p:pipe port="in-memory.out" step="input-dtbook.in-memory"/>
            </p:output>
            <p:output port="fileset">
                <p:pipe port="result" step="input-dtbook.fileset"/>
            </p:output>

            <p:load name="input-dtbook">
                <p:with-option name="href" select="$dtbook"/>
            </p:load>

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
                    <p:document href="../../schema/tpb2011-1.sch"/>
                </p:input>
            </p:validate-with-schematron>
            <p:sink/>

            <px:combine-validation-reports name="validate.input-dtbook.nordic">
                <p:input port="source">
                    <p:pipe port="report" step="validate.input-dtbook.nordic.validation"/>
                    <p:pipe port="report" step="validate.input-dtbook.tpb.validation"/>
                    <p:inline>
                        <c:errors>
                            <!-- Temporary fix for v1.7. Will probably be fixed in v1.8. See: https://github.com/daisy-consortium/pipeline-modules-common/pull/48 -->
                        </c:errors>
                    </p:inline>
                </p:input>
                <p:with-option name="document-name" select="replace($dtbook,'.*/','')">
                    <p:empty/>
                </p:with-option>
                <p:with-option name="document-type" select="'Nordic DTBook'">
                    <p:empty/>
                </p:with-option>
                <p:with-option name="document-path" select="$dtbook">
                    <p:empty/>
                </p:with-option>
            </px:combine-validation-reports>

            <px:dtbook-load name="input-dtbook.in-memory">
                <p:input port="source">
                    <p:pipe port="result" step="input-dtbook"/>
                </p:input>
            </px:dtbook-load>
            <px:mediatype-detect name="input-dtbook.fileset"/>

        </p:otherwise>
    </p:choose>

</p:declare-step>
