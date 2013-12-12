<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" xmlns:px="http://www.daisy.org/ns/pipeline/xproc" xmlns:d="http://www.daisy.org/ns/pipeline/data"
    type="px:nordic-epub3-validate" name="main" version="1.0" xmlns:epub="http://www.idpf.org/2007/ops" xmlns:html="http://www.w3.org/1999/xhtml" xmlns:opf="http://www.idpf.org/2007/opf"
    xmlns:pxi="http://www.daisy.org/ns/pipeline/xproc/internal/nordic-epub3-dtbook-migrator">
    
    <p:input port="fileset.in" primary="true"/>
    <p:input port="in-memory.in" sequence="true">
        <p:empty/>
    </p:input>
    
    <p:output port="fileset.out" primary="true">
        <p:pipe port="result" step="fileset"/>
    </p:output>
    <p:output port="in-memory.out" sequence="true">
        <p:pipe port="result" step="in-memory"/>
    </p:output>
    
    <p:option name="temp-dir" required="true"/>
    
<!--    <p:import href="http://www.daisy.org/pipeline/modules/html-utils/html-library.xpl"/>-->
<!--    <p:import href="http://www.daisy.org/pipeline/modules/fileset-utils/xproc/fileset-library.xpl"/>-->
    <p:import href="http://www.daisy.org/pipeline/modules/common-utils/logging-library.xpl"/>
<!--    <p:import href="http://www.daisy.org/pipeline/modules/mediatype-utils/mediatype.xpl"/>-->
    
    <px:fileset-filter media-types="application/epub+xml"/>
    <px:assert test-count-min="1" test-count-max="1" message="There must be exactly one EPUB in the fileset." error-code="NORDICDTBOOKEPUB021"/>
    
    <!-- TODO: use epubcheck to validate the epub at /d:fileset/d:file here -->
    
    <px:unzip-fileset name="load.in-memory">
        <p:with-option name="href" select="resolve-uri(/*/d:file/(@original-href,@href)[1], base-uri(/*/d:file))"/>
        <p:with-option name="unzipped-basedir" select="$temp-dir"/>
    </px:unzip-fileset>
    
    <px:fileset-store name="load.stored">
        <p:input port="fileset.in">
            <p:pipe port="fileset.out" step="load.in-memory"/>
        </p:input>
        <p:input port="in-memory.in">
            <p:pipe port="in-memory.out" step="load.in-memory"/>
        </p:input>
    </px:fileset-store>
    
    <px:fileset-load media-types="application/oebps-package+xml">
        <p:input port="in-memory">
            <p:pipe port="in-memory.in" step="main"/>
        </p:input>
    </px:fileset-load>
    <px:assert test-count-min="1" test-count-max="1" message="There must be exactly one Package Document in the EPUB." error-code="NORDICDTBOOKEPUB011"/>
    <p:identity name="package-doc"/>
    <!-- TODO: perform OPF assertions here -->
    <p:identity name="opf-assertions"/>
    
    <!--<px:fileset-load media-types="application/oebps-package+xml">
        <p:input port="in-memory">
            <p:pipe port="in-memory.in" step="main"/>
        </p:input>
    </px:fileset-load>-->
    
    <p:wrap-sequence wrapper="assertions">
        <p:input port="source">
            <p:pipe port="result" step="opf-assertions"/>
        </p:input>
    </p:wrap-sequence>
    <p:add-attribute attribute-name="xml:base">
        <p:with-option name="attribute-value" select="concat($temp-dir,'report.xml')"/>
    </p:add-attribute>
    <p:identity name="result.in-memory"/>
    
    <px:fileset-create>
        <p:with-option name="base" select="$temp-dir"/>
    </px:fileset-create>
    <px:fileset-add-entry href="report.xml" media-type="application/xml"/>
    <p:identity name="result.fileset"/>
    
<!--    <p:filter select="/*/opf:manifest/opf:item[matches(@properties,'(^|\s)nav(\s|$)')]"/>-->
    <!--<px:fileset-load>
        <p:input port="fileset">
            <p:pipe port="fileset.in" step="main"/>
        </p:input>
        <p:input port="in-memory">
            <p:pipe port="in-memory.in" step="main"/>
        </p:input>
        <p:with-option name="href" select="resolve-uri(/*/@href,base-uri(/*))"/>
    </px:fileset-load>-->
    <!--<p:xslt>
        <p:input port="parameters">
            <p:empty/>
        </p:input>
        <p:input port="stylesheet">
            <p:document href="../../xslt/navdoc-to-outline.xsl"/>
        </p:input>
    </p:xslt>-->
<!--    <p:delete match="//html:section[@xml:base=(preceding::html:section|ancestor::html:section)/@xml:base]"/>-->
    <!--<p:xslt>
        <p:input port="parameters">
            <p:empty/>
        </p:input>
        <p:input port="stylesheet">
            <p:document href="../../xslt/make-uris-relative-to-document.xsl"/>
        </p:input>
    </p:xslt>-->
<!--    <p:identity name="single-html.body"/>-->
    
    <!--<p:xslt>
        <p:input port="parameters">
            <p:empty/>
        </p:input>
        <p:input port="source">
            <p:pipe step="package-doc" port="result"/>
        </p:input>
        <p:input port="stylesheet">
            <p:document href="../../xslt/opf-to-html-metadata.xsl"/>
        </p:input>
    </p:xslt>
    <p:identity name="single-html.metadata"/>-->
    
    <!--<p:replace match="//html:head">
        <p:input port="source">
            <p:pipe port="result" step="single-html.body"/>
        </p:input>
        <p:input port="replacement" select="//html:head">
            <p:pipe port="result" step="single-html.metadata"/>
        </p:input>
    </p:replace>
    <p:identity name="in-memory"/>-->
    
    <!--<px:html-to-fileset>
        <p:input port="fileset.in">
            <p:pipe port="fileset.in" step="main"/>
        </p:input>
    </px:html-to-fileset>
    <px:fileset-add-entry>
        <p:with-option name="href" select="base-uri(/*)">
            <p:pipe port="result" step="in-memory"/>
        </p:with-option>
    </px:fileset-add-entry>
    <px:mediatype-detect/>
    <p:identity name="fileset"/>-->
    
</p:declare-step>
