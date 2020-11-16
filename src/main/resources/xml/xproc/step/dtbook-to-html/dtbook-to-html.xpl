<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" version="1.0"
                xmlns:px="http://www.daisy.org/ns/pipeline/xproc"
                xmlns:d="http://www.daisy.org/ns/pipeline/data"
                xmlns:dtb="http://www.daisy.org/z3986/2005/dtbook/"
                xmlns:html="http://www.w3.org/1999/xhtml"
                type="px:dtbook-to-html" name="main">

    <p:input port="source.fileset" primary="true"/>
    <p:input port="source.in-memory" sequence="true">
        <p:empty/>
    </p:input>

    <p:output port="result.fileset" primary="true"/>
    <p:output port="result.in-memory" sequence="true">
        <p:pipe step="add-html" port="result.in-memory"/>
    </p:output>

    <p:option name="output-dir" required="true">
        <p:documentation xmlns="http://www.w3.org/1999/xhtml">
            <p>The directory that will contain the HTML fileset.</p>
        </p:documentation>
    </p:option>

    <p:import href="http://www.daisy.org/pipeline/modules/fileset-utils/library.xpl">
        <p:documentation>
            px:fileset-load
            px:fileset-filter
            px:fileset-copy
            px:fileset-add-entry
        </p:documentation>
    </p:import>
    <p:import href="http://www.daisy.org/pipeline/modules/file-utils/library.xpl">
        <p:documentation>
            px:set-base-uri
        </p:documentation>
    </p:import>
    <p:import href="http://www.daisy.org/pipeline/modules/common-utils/library.xpl">
        <p:documentation>
            px:assert
        </p:documentation>
    </p:import>

    <!--
        Load DTBook
    -->
    <px:fileset-load media-types="application/x-dtbook+xml">
        <p:input port="in-memory">
            <p:pipe step="main" port="source.in-memory"/>
        </p:input>
    </px:fileset-load>
    <px:assert test-count-max="1" message="There are multiple DTBooks in the fileset; only the first one will be converted."/>
    <px:assert test-count-min="1" message="There must be a DTBook file in the fileset." error-code="NORDICDTBOOKEPUB004"/>
    <p:split-sequence initial-only="true" test="position()=1"/>
    <p:identity name="dtbook"/>

    <!--
        Convert DTBook to HTML
    -->
    <p:xslt>
        <p:input port="parameters">
            <p:empty/>
        </p:input>
        <p:input port="stylesheet">
            <p:document href="../../../xslt/dtbook-to-html/dtbook-to-epub3.xsl"/>
        </p:input>
    </p:xslt>
    <!--
        Generate name from UID metadata
    -->
    <px:set-base-uri>
        <p:with-option name="base-uri" select="concat($output-dir,(//dtb:meta[@name='dtb:uid']/@content,'missing-uid')[1],'.xhtml')">
            <p:pipe step="dtbook" port="result"/>
        </p:with-option>
    </px:set-base-uri>

    <!-- TODO: add ASCIIMathML.js if there are asciimath elements -->

    <p:identity name="html"/>
    <p:sink/>

    <!--
        Move resources to $output-dir
    -->
    <px:fileset-filter not-media-types="application/x-dtbook+xml text/css" name="filter-resources">
        <p:input port="source">
            <p:pipe step="main" port="source.fileset"/>
        </p:input>
        <p:input port="source.in-memory">
            <p:pipe step="main" port="source.in-memory"/>
        </p:input>
    </px:fileset-filter>
    <px:fileset-copy name="move-resources">
        <p:with-option name="target" select="$output-dir"/>
        <p:input port="source.in-memory">
            <p:pipe step="filter-resources" port="result.in-memory"/>
        </p:input>
    </px:fileset-copy>
    <!--
        Combine HTML with resources
    -->
    <px:fileset-add-entry media-type="application/xhtml+xml" name="add-html">
        <p:input port="entry">
            <p:pipe step="html" port="result"/>
        </p:input>
        <p:input port="source.in-memory">
            <p:pipe step="move-resources" port="result.in-memory"/>
        </p:input>
        <p:with-param port="file-attributes" name="omit-xml-declaration" select="'false'"/>
        <p:with-param port="file-attributes" name="version" select="'1.0'"/>
        <p:with-param port="file-attributes" name="encoding" select="'utf-8'"/>
    </px:fileset-add-entry>

</p:declare-step>
