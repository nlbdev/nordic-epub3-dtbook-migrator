<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" xmlns:px="http://www.daisy.org/ns/pipeline/xproc" xmlns:d="http://www.daisy.org/ns/pipeline/data"
    type="px:nordic-epub3-to-dtbook" name="main" version="1.0" xmlns:epub="http://www.idpf.org/2007/ops" xmlns:pxp="http://exproc.org/proposed/steps">
    
    <p:documentation xmlns="http://www.w3.org/1999/xhtml">
        <h1 px:role="name">Nordic EPUB3 Validator</h1>
        <p px:role="desc">Validates an EPUB3 publication according to the nordic markup guidelines.</p>
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
            <p px:role="desc">Output directory for the report.</p>
        </p:documentation>
    </p:option>
    
    <p:import href="step/epub3.validate.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/zip-utils/library.xpl"/>
<!--    <p:import href="http://www.daisy.org/pipeline/modules/fileset-utils/library.xpl"/>-->
    <!--    <p:import href="http://www.daisy.org/pipeline/modules/dtbook-utils/library.xpl"/>-->
<!--    <p:import href="http://www.daisy.org/pipeline/modules/mediatype-utils/library.xpl"/>-->
    <p:import href="http://www.daisy.org/pipeline/modules/common-utils/library.xpl"/>
    <!--    <p:import href="http://www.daisy.org/pipeline/modules/epub3-ocf-utils/library.xpl"/>-->
    
    <px:fileset-create>
        <p:with-option name="base" select="replace($epub,'[^/]+$','')"/>
    </px:fileset-create>
    <px:fileset-add media-type="application/epub+zip">
        <p:with-option name="href" select="replace($epub,'^(.*)/[^/]*$','$1')"/>
    </px:fileset-add>
    
    <px:nordic-epub3-validate name="validate">
        <p:with-option name="temp-dir" select="concat($temp-dir,'validate/')"/>
    </px:nordic-epub3-validate>
    
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
            <p:pipe port="in-memory.out" step="validate"/>
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
            <p:pipe port="in-memory" step="validate"/>
        </p:input>
    </px:fileset-store>
    
</p:declare-step>
