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

    <!-- Rule 40: No page numbering gaps for pagebreak w/page-normal -->
    <pattern id="epub_nordic_40">
        <rule
            context="html:*[tokenize(@epub:type,'\s+')='pagebreak' and tokenize(@class,'\s+')='page-normal' and count(preceding::html:*[tokenize(@epub:type,'\s+')='pagebreak' and tokenize(@class,'\s+')='page-normal'])]">
            <let name="preceding-pagebreak" value="preceding::html:*[tokenize(@epub:type,'\s+')='pagebreak' and tokenize(@class,'\s+')='page-normal'][1]"/>
            <report test="number($preceding-pagebreak/@title) != number(@title)-1">[nordic40b] No gaps may occur in page numbering (see pagebreak with title="<value-of select="@title"/>" in <value-of
                    select="replace(base-uri(.),'^.*/','')"/> and compare with pagebreak with title="<value-of select="$preceding-pagebreak/@title"/>" in <value-of
                    select="replace(base-uri($preceding-pagebreak),'^.*/','')"/>)</report>
        </rule>
    </pattern>

    <!-- Rule 23: Increasing pagebreak values for page-normal -->
    <pattern id="epub_nordic_23">
        <rule
            context="html:*[tokenize(@epub:type,'\s+')='pagebreak' and tokenize(@class,'\s+')='page-normal' and preceding::html:*[tokenize(@epub:type,'\s+')='pagebreak'][tokenize(@class,'\s+')='page-normal']]">
            <let name="preceding" value="preceding::html:*[tokenize(@epub:type,'\s+')='pagebreak' and tokenize(@class,'\s+')='page-normal'][1]"/>
            <assert test="number(current()/@title) > number($preceding/@title)">[nordic23] pagebreak values must increase for pagebreaks with class="page-normal" (see pagebreak with title="<value-of
                    select="@title"/>" in <value-of select="replace(base-uri(.),'^.*/','')"/> and compare with pagebreak with title="<value-of select="$preceding/@title"/> in <value-of
                    select="replace(base-uri($preceding),'^.*/','')"/>)</assert>
        </rule>
    </pattern>

    <!-- Rule 24: Values of pagebreak must be unique for page-front -->
    <pattern id="epub_nordic_24">
        <rule context="html:*[tokenize(@epub:type,' ')='pagebreak'][tokenize(@class,' ')='page-front']">
            <assert test="count(//html:*[tokenize(@epub:type,'\s+')='pagebreak' and tokenize(@class,'\s+')='page-front' and @title=current()/@title])=1">[nordic24] pagebreak values must be unique for
                pagebreaks with class="page-front" (see pagebreak with title="<value-of select="@title"/>" in <value-of select="replace(base-uri(.),'^.*/','')"/>)</assert>
        </rule>
    </pattern>

    <!-- Rule 26: Each note must have a noteref -->
    <pattern id="epub_nordic_26">
        <rule context="html:*[tokenize(@epub:type,'\s+')='note']">
            <!-- this is the multi-HTML version of the rule; the single-HTML version of this rule is in nordic2015-1.sch -->
            <assert test="count(//html:a[tokenize(@epub:type,'\s+')='noteref'][substring-after(@href, '#')=current()/@id])>=1">[nordic26] Each note must have at least one &lt;a epub:type="noteref"
                ...&gt; referencing it: <value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/> (in <value-of
                    select="replace(base-uri(),'.*/','')"/>)</assert>
        </rule>
    </pattern>

    <!-- Rule 27: Each annotation must have an annoref -->
    <pattern id="epub_nordic_27">
        <rule context="html:*[tokenize(@epub:type,' ')='annotation']">
            <!-- this is the multi-HTML version of the rule; the single-HTML version of this rule is in nordic2015-1.sch -->
            <assert test="count(//html:a[tokenize(@epub:type,' ')='annoref'][substring-after(@href, '#')=current()/@id])>=1">[nordic27] Each annotation must have at least one &lt;a epub:type="annoref"
                ...&gt; referencing it: <value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/> (in <value-of
                    select="replace(base-uri(),'.*/','')"/>)</assert>
        </rule>
    </pattern>

    <!-- Rule 28: The HTML title element must be the same as the OPF publication dc:title -->
    <pattern id="epub_nordic_28">
        <rule context="html:title">
            <assert test="text() = /*/opf:package/opf:metadata/dc:title[not(@refines)]/text()">[nordic28_opf] The HTML title element must contain the same text as the dc:title element in the OPF
                metadata. The HTML title element contains "<value-of select="."/>" while the dc:title element in the OPF contains "<value-of
                    select="/*/opf:package/opf:metadata/dc:title[not(@refines)]/text()"/>".</assert>
        </rule>
    </pattern>

</schema>
