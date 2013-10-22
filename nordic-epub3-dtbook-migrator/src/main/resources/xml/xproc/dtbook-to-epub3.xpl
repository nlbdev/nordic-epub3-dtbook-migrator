<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" xmlns:px="http://www.daisy.org/ns/pipeline/xproc" xmlns:d="http://www.daisy.org/ns/pipeline/data"
    type="px:nordic-dtbook-to-epub3" name="main" version="1.0" xmlns:epub="http://www.idpf.org/2007/ops">

    <p:documentation xmlns="http://www.w3.org/1999/xhtml">
        <h1 px:role="name">Nordic DTBook to EPUB3</h1>
        <p px:role="desc">Transforms a DTBook document into an EPUB3 publication according to the nordic markup guidelines.</p>
    </p:documentation>

    <p:input port="source" primary="true" px:name="source" px:media-type="application/x-dtbook+xml">
        <p:documentation xmlns="http://www.w3.org/1999/xhtml">
            <h2 px:role="name">DTBook</h2>
            <p px:role="desc">Input DTBook to be converted.</p>
        </p:documentation>
    </p:input>
    
    <p:option name="temp-dir" required="true" px:output="temp" px:type="anyDirURI">
        <p:documentation xmlns="http://www.w3.org/1999/xhtml">
            <h2 px:role="name">Temporary directory</h2>
            <p px:role="desc">Temporary directory for use by the script.</p>
        </p:documentation>
    </p:option>
    
    <p:option name="output-dir" required="true" px:output="result" px:type="anyDirURI">
        <p:documentation xmlns="http://www.w3.org/1999/xhtml">
            <h2 px:role="name">Output directory</h2>
            <p px:role="desc">Output directory for the EPUB publication.</p>
        </p:documentation>
    </p:option>
    
    <p:import href="library.xpl"/>
    <p:import href="convert/dtbook-to-epub3.convert.xpl"/>
    
    <px:fileset-create>
        <p:with-option name="base" select="replace(base-uri(/),'[^/]*$','')"/>
    </px:fileset-create>
    <px:fileset-add-entry media-type="application/x-dtbook+xml">
        <p:with-option name="href" select="replace(base-uri(/),'^.*/([^/]*)$','$1')"/>
    </px:fileset-add-entry>
    
    <px:nordic-dtbook-to-epub3-convert name="convert">
        <p:input port="in-memory.in">
            <p:pipe port="source" step="main"/>
        </p:input>
        <p:with-option name="temp-dir" select="$temp-dir"/>
        <p:with-option name="output-dir" select="$output-dir"/>
    </px:nordic-dtbook-to-epub3-convert>
    
    <px:epub3-store>
        <p:input port="in-memory.in">
            <p:pipe port="in-memory.out" step="convert"/>
        </p:input>
        <p:with-option name="href" select="concat($output-dir,if (normalize-space(.)='') then 'no-title' else replace(normalize-space(.),'^\w ',''),'.epub')">
            <p:pipe port="result" step="title"/>
        </p:with-option>
    </px:epub3-store>
    
    <px:fileset-load media-type="application/oebps-package+xml"/>
    <px:assert test-count-min="1" test-count-max="1" message="There must be exactly one Package Document in the resulding EPUB." error-code="NORDICDTBOOKEPUB002"/>
    <p:filter select="//dc:title" xmlns:dc="http://purl.org/dc/elements/1.1/"/>
    <px:assert test-count-min="1" test-count-max="1" message="The Package Document in the resulting EPUB must have exactly one dc:title element." error-code="NORDICDTBOOKEPUB003"/>
    <p:identity name="title"/>

</p:declare-step>
