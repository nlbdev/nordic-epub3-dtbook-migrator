<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2" xmlns:c="http://www.w3.org/ns/xproc-step">

    <title>Nordic EPUB3 Navigation Document content reference rules</title>

    <!--
        The input for nordic2015-1.nav-references.sch is the navigation document, with its xml:base set explicitly on the root element,
        and with an added c:result element inserted as the first child of its root element. The contents of the c:result element contains
        references to all the headings and pabebreaks in the content documents, in spine order. These references are created by running
        list-heading-and-pagebreak-references.xsl on each content document individually, and then combining the results. Example:

        <html xmlns="http://www.w3.org/1999/xhtml" xmlns:epub="http://www.idpf.org/2007/ops"
            xml:base="file:/…/temp-dir/validate/EPUB/nav.xhtml">

            <c:result xmlns:c="http://www.w3.org/ns/xproc-step">
                <c:result xml:base="file:/…/temp-dir/validate/EPUB/581202-001-halftitlepage.xhtml"
                        data-sectioning-element="body" data-sectioning-id="level1_1" data-sectioning-depth="1"/>
                <c:result xml:base="file:/…/temp-dir/validate/EPUB/581202-001-halftitlepage.xhtml"
                        data-pagebreak-element="div" data-pagebreak-id="page-1">1</c:result>
                <c:result xml:base="file:/…/temp-dir/validate/EPUB/581202-001-halftitlepage.xhtml"
                        data-pagebreak-element="div" data-pagebreak-id="page-2">2</c:result>
                <c:result xml:base="file:/…/temp-dir/validate/EPUB/581202-002-titlepage.xhtml"
                        data-pagebreak-element="div" data-pagebreak-id="page-3">3</c:result>
                <c:result xml:base="file:/…/temp-dir/validate/EPUB/581202-002-titlepage.xhtml"
                        data-sectioning-element="body" data-sectioning-id="level1_2" data-heading-element="h1"
                        data-heading-id="h1_1" data-heading-depth="1" data-sectioning-depth="1">Book title</c:result>
                <c:result xml:base="file:/…/temp-dir/validate/EPUB/581202-003-colophon.xhtml"
                        data-sectioning-element="body" data-sectioning-id="level1_3" data-sectioning-depth="1"/>
                <c:result xml:base="file:/…/temp-dir/validate/EPUB/581202-003-colophon.xhtml"
                        data-pagebreak-element="div" data-pagebreak-id="page-4">4</c:result>
                <c:result xml:base="file:/…/temp-dir/validate/EPUB/581202-004-dedication.xhtml"
                        data-sectioning-element="body" data-sectioning-id="level1_4" data-sectioning-depth="1"/>
                <c:result xml:base="file:/…/temp-dir/validate/EPUB/581202-004-dedication.xhtml"
                        data-pagebreak-element="div" data-pagebreak-id="page-5">5</c:result>
                <c:result xml:base="file:/…/temp-dir/validate/EPUB/581202-004-dedication.xhtml"
                        data-pagebreak-element="div" data-pagebreak-id="page-6">6</c:result>
                <c:result xml:base="file:/…/temp-dir/validate/EPUB/581202-005-toc.xhtml"
                        data-pagebreak-element="div" data-pagebreak-id="page-7">7</c:result>
                <c:result xml:base="file:/…/temp-dir/validate/EPUB/581202-005-toc.xhtml"
                        data-sectioning-element="body" data-sectioning-id="level1_5" data-heading-element="h1"
                        data-heading-id="h1_2" data-heading-depth="1" data-sectioning-depth="1">Table of contents</c:result>
                <c:result xml:base="file:/…/temp-dir/validate/EPUB/581202-005-toc.xhtml"
                        data-pagebreak-element="span" data-pagebreak-id="page-8">8</c:result>
                <c:result xml:base="file:/…/temp-dir/validate/EPUB/581202-005-toc.xhtml"
                        data-pagebreak-element="span" data-pagebreak-id="page-9">9</c:result>
                <c:result xml:base="file:/…/temp-dir/validate/EPUB/581202-005-toc.xhtml"
                        data-pagebreak-element="span" data-pagebreak-id="page-10">10</c:result>
                <c:result xml:base="file:/…/temp-dir/validate/EPUB/581202-005-toc.xhtml"
                        data-pagebreak-element="span" data-pagebreak-id="page-11">11</c:result>
                <c:result xml:base="file:/…/temp-dir/validate/EPUB/581202-005-toc.xhtml"
                        data-pagebreak-element="div" data-pagebreak-id="page-12">12</c:result>
                <c:result xml:base="file:/…/temp-dir/validate/EPUB/581202-006-preface.xhtml"
                        data-pagebreak-element="div" data-pagebreak-id="page-13">13</c:result>
                <c:result xml:base="file:/…/temp-dir/validate/EPUB/581202-006-preface.xhtml"
                        data-sectioning-element="body" data-sectioning-id="level1_6" data-heading-element="h1"
                        data-heading-id="h1_3" data-heading-depth="1" data-sectioning-depth="1">Preface</c:result>
                <c:result xml:base="file:/…/temp-dir/validate/EPUB/581202-006-preface.xhtml"
                        data-pagebreak-element="span" data-pagebreak-id="page-14">14</c:result>
                <c:result xml:base="file:/…/temp-dir/validate/EPUB/581202-007-chapter.xhtml"
                        data-pagebreak-element="div" data-pagebreak-id="page-15">15</c:result>
                <c:result xml:base="file:/…/temp-dir/validate/EPUB/581202-007-chapter.xhtml"
                        data-sectioning-element="body" data-sectioning-id="level1_7" data-heading-element="h1"
                        data-heading-id="h1_4" data-heading-depth="1" data-sectioning-depth="1">Chapter title</c:result>
                <c:result xml:base="file:/…/temp-dir/validate/EPUB/581202-007-chapter.xhtml"
                        data-pagebreak-element="span" data-pagebreak-id="page-16">16</c:result>
                <c:result xml:base="file:/…/temp-dir/validate/EPUB/581202-007-chapter.xhtml"
                        data-sectioning-element="section" data-sectioning-id="level2_1" data-heading-element="h2"
                        data-heading-id="h2_1" data-heading-depth="2" data-sectioning-depth="2">Subchapter title</c:result>
                <c:result xml:base="file:/…/temp-dir/validate/EPUB/581202-007-chapter.xhtml"
                        data-pagebreak-element="span" data-pagebreak-id="page-17">17</c:result>
            </c:result>

            <head>…</head>
            <body>
                <nav epub:type="toc">…</nav>
                <nav epub:type="page-list" hidden="">…</nav>
            </body>
        </html>
    -->

    <ns prefix="html" uri="http://www.w3.org/1999/xhtml"/>
    <ns prefix="opf" uri="http://www.idpf.org/2007/opf"/>
    <ns prefix="dc" uri="http://purl.org/dc/elements/1.1/"/>
    <ns prefix="epub" uri="http://www.idpf.org/2007/ops"/>
    <ns prefix="nordic" uri="http://www.mtm.se/epub/"/>
    <ns prefix="c" uri="http://www.w3.org/ns/xproc-step"/>

    <pattern id="nav_references_1">
        <title>Rule 1</title>
        <p>All headings in the book must be referenced from the navigation document</p>
        <rule context="c:result/c:result[@data-sectioning-element]">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <let name="sectioning-ref" value="if (@data-sectioning-id) then concat(replace(@xml:base,'.*/',''),'#',@data-sectioning-id) else ()"/>
            <let name="heading-ref" value="if (@data-heading-id) then concat(replace(@xml:base,'.*/',''),'#',@data-heading-id) else ()"/>
            <let name="nav-ref" value="//html:nav[tokenize(@epub:type,'\s+')='toc']//html:a[$sectioning-ref and ends-with(@href, $sectioning-ref) or $heading-ref and ends-with(@href, $heading-ref)]"/>

            <assert test="count($nav-ref) = 1">[nordic_nav_references_1] All headings in the content documents must be referenced exactly once in the navigation document. In the content document
                    "<value-of select="replace(@xml:base,'.*/','')"/>", the <value-of
                    select="if (@data-heading-element) then concat('heading &quot;', text(), '&quot;', if (@data-heading-id) then concat(' with id=&quot;', @data-heading-id,'&quot;') else '', ' inside the ') else ''"
                /> "<value-of select="@data-sectioning-element"/>" element<value-of select="if (@data-sectioning-id) then concat(' with id=&quot;', @data-sectioning-id,'&quot;') else ''"/> is
                    <value-of select="if (count($nav-ref)=0) then 'not referenced' else 'referenced multiple times'"/> from the navigation document.</assert>

            <assert test="count($nav-ref) = 0 or normalize-space(string-join(.//text(),'')) = normalize-space(string-join($nav-ref//text(),''))">[nordic_nav_references_1] The
                text for the heading in the navigation document ("<value-of select="normalize-space(string-join($nav-ref//text(),''))"/>") should match the headline in the content document ("<value-of
                    select="normalize-space(string-join(.//text(),''))"/>" at <value-of select="($heading-ref, $sectioning-ref)[1]"/>)</assert>
        </rule>
    </pattern>

    <pattern id="nav_references_2">
        <title>Rule 2</title>
        <p>The toc must be in reading order and nested correctly</p>
        <rule context="html:a[ancestor::html:nav[tokenize(@epub:type,'\s+')='toc']]">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <let name="href" value="substring-before(@href,'#')"/>
            <let name="fragment" value="substring-after(@href,'#')"/>
            <let name="result-ref" value="/*/c:result/c:result[(@data-sectioning-id) = $fragment]"/>

            <assert test="$result-ref">[nordic_nav_references_2a] All references from the navigation document must reference a sectioning element in one of the content documents:
                    <value-of select="$context"/></assert>
            <report test="count($result-ref) &gt; 1">[nordic_nav_references_2a] All references from the navigation document must reference exactly one sectioning element in one of the
                content documents, there are multiple sections matching the href="<value-of select="@href"/>" in <value-of select="$context"/>; <value-of
                    select="string-join($result-ref/concat(replace(@xml:base,'.*/',''),'#',$fragment), ',')"/></report>

            <let name="result-ref-first" value="$result-ref[1]"/>
            <let name="document-in-nav" value="((preceding::html:a | self::*) intersect ancestor::html:nav//html:a)[substring-before(@href,'#') = $href][1]"/>
            <let name="document-in-nav-depth" value="count($document-in-nav/ancestor::html:li)"/>
            <let name="depth-in-nav" value="count(ancestor::html:li)"/>

            <let name="result-chapter-epub" value="if ($result-ref-first[tokenize(@data-document-epub-type,'\s+')='chapter']) then 1 else 0"/>
            <let name="result-chapter-role" value="if ($result-ref-first[@data-document-role='doc-chapter']) then 1 else 0"/>
            <let name="result-after-part-epub" value="if ($result-ref-first/preceding-sibling::c:result[tokenize(@data-document-epub-type,'\s+')='part']) then 1 else 0"/>
            <let name="result-after-part-role" value="if ($result-ref-first/preceding-sibling::c:result[@data-document-role='doc-part']) then 1 else 0"/>
            <let name="result-chapter-after-part" value="if (($result-chapter-epub=1 and $result-after-part-epub=1) or ($result-chapter-role=1 and $result-after-part-role=1)) then 1 else 0"/>

            <let name="depth-in-content" value="$result-ref-first/xs:integer((@data-heading-depth, @data-sectioning-depth)[1])"/>

            <assert test="not($result-ref-first) or $depth-in-nav = $depth-in-content + $document-in-nav-depth - 1 - $result-chapter-after-part">[nordic_nav_references_2b] The nesting of headlines in the content does not match the
                nesting of headlines in the navigation document. The toc item `<value-of select="$context"/>` in the navigation document is not nested at the correct
                level. The referenced document (<value-of select="$href"/>) occurs in the navigation document at nesting depth <value-of select="$document-in-nav-depth - $result-chapter-after-part"/> (<value-of
                    select="if ($document-in-nav-depth = 1) then 'it is not contained inside other sections such as a part or a chapter'
                    else concat('it is contained inside ',string-join($document-in-nav/ancestor::html:li[1]/ancestor::html:li/concat('&quot;',(text(),*[not(local-name()=('ol','ul'))]/string-join(.//text(),''))[normalize-space()][1],'&quot;'),', which is contained inside'))"
                />). The referenced headline (<value-of select="@href"/>) occurs in the navigation document at nesting depth <value-of select="$depth-in-nav"/> (<value-of
                    select="if ($depth-in-nav = 1) then 'it is not contained inside other sections such as a part or a chapter'
                    else concat('it is contained inside ',string-join(ancestor::html:li[1]/ancestor::html:li/concat('&quot;',(text(),*/string-join(.//text(),''))[normalize-space()][1],'&quot;'),', which is contained inside'))"
                />). The referenced headline (`&lt;<value-of select="$result-ref-first/@data-heading-element"/><value-of select="$result-ref-first/@data-heading-id/concat(' id=&quot;',.,'&quot;')"/>&gt;<value-of
                    select="$result-ref-first/text()"/>&lt;/<value-of select="$result-ref-first/@data-heading-element"/>&gt;) occurs in the content document <value-of select="$href"/> as a `<value-of
                    select="$result-ref-first/@data-heading-element"/>` which implies that it should be referenced at nesting depth <value-of select="$depth-in-content + $document-in-nav-depth - 1"/> in the
                navigation document.</assert>
        </rule>
    </pattern>

    <pattern id="nav_references_3">
        <title>Rule 3</title>
        <p>All pagebreaks in the book must be referenced from the navigation document</p>
        <rule context="c:result/c:result[@data-pagebreak-element]">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <let name="pagebreak-ref" value="if (@data-pagebreak-id) then concat(replace(@xml:base,'.*/',''),'#',@data-pagebreak-id) else ()"/>
            <let name="nav-ref" value="//html:nav[tokenize(@epub:type,'\s+')='page-list']//html:a[$pagebreak-ref and ends-with(@href, $pagebreak-ref)]"/>

            <assert test="count($nav-ref) = 1">[nordic_nav_references_3] All pagebreaks in the content documents must be referenced exactly once in the navigation document. In the content document
                    "<value-of select="replace(@xml:base,'.*/','')"/>", the pagebreak "<value-of select="text()"/>"<value-of
                    select="if (@data-pagebreak-id) then concat(' with id=&quot;', @data-pagebreak-id,'&quot;') else ''"/> is <value-of
                    select="if (count($nav-ref)=0) then 'not referenced' else 'referenced multiple times'"/> from the navigation document.</assert>

            <report test="count($nav-ref) and not(normalize-space(string-join(.//text(),'')) = ('', normalize-space(string-join($nav-ref//text(),''))))">[nordic_nav_references_3] The page number for
                the pagebreak in the navigation document ("<value-of select="normalize-space(string-join($nav-ref//text(),''))"/>") should match the page number of the referenced pagebreak in the
                content document ("<value-of select="normalize-space(string-join(.//text(),''))"/>" at <value-of select="$pagebreak-ref"/>)</report>
        </rule>
    </pattern>

    <pattern id="nav_references_4">
        <title>Rule 4</title>
        <p>The page-list must be in reading order</p>
        <rule context="html:a[ancestor::html:nav[tokenize(@epub:type,'\s+')='page-list']]">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <let name="result-ref" value="/*/c:result/c:result[@data-pagebreak-id = substring-after(@href,'#')]"/>
            <let name="preceding-refs-which-is-following-in-content"
                value="(preceding::html:a intersect ancestor::html:nav//html:a)[@href = $result-ref/following-sibling::c:result/concat(replace(@xml:base,'.*/',''),@data-pagebreak-id)]"/>
            <report test="count($preceding-refs-which-is-following-in-content)">[nordic_nav_references_4] The page list in the navigation document must reference the pagebreaks in the correct order.
                The pagebreak with id="<value-of select="substring-after(@href,'#')"/>" in the document "<value-of select="substring-before(@href,'#')"/>" is referenced from the navigation document
                after the pagebreak with id="<value-of select="$preceding-refs-which-is-following-in-content[1]/substring-after(@href,'#')"/>" in the document "<value-of
                    select="$preceding-refs-which-is-following-in-content[1]/substring-before(@href,'#')"/>", but in the content document it occurs before it.</report>
        </rule>
    </pattern>

</schema>
