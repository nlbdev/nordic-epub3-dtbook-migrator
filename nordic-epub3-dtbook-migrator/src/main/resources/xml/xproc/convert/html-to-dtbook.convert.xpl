<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" xmlns:px="http://www.daisy.org/ns/pipeline/xproc" xmlns:d="http://www.daisy.org/ns/pipeline/data"
    type="px:nordic-dtbook-to-html-convert" name="main" version="1.0" xmlns:epub="http://www.idpf.org/2007/ops" xmlns:dtbook="http://www.daisy.org/z3986/2005/dtbook/" xmlns:html="http://www.w3.org/1999/xhtml">
    
    <p:input port="fileset.in" primary="true"/>
    <p:input port="in-memory.in" sequence="true"/>
    
    <p:output port="fileset.out" primary="true">
        <p:pipe port="fileset.out" step="convert"/>
    </p:output>
    <p:output port="in-memory.out" sequence="true">
        <p:pipe port="in-memory.out" step="convert"/>
    </p:output>
    
    <p:option name="temp-dir" required="true"/>
    <p:option name="result-uri"/>
    
    <p:import href="../library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/fileset-utils/xproc/fileset-library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/common-utils/logging-library.xpl"/>
    
    <p:variable name="href" select="resolve-uri((//d:file[@media-type='application/xhtml+xml'])[1]/@href,base-uri(/))"/>
    <p:variable name="new-href" select="if (p:value-available('result-uri')) then $result-uri else if (ends-with($href,'.x?html?')) then replace($href,'\.x?html?$','.xml') else concat($href,'.xml')"/>
    
    <px:fileset-load media-type="application/x-dtbook+xml"/>
    <px:assert test-count-max="1" message="There are multiple DTBooks in the fileset; only the first one will be converted." severity="WARN"/>
    <px:assert test-count-min="1" message="There must be a DTBook file in the fileset." error-code="NORDICDTBOOKEPUB005"/>
    <p:split-sequence initial-only="true" test="position()=1"/>
    
    <!-- TODO: validate input HTML -->
    
    <p:xslt>
        <p:input port="parameters">
            <p:empty/>
        </p:input>
        <p:input port="stylesheet">
            <p:document href="../../xslt/epub3-to-dtbook.xsl"/>
        </p:input>
    </p:xslt>
    
    <p:add-attribute match="/*" attribute-name="xml:base">
        <p:with-option name="attribute-value" select="$new-href"/>
    </p:add-attribute>
    <p:delete match="/*/@xml:base"/>
    <p:identity name="result.in-memory"/>
    
    <!-- TODO: validate output DTBook -->
    
    <p:store media-type="text/css" method="text">
        <p:input port="source">
            <p:data href="../../css/dtbook.2005.basic.css" content-type="text/css"/>
        </p:input>
        <p:with-option name="href" select="concat($temp-dir,'style.css')"/>
    </p:store>
    
    <px:fileset-create>
        <p:with-option name="base" select="replace($new-base,'[^/]*$','')"/>
    </px:fileset-create>
    <px:fileset-add-entry media-type="application/xhtml+xml">
        <p:with-option name="href" select="replace($new-base,'^.*/([^/]*)$','$1')"/>
    </px:fileset-add-entry>
    <px:fileset-add-entry media-type="text/css">
        <p:with-option name="href" select="'style.css'"/>
        <p:with-option name="original-href" select="concat($temp-dir,'style.css')"/>
    </px:fileset-add-entry>
    <p:identity name="result.fileset"/>
    
</p:declare-step>
