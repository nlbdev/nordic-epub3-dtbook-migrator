<?xml version="1.0" encoding="UTF-8"?>
<p:library xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" version="1.0" xmlns:pxi="http://www.daisy.org/ns/pipeline/xproc/internal">

    <p:declare-step type="pxi:file-peek">
        <p:option name="href" required="true"/>
        <p:option name="offset" required="true"/>
        <p:option name="length" required="true"/>
        <p:output port="result"/>
    </p:declare-step>

    <p:declare-step type="pxi:file-xml-peek">
        <p:option name="href" required="true"/>
        <p:output port="result"/>
    </p:declare-step>

</p:library>
