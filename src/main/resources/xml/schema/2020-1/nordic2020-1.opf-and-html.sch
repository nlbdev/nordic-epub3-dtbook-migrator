<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">

    <title>Nordic EPUB3 Package Document and Content Document cross-reference rules</title>

    <!--
        The input for nordic2015-1.opf-and-html.sch is a c:result wrapper element, containing the package file as its first child element,
        and the content documents, in spine order, as the other child elements. The xml:base is set explicitly for the package document and
        the content documents. Example:

        <c:result xmlns:c="http://www.w3.org/ns/xproc-step">
            <package xmlns="http://www.idpf.org/2007/opf" xml:base="file:/…/temp-dir/validate/EPUB/package.opf">
                <metadata>…</metadata>
                <manifest>…</manifest>
                <spine toc="ncx">…</spine>
            </package>
            <html xmlns="http://www.w3.org/1999/xhtml" xml:base="file:/…/temp-dir/validate/EPUB/581202-001-halftitlepage.xhtml">…</html>
            <html xmlns="http://www.w3.org/1999/xhtml" xml:base="file:/…/temp-dir/validate/EPUB/581202-002-titlepage.xhtml">…</html>
            <html xmlns="http://www.w3.org/1999/xhtml" xml:base="file:/…/temp-dir/validate/EPUB/581202-003-colophon.xhtml">…</html>
            <html xmlns="http://www.w3.org/1999/xhtml" xml:base="file:/…/temp-dir/validate/EPUB/581202-004-dedication.xhtml">…</html>
            <html xmlns="http://www.w3.org/1999/xhtml" xml:base="file:/…/temp-dir/validate/EPUB/581202-005-toc.xhtml">…</html>
            <html xmlns="http://www.w3.org/1999/xhtml" xml:base="file:/…/temp-dir/validate/EPUB/581202-006-preface.xhtml">…</html>
            <html xmlns="http://www.w3.org/1999/xhtml" xml:base="file:/…/temp-dir/validate/EPUB/581202-007-chapter.xhtml">…</html>
            <html xmlns="http://www.w3.org/1999/xhtml" xml:base="file:/…/temp-dir/validate/EPUB/581202-008-chapter.xhtml">…</html>
            <html xmlns="http://www.w3.org/1999/xhtml" xml:base="file:/…/temp-dir/validate/EPUB/581202-009-chapter.xhtml">…</html>
            <html xmlns="http://www.w3.org/1999/xhtml" xml:base="file:/…/temp-dir/validate/EPUB/581202-010-chapter.xhtml">…</html>
            <html xmlns="http://www.w3.org/1999/xhtml" xml:base="file:/…/temp-dir/validate/EPUB/581202-011-chapter.xhtml">…</html>
            <html xmlns="http://www.w3.org/1999/xhtml" xml:base="file:/…/temp-dir/validate/EPUB/581202-012-chapter.xhtml">…</html>
            <html xmlns="http://www.w3.org/1999/xhtml" xml:base="file:/…/temp-dir/validate/EPUB/581202-013-chapter.xhtml">…</html>
            <html xmlns="http://www.w3.org/1999/xhtml" xml:base="file:/…/temp-dir/validate/EPUB/581202-014-chapter.xhtml">…</html>
            <html xmlns="http://www.w3.org/1999/xhtml" xml:base="file:/…/temp-dir/validate/EPUB/581202-015-afterword.xhtml">…</html>
            <html xmlns="http://www.w3.org/1999/xhtml" xml:base="file:/…/temp-dir/validate/EPUB/581202-016-backmatter.xhtml">…</html>
            <html xmlns="http://www.w3.org/1999/xhtml" xml:base="file:/…/temp-dir/validate/EPUB/581202-017-index.xhtml">…</html>
            <html xmlns="http://www.w3.org/1999/xhtml" xml:base="file:/…/temp-dir/validate/EPUB/581202-018-footnotes.xhtml">…</html>
        </c:result>
    -->

    <ns prefix="html" uri="http://www.w3.org/1999/xhtml"/>
    <ns prefix="opf" uri="http://www.idpf.org/2007/opf"/>
    <ns prefix="dc" uri="http://purl.org/dc/elements/1.1/"/>
    <ns prefix="epub" uri="http://www.idpf.org/2007/ops"/>
    <ns prefix="nordic" uri="http://www.mtm.se/epub/"/>

    <let name="ids" value="//xs:string(@id)"/>

    <pattern id="opf_and_html_nordic_1">
        <title>Rule 1</title>
        <p></p>
        <rule context="*[@id]">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <let name="id" value="@id"/>
            <assert test="count($ids[.=$id]) = 1">[nordic_opf_and_html_1] id attributes must be unique; <value-of select="@id"/> in <value-of select="replace(base-uri(.),'^.*/','')"/> also exists
                in <value-of select="(//*[@id=$id] except .)/replace(base-uri(.),'^.*/','')"/></assert>
        </rule>
    </pattern>

    <pattern id="nordic_opf_and_html_13_a">
        <!-- see also nordic2015-1.sch for single-document version -->
        <title>Rule 13</title>
        <p>All books must have frontmatter and bodymatter</p>
        <rule context="html:html[not(preceding-sibling::html:html)]">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <assert test="((.|following-sibling::html:html)/html:body/html:section/tokenize(@epub:type,'\s+')=('cover','frontmatter')) = true()">[nordic_opf_and_html_13a] There must be at least one frontmatter or
                cover document</assert>
            <assert test="((.|following-sibling::html:html)/html:body/html:section/tokenize(@epub:type,'\s+')='bodymatter') = true()">[nordic_opf_and_html_13a] There must be at least one bodymatter
                document</assert>
        </rule>
    </pattern>

    <pattern id="nordic_opf_and_html_15">
        <!-- see also nordic2015-1.sch for single-document version -->
        <title>Rule 15</title>
        <p></p>
        <rule context="opf:itemref">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <let name="this" value="."/>
            <let name="this-item" value="../../opf:manifest/opf:item[@id = $this/@idref]"/>
            <let name="this-type"
                value="/*/html:html/html:body[replace(base-uri(),'.*/','') = $this-item/@href]/(tokenize(@epub:type,'\s+')[.=('cover','frontmatter','bodymatter','backmatter')],'bodymatter')[1]"/>
            <let name="preceding-items" value="../../opf:manifest/opf:item[@id = $this/preceding-sibling::opf:item/@idref]"/>
            <let name="preceding-cover" value="/*/html:html/html:body[replace(base-uri(),'.*/','') = $preceding-items/@href and tokenize(@epub:type,'\s+') = 'cover']"/>
            <let name="preceding-frontmatter" value="/*/html:html/html:body[replace(base-uri(),'.*/','') = $preceding-items/@href and tokenize(@epub:type,'\s+') = 'frontmatter']"/>
            <let name="preceding-bodymatter"
                value="/*/html:html/html:body[replace(base-uri(),'.*/','') = $preceding-items/@href and (tokenize(@epub:type,'\s+') = 'bodymatter' or not(tokenize(@epub:type,'\s+') = ('cover','frontmatter','backmatter')))]"/>
            <let name="preceding-backmatter" value="/*/html:html/html:body[replace(base-uri(),'.*/','') = $preceding-items/@href and tokenize(@epub:type,'\s+') = 'backmatter']"/>
            <report test="$this-type = 'cover' and count($preceding-items)">[nordic_opf_and_html_15] Cover must not be preceded by any other itemrefs in the OPF spine: <value-of select="$context"/> (in <value-of select="replace(base-uri(),'.*/','')"
                /></report>
            <report test="$this-type = 'frontmatter' and $preceding-bodymatter">[nordic_opf_and_html_15] Frontmatter must be placed before all bodymatter in the spine: <value-of select="$context"/> (in <value-of select="replace(base-uri(),'.*/','')"
                /></report>
            <report test="$this-type = 'frontmatter' and $preceding-backmatter">[nordic_opf_and_html_15] Frontmatter must be placed before all backmatter in the spine: <value-of select="$context"/> (in <value-of select="replace(base-uri(),'.*/','')"
                /></report>
            <report test="$this-type = 'bodymatter' and $preceding-backmatter">[nordic_opf_and_html_15] Bodymatter must be placed before all backmatter in the spine: <value-of select="$context"/> (in <value-of select="replace(base-uri(),'.*/','')"
                /></report>
        </rule>
    </pattern>

    <pattern id="nordic_opf_and_html_23">
        <title>Rule 23</title>
        <p>Increasing pagebreak values for page-normal</p>
        <rule
            context="html:*[tokenize(@epub:type,'\s+')='pagebreak' and tokenize(@class,'\s+')='page-normal' and preceding::html:*[tokenize(@epub:type,'\s+')='pagebreak'][tokenize(@class,'\s+')='page-normal']]">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <let name="preceding" value="preceding::html:*[tokenize(@epub:type,'\s+')='pagebreak' and tokenize(@class,'\s+')='page-normal'][1]"/>
            <assert test="number(current()/@aria-label) > number($preceding/@aria-label)">[nordic_opf_and_html_23] pagebreak values must increase for pagebreaks with class="page-normal" (see pagebreak with
                aria-label="<value-of select="@aria-label"/>" in <value-of select="replace(base-uri(.),'^.*/','')"/> and compare with pagebreak with aria-label="<value-of select="$preceding/@aria-label"/> in
                    <value-of select="replace(base-uri($preceding),'^.*/','')"/>)</assert>
        </rule>
    </pattern>

    <pattern id="nordic_opf_and_html_24">
        <title>Rule 24</title>
        <p>Values of pagebreak must be unique for page-front</p>
        <rule context="html:*[tokenize(@epub:type,' ')='pagebreak'][tokenize(@class,' ')='page-front']">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <assert test="count(//html:*[tokenize(@epub:type,'\s+')='pagebreak' and tokenize(@class,'\s+')='page-front' and @aria-label=current()/@aria-label])=1">[nordic_opf_and_html_24] pagebreak values must
                be unique for pagebreaks with class="page-front" (see pagebreak with aria-label="<value-of select="@aria-label"/>" in <value-of select="replace(base-uri(.),'^.*/','')"/>)</assert>
        </rule>
    </pattern>

    <pattern id="nordic_opf_and_html_26_a">
        <title>Rule 26a</title>
        <p>Each note must have a noteref</p>
        <rule context="html:*[tokenize(@epub:type,'\s+')=('note','endnote','footnote')]">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <!-- this is the multi-HTML version of the rule; the single-HTML version of this rule is in nordic2015-1.sch -->
            <assert test="count(//html:a[tokenize(@epub:type,'\s+')='noteref' and substring-after(@href,'#') = current()/@id]) &gt;= 1">[nordic_opf_and_html_26a] The <value-of
                    select="(tokenize(@epub:type,'\s+')[.=('note','endnote','footnote')],'note')[1]"/><value-of select="if (@id) then concat(' with the id &quot;',@id,'&quot;') else ''"/> must have
                at least one &lt;a epub:type="noteref" ...&gt; referencing it: <value-of select="$context"/> (in <value-of select="replace(base-uri(),'.*/','')"
                />)</assert>
        </rule>
    </pattern>

    <pattern id="nordic_opf_and_html_26_b">
        <title>Rule 26b</title>
        <p>Each noteref must reference a note</p>
        <rule context="html:a[tokenize(@epub:type,'\s+')='noteref']">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <!-- this is the multi-HTML version of the rule; the single-HTML version of this rule is in nordic2015-1.sch -->
            <assert test="count(//html:*[tokenize(@role,'\s+')=('doc-endnote','doc-footnote') and @id = current()/substring-after(@href,'#')]) &gt;= 1">[nordic_opf_and_html_26b] The note
                reference with the href "<value-of select="@href"/>" attribute must resolve to a note, endnote or footnote in the publication: <value-of select="$context"/> (in <value-of select="replace(base-uri(),'.*/','')"
                />)</assert>
        </rule>
    </pattern>

    <pattern id="nordic_opf_and_html_27_a">
        <title>Rule 27a</title>
        <p>Each annotation must have a annoref</p>
        <rule context="html:*[tokenize(@epub:type,'\s+')=('annotation')]">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <!-- this is the multi-HTML version of the rule; the single-HTML version of this rule is in nordic2015-1.sch -->
            <assert test="count(//html:a[tokenize(@epub:type,'\s+')='annoref' and substring-after(@href,'#') = current()/@id]) &gt;= 1">[nordic_opf_and_html_27a] The annotation<value-of
                    select="if (@id) then concat(' with the id &quot;',@id,'&quot;') else ''"/> must have at least one &lt;a epub:type="annoref" ...&gt; referencing it: <value-of select="$context"/> (in <value-of select="replace(base-uri(),'.*/','')"
                />)</assert>
        </rule>
    </pattern>

    <pattern id="nordic_opf_and_html_27_b">
        <title>Rule 27b</title>
        <p>Each annoref must reference a annotation</p>
        <rule context="html:a[tokenize(@epub:type,'\s+')='annoref']">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <!-- this is the multi-HTML version of the rule; the single-HTML version of this rule is in nordic2015-1.sch -->
            <assert test="count(//html:*[tokenize(@epub:type,'\s+')=('annotation') and @id = current()/substring-after(@href,'#')]) &gt;= 1">[nordic_opf_and_html_26b] The annotation with the href
                    "<value-of select="@href"/>" must resolve to a annotation in the publication: <value-of select="$context"/> (in <value-of select="replace(base-uri(),'.*/','')"
                />)</assert>
        </rule>
    </pattern>

    <pattern id="nordic_opf_and_html_28">
        <title>Rule 28</title>
        <p>The HTML title element must be the same as the OPF publication dc:title</p>
        <rule context="html:title">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <assert test="text() = /*/opf:package/opf:metadata/dc:title[not(@refines)]/text()">[nordic_opf_and_html_28] The HTML title element in <value-of select="replace(base-uri(.),'.*/','')"/>
                must contain the same text as the dc:title element in the OPF metadata. The HTML title element contains "<value-of select="."/>" while the dc:title element in the OPF contains
                    "<value-of select="/*/opf:package/opf:metadata/dc:title[not(@refines)]/text()"/>".</assert>
        </rule>
    </pattern>

    <pattern id="nordic_opf_and_html_29">
        <title>Rule 29</title>
        <p>The HTML meta element with dc:identifier must have as content the same as the OPF publication dc:identifier</p>
        <rule context="html:meta[@name='dc:identifier']">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <assert test="@content = /*/opf:package/opf:metadata/dc:identifier[not(@refines)]/text()">[nordic_opf_and_html_29] The HTML meta element in <value-of select="replace(base-uri(.),'.*/','')"
                /> with dc:identifier must have as content the same as the OPF publication dc:identifier. The OPF dc:identifier is "<value-of
                    select="/*/opf:package/opf:metadata/dc:identifier[not(@refines)]/text()"/>" while the HTML dc:identifier is "<value-of select="@content"/>".</assert>
        </rule>
    </pattern>


    <pattern id="nordic_opf_and_html_30_a">
        <title>Rule 30a</title>
        <p>Each noteref must have a backlink</p>
        <rule context="html:a[tokenize(@epub:type,'\s+')=('noteref')]">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <assert test="count(//html:a[tokenize(@role,'\s+')='doc-backlink' and substring-after(@href,'#') = current()/@id]) = 1">[nordic_opf_and_html_30a] The <value-of
                    select="(tokenize(@epub:type,'\s+')[.=('noteref')],'noteref')[1]"/><value-of select="if (@id) then concat(' with the id &quot;',@id,'&quot;') else ''"/> must have
                at least one &lt;a role="doc-backlink" ...&gt; referencing it: <value-of select="$context"/> (in <value-of select="replace(base-uri(),'.*/','')"
                />)</assert>
        </rule>
    </pattern>

    <pattern id="nordic_opf_and_html_30_b">
        <title>Rule 30b</title>
        <p>Each backlink must reference a noteref</p>
        <rule context="html:a[tokenize(@role,'\s+')='doc-backlink']">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <assert test="count(//html:a[tokenize(@epub:type,'\s+')=('noteref') and @id = current()/substring-after(@href,'#')]) = 1">[nordic_opf_and_html_30b] The backlink
                with the href "<value-of select="@href"/>" attribute must resolve to a noteref in the publication: <value-of select="$context"/> (in <value-of select="replace(base-uri(),'.*/','')"
                />)</assert>
        </rule>
    </pattern>

</schema>
