<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" xmlns:px="http://www.daisy.org/ns/pipeline/xproc" xmlns:d="http://www.daisy.org/ns/pipeline/data"
    type="px:nordic-html-split-perform" name="main" version="1.0" xmlns:epub="http://www.idpf.org/2007/ops" xmlns:dtbook="http://www.daisy.org/z3986/2005/dtbook/"
    xmlns:html="http://www.w3.org/1999/xhtml" xmlns:pxi="http://www.daisy.org/ns/pipeline/xproc/internal/nordic-epub3-dtbook-migrator">

    <p:input port="fileset.in" primary="true"/>
    <p:input port="in-memory.in" sequence="true"/>

    <p:output port="fileset.out" primary="true">
        <p:pipe port="result" step="fileset.result"/>
    </p:output>
    <p:output port="in-memory.out" sequence="true">
        <p:pipe port="result" step="in-memory.html"/>
        <p:pipe port="result" step="in-memory.resources"/>
    </p:output>

    <p:import href="http://www.daisy.org/pipeline/modules/fileset-utils/library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/common-utils/library.xpl"/>

    <px:fileset-load media-types="application/xhtml+xml">
        <p:input port="in-memory">
            <p:pipe port="in-memory.in" step="main"/>
        </p:input>
    </px:fileset-load>
    <px:assert test-count-min="1" test-count-max="1" message="There must be exactly one HTML file in the fileset." error-code="NORDICDTBOOKEPUB006"/>
    <p:identity name="html"/>

    <p:xslt>
        <p:with-param name="output-dir" select="replace(base-uri(/*),'[^/]+$','')">
            <p:pipe port="result" step="html"/>
        </p:with-param>
        <p:input port="stylesheet">
            <p:document href="../../xslt/split-html.annotate.xsl"/>
        </p:input>
    </p:xslt>
    <p:xslt name="split">
        <p:with-param name="output-dir" select="replace(base-uri(/*),'[^/]+$','')">
            <p:pipe port="result" step="html"/>
        </p:with-param>
        <p:input port="stylesheet">
            <p:document href="../../xslt/split-html.xsl"/>
        </p:input>
    </p:xslt>

    <p:for-each name="for-each">
        <p:iteration-source select="/*/*"/>
        <p:output port="html" primary="true" sequence="true">
            <p:pipe port="result" step="for-each.html"/>
        </p:output>
        <p:output port="fileset" sequence="true">
            <p:pipe port="result" step="for-each.fileset"/>
        </p:output>

        <p:variable name="base" select="base-uri(/*)"/>

        <p:identity name="for-each.html"/>

        <px:fileset-create>
            <p:with-option name="base" select="replace($base,'[^/]+$','')"/>
        </px:fileset-create>
        <px:fileset-add-entry media-type="application/xhtml+xml">
            <p:with-option name="href" select="replace($base,'^.*/([^/]+)$','$1')"/>
        </px:fileset-add-entry>
        <p:add-attribute match="//d:file" attribute-name="omit-xml-declaration" attribute-value="false"/>
        <p:add-attribute match="//d:file" attribute-name="version" attribute-value="1.0"/>
        <p:add-attribute match="//d:file" attribute-name="encoding" attribute-value="utf-8"/>
        <p:add-attribute match="//d:file" attribute-name="method" attribute-value="xhtml"/>
        <p:add-attribute match="//d:file" attribute-name="indent" attribute-value="true"/>
        <p:add-attribute match="//d:file" attribute-name="doctype" attribute-value="&lt;!DOCTYPE html&gt;"/>
        <p:identity name="for-each.fileset"/>
    </p:for-each>
    <p:identity name="in-memory.html"/>

    <px:fileset-load not-media-types="application/xhtml+xml" load-if-not-in-memory="false">
        <p:input port="fileset">
            <p:pipe port="fileset.in" step="main"/>
        </p:input>
        <p:input port="in-memory">
            <p:pipe port="in-memory.in" step="main"/>
        </p:input>
    </px:fileset-load>
    <p:identity name="in-memory.resources"/>

    <px:fileset-filter not-media-types="application/xhtml+xml">
        <p:input port="source">
            <p:pipe port="fileset.in" step="main"/>
        </p:input>
    </px:fileset-filter>
    <p:identity name="fileset.resources"/>
    <px:fileset-join>
        <p:input port="source">
            <p:pipe port="fileset" step="for-each"/>
            <p:pipe port="result" step="fileset.resources"/>
        </p:input>
    </px:fileset-join>
    <p:identity name="fileset.result"/>

</p:declare-step>
