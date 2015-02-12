<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" xmlns:px="http://www.daisy.org/ns/pipeline/xproc" xmlns:d="http://www.daisy.org/ns/pipeline/data"
    type="px:nordic-html-validate.step" name="main" version="1.0" xmlns:epub="http://www.idpf.org/2007/ops" xmlns:html="http://www.w3.org/1999/xhtml" xmlns:opf="http://www.idpf.org/2007/opf"
    xmlns:pxi="http://www.daisy.org/ns/pipeline/xproc/internal/nordic-epub3-dtbook-migrator" xmlns:l="http://xproc.org/library">

    <p:serialization port="report.out" indent="true"/>

    <p:input port="fileset.in" primary="true"/>
    <p:input port="in-memory.in" sequence="true">
        <p:empty/>
    </p:input>
    <p:input port="report.in" sequence="true">
        <p:empty/>
    </p:input>

    <p:output port="fileset.out" primary="true">
        <p:pipe port="fileset.in" step="main"/>
    </p:output>
    <p:output port="in-memory.out" sequence="true">
        <p:pipe port="in-memory.in" step="main"/>
    </p:output>
    <p:output port="report.out" sequence="true">
        <p:pipe port="report.in" step="main"/>
        <p:pipe port="result" step="report"/>
    </p:output>

    <p:option name="document-type" required="false" select="'Nordic HTML'"/>

    <p:import href="../upstream/fileset-utils/fileset-load.xpl"/>
    <p:import href="../upstream/fileset-utils/fileset-add-entry.xpl"/>
    <!--<p:import href="http://www.daisy.org/pipeline/modules/fileset-utils/library.xpl"/>-->
    <p:import href="http://www.daisy.org/pipeline/modules/validation-utils/library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/common-utils/library.xpl"/>

    <pxi:fileset-load media-types="application/xhtml+xml">
        <p:input port="in-memory">
            <p:pipe port="in-memory.in" step="main"/>
        </p:input>
    </pxi:fileset-load>
    <px:assert test-count-min="1" test-count-max="1" message="There must be exactly one HTML-file in the fileset." error-code="NORDICDTBOOKEPUB031"/>
    <p:delete match="/*/@xml:base"/>
    <p:identity name="html"/>
    <p:sink/>

    <l:relax-ng-report name="validate.rng">
        <p:input port="source">
            <p:pipe step="html" port="result"/>
        </p:input>
        <p:input port="schema">
            <p:document href="../../schema/nordic-html5.rng"/>
        </p:input>
        <p:with-option name="dtd-attribute-values" select="'false'"/>
        <p:with-option name="dtd-id-idref-warnings" select="'false'"/>
    </l:relax-ng-report>
    <p:sink/>

    <p:validate-with-schematron name="validate.sch" assert-valid="false">
        <p:input port="parameters">
            <p:empty/>
        </p:input>
        <p:input port="source">
            <p:pipe step="html" port="result"/>
        </p:input>
        <p:input port="schema">
            <p:document href="../../schema/nordic2015-1.sch"/>
        </p:input>
    </p:validate-with-schematron>
    <p:sink/>

    <px:combine-validation-reports>
        <p:with-option name="document-type" select="$document-type"/>
        <p:input port="source">
            <p:pipe port="report" step="validate.rng"/>
            <p:pipe port="report" step="validate.sch"/>
        </p:input>
        <p:with-option name="document-name" select="replace(base-uri(/*),'.*/','')">
            <p:pipe port="result" step="html"/>
        </p:with-option>
        <p:with-option name="document-path" select="base-uri(/*)">
            <p:pipe port="result" step="html"/>
        </p:with-option>
    </px:combine-validation-reports>
    <p:xslt>
        <!-- pretty print to make debugging easier -->
        <p:input port="parameters">
            <p:empty/>
        </p:input>
        <p:input port="stylesheet">
            <p:document href="../../xslt/pretty-print.xsl"/>
        </p:input>
    </p:xslt>
    <p:identity name="report"/>
    <p:sink/>

</p:declare-step>
