<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" xmlns:px="http://www.daisy.org/ns/pipeline/xproc" xmlns:d="http://www.daisy.org/ns/pipeline/data"
    type="px:nordic-dtbook-to-html" name="main" version="1.0" xmlns:epub="http://www.idpf.org/2007/ops" xmlns:pxi="http://www.daisy.org/ns/pipeline/xproc/internal/nordic-epub3-dtbook-migrator"
    xmlns:cx="http://xmlcalabash.com/ns/extensions">

    <p:documentation xmlns="http://www.w3.org/1999/xhtml">
        <h1 px:role="name">Nordic DTBook to EPUB3</h1>
        <p px:role="desc">Transforms a DTBook document into an HTML document according to the nordic markup guidelines.</p>
    </p:documentation>

    <p:input port="source" primary="true" px:name="source" px:media-type="application/x-dtbook+xml">
        <p:documentation xmlns="http://www.w3.org/1999/xhtml">
            <h2 px:role="name">DTBook</h2>
            <p px:role="desc">Input DTBook to be converted.</p>
        </p:documentation>
    </p:input>

    <p:option name="output-dir" required="true" px:name="output-dir">
        <p:documentation xmlns="http://www.w3.org/1999/xhtml">
            <h2 px:role="name">HTML</h2>
            <p px:role="desc">The resulting HTML fileset, marked up using the EPUB3 `epub:type` attribute.</p>
        </p:documentation>
    </p:option>

    <p:import href="library.xpl"/>

    <p:variable name="base" select="replace(base-uri(/),'[^/]*$','')"/>
    <p:variable name="href" select="replace(base-uri(/),'^.*/([^/]*)$','$1')"/>
    <p:variable name="result-uri" select="concat($output-dir,if (ends-with($href,'.xml')) then replace($href,'\.xml$','.xhtml') else concat($href,'.xhtml'))"/>

    <px:message message="$1" name="nordic-version-message">
        <p:with-option name="param1" select="/*">
            <p:document href="../version-description.xml"/>
        </p:with-option>
    </px:message>

    <px:fileset-create cx:depends-on="nordic-version-message">
        <p:with-option name="base" select="$base"/>
    </px:fileset-create>
    <px:fileset-add-entry media-type="application/x-dtbook+xml">
        <p:with-option name="href" select="$href"/>
    </px:fileset-add-entry>

    <px:nordic-dtbook-to-html-convert name="convert">
        <p:with-option name="result-uri" select="$result-uri"/>
        <p:input port="in-memory.in">
            <p:pipe port="source" step="main"/>
        </p:input>
    </px:nordic-dtbook-to-html-convert>

    <pxi:fileset-store>
        <p:input port="in-memory.in">
            <p:pipe port="in-memory.out" step="convert"/>
        </p:input>
    </pxi:fileset-store>

</p:declare-step>
