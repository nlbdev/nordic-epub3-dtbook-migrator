<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2" xmlns:c="http://www.w3.org/ns/xproc-step">

    <title>Schematron tests for Nordic EPUB 2015-1 rules with regards to the navigation document and its references to the content documents</title>

    <!--
        Example input to this schematron:
        
        <html>
            <c:result>
                <c:result xml:base="..." data-sectioning-element="body" data-sectioning-id="..." data-heading-element="h1" data-heading-id="..."/>
                <c:result xml:base="..." data-sectioning-element="body" data-sectioning-id="..." data-heading-element="h1" data-heading-id="..."/>
                ...
            </c:result>
            <head>...</head>
            <body>
                ...
                <nav epub:type="nav">
                    ...
                </nav>
                ...
            </body>
        </html>
    -->

    <ns prefix="html" uri="http://www.w3.org/1999/xhtml"/>
    <ns prefix="opf" uri="http://www.idpf.org/2007/opf"/>
    <ns prefix="dc" uri="http://purl.org/dc/elements/1.1/"/>
    <ns prefix="epub" uri="http://www.idpf.org/2007/ops"/>
    <ns prefix="nordic" uri="http://www.mtm.se/epub/"/>
    <ns prefix="c" uri="http://www.w3.org/ns/xproc-step"/>

    <!-- Rule 1: All headings in the book must be referenced from the navigation document -->
    <pattern id="nav_references_1">
        <rule context="c:result/c:result">
            <let name="sectioning-ref" value="if (@data-sectioning-id) then concat(replace(@xml:base,'.*/',''),'#',@data-sectioning-id) else ()"/>
            <let name="heading-ref" value="if (@data-heading-id) then concat(replace(@xml:base,'.*/',''),'#',@data-heading-id) else ()"/>
            <let name="nav-ref" value="//html:nav[tokenize(@epub:type,'\s+')='toc']//html:a[replace(@href,'^.*/','') = ($sectioning-ref, $heading-ref)]"/>

            <assert test="count($nav-ref) = 1">[nordic_nav_references_1] All headings in the content documents must be referenced exactly once in the navigation document. In the content document
                    "<value-of select="replace(@xml:base,'.*/','')"/>", the heading "<value-of select="text()"/>"<value-of
                    select="if (@data-heading-id) then concat(' with id=&quot;', @data-heading-id,'&quot;') else ''"/> inside the "<value-of select="@data-sectioning-element"/>" element<value-of
                    select="if (@data-heading-id) then concat(' with id=&quot;', @data-sectioning-id,'&quot;') else ''"/> is <value-of
                    select="if (count($nav-ref)=0) then 'not referenced' else 'referenced multiple times'"/> from the navigation document.</assert>

            <assert test="count($nav-ref)=0 or normalize-space(string-join(.//text(),'')) = normalize-space(string-join($nav-ref//text(),''))">[nordic_nav_references_1] The text for the heading in the
                navigation document ("<value-of select="normalize-space(string-join($nav-ref//text(),''))"/>") should match the headline in the content document ("<value-of
                    select="normalize-space(string-join(.//text(),''))"/>" at <value-of select="($heading-ref, $sectioning-ref)[1]"/>)</assert>
        </rule>
    </pattern>

</schema>
