<?xml version="1.0" encoding="UTF-8"?>
<p:library xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" version="1.0" xmlns:letex="http://www.le-tex.de/namespace">

    <p:declare-step type="letex:unzip">
        <p:option name="zip" required="true"/>
        <p:option name="dest-dir" required="true"/>
        <p:option name="overwrite" required="false" select="'no'"/>
        <p:option name="file" required="false"/>
        <p:output port="result" primary="true"/>
    </p:declare-step>

</p:library>
