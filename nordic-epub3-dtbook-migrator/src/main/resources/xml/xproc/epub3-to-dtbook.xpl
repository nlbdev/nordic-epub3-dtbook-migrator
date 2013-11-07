<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" xmlns:px="http://www.daisy.org/ns/pipeline/xproc" xmlns:d="http://www.daisy.org/ns/pipeline/data"
    type="px:nordic-dtbook-to-epub3" name="main" version="1.0" xmlns:epub="http://www.idpf.org/2007/ops" xmlns:pxp="http://exproc.org/proposed/steps">

    <p:documentation xmlns="http://www.w3.org/1999/xhtml">
        <h1 px:role="name">Nordic EPUB3 to DTBook</h1>
        <p px:role="desc">Transforms an EPUB3 publication into DTBook according to the nordic markup guidelines.</p>
    </p:documentation>

    <p:output port="result" primary="true" px:name="result" px:media-type="application/x-dtbook+xml">
        <p:documentation xmlns="http://www.w3.org/1999/xhtml">
            <h2 px:role="name">DTBook</h2>
            <p px:role="desc">Resulting DTBook.</p>
        </p:documentation>
    </p:output>

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

    <p:import href="http://www.daisy.org/pipeline/modules/zip-utils/xproc/zip-library.xpl"/>
    <!--    <p:import href="convert/dtbook-to-epub3.convert.xpl"/>-->
    <!--    <p:import href="http://www.daisy.org/pipeline/modules/fileset-utils/xproc/fileset-library.xpl"/>-->
    <!--    <p:import href="http://www.daisy.org/pipeline/modules/dtbook-utils/dtbook-utils-library.xpl"/>-->
    <!--    <p:import href="http://www.daisy.org/pipeline/modules/mediatype-utils/mediatype.xpl"/>-->
    <!--    <p:import href="http://www.daisy.org/pipeline/modules/common-utils/logging-library.xpl"/>-->
    <!--    <p:import href="http://www.daisy.org/pipeline/modules/epub3-ocf-utils/xproc/epub3-ocf-library.xpl"/>-->
    
    <p:declare-step type="pxp:unzip">
        <p:output port="result"/>
        <p:option name="href" required="true"/>    <!-- xsd:anyURI -->
        <p:option name="file"/>                    <!-- string -->
        <p:option name="content-type"/>            <!-- string -->
    </p:declare-step>
    
    <pxp:unzip href="file:/home/jostein/Skrivebord/epub.epub" file="EPUB/css/accessibility.css" content-type="text/css"/>

</p:declare-step>
