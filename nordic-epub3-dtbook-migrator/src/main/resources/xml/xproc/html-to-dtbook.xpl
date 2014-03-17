<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" xmlns:px="http://www.daisy.org/ns/pipeline/xproc" xmlns:d="http://www.daisy.org/ns/pipeline/data"
    type="px:nordic-html-to-dtbook" name="main" version="1.0" xmlns:epub="http://www.idpf.org/2007/ops" xmlns:cx="http://xmlcalabash.com/ns/extensions">

    <p:documentation xmlns="http://www.w3.org/1999/xhtml">
        <h1 px:role="name">Nordic HTML5 to DTBook</h1>
        <p px:role="desc">Transforms a HTML5 document into a DTBook according to the nordic markup guidelines.</p>
    </p:documentation>

    <p:input port="source" primary="true" px:name="source" px:media-type="application/xhtml+xml">
        <p:documentation xmlns="http://www.w3.org/1999/xhtml">
            <h2 px:role="name">HTML</h2>
            <p px:role="desc">Input HTML to be converted, marked up using the EPUB3 `epub:type` attribute.</p>
        </p:documentation>
    </p:input>

    <p:input port="result" primary="true" px:name="result" px:media-type="application/x-dtbook+xml">
        <p:documentation xmlns="http://www.w3.org/1999/xhtml">
            <h2 px:role="name">DTBook</h2>
            <p px:role="desc">The resulting DTBook.</p>
        </p:documentation>
    </p:input>
    
    <p:import href="http://www.daisy.org/pipeline/modules/common-utils/library.xpl"/>

    <!-- TODO: validate input HTML -->

    <px:message message="$1">
        <p:with-option name="param1" select="/*">
            <p:document href="../version-description.xml"/>
        </p:with-option>
    </px:message>

    <p:xslt>
        <p:input port="parameters">
            <p:empty/>
        </p:input>
        <p:input port="stylesheet">
            <p:document href="../xslt/dtbook-to-html.xsl"/>
        </p:input>
    </p:xslt>

    <!-- TODO: validate output DTBook -->

</p:declare-step>
