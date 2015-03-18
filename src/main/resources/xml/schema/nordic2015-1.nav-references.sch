<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2" xmlns:c="http://www.w3.org/ns/xproc-step">

    <title>Nordic EPUB3 Navigation Document content reference rules</title>

    <!--
        Example input to this schematron (c:result elements must be in reading order):
        
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
        <rule context="c:result/c:result[@data-sectioning-element]">
            <let name="sectioning-ref" value="if (@data-sectioning-id) then concat(replace(@xml:base,'.*/',''),'#',@data-sectioning-id) else ()"/>
            <let name="heading-ref" value="if (@data-heading-id) then concat(replace(@xml:base,'.*/',''),'#',@data-heading-id) else ()"/>
            <let name="nav-ref" value="//html:nav[tokenize(@epub:type,'\s+')='toc']//html:a[replace(@href,'^.*/','') = ($sectioning-ref, $heading-ref)]"/>

            <assert test="count($nav-ref) = 1">[nordic_nav_references_1] All headings in the content documents must be referenced exactly once in the navigation document. In the content document
                    "<value-of select="replace(@xml:base,'.*/','')"/>", the heading "<value-of select="text()"/>"<value-of
                    select="if (@data-heading-id) then concat(' with id=&quot;', @data-heading-id,'&quot;') else ''"/> inside the "<value-of select="@data-sectioning-element"/>" element<value-of
                    select="if (@data-heading-id) then concat(' with id=&quot;', @data-sectioning-id,'&quot;') else ''"/> is <value-of
                    select="if (count($nav-ref)=0) then 'not referenced' else 'referenced multiple times'"/> from the navigation document.</assert>

            <assert test="count($nav-ref) = 0 or normalize-space(string-join(.//text(),'')) = normalize-space(string-join($nav-ref//text(),''))">[nordic_nav_references_1] The text for the heading in
                the navigation document ("<value-of select="normalize-space(string-join($nav-ref//text(),''))"/>") should match the headline in the content document ("<value-of
                    select="normalize-space(string-join(.//text(),''))"/>" at <value-of select="($heading-ref, $sectioning-ref)[1]"/>)</assert>
        </rule>
    </pattern>

    <!-- Rule 2: The toc must be in reading order -->
    <pattern id="nav_references_2">
        <rule context="html:a[ancestor::html:nav[tokenize(@epub:type,'\s+')='toc']]">
            <let name="result-ref" value="/*/c:result/c:result[(@data-sectioning-id, @data-heading-id) = substring-after(@href,'#')]"/>
            <let name="preceding-refs-which-is-following-in-content"
                value="(preceding::html:a intersect ancestor::html:nav//html:a)[@href = $result-ref/following-sibling::c:result/concat(replace(@xml:base,'.*/',''),(@data-sectioning-id, @data-heading-id)[1])]"/>
            <report test="count($preceding-refs-which-is-following-in-content)">[nordic_nav_references_2] The table of contents in the navigation document must reference the headlines in the correct
                order. The headline with id="<value-of select="substring-after(@href,'#')"/>" in the document "<value-of select="substring-before(@href,'#')"/>" is referenced from the navigation
                document after the headline with id="<value-of select="$preceding-refs-which-is-following-in-content[1]/substring-after(@href,'#')"/>" in the document "<value-of
                    select="$preceding-refs-which-is-following-in-content[1]/substring-before(@href,'#')"/>", but in the content document it occurs before it.</report>
        </rule>
    </pattern>

    <!-- Rule 3: All pagebreaks in the book must be referenced from the navigation document -->
    <pattern id="nav_references_3">
        <rule context="c:result/c:result[@data-pagebreak-element]">
            <let name="pagebreak-ref" value="if (@data-pagebreak-id) then concat(replace(@xml:base,'.*/',''),'#',@data-sectioning-id) else ()"/>
            <let name="nav-ref" value="//html:nav[tokenize(@epub:type,'\s+')='page-list']//html:a[replace(@href,'^.*/','') = $pagebreak-ref]"/>

            <assert test="count($nav-ref) = 1">[nordic_nav_references_3] All pagebreaks in the content documents must be referenced exactly once in the navigation document. In the content document
                    "<value-of select="replace(@xml:base,'.*/','')"/>", the pagebreak "<value-of select="text()"/>"<value-of
                    select="if (@data-pagebreak-id) then concat(' with id=&quot;', @data-pagebreak-id,'&quot;') else ''"/> is <value-of
                    select="if (count($nav-ref)=0) then 'not referenced' else 'referenced multiple times'"/> from the navigation document.</assert>

            <assert test="count($nav-ref) = 0 or normalize-space(string-join(.//text(),'')) = normalize-space(string-join($nav-ref//text(),''))">[nordic_nav_references_3] The page number for the
                pagebreak in the navigation document ("<value-of select="normalize-space(string-join($nav-ref//text(),''))"/>") should match the page number of the referenced pagebreak in the content
                document ("<value-of select="normalize-space(string-join(.//text(),''))"/>" at <value-of select="$pagebreak-ref"/>)</assert>
        </rule>
    </pattern>

    <!-- Rule 4: The page-list must be in reading order -->
    <pattern id="nav_references_4">
        <rule context="html:a[ancestor::html:nav[tokenize(@epub:type,'\s+')='page-list']]">
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
