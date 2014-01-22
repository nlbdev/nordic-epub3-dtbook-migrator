<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" xmlns:px="http://www.daisy.org/ns/pipeline/xproc" xmlns:d="http://www.daisy.org/ns/pipeline/data"
    type="px:nordic-epub3-validate.step" name="main" version="1.0" xmlns:epub="http://www.idpf.org/2007/ops" xmlns:html="http://www.w3.org/1999/xhtml" xmlns:opf="http://www.idpf.org/2007/opf"
    xmlns:pxi="http://www.daisy.org/ns/pipeline/xproc/internal/nordic-epub3-dtbook-migrator">
    
    <p:serialization port="report.out" indent="true"/>
    
    <p:input port="fileset.in" primary="true"/>
    <p:input port="in-memory.in" sequence="true">
        <p:empty/>
    </p:input>
    <p:input port="report.in" sequence="true">
        <p:empty/>
    </p:input>

    <p:output port="fileset.out" primary="true">
        <p:pipe port="fileset" step="unzip"/>
    </p:output>
    <p:output port="in-memory.out" sequence="true">
        <p:pipe port="in-memory" step="unzip"/>
    </p:output>
    <p:output port="report.out" sequence="true">
        <p:pipe port="report.in" step="main"/>
        <p:pipe port="result" step="opf.validate"/>
    </p:output>

    <p:option name="temp-dir" required="true"/>
    
    <p:variable name="basedir" select="if (/*/d:file[@media-type='application/epub+zip']) then $temp-dir else base-uri(/*)"/>

    <p:import href="http://www.daisy.org/pipeline/modules/zip-utils/library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/fileset-utils/library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/validation-utils/library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/common-utils/library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/mediatype-utils/library.xpl"/>
    
    <p:choose name="unzip">
        <p:when test="/*/d:file[@media-type='application/epub+zip']">
            <p:output port="fileset">
                <p:pipe port="fileset.out" step="unzip-fileset"/>
            </p:output>
            <p:output port="in-memory" sequence="true">
                <p:pipe port="in-memory.out" step="unzip-fileset"/>
            </p:output>
            <px:fileset-filter media-types="application/epub+zip"/>
            <px:assert test-count-min="1" test-count-max="1" message="There must be exactly one EPUB in the fileset." error-code="NORDICDTBOOKEPUB021"/>
            <px:unzip-fileset name="unzip-fileset">
                <p:with-option name="href" select="resolve-uri(/*/*/(@original-href,@href)[1],/*/*/base-uri(.))"/>
                <p:with-option name="unzipped-basedir" select="$temp-dir"/>
            </px:unzip-fileset>
            <p:sink/>
        </p:when>
        <p:otherwise>
            <p:output port="fileset">
                <p:pipe port="fileset.in" step="main"/>
            </p:output>
            <p:output port="in-memory" sequence="true">
                <p:pipe port="in-memory.in" step="main"/>
            </p:output>
            <p:sink>
                <p:input port="source">
                    <p:empty/>
                </p:input>
            </p:sink>
        </p:otherwise>
    </p:choose>

    <px:fileset-load media-types="application/oebps-package+xml">
        <p:input port="fileset">
            <p:pipe port="fileset" step="unzip"/>
        </p:input>
        <p:input port="in-memory">
            <p:pipe port="in-memory" step="unzip"/>
        </p:input>
    </px:fileset-load>
    <px:assert test-count-min="1" test-count-max="1" message="There must be exactly one Package Document in the EPUB." error-code="NORDICDTBOOKEPUB011"/>
    <p:identity name="opf"/>
    
    <p:xslt>
        <p:input port="parameters">
            <p:empty/>
        </p:input>
        <p:input port="source">
            <p:pipe port="result" step="opf"/>
        </p:input>
        <p:input port="stylesheet">
            <p:document href="../../xslt/opf.validate.xsl"/>
        </p:input>
    </p:xslt>
    <p:string-replace match="//d:document-name/text()">
        <p:with-option name="replace" select="concat('substring(//d:document-name/text(),',string-length($basedir)+1,')')"/>
    </p:string-replace>
    <p:string-replace match="//d:error-count/text()">
        <p:with-option name="replace" select="count(//d:error)"/>
    </p:string-replace>
    <p:identity name="opf.validate"/>
    <p:sink/>

    <!--
        TODO:
        * report whether the HTML is single-page or one of many
        * if single page;
        * if multi-page:
    -->

</p:declare-step>
