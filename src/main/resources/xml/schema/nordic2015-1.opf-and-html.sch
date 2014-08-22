<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">

    <title>Schematron tests for Nordic EPUB 2015-1 rules with regards to OPF+HTML filesets in the EPUBs</title>

    <!--
        Example input to this schematron:
        
        <wrapper>
            <opf:package xml:base="..." .../>
            <html:html xml:base="..." .../>
            <html:html xml:base="..." .../>
        </wrapper>
    -->

    <ns prefix="html" uri="http://www.w3.org/1999/xhtml"/>
    <ns prefix="opf" uri="http://www.idpf.org/2007/opf"/>
    <ns prefix="dc" uri="http://purl.org/dc/elements/1.1/"/>
    <ns prefix="epub" uri="http://www.idpf.org/2007/ops"/>
    <ns prefix="nordic" uri="http://www.mtm.se/epub/"/>

    <pattern id="opf_and_html_nordic_1">
        <rule context="*[@id]">
            <let name="id" value="@id"/>
            <assert test="not(//*[@id=$id] except .)">id attributes must be unique; <value-of select="@id"/> in <value-of select="replace(base-uri(.),'^.*/','')"/> also exists in <value-of
                    select="(//*[@id=$id] except .)/replace(base-uri(.),'^.*/','')"/></assert>
        </rule>
    </pattern>

    <pattern id="opf_and_html_nordic_2">
        <rule context="html:title">
            <assert test="text() = /*/opf:package/opf:metadata/dc:title/text()">The title element in HTML documents must have the same value as the dc:title element in the OPF; <value-of
                    select="replace(base-uri(.),'.*/','')"/> contains a bad title value</assert>
        </rule>
    </pattern>

</schema>
