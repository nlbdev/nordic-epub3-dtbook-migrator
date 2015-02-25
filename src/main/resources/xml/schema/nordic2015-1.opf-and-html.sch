<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">

    <title>Nordic EPUB3 Package Document and Content Document cross-reference rules</title>

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
            <assert test="not(//*[@id=$id] except .)">[nordic_opf_and_html_1] id attributes must be unique; <value-of select="@id"/> in <value-of select="replace(base-uri(.),'^.*/','')"/> also exists
                in <value-of select="(//*[@id=$id] except .)/replace(base-uri(.),'^.*/','')"/></assert>
        </rule>
    </pattern>

    <!-- Rule 13: All books must have frontmatter and bodymatter -->
    <pattern id="epub_nordic_13_a">
        <!-- see also nordic2015-1.opf-and-html.sch for multi-document version -->
        <rule context="html:html[not(preceding-sibling::html:html)]">
            <assert test="((.|following-sibling::html:html)/html:body/tokenize(@epub:type,'\s+')=('cover','frontmatter')) = true()">[nordic_opf_and_html_13a] There must be at least one frontmatter or
                cover document</assert>
            <assert test="((.|following-sibling::html:html)/html:body/tokenize(@epub:type,'\s+')='bodymatter') = true()">[nordic_opf_and_html_13a] There must be at least one bodymatter
                document</assert>
        </rule>
    </pattern>

    <!-- Rule 40: No page numbering gaps for pagebreak w/page-normal -->
    <pattern id="epub_nordic_40">
        <rule
            context="html:*[tokenize(@epub:type,'\s+')='pagebreak' and tokenize(@class,'\s+')='page-normal' and count(preceding::html:*[tokenize(@epub:type,'\s+')='pagebreak' and tokenize(@class,'\s+')='page-normal'])]">
            <let name="preceding-pagebreak" value="preceding::html:*[tokenize(@epub:type,'\s+')='pagebreak' and tokenize(@class,'\s+')='page-normal'][1]"/>
            <report test="number($preceding-pagebreak/@title) != number(@title)-1">[nordic_opf_and_html_40b] No gaps may occur in page numbering (see pagebreak with title="<value-of select="@title"/>"
                in <value-of select="replace(base-uri(.),'^.*/','')"/> and compare with pagebreak with title="<value-of select="$preceding-pagebreak/@title"/>" in <value-of
                    select="replace(base-uri($preceding-pagebreak),'^.*/','')"/>)</report>
        </rule>
    </pattern>

    <!-- Rule 23: Increasing pagebreak values for page-normal -->
    <pattern id="epub_nordic_23">
        <rule
            context="html:*[tokenize(@epub:type,'\s+')='pagebreak' and tokenize(@class,'\s+')='page-normal' and preceding::html:*[tokenize(@epub:type,'\s+')='pagebreak'][tokenize(@class,'\s+')='page-normal']]">
            <let name="preceding" value="preceding::html:*[tokenize(@epub:type,'\s+')='pagebreak' and tokenize(@class,'\s+')='page-normal'][1]"/>
            <assert test="number(current()/@title) > number($preceding/@title)">[nordic_opf_and_html_23] pagebreak values must increase for pagebreaks with class="page-normal" (see pagebreak with
                    title="<value-of select="@title"/>" in <value-of select="replace(base-uri(.),'^.*/','')"/> and compare with pagebreak with title="<value-of select="$preceding/@title"/> in
                    <value-of select="replace(base-uri($preceding),'^.*/','')"/>)</assert>
        </rule>
    </pattern>

    <!-- Rule 24: Values of pagebreak must be unique for page-front -->
    <pattern id="epub_nordic_24">
        <rule context="html:*[tokenize(@epub:type,' ')='pagebreak'][tokenize(@class,' ')='page-front']">
            <assert test="count(//html:*[tokenize(@epub:type,'\s+')='pagebreak' and tokenize(@class,'\s+')='page-front' and @title=current()/@title])=1">[nordic_opf_and_html_24] pagebreak values must
                be unique for pagebreaks with class="page-front" (see pagebreak with title="<value-of select="@title"/>" in <value-of select="replace(base-uri(.),'^.*/','')"/>)</assert>
        </rule>
    </pattern>

    <!-- Rule 26a: Each note must have a noteref -->
    <pattern id="epub_nordic_26_a">
        <rule context="html:*[tokenize(@epub:type,'\s+')=('note','rearnote','footnote')]">
            <!-- this is the multi-HTML version of the rule; the single-HTML version of this rule is in nordic2015-1.sch -->
            <assert test="count(//html:a[tokenize(@epub:type,'\s+')='noteref' and substring-after(@href,'#') = current()/@id]) &gt;= 1">[nordic_opf_and_html_26a] The <value-of
                    select="(tokenize(@epub:type,'\s+')[.=('note','rearnote','footnote')],'note')[1]"/><value-of select="if (@id) then concat(' with the id &quot;',@id,'&quot;') else ''"/> must have
                at least one &lt;a epub:type="noteref" ...&gt; referencing it: <value-of
                    select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/> (in <value-of select="replace(base-uri(),'.*/','')"
                />)</assert>
        </rule>
    </pattern>

    <!-- Rule 26b: Each noteref must reference a note -->
    <pattern id="epub_nordic_26_b">
        <rule context="html:a[tokenize(@epub:type,'\s+')='noteref']">
            <!-- this is the multi-HTML version of the rule; the single-HTML version of this rule is in nordic2015-1.sch -->
            <assert test="count(//html:*[tokenize(@epub:type,'\s+')=('note','rearnote','footnote') and @id = current()/substring-after(@href,'#')]) &gt;= 1">[nordic_opf_and_html_26b] The note
                reference with the href "<value-of select="@href"/>" attribute must resolve to a note, rearnote or footnote in the publication: <value-of
                    select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/> (in <value-of select="replace(base-uri(),'.*/','')"
                />)</assert>
        </rule>
    </pattern>

    <!-- Rule 27a: Each note must have a noteref -->
    <pattern id="epub_nordic_27_a">
        <rule context="html:*[tokenize(@epub:type,'\s+')=('annotation')]">
            <!-- this is the multi-HTML version of the rule; the single-HTML version of this rule is in nordic2015-1.sch -->
            <assert test="count(//html:a[tokenize(@epub:type,'\s+')='annoref' and substring-after(@href,'#') = current()/@id]) &gt;= 1">[nordic_opf_and_html_27a] The annotation<value-of
                    select="if (@id) then concat(' with the id &quot;',@id,'&quot;') else ''"/> must have at least one &lt;a epub:type="annoref" ...&gt; referencing it: <value-of
                    select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/> (in <value-of select="replace(base-uri(),'.*/','')"
                />)</assert>
        </rule>
    </pattern>

    <!-- Rule 27b: Each noteref must reference a note -->
    <pattern id="epub_nordic_27_b">
        <rule context="html:a[tokenize(@epub:type,'\s+')='annoref']">
            <!-- this is the multi-HTML version of the rule; the single-HTML version of this rule is in nordic2015-1.sch -->
            <assert test="count(//html:*[tokenize(@epub:type,'\s+')=('annotation') and @id = current()/substring-after(@href,'#')]) &gt;= 1">[nordic_opf_and_html_26b] The annotation with the href
                    "<value-of select="@href"/>" must resolve to a annotation in the publication: <value-of
                    select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/> (in <value-of select="replace(base-uri(),'.*/','')"
                />)</assert>
        </rule>
    </pattern>

    <!-- Rule 28: The HTML title element must be the same as the OPF publication dc:title -->
    <pattern id="epub_nordic_28">
        <rule context="html:title">
            <assert test="text() = /*/opf:package/opf:metadata/dc:title[not(@refines)]/text()">[nordic_opf_and_html_28] The HTML title element in <value-of select="replace(base-uri(.),'.*/','')"/>
                must contain the same text as the dc:title element in the OPF metadata. The HTML title element contains "<value-of select="."/>" while the dc:title element in the OPF contains
                    "<value-of select="/*/opf:package/opf:metadata/dc:title[not(@refines)]/text()"/>".</assert>
        </rule>
    </pattern>

    <!-- Rule 29: The HTML meta element with dc:identifier must have as content the same as the OPF publication dc:identifier -->
    <pattern id="epub_nordic_29">
        <rule context="html:meta[@name='dc:identifier']">
            <assert test="@content = /*/opf:package/opf:metadata/dc:identifier[not(@refines)]/text()">[nordic_opf_and_html_29] The HTML meta element in <value-of select="replace(base-uri(.),'.*/','')"
                /> with dc:identifier must have as content the same as the OPF publication dc:identifier. The OPF dc:identifier is "<value-of
                    select="/*/opf:package/opf:metadata/dc:identifier[not(@refines)]/text()"/>" while the HTML dc:identifier is "<value-of select="@content"/>".</assert>
        </rule>
    </pattern>

    <!--
        MG20061101: added as a consequence of zedval feature request #1565049: http://sourceforge.net/p/zedval/feature-requests/12/
        JAJ20150225: Imported from Pipeline 1 DTBook validator and adapted to EPUB3
    -->
    <pattern id="epub_nordic_32">
        <rule context="html:img[@longdesc]">
            <assert test="substring-after(normalize-space(@longdesc),'#') = //@id">[nordic_opf_and_html_32] The URL in the img longdesc attribute does not reference any element in the publication:
                    <value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/></assert>
        </rule>
    </pattern>

</schema>
