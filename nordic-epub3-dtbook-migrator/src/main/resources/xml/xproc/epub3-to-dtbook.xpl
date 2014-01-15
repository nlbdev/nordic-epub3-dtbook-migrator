<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" xmlns:px="http://www.daisy.org/ns/pipeline/xproc" xmlns:d="http://www.daisy.org/ns/pipeline/data"
    type="px:nordic-epub3-to-dtbook" name="main" version="1.0" xmlns:epub="http://www.idpf.org/2007/ops" xmlns:pxp="http://exproc.org/proposed/steps">

    <p:documentation xmlns="http://www.w3.org/1999/xhtml">
        <h1 px:role="name">Nordic EPUB3 to DTBook</h1>
        <p px:role="desc">Transforms an EPUB3 publication into DTBook according to the nordic markup guidelines.</p>
    </p:documentation>

    <p:option name="epub" required="true" px:type="anyFileURI" px:media-type="application/epub+zip">
        <p:documentation xmlns="http://www.w3.org/1999/xhtml">
            <h2 px:role="name">EPUB3 Publication</h2>
            <p px:role="desc">EPUB3 Publication marked up according to the nordic markup guidelines.</p>
        </p:documentation>
    </p:option>

    <p:option name="temp-dir" required="true" px:output="temp" px:type="anyDirURI">
        <p:documentation xmlns="http://www.w3.org/1999/xhtml">
            <h2 px:role="name">Temporary directory</h2>
            <p px:role="desc">Temporary directory for use by the script.</p>
        </p:documentation>
    </p:option>

    <p:option name="output-dir" required="true" px:output="result" px:type="anyDirURI">
        <p:documentation xmlns="http://www.w3.org/1999/xhtml">
            <h2 px:role="name">Output directory</h2>
            <p px:role="desc">Output directory for the DTBook.</p>
        </p:documentation>
    </p:option>

    <p:import href="step/epub3-to-html.convert.xpl"/>
    <p:import href="step/html-to-dtbook.convert.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/zip-utils/library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/fileset-utils/library.xpl"/>
    <!--    <p:import href="http://www.daisy.org/pipeline/modules/dtbook-utils/library.xpl"/>-->
    <p:import href="http://www.daisy.org/pipeline/modules/mediatype-utils/library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/common-utils/library.xpl"/>
    <!--    <p:import href="http://www.daisy.org/pipeline/modules/epub3-ocf-utils/library.xpl"/>-->

    <px:unzip-fileset name="load.in-memory">
        <p:with-option name="href" select="$epub"/>
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

    <px:nordic-epub3-to-html-convert name="convert.html">
        <p:input port="fileset.in">
            <p:pipe port="fileset.out" step="load.stored"/>
        </p:input>
        <p:input port="in-memory.in">
            <p:pipe port="in-memory.out" step="load.in-memory"/>
        </p:input>
    </px:nordic-epub3-to-html-convert>

    <px:nordic-html-to-dtbook-convert name="convert.dtbook">
        <p:with-option name="temp-dir" select="concat($temp-dir,'dtbook/')"/>
        <p:input port="in-memory.in">
            <p:pipe port="in-memory.out" step="convert.html"/>
        </p:input>
    </px:nordic-html-to-dtbook-convert>

    <px:fileset-rebase>
        <p:with-option name="new-base" select="concat($temp-dir,'dtbook/')"/>
    </px:fileset-rebase>
    <p:viewport match="//d:file[not(@original-href)]">
        <p:add-attribute match="/*" attribute-name="original-href">
            <p:with-option name="attribute-value" select="resolve-uri(/*/@href,base-uri(/*))"/>
        </p:add-attribute>
    </p:viewport>
    <p:add-attribute match="/*" attribute-name="xml:base">
        <p:with-option name="attribute-value" select="$output-dir"/>
    </p:add-attribute>
    <p:identity name="result.fileset">
<!--        <p:log port="result" href="file:/tmp/fileset.xml"/>-->
    </p:identity>

    <p:for-each>
        <p:iteration-source>
            <p:pipe port="in-memory.out" step="convert.dtbook"/>
        </p:iteration-source>
        <p:variable name="old-base" select="base-uri(/*)"/>
        <p:variable name="new-base" select="(//d:file[@original-href=$old-base])[1]/resolve-uri(@href,base-uri(.))">
            <p:pipe port="result" step="result.fileset"/>
        </p:variable>
        <p:add-attribute match="/*" attribute-name="xml:base">
            <p:with-option name="attribute-value" select="$new-base"/>
        </p:add-attribute>
    </p:for-each>
    <p:identity name="result.in-memory">
<!--        <p:log port="result" href="file:/tmp/in-memory.xml"/>-->
    </p:identity>

    <px:fileset-store name="fileset-store">
        <p:input port="fileset.in">
            <p:pipe port="result" step="result.fileset"/>
        </p:input>
        <p:input port="in-memory.in">
            <p:pipe port="result" step="result.in-memory"/>
        </p:input>
    </px:fileset-store>

</p:declare-step>
