<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">

    <title>DTBook 2005 Schematron tests for NORDIC 2010-1 rules - adapted for HTML5</title>

    <ns prefix="html" uri="http://www.w3.org/1999/xhtml"/>
    <ns prefix="epub" uri="http://www.idpf.org/2007/ops"/>
    <ns prefix="nordic" uri="http://www.mtm.se/epub/"/>

    <!-- Rule 7: No <ul>, <ol> or <dl> inside <p> -->
    <pattern id="epub_nordic_7">
        <rule context="html:p">
            <report test="html:ul | html:ol">[nordic07] Lists (<value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/>) are
                not allowed inside paragraphs.</report>
            <report test="html:dl">[nordic07] Definition lists (<value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/>) are
                not allowed inside paragraphs.</report>
        </rule>
    </pattern>

    <!-- Rule 8: Only allow pagebreak w/page-front in frontmatter -->
    <pattern id="epub_nordic_8">
        <rule context="html:*[tokenize(@epub:type,'\s+')='pagebreak' and tokenize(@class,'\s+')='page-front']">
            <assert test="ancestor::html:*[self::html:section or self::html:article or self::html:body]/tokenize(@epub:type,'\s+') = ('frontmatter','cover')">[nordic08] &lt;span epub:type="pagebreak"
                class="page-front"/&gt; may only occur in frontmatter and cover. <value-of
                    select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/></assert>
        </rule>
    </pattern>

    <!-- Rule 9: Disallow empty elements (with a few exceptions) -->
    <pattern id="epub_nordic_9">
        <rule context="html:*">
            <report
                test="normalize-space(.)='' and not(*) and not(self::html:img or self::html:br or self::html:meta or self::html:link or self::html:col or self::html:th or self::html:td or self::html:dd or self::html:*[tokenize(@epub:type,'\s+')='pagebreak'] or self::html:hr or self::html:script)"
                >[nordic09] Element may not be empty: <value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/></report>
        </rule>
    </pattern>

    <!-- Rule 10: Metadata for dc:language, dc:date and dc:publisher must exist in the single-HTML representation -->
    <pattern id="epub_nordic_10">
        <rule context="html:head[following-sibling::html:body/html:header]">
            <!-- dc:language -->
            <assert test="count(html:meta[@name='dc:language'])>=1">[nordic10] Meta dc:language must occur at least once in HTML head</assert>
            <!-- dc:date -->
            <assert test="count(html:meta[@name='dc:date'])=1">[nordic10] Meta dc:date=YYYY-MM-DD must occur exactly once in HTML head</assert>
            <report test="html:meta[@name='dc:date' and translate(@content, '0123456789', '0000000000')!='0000-00-00']">[nordic10] Meta dc:date ("<value-of select="@content"/>") must have format
                YYYY-MM-DD</report>
            <!-- dc:publisher -->
            <assert test="count(html:meta[@name='dc:publisher'])=1">[nordic10] Meta dc:publisher must occur exactly once</assert>
        </rule>
    </pattern>

    <!-- Rule 11: Root element must have @xml:lang -->
    <pattern id="epub_nordic_11">
        <rule context="html:html">
            <assert test="@xml:lang">[nordic11] &lt;html&gt; element must have an xml:lang attribute</assert>
        </rule>
    </pattern>

    <!-- Rule 12: Frontmatter starts with doctitle and docauthor -->
    <pattern id="epub_nordic_12">
        <rule context="html:body/html:header">
            <assert test="html:*[1][self::html:h1[tokenize(@epub:type,' ')='fulltitle']]">[nordic12] Single-HTML document must begin with a fulltitle headline in its header element (xpath:
                /html/body/header/h1).</assert>
        </rule>
    </pattern>

    <!-- Rule 13: All books must have frontmatter and bodymatter -->
    <pattern id="epub_nordic_13_a">
        <rule context="html:body[html:header]">
            <assert test="((html:section|html:article)/tokenize(@epub:type,'\s+')=('cover','frontmatter')) = true()">[nordic13a] A single-HTML document must have at least one frontmatter or cover
                section</assert>
            <assert test="((html:section|html:article)/tokenize(@epub:type,'\s+')='bodymatter') = true()">[nordic13a] A single-HTML document must have at least one bodymatter section</assert>
            <assert test="not(tokenize(@epub:type,'\s+')=('cover','frontmatter','bodymatter','backmatter'))">[nordic13a] The single-HTML document must not have cover, frontmatter, bodymatter or
                backmatter as epub:type on its body element</assert>
        </rule>
    </pattern>

    <pattern id="epub_nordic_13_b">
        <rule context="html:*[self::html:section or self::html:article][ancestor::html:body[html:header] and not(parent::html:body) and not(parent::html:section[tokenize(@epub:type,'\s+')='part'])]">
            <assert test="not((tokenize(@epub:type,'\s+')=('cover','frontmatter','bodymatter','backmatter')) = true())">[nordic13b] The single-HTML document must not have cover, frontmatter,
                bodymatter or backmatter on any of its sectioning elements other than the top-level elements that has body as its parent</assert>
        </rule>
    </pattern>

    <pattern id="epub_nordic_13_c">
        <rule context="html:body[not(html:header|html:nav)]">
            <assert test="tokenize(@epub:type,'\s+')=('cover','frontmatter','bodymatter','backmatter')">[nordic13c] The document must have either cover, frontmatter, bodymatter or backmatter as
                epub:type on its body element.</assert>
        </rule>
    </pattern>

    <pattern id="epub_nordic_13_d">
        <rule context="html:*[self::html:section or self::html:article][ancestor::html:body[not(html:header|html:nav)]]">
            <assert test="not((tokenize(@epub:type,'\s+')=('cover','frontmatter','bodymatter','backmatter')) = true())">[nordic13d] The document must not have cover, frontmatter, bodymatter or
                backmatter on any of its sectioning elements (they are only allowed on the body element).</assert>
        </rule>
    </pattern>

    <!-- Rule 14:  Don't allow <h x+1> in section w/depth x+1 unless <h x> in section w/depth x is present -->
    <pattern id="epub_nordic_14">
        <rule context="html:*[self::html:body[not(html:header)] or self::html:section or self::html:article][not(tokenize(@epub:type,'\s+')='cover')][html:section|html:article]">
            <assert test="html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6">[nordic14] sectioning element with no headline (h1-h6) when sub-section is present (is only allowed for sectioning
                element with epub:type="cover"): <value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/></assert>
        </rule>
    </pattern>

    <!-- Rule 20: No image series in inline context -->
    <pattern id="epub_nordic_20">
        <rule context="html:figure">
            <report
                test="ancestor::html:a        or ancestor::html:abbr    or ancestor::html:a[tokenize(@epub:type,' ')='annoref']   or
                          ancestor::html:bdo      or ancestor::html:code       or ancestor::html:dfn        or ancestor::html:em        or
                          ancestor::html:kbd      or ancestor::html:p[tokenize(@class,' ')='linenum']    or ancestor::html:a[tokenize(@epub:type,' ')='noteref']    or ancestor::html:span[tokenize(@class,' ')='lic']       or
                          ancestor::html:q        or ancestor::html:samp       or ancestor::html:span[tokenize(@epub:type,' ')='z3998:sentence']       or ancestor::html:span      or
                          ancestor::html:strong   or ancestor::html:sub        or ancestor::html:sup        or ancestor::html:span[tokenize(@epub:type,' ')='z3998:word']         or
                          ancestor::html:address  or ancestor::html:*[tokenize(@epub:type,' ')='z3998:author' and not(parent::html:header[parent::html:body])]     or ancestor::html:p[tokenize(@epub:type,' ')='bridgehead'] or ancestor::html:*[tokenize(@class,' ')='byline']    or
                          ancestor::html:cite     or ancestor::html:*[tokenize(@epub:type,' ')='covertitle'] or ancestor::html:*[tokenize(@class,' ')='dateline']   or ancestor::html:p[parent::html:header[parent::html:body] and tokenize(@epub:type,' ')='z3998:author'] or
                          ancestor::html:h1[tokenize(@epub:type,' ')='fulltitle'] or ancestor::html:dt         or ancestor::html:h1         or ancestor::html:h2        or
                          ancestor::html:h3       or ancestor::html:h4         or ancestor::html:h5         or ancestor::html:h6        or
                          ancestor::html:p[tokenize(@class,' ')='line']       or ancestor::html:p"
                >[nordic20] Image series are not allowed in inline context (<value-of
                    select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/>)</report>
        </rule>
    </pattern>

    <!-- Rule 21: No nested tables -->
    <pattern id="epub_nordic_21">
        <rule context="html:table">
            <report test="ancestor::html:table">[nordic21] Nested tables are not allowed (<value-of
                    select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/>)</report>
        </rule>
    </pattern>

    <!-- Rule 23: Increasing pagebreak values for page-normal -->
    <pattern id="epub_nordic_23">
        <rule
            context="html:*[tokenize(@epub:type,'\s+')='pagebreak' and tokenize(@class,'\s+')='page-normal' and preceding::html:*[tokenize(@epub:type,'\s+')='pagebreak'][tokenize(@class,'\s+')='page-normal']]">
            <let name="preceding" value="preceding::html:*[tokenize(@epub:type,'\s+')='pagebreak' and tokenize(@class,'\s+')='page-normal'][1]"/>
            <assert test="number(current()/@title) > number($preceding/@title)">[nordic23] pagebreak values must increase for pagebreaks with class="page-normal" (see pagebreak with title="<value-of
                    select="@title"/>" and compare with pagebreak with title="<value-of select="$preceding/@title"/>")</assert>
        </rule>
    </pattern>

    <!-- Rule 24: Values of pagebreak must be unique for page-front -->
    <pattern id="epub_nordic_24">
        <rule context="html:*[tokenize(@epub:type,' ')='pagebreak'][tokenize(@class,' ')='page-front']">
            <assert test="count(//html:*[tokenize(@epub:type,'\s+')='pagebreak' and tokenize(@class,'\s+')='page-front' and @title=current()/@title])=1">[nordic24] pagebreak values must be unique for
                pagebreaks with class="page-front" (see pagebreak with title="<value-of select="@title"/>")</assert>
        </rule>
    </pattern>

    <!-- Rule 26: Each note must have a noteref -->
    <pattern id="epub_nordic_26">
        <rule context="html:*[tokenize(@epub:type,'\s+')='note'][ancestor::html:body[html:header]]">
            <!-- this is the single-HTML version of the rule; the multi-HTML version of this rule is in nordic2015-1.opf-and-html.sch -->
            <assert test="count(//html:a[tokenize(@epub:type,'\s+')='noteref'][translate(@idref, '#', '')=current()/@id])&gt;=1">[nordic26] Each note must have at least one &lt;a epub:type="noteref"
                ...&gt; referencing it: <value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/></assert>
        </rule>
    </pattern>

    <!-- Rule 27: Each annotation must have an annoref -->
    <pattern id="epub_nordic_27">
        <rule context="html:*[tokenize(@epub:type,' ')='annotation'][ancestor::html:body[html:header]]">
            <!-- this is the single-HTML version of the rule; the multi-HTML version of this rule is in nordic2015-1.opf-and-html.sch -->
            <assert test="count(//html:a[tokenize(@epub:type,' ')='annoref'][translate(@idref, '#', '')=current()/@id])&gt;=1">[nordic27] Each annotation must have at least one &lt;a
                epub:type="annoref" ...&gt; referencing it: <value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/></assert>
        </rule>
    </pattern>

    <!-- Rule 29: No block elements in inline context -->
    <pattern id="epub_nordic_29a">
        <rule
            context="html:address | html:aside | html:blockquote | html:p | html:caption | html:div | html:dl | html:ul | html:ol | html:figure | html:table | html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6">
            <let name="inline-ancestor"
                value="ancestor::*[namespace-uri()='http://www.w3.org/1999/xhtml' and local-name()=('a','abbr','bdo','code','dfn','em','kbd','q','samp','span','strong','sub','sup')][1]"/>
            <report test="count($inline-ancestor)">[nordic29] Block element <value-of
                    select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/> used in inline context (inside the inline element
                    <value-of select="concat('&lt;',$inline-ancestor/name(),string-join(for $a in ($inline-ancestor/@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/>)</report>
        </rule>
    </pattern>

    <!-- Rule 29: No block elements in inline context - continued -->
    <pattern id="epub_nordic_29b">
        <rule
            context="html:address | html:aside | html:blockquote | html:p | html:caption | html:div | html:dl | html:ul | html:ol | html:figure | html:table | html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6 | html:section | html:article">
            <let name="inline-sibling-element"
                value="../*[namespace-uri()='http://www.w3.org/1999/xhtml' and local-name()=('a','abbr','bdo','code','dfn','em','kbd','q','samp','span','strong','sub','sup')][1]"/>
            <let name="inline-sibling-text" value="../text()[normalize-space()][1]"/>
            <report test="count($inline-sibling-element) and not((self::html:ol or self::html:ul) and parent::html:li)">[nordic29] Block element <value-of
                    select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/> as sibling to inline element <value-of
                    select="concat('&lt;',$inline-sibling-element/name(),string-join(for $a in ($inline-sibling-element/@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/></report>
            <report test="count($inline-sibling-text) and not((self::html:ol or self::html:ul) and parent::html:li)">[nordic29] Block element <value-of
                    select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/> as sibling to text content (<value-of
                    select="if (string-length(normalize-space($inline-sibling-text)) &lt; 100) then normalize-space($inline-sibling-text) else concat(substring(normalize-space($inline-sibling-text),1,100),' (...)')"
                />)</report>
        </rule>
    </pattern>

    <!-- Rule 29: No block elements in inline context - continued -->
    <pattern id="epub_nordic_29c">
        <rule
            context="html:*[tokenize(@epub:type,' ')='z3998:production'][ancestor::html:a        or ancestor::html:abbr    or ancestor::html:a[tokenize(@epub:type,' ')='annoref']   or
                                     ancestor::html:bdo      or ancestor::html:code       or ancestor::html:dfn        or ancestor::html:em        or
                                     ancestor::html:kbd      or ancestor::html:p[tokenize(@class,' ')='linenum']    or ancestor::html:a[tokenize(@epub:type,' ')='noteref']    or
                                     ancestor::html:q        or ancestor::html:samp       or ancestor::html:span[tokenize(@epub:type,' ')='z3998:sentence']       or ancestor::html:span      or
                                     ancestor::html:strong   or ancestor::html:sub        or ancestor::html:sup        or ancestor::html:span[tokenize(@epub:type,' ')='z3998:word']         or
                                     ancestor::html:address  or ancestor::html:*[tokenize(@epub:type,' ')='z3998:author' and not(parent::html:header[parent::html:body])]     or ancestor::html:p[tokenize(@epub:type,' ')='bridgehead'] or ancestor::html:*[tokenize(@class,' ')='byline']    or
                                     ancestor::html:cite     or ancestor::html:*[tokenize(@epub:type,' ')='covertitle'] or ancestor::html:*[tokenize(@class,' ')='dateline']   or ancestor::html:p[parent::html:header[parent::html:body] and tokenize(@epub:type,' ')='z3998:author'] or
                                     ancestor::html:h1[tokenize(@epub:type,' ')='fulltitle'] or ancestor::html:dt         or ancestor::html:h1         or ancestor::html:h2        or
                                     ancestor::html:h3       or ancestor::html:h4         or ancestor::html:h5         or ancestor::html:h6        or
                                     ancestor::html:p[tokenize(@class,' ')='line']       or ancestor::html:p]">
            <report
                test="descendant::html:*[self::html:address    or self::html:aside[tokenize(@epub:type,' ')='annotation'] or self::html:*[tokenize(@epub:type,' ')='z3998:author' and not(parent::html:header[parent::html:body])]   or
  	                                       self::html:blockquote or self::html:p[tokenize(@epub:type,' ')='bridgehead'] or self::html:caption  or
                                           self::html:*[tokenize(@class,' ')='dateline']   or self::html:div        or self::html:dl       or
                                           self::html:p[parent::html:header[parent::html:body] and tokenize(@epub:type,' ')='z3998:author']  or self::html:h1[tokenize(@epub:type,' ')='fulltitle']   or
                                           self::html:aside[tokenize(@epub:type,' ')='epigraph']   or self::html:p[tokenize(@class,' ')='line']     or
  	                                       self::html:*[tokenize(@class,' ')='linegroup']  or
                                           self::html:*[self::html:ul or self::html:ol]       or self::html:a[tokenize(@epub:type,' ')='note']       or self::html:p        or
                                           self::html:*[tokenize(@epub:type,' ')='z3998:poem']       or self::html:*[(self::figure or self::aside) and tokenize(@epub:type,'s')='sidebar']    or self::html:table    or
                                           self::html:*[matches(local-name(),'^h\d$') and tokenize(@class,' ')='title']]"
                >[nordic29] Prodnote in inline context used as block element: <value-of
                    select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/></report>
        </rule>
    </pattern>

    <!-- Rule 40: No page numbering gaps for pagebreak w/page-normal -->
    <pattern id="epub_nordic_40">
        <rule
            context="html:*[tokenize(@epub:type,'\s+')='pagebreak' and tokenize(@class,'\s+')='page-normal' and count(preceding::html:*[tokenize(@epub:type,'\s+')='pagebreak' and tokenize(@class,'\s+')='page-normal'])]">
            <let name="preceding-pagebreak" value="preceding::html:*[tokenize(@epub:type,'\s+')='pagebreak' and tokenize(@class,'\s+')='page-normal'][1]"/>
            <report test="number($preceding-pagebreak/@title) != number(@title)-1">[nordic40a] No gaps may occur in page numbering (see pagebreak with title="<value-of select="@title"/>" and compare
                with pagebreak with title="<value-of select="$preceding-pagebreak/@title"/>")</report>
        </rule>
    </pattern>

    <!-- Rule 50: image alt attribute -->
    <pattern id="epub_nordic_50_a">
        <rule context="html:img[parent::html:figure/tokenize(@class,'\s+')='image']">
            <report test="string(@alt)!='image'">[nordic50a] an image inside a figure with class='image' must have attribute alt="image": <value-of
                    select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/></report>
        </rule>
    </pattern>

    <pattern id="epub_nordic_50_b">
        <rule context="html:img[not(parent::html:figure/tokenize(@class,'\s+')='image')]">
            <report test="string(@alt)!=''">[nordic50b] an image which is not inside a figure with class='image' is irrelevant or redundant with regards to the understanding of the book, so the alt
                attribute must be present but empty: <value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/></report>
        </rule>
    </pattern>

    <!-- Rule 51 & 52: -->
    <pattern id="epub_nordic_5152">
        <rule context="html:img">
            <assert test="contains(@src,'.jpg') and substring-after(@src,'.jpg')=''">[nordic52] Images must have the .jpg file extension: <value-of
                    select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/></assert>
            <report test="contains(@src,'.jpg') and string-length(@src)=4">[nordic52] Images must have a base name, not just an extension: <value-of
                    select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/></report>
            <report test="not(matches(@src,'^images/[^/]+$'))">[nordic51] Images must be in the "images" folder (relative to the HTML file).</report>
            <assert test="string-length(translate(substring(@src,1,string-length(@src)-4),'-_abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/',''))=0">[nordic52] Image file name
                contains an illegal character (must be -_a-zA-Z0-9): <value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"
                /></assert>
        </rule>
    </pattern>

    <!-- Rule 59: No pagegnum between a term and a definition in definition lists -->
    <pattern id="epub_nordic_59">
        <rule context="html:dl/html:*[tokenize(@epub:type,' ')='pagebreak']">
            <assert test="not(parent::*/html:dd or parent::*/html:dt)">[nordic59] pagebreak in definition list must not occur as siblings to dd or dt: <value-of
                    select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/></assert>
        </rule>
    </pattern>

    <!-- Rule 63: Only note references within the same document -->
    <pattern id="epub_nordic_63">
        <rule context="html:a[tokenize(@epub:type,' ')='noteref']">
            <report test="matches(@href,'^[^/]+:')">[nordic63] Only note references within the same publication are allowed: <value-of
                    select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/></report>
        </rule>
    </pattern>

    <!-- Rule 64: Only annotation references within the same document -->
    <pattern id="epub_nordic_64">
        <rule context="html:a[tokenize(@epub:type,' ')='annoref']">
            <report test="matches(@href,'^[^/]+:')">[nordic64] Only annotation references within the same publication are allowed</report>
        </rule>
    </pattern>

    <!-- Rule 93: Some elements may not start of end with whitespace -->
    <pattern id="epub_nordic_93">
        <rule context="html:*[self::html:h1 or self::html:h2 or self::html:h3 or self::html:h4 or self::html:h5 or self::html:h6]">
            <report test="matches((.//text()[normalize-space()])[1],'^\s')">[nordic93] element <value-of
                    select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/> may not have leading whitespace</report>
            <report test="matches((.//text()[normalize-space()])[last()],'\s$')">[nordic93] element <value-of
                    select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/> may not have trailing whitespace</report>
        </rule>
    </pattern>

    <!-- Rule 96: no nested prodnotes or image groups -->
    <pattern id="epub_nordic_96_a">
        <rule context="html:*[tokenize(@epub:type,' ')='z3998:production']">
            <report test="ancestor::html:*[tokenize(@epub:type,' ')='z3998:production']">[nordic96a] nested production notes are not allowed: <value-of
                    select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/></report>
        </rule>
    </pattern>

    <pattern id="epub_nordic_96_b">
        <rule context="html:figure[tokenize(@class,'\s+')='image-series']">
            <report test="ancestor::html:figure[tokenize(@class,'\s+')='image-series']">[nordic96b] nested image series are not allowed (<value-of
                    select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/>). Remember that image figures use the class "image", while
                image series figures use the class "image-series". Maybe this inner figure should be using the "image" class?</report>
        </rule>
    </pattern>

    <!-- Rule 101: All image series must have at least one image figure -->
    <pattern id="epub_nordic_101">
        <rule context="html:figure[tokenize(@class,'\s+')='image-series']">
            <assert test="html:figure[tokenize(@class,'\s+')='image']">[nordic101] There must be at least one figure with class="image" in a image series figure: <value-of
                    select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/></assert>
        </rule>
    </pattern>

    <!-- Rule 102: All image figures must have a image -->
    <pattern id="epub_nordic_102">
        <rule context="html:figure[tokenize(@class,'\s+')='image']">
            <assert test="html:img">[nordic102] There must be an img element in every figure with class="image": <value-of
                    select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/></assert>
        </rule>
    </pattern>

    <!-- Rule 103: No img without imggroup -->
    <pattern id="epub_nordic_103">
        <rule context="html:img[string-length(@alt)!=0]">
            <assert test="parent::html:figure">[nordic103] There must be a figure element wrapping every img with a non-empty alt text: <value-of
                    select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/></assert>
        </rule>
    </pattern>

    <!-- Rule 104: Headings may not be empty elements -->
    <pattern id="epub_nordic_104">
        <rule context="html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6">
            <report test="normalize-space(.)=''">[nordic104] Heading <value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/>
                may not be empty</report>
        </rule>
    </pattern>

    <!-- Rule 105: Pagebreaks must have a page-* class and must not contain anything -->
    <pattern id="epub_nordic_105">
        <rule context="html:*[tokenize(@epub:type,' ')='pagebreak']">
            <assert test="tokenize(@class,'\s+')=('page-front','page-normal','page-special')">[nordic105] Page breaks must have either a 'page-front', a 'page-normal' or a 'page-special' class:
                    <value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/></assert>
            <assert test="count(*|comment())=0 and string-length(string-join(text(),''))=0">[nordic105] Pagebreaks must not contain anything<value-of
                    select="if (string-length(text())&gt;0 and normalize-space(text())='') then ' (element contains empty spaces)' else ''"/>: <value-of
                    select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/></assert>
        </rule>
    </pattern>

    <!-- Rule 110: pagebreak in headings -->
    <pattern id="epub_nordic_110">
        <rule context="html:*[tokenize(@epub:type,' ')='pagebreak']">
            <report test="ancestor::*[self::html:h1 or self::html:h2 or self::html:h3 or self::html:h4 or self::html:h5 or self::html:h6]">[nordic110] pagebreak elements are not allowed in headings:
                    <value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/></report>
        </rule>
    </pattern>

    <!-- Rule 116: Don't allow arabic numbers in pagebreak w/page-front -->
    <pattern id="epub_nordic_116">
        <rule context="html:*[tokenize(@epub:type,' ')='pagebreak']">
            <report test="tokenize(@class,' ')='page-front' and translate(.,'0123456789','xxxxxxxxxx')!=.">[nordic116] Hindu-Arabic numbers when @class="page-front" are not allowed: <value-of
                    select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/></report>
        </rule>
    </pattern>

    <!-- Rule 120:  Allow only pagebreak before hx in section/article -->
    <pattern id="epub_nordic_120">
        <rule context="html:*[self::html:h1 or self::html:h2 or self::html:h3 or self::html:h4 or self::html:h5 or self::html:h6]">
            <assert test="not(preceding-sibling::html:*) or preceding-sibling::html:*[tokenize(@epub:type,' ')='pagebreak']">[nordic120] Only pagebreaks are allowed before the heading <value-of
                    select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;',string-join(.//text(),' '),'&lt;/',name(),'&gt;')"/>.</assert>
        </rule>
    </pattern>

    <!-- Rule 121:  pagebreaks in tables must not occur between table rows -->
    <pattern id="epub_nordic_121">
        <rule context="html:*[tokenize(@epub:type,' ')='pagebreak'][ancestor::html:table]">
            <assert test="not(../html:tr)">[nordic121] Page numbers in tables must not be placed between table rows: <value-of
                    select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/></assert>
        </rule>
    </pattern>

    <!-- Rule 123 (39): Cover is not part of frontmatter, bodymatter or backmatter -->
    <pattern id="epub_nordic_123">
        <rule context="html:body | html:section | html:article">
            <report test="tokenize(@epub:type,'\s+')='cover' and tokenize(@epub:type,'\s+')=('frontmatter','bodymatter','backmatter')">[nordic123] Cover (Jacket copy) is a document partition and can
                not be part the other document partitions frontmatter, bodymatter and rearmatter: <value-of
                    select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/></report>
        </rule>
    </pattern>

    <!-- Rule 124 (106): The publication must contain pagebreaks -->
    <pattern id="epub_nordic_124">
        <rule context="html:body[html:nav]">
            <assert test="count(html:nav[tokenize(@epub:type,'\s+')='page-list']) &gt; 0">[nordic124] The publication must contain pagebreaks, and they must be referenced from a &lt;nav
                epub:type="page-list"&gt; in the navigation document. There is no such &lt;nav&gt; element in the navigation document.</assert>
            <assert test="count(html:nav[tokenize(@epub:type,'\s+')='page-list']//html:a) &gt; 0">[nordic124] The publication must contain pagebreaks, and they must be referenced from the &lt;nav
                epub:type="page-list"&gt; in the navigation document. No pagebreaks are referenced from within this &lt;nav&gt; page list.</assert>
        </rule>
    </pattern>

    <!-- Rule 125 (109): Only allow images in JPG format -->
    <pattern id="epub_nordic_125">
        <rule context="html:img">
            <assert test="string-length(@src)>=5">[nordic125] Invalid image filename: <value-of
                    select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/></assert>
            <assert test="substring(@src,string-length(@src) - 3, 4)='.jpg'">[nordic125] Images must be in JPG (*.jpg) format: <value-of
                    select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/></assert>
        </rule>
    </pattern>

    <!-- Rule 126: pagebreak must not occur directly after hx unless the hx is preceded by a pagebreak -->
    <pattern id="epub_nordic_126">
        <rule context="html:*[tokenize(@epub:type,' ')='pagebreak']">
            <report
                test="preceding-sibling::*[1][self::html:h1 or self::html:h2 or self::html:h3 or self::html:h4 or self::html:h5 or self::html:h6] and
  		                  not(preceding-sibling::*[2][self::html:*[tokenize(@epub:type,' ')='pagebreak']])"
                >[nordic126] pagebreak must not occur directly after hx unless the hx is preceded by a pagebreak: <value-of
                    select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/></report>
        </rule>
    </pattern>

    <!-- Rule 127: Table of contents list must be child of the toc sectioning element -->
    <pattern id="epub_nordic_127">
        <rule context="html:section[tokenize(@epub:type,'\s+')='toc'] | html:body[tokenize(@epub:type,'\s+')='toc']">
            <assert test="html:ol">[nordic127a] The table of contents must contain a "ol" element as a direct child of the parent <value-of select="if (self::html:body) then 'body' else 'section'"/>
                element.</assert>
            <report test="ancestor-or-self::*/tokenize(@epub:type,'\s+')=('bodymatter','cover')">[nordic127b] The table of contents must be in either frontmatter or backmatter; it is not allowed in
                bodymatter or cover.</report>
        </rule>
    </pattern>

    <!-- Rule 128: tracking metadata must exist (nordic:guidelines) -->
    <pattern id="epub_nordic_128_a">
        <rule context="html:html[//html:body/html:header]">
            <assert test="namespace-uri-for-prefix('nordic',.)='http://www.mtm.se/epub/'">[nordic128a] xmlns:nordic="http://www.mtm.se/epub/" must be defined on the root html element.</assert>
        </rule>
    </pattern>

    <pattern id="epub_nordic_128_b">
        <rule context="html:head[//html:body/html:header]">
            <assert test="count(html:meta[@name='nordic:guidelines'])=1">[nordic128b] nordic:guidelines metadata must occur once.</assert>
        </rule>
    </pattern>

    <pattern id="epub_nordic_128_c">
        <rule context="html:meta[//html:body/html:header][@name='nordic:guidelines']">
            <assert test="@content='2015-1'">[nordic128c] nordic:guidelines metadata value must be 2015-1.</assert>
        </rule>
    </pattern>

    <pattern id="epub_nordic_128_d">
        <rule context="html:head[//html:body/html:header]">
            <assert test="count(html:meta[@name='nordic:supplier'])=1">[nordic128d] nordic:supplier metadata must occur once.</assert>
        </rule>
    </pattern>

    <!-- Rule 130 (44): dc:language must equal root element xml:lang -->
    <pattern id="epub_nordic_130">
        <rule context="html:meta[@name='dc:language']">
            <assert test="@content=/html:html/@xml:lang">[nordic130] dc:language metadata must equal the root element xml:lang</assert>
        </rule>
    </pattern>

    <!-- Rule 131 (35): Allowed values in xml:lang -->
    <pattern id="epub_nordic_131">
        <rule context="*[@xml:lang]">
            <assert test="matches(@xml:lang,'^[a-z]+(-[A-Z][A-Z]+)?$')">[nordic131] xml:lang must match '^[a-z]+(-[A-Z][A-Z]+)?$' (<value-of
                    select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/>)</assert>
        </rule>
    </pattern>

    <!-- Rule 135: Poem contents -->
    <pattern id="epub_nordic_135_a">
        <rule context="html:*[tokenize(@epub:type,'\s+')='z3998:poem'] | html:*[tokenize(@epub:type,'\s+')='z3998:verse' and not(ancestor::html:*/tokenize(@epub:type,'\s+')='z3998:poem')]">
            <assert test="html:*[tokenize(@class,'\s+')='linegroup']">[nordic135] Every poem must contain a linegroup: <value-of
                    select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/></assert>
            <report test="html:p[tokenize(@class,'\s+')='line']">[nordic135] Poem lines must be wrapped in a linegroup: <value-of
                    select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/> contains; <value-of
                    select="concat('&lt;',html:p[tokenize(@class,'\s+')='line'][1]/name(),string-join(for $a in (html:p[tokenize(@class,'\s+')='line'][1]/@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"
                /></report>
        </rule>
    </pattern>

    <!-- Rule 140: Jacket copy must contain at least one part of the cover, at most one of each @class value and no other elements -->
    <pattern id="epub_nordic_140">
        <rule context="html:body[tokenize(@epub:type,'\s+')='cover'] | html:section[tokenize(@epub:type,'\s+')='cover']">
            <assert test="count(*[not(matches(local-name(),'h\d'))])=count(html:section[tokenize(@class,'\s+')=('frontcover','rearcover','leftflap','rightflap')])">[nordic140] Only sections with one
                of the classes 'frontcover', 'rearcover', 'leftflap' or 'rightflap' is allowed in cover</assert>
            <assert test="count(html:section[tokenize(@class,'\s+')=('frontcover','rearcover','leftflap','rightflap')])>=1">[nordic140] There must be at least one section with one of the classes
                'frontcover', 'rearcover', 'leftflap' or 'rightflap' in cover.</assert>
            <report test="count(html:section[tokenize(@class,'\s+')='frontcover'])>1">[nordic140] Too many sections with class="frontcover" in cover</report>
            <report test="count(html:section[tokenize(@class,'\s+')='rearcover'])>1">[nordic140] Too many sections with class="rearcover" in cover</report>
            <report test="count(html:section[tokenize(@class,'\s+')='leftflap'])>1">[nordic140] Too many sections with class="leftflap" in cover</report>
            <report test="count(html:section[tokenize(@class,'\s+')='rightflap'])>1">[nordic140] Too many sections with class="rightflap" in cover</report>
        </rule>
    </pattern>

    <!-- Rule 142: Only tokenize(@class,' ')='page-special' in level1/@class='nonstandardpagination' -->
    <pattern id="epub_nordic_142">
        <rule context="html:*[tokenize(@epub:type,' ')='pagebreak'][ancestor::html:section[@class='nonstandardpagination']]">
            <assert test="tokenize(@class,' ')='page-special'">[nordic142] The class page-special must be used in section/@class='nonstandardpagination': <value-of
                    select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/></assert>
        </rule>
    </pattern>

    <!-- Rule 143: Don't allow pagebreak as siblings to list items or inside the first list item -->
    <pattern id="epub_nordic_143_a">
        <rule context="html:*[tokenize(@epub:type,' ')='pagebreak'][parent::html:ul or parent::html:ol]">
            <report test="../html:li">[nordic143a] pagebreak is not allowed as sibling to list items: <value-of
                    select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/></report>
        </rule>
    </pattern>

    <pattern id="epub_nordic_143_b">
        <rule context="html:*[tokenize(@epub:type,' ')='pagebreak'][parent::html:li]">
            <assert test="../preceding-sibling::html:li or preceding-sibling::* or preceding-sibling::text()[normalize-space()]">[nordic143b] pagebreak is not allowed at the beginning of the first
                list item; it should be placed before the list: <value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"
                /></assert>
        </rule>
    </pattern>

    <!-- Rule 200: The title element must not be empty -->
    <pattern id="epub_nordic_200">
        <rule context="html:title">
            <assert test="text() and not(normalize-space(.)='')">[nordic200] The title element must not be empty.</assert>
        </rule>
    </pattern>

    <!-- Rule 201: cover -->
    <pattern id="epub_nordic_201">
        <rule context="html:*[tokenize(@epub:type,'\s+')='cover']">
            <assert test="not(tokenize(@epub:type,'\s+')=('frontmatter','bodymatter','backmatter'))">[nordic201] cover is not allowed in frontmatter, bodymatter or backmatter.</assert>
        </rule>
    </pattern>

    <!-- Rule 202: frontmatter -->
    <pattern id="epub_nordic_202">
        <rule context="html:*[tokenize(@epub:type,' ')='frontmatter']">
            <!-- types can be titlepage, colophon, toc, foreword, introduction or blank -->
            <assert
                test="count(tokenize(@epub:type,'\s+')) = 1 or tokenize(@epub:type,'\s+')=('titlepage','chapter','abstract','foreword','preface','prologue','introduction','preamble','conclusion','epilogue',
                'afterword','epigraph','toc','toc-brief','landmarks','loa','loi','lot','lov','appendix','colophon','credits','keywords','index','glossary','bibliography','titlepage','halftitlepage',
                'copyright-page','seriespage','acknowledgments','imprint','imprimatur','contributors','other-credits','errata','dedication','revision-history','case-study','answers','assessments','qna',
                'practices','footnotes','rearnotes')"
                >[nordic202] '<value-of select="(tokenize(@epub:type,'\s+')[not(.='frontmatter')])[1]"/>' is not an allowed type in frontmatter. On elements with the epub:type "frontmatter", you can
                either leave the type blank (and just use 'frontmatter' as the type in the filename), or you can use one of the following types: 'titlepage', 'chapter', 'abstract', 'foreword',
                'preface', 'prologue', 'introduction', 'preamble', 'conclusion', 'epilogue', 'afterword', 'epigraph', 'toc', 'toc-brief', 'landmarks', 'loa', 'loi', 'lot', 'lov', 'appendix',
                'colophon', 'credits', 'keywords', 'index', 'glossary', 'bibliography', 'titlepage', 'halftitlepage', 'copyright-page', 'seriespage', 'acknowledgments', 'imprint', 'imprimatur',
                'contributors', 'other-credits', 'errata', 'dedication', 'revision-history', 'case-study', 'answers', 'assessments', 'qna', 'practices', 'footnotes' or 'rearnotes'.</assert>
        </rule>
    </pattern>

    <!-- Rule 203: Check that both the epub:types "rearnote" and "rearnotes" are used in rearnotes -->
    <pattern id="epub_nordic_203_a">
        <rule context="html:*[ancestor::html:body[html:header] and tokenize(@epub:type,'\s+')='rearnote']">
            <assert test="ancestor::html:section[tokenize(@epub:type,'\s+')='rearnotes']">[nordic203a] 'rearnote' must have a section ancestor with 'rearnotes': <value-of
                    select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/></assert>
        </rule>
    </pattern>

    <pattern id="epub_nordic_203_b">
        <rule context="html:*[not(ancestor::html:body[html:header]) and tokenize(@epub:type,'\s+')='rearnote']">
            <assert test="ancestor::html:body[tokenize(@epub:type,'\s+')='rearnotes']">[nordic203b] 'rearnote' must have a body ancestor with 'rearnotes': <value-of
                    select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/></assert>
        </rule>
    </pattern>

    <pattern id="epub_nordic_203_c">
        <rule context="html:body[tokenize(@epub:type,'\s+')='rearnotes'] | html:section[tokenize(@epub:type,'\s+')='rearnotes']">
            <assert test="descendant::html:*[tokenize(@epub:type,'\s+')='rearnote']">[nordic203c] <value-of select="if (self::html:body) then 'documents' else 'sections'"/> with the epub:type
                'rearnotes' must have descendants with 'rearnote'.</assert>
            <assert test="html:ol">[nordic204c] <value-of select="if (self::html:body) then 'documents' else 'sections'"/> with the epub:type 'rearnotes' must have &lt;ol&gt; child elements.</assert>
        </rule>
    </pattern>

    <pattern id="epub_nordic_203_d">
        <rule context="html:*[tokenize(@epub:type,'\s+')='rearnote']">
            <assert test="self::html:li">[nordic203d] 'rearnote' can only be applied to &lt;li&gt; elements: <value-of
                    select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/></assert>
            <assert test="tokenize(@class,'\s+')='notebody'">[nordic203d] The 'notebody' class must be applied to all rearnotes: <value-of
                    select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/></assert>
        </rule>
    </pattern>

    <!-- Rule 204: Check that both the epub:types "footnote" and "footnotes" are used in rearnotes -->
    <pattern id="epub_nordic_204_a">
        <rule context="html:*[ancestor::html:body[html:header] and tokenize(@epub:type,'\s+')='footnote']">
            <assert test="count(ancestor::html:section | ancestor::html:article) = 1">[nordic204a] footnotes must be placed in a top-level section: <value-of
                    select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/></assert>
            <assert test="ancestor::html:section[tokenize(@epub:type,'\s+')='footnotes']">[nordic204a] 'footnote' must have a section ancestor with 'footnotes': <value-of
                    select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/></assert>
        </rule>
    </pattern>

    <pattern id="epub_nordic_204_b">
        <rule context="html:*[not(ancestor::html:body[html:header]) and tokenize(@epub:type,'\s+')='footnote']">
            <assert test="count(ancestor::html:section | ancestor::html:article) = 0">[nordic204b] footnotes must be placed in the body element, not in a nested section. Remember that footnotes should
                be placed in a separate file from the rest of the content: <value-of
                    select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/></assert>
            <assert test="ancestor::html:body[tokenize(@epub:type,'\s+')='footnotes']">[nordic204b] 'footnote' must have a body ancestor with 'footnotes': <value-of
                    select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/></assert>
        </rule>
    </pattern>

    <pattern id="epub_nordic_204_c">
        <rule context="html:body[tokenize(@epub:type,'\s+')='footnotes'] | html:section[tokenize(@epub:type,'\s+')='footnotes']">
            <assert test="descendant::html:*[tokenize(@epub:type,'\s+')='footnote']">[nordic204c] <value-of select="if (self::html:body) then 'documents' else 'sections'"/> with the epub:type
                'footnotes' must have descendants with 'footnote'.</assert>
            <assert test="html:ol">[nordic204c] <value-of select="if (self::html:body) then 'documents' else 'sections'"/> with the epub:type 'footnotes' must have &lt;ol&gt; child elements.</assert>
        </rule>
    </pattern>

    <pattern id="epub_nordic_204_d">
        <rule context="html:*[tokenize(@epub:type,'\s+')='footnote']">
            <assert test="self::html:li">[nordic204d] 'footnote' can only be applied to &lt;li&gt; elements: <value-of
                    select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/></assert>
            <assert test="tokenize(@class,'\s+')='notebody'">[nordic204d] The 'notebody' class must be applied to all footnotes: <value-of
                    select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/></assert>
        </rule>
    </pattern>

    <!-- Rule 208: bodymatter -->
    <pattern id="epub_nordic_208">
        <rule context="html:*[tokenize(@epub:type,' ')='bodymatter']">
            <assert
                test="tokenize(@epub:type,'\s+')=('part','chapter','abstract','foreword','preface','prologue','introduction','preamble','conclusion','epilogue','afterword','epigraph','toc',
                'toc-brief','landmarks','loa','loi','lot','lov','appendix','colophon','credits','keywords','index','glossary','bibliography','titlepage','halftitlepage','copyright-page',
                'seriespage','acknowledgments','imprint','imprimatur','contributors','other-credits','errata','dedication','revision-history','case-study','answers','assessments','qna',
                'practices','footnotes','rearnotes')"
                >[nordic208] '<value-of select="(tokenize(@epub:type,'\s+')[not(.='bodymatter')])[1]"/>' is not an allowed type in bodymatter. Elements with the type "bodymatter" must also have one of
                the types 'part', 'chapter', 'abstract', 'foreword', 'preface', 'prologue', 'introduction', 'preamble', 'conclusion', 'epilogue', 'afterword', 'epigraph', 'toc', 'toc-brief',
                'landmarks', 'loa', 'loi', 'lot', 'lov', 'appendix', 'colophon', 'credits', 'keywords', 'index', 'glossary', 'bibliography', 'titlepage', 'halftitlepage', 'copyright-page',
                'seriespage', 'acknowledgments', 'imprint', 'imprimatur', 'contributors', 'other-credits', 'errata', 'dedication', 'revision-history', 'case-study', 'answers', 'assessments', 'qna',
                'practices', 'footnotes' or 'rearnotes'.</assert>
        </rule>
    </pattern>

    <!-- Rule 211: bodymatter.part -->
    <pattern id="epub_nordic_211">
        <rule context="html:*[self::html:section or self::html:article][parent::html:section[tokenize(@epub:type,' ')=('part','volume')]]">
            <assert
                test="tokenize(@epub:type,'\s+')=('chapter','abstract','foreword','preface','prologue','introduction','preamble','conclusion','epilogue','afterword','epigraph','toc','toc-brief',
                'landmarks','loa','loi','lot','lov','appendix','colophon','credits','keywords','index','glossary','bibliography','titlepage','halftitlepage','copyright-page','seriespage',
                'acknowledgments','imprint','imprimatur','contributors','other-credits','errata','dedication','revision-history','case-study','answers','assessments','qna','practices',
                'footnotes','rearnotes')"
                >[nordic211] '<value-of select="(tokenize(@epub:type,'\s+')[not(.=('part','volume'))])[1]"/>' is not an allowed type in a part. Sections inside a part must also have one of the types
                'chapter', 'abstract', 'foreword', 'preface', 'prologue', 'introduction', 'preamble', 'conclusion', 'epilogue', 'afterword', 'epigraph', 'toc', 'toc-brief', 'landmarks', 'loa', 'loi',
                'lot', 'lov', 'appendix', 'colophon', 'credits', 'keywords', 'index', 'glossary', 'bibliography', 'titlepage', 'halftitlepage', 'copyright-page', 'seriespage', 'acknowledgments',
                'imprint', 'imprimatur', 'contributors', 'other-credits', 'errata', 'dedication', 'revision-history', 'case-study', 'answers', 'assessments', 'qna', 'practices', 'footnotes' or
                'rearnotes'.</assert>
        </rule>
    </pattern>

    <!-- Rule 215: rearmatter -->
    <pattern id="epub_nordic_215">
        <rule context="html:*[tokenize(@epub:type,'\s+')='backmatter']">
            <assert
                test="count(tokenize(@epub:type,'\s+')) = 1 or tokenize(@epub:type,'\s+')=('chapter','abstract','foreword','preface','prologue','introduction','preamble','conclusion','epilogue','afterword',
                'epigraph','toc','toc-brief','landmarks','loa','loi','lot','lov','appendix','colophon','credits','keywords','index','glossary','bibliography','titlepage','halftitlepage','copyright-page',
                'seriespage','acknowledgments','imprint','imprimatur','contributors','other-credits','errata','dedication','revision-history','case-study','answers','assessments','qna','practices',
                'footnotes','rearnotes')"
                >[nordic215] '<value-of select="(tokenize(@epub:type,'\s+')[not(.='backmatter')])[1]"/>' is not an allowed type in backmatter. On elements with the epub:type "backmatter", you can
                either leave the type blank (and just use 'backmatter' as the type in the filename), or you can use one of the following types: 'chapter', 'abstract', 'foreword', 'preface',
                'prologue', 'introduction', 'preamble', 'conclusion', 'epilogue', 'afterword', 'epigraph', 'toc', 'toc-brief', 'landmarks', 'loa', 'loi', 'lot', 'lov', 'appendix', 'colophon',
                'credits', 'keywords', 'index', 'glossary', 'bibliography', 'titlepage', 'halftitlepage', 'copyright-page', 'seriespage', 'acknowledgments', 'imprint', 'imprimatur', 'contributors',
                'other-credits', 'errata', 'dedication', 'revision-history', 'case-study', 'answers', 'assessments', 'qna', 'practices', 'footnotes' or 'rearnotes'.</assert>
        </rule>
    </pattern>

    <!-- Rule 224: linenum - span -->
    <pattern id="epub_nordic_224">
        <rule context="html:span[tokenize(@class,' ')='linenum']">
            <assert test="ancestor::html:p[tokenize(@class,' ')='line']">[nordic224] linenums (span class="linenum") must be part of a line (p class="line"): <value-of
                    select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;',string-join(.//text()[normalize-space()],' '),'&lt;/',name(),'&gt;')"
                /></assert>
        </rule>
    </pattern>

    <!-- Rule 225: pagebreak -->
    <pattern id="epub_nordic_225">
        <rule context="html:*[tokenize(@epub:type,' ')='pagebreak' and text()]">
            <assert test="matches(@title,'.+')">[nordic225] The title attribute must be used to describe the page number: <value-of
                    select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;',string-join(.//text()[normalize-space()],' '),'&lt;/',name(),'&gt;')"
                /></assert>
        </rule>
    </pattern>

    <!-- Rule 247: doctitle.headline - h1 -->
    <pattern id="epub_nordic_247">
        <rule context="html:body/html:header/html:h1">
            <assert test="tokenize(@epub:type,' ')='fulltitle'">[nordic247] The first headline in the html:body/html:header element must have the 'fulltitle' epub:type.</assert>
        </rule>
    </pattern>

    <!-- Rule 248: docauthor - p -->
    <pattern id="epub_nordic_248">
        <rule context="html:body/html:header/html:*[not(self::html:h1)]">
            <assert test="self::html:p">[nordic248] The only allowed element inside html/header besides "h1" is "p".</assert>
            <!--<assert test="tokenize(@epub:type,' ')=('z3998:author','covertitle')">[nordic248] Inside body/header; all p elements must have a epub:type and they must be either 'z3998:author' or
                'covertitle'.</assert>-->
        </rule>
    </pattern>

    <!-- Rule 251: lic - span -->
    <pattern id="epub_nordic_251">
        <rule context="html:span[tokenize(@class,' ')='lic']">
            <assert test="parent::html:li or parent::html:a/parent::html:li">[nordic251] The parent of a list item component (span class="lic") must be either a "li" or a "a" (where the "a" has "li"
                as parent): <value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/></assert>
        </rule>
    </pattern>

    <!-- Rule 253: figures and captions -->
    <pattern id="epub_nordic_253_a">
        <rule context="html:figure">
            <assert test="tokenize(@epub:type,'\s+')='sidebar' or tokenize(@class,'\s+')=('image','image-series')">[nordic253a] &lt;figure&gt; elements must either have an epub:type of "sidebar" or a
                class of "image" or "image-series": <value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/></assert>
            <report test="count((.[tokenize(@epub:type,'\s+')='sidebar'], .[tokenize(@class,'\s+')='image'], .[tokenize(@class,'\s+')='image-series'])) &gt; 1">[nordic253a] &lt;figure&gt; elements
                must either have an epub:type of "sidebar" or a class of "image" or "image-series": <value-of
                    select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/></report>
            <assert test="count(html:figcaption) &lt;= 1">[nordic253a] There cannot be more than one &lt;figcaption&gt; in a single figure element: <value-of
                    select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/></assert>
        </rule>
    </pattern>

    <pattern id="epub_nordic_253_b">
        <rule context="html:figure[tokenize(@class,'\s+')='image']">
            <assert test="count(.//html:img) = 1">[nordic253b] Image figures must contain exactly one img: <value-of
                    select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/></assert>
            <assert test="count(html:img) = 1">[nordic253b] The img in image figures must be a direct child of the figure: <value-of
                    select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/></assert>
        </rule>
    </pattern>

    <pattern id="epub_nordic_253_c">
        <rule context="html:figure[tokenize(@class,'\s+')='image-series']">
            <assert test="count(html:img) = 0">[nordic253c] Image series figures cannot contain img childen (the img elements must be contained in children figure elements): <value-of
                    select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/></assert>
            <assert test="count(html:figure[tokenize(@class,'\s+')='image']) &gt;= 2">[nordic253c] Image series must contain at least 2 image figures ("figure" elements with class "image"): <value-of
                    select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/></assert>
        </rule>
    </pattern>

    <!-- Rule 254: aside types -->
    <pattern id="epub_nordic_254">
        <rule context="html:aside">
            <assert test="tokenize(@epub:type,' ') = ('z3998:production','sidebar','note','annotation','epigraph')">[nordic254] &lt;aside&gt; elements must use one of the following epub:types:
                z3998:production, sidebar, note, annotation, epigraph (<value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"
                />)</assert>
        </rule>
    </pattern>

    <!-- Rule 255: abbr types -->
    <pattern id="epub_nordic_255">
        <rule context="html:abbr">
            <assert test="tokenize(@epub:type,' ') = ('z3998:acronym','z3998:initialism','z3998:truncation')">[nordic255] "abbr" elements must use one of the following epub:types: z3998:acronym
                (formed from the first part of a word: "Mr.", "approx.", "lbs.", "rec'd"), z3998:initialism (each letter pronounced separately: "XML", "US"), z3998:truncation (pronounced as a word:
                "NATO"): <value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/></assert>
        </rule>
    </pattern>

    <!-- Rule 256: HTML documents with only a headline -->
    <pattern id="epub_nordic_256">
        <rule
            context="html:body[ancestor-or-self::*/tokenize(@epub:type,'\s+') = 'bodymatter' and count(* except (html:h1 | *[tokenize(@epub:type,'\s+')='pagebreak'])) = 0] | html:section[ancestor-or-self::*/tokenize(@epub:type,'\s+') = 'bodymatter' and count(* except (html:h1 | *[tokenize(@epub:type,'\s+')='pagebreak'])) = 0]">
            <assert test="tokenize(@epub:type,'\s+') = 'part'">[nordic256] In bodymatter, "<name/>" elements must contain more than just a headline and pagebreaks (except when epub:type="part"):
                    <value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/></assert>
        </rule>
    </pattern>

    <!-- Rule 257: always require both xml:lang and lang -->
    <pattern id="epub_nordic_257">
        <rule context="*[@xml:lang or @lang]">
            <assert test="@xml:lang = @lang">[nordic257] The `xml:lang` and the `lang` attributes must have the same value: <value-of
                    select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/></assert>
        </rule>
    </pattern>

    <!-- Rule 258: allow at most one pagebreak before any content in each content file -->
    <pattern id="epub_nordic_258">
        <rule context="html:div[../html:body and tokenize(@epub:type,'\s')='pagebreak']">
            <report test="preceding-sibling::html:div[tokenize(@epub:type,'\s')='pagebreak']">[nordic258] Only one pagebreak is allowed before any content in each content file: <value-of
                    select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/></report>
        </rule>
    </pattern>

    <!-- Rule 259: don't allow pagebreak in thead -->
    <pattern id="epub_nordic_259">
        <rule context=".[tokenize(@epub:type,'\s+')='pagebreak']">
            <report test="ancestor::html:thead">[nordic259] Pagebreaks can not occur within table headers (thead): <value-of
                    select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/></report>
            <report test="ancestor::html:tfoot">[nordic259] Pagebreaks can not occur within table footers (tfoot): <value-of
                    select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/></report>
        </rule>
    </pattern>

    <!-- Rule 260: img must be first in image figure, and non-image content must be placed first in image-series -->
    <pattern id="epub_nordic_260_a">
        <rule context="html:figure[tokenize(@class,'\s+')='image']">
            <assert test="html:img intersect *[1]">[nordic260a] The first element in a figure with class="image" must be a "img" element: <value-of
                    select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/></assert>
        </rule>
    </pattern>

    <pattern id="epub_nordic_260_b">
        <rule context="html:figure[tokenize(@class,'\s+')='image-series']/html:*[not(self::html:figure[tokenize(@class,'\s+')='image'])]">
            <report test="preceding-sibling::html:figure[tokenize(@class,'\s+')='image']">[nordic260b] Content not allowed between or after image figure elements: <value-of
                    select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/></report>
        </rule>
    </pattern>

    <!-- Rule 261: Text can't be direct child of div -->
    <pattern id="epub_nordic_261">
        <rule context="html:div">
            <report test="text()[normalize-space(.)]">[nordic261] Text can't be placed directly inside div elements. Try wrapping it in a p element: <value-of
                    select="normalize-space(string-join(text(),' '))"/></report>
        </rule>
    </pattern>

    <!-- Rule 263: there must be a headline on the titlepage -->
    <pattern id="epub_nordic_263">
        <rule context="html:body[tokenize(@epub:type,'\s+')='titlepage'] | html:section[tokenize(@epub:type,'\s+')='titlepage']">
            <assert test="count(html:*[matches(local-name(),'h\d')])">[nordic263] the titlepage must have a headline (and the headline must have epub:type="fulltitle" and class="title")</assert>
        </rule>
    </pattern>

    <!-- Rule 264: h1 on titlepage must be epub:type=fulltitle with class=title -->
    <pattern id="epub_nordic_264">
        <rule context="html:body[tokenize(@epub:type,'\s+')='titlepage']/html:*[matches(local-name(),'h\d')] | html:section[tokenize(@epub:type,'\s+')='titlepage']/html:*[matches(local-name(),'h\d')]">
            <assert test="tokenize(@epub:type,'\s+') = 'fulltitle'">[nordic264] the headline on the titlepage must have a epub:type with the value "fulltitle": <value-of
                    select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/></assert>
            <assert test="tokenize(@class,'\s+') = 'title'">[nordic264] the headline on the titlepage must have a class with the value "title": <value-of
                    select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/></assert>
        </rule>
    </pattern>

    <pattern id="epub_nordic_265">
        <rule context="html:*[tokenize(@class,'\s+')='linegroup']">
            <report test="count(html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6) &gt; 0 and not(self::html:section)">[nordic265] linegroups with headlines must be section elements: <value-of
                    select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/></report>
            <report test="count(html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6)   =  0 and not(self::html:div)">[nordic265] linegroups without headlines must be div elements: <value-of
                    select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/></report>
        </rule>
    </pattern>

    <pattern id="epub_nordic_266_a">
        <rule context="html:*[*[tokenize(@epub:type,'\s+')='footnote']]">
            <assert test="self::html:ol">[nordic266a] Footnotes must be wrapped in a "ol" element, but is currently wrapped in a <name/>: <value-of
                    select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/></assert>
        </rule>
    </pattern>

    <pattern id="epub_nordic_266_b">
        <rule context="html:section[tokenize(@epub:type,'\s+')='footnotes']/html:ol/html:li | html:body[tokenize(@epub:type,'\s+')='footnotes']/html:ol/html:li">
            <assert test="tokenize(@epub:type,'\s+')='footnote'">[nordic266b] List items inside a footnotes list must use epub:type="footnote": <value-of
                    select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/></assert>
        </rule>
    </pattern>

    <pattern id="epub_nordic_267_a">
        <rule context="html:*[*[tokenize(@epub:type,'\s+')='rearnote']]">
            <assert test="self::html:ol">[nordic267a] Rearnotes must be wrapped in a "ol" element, but is currently wrapped in a <name/>: <value-of
                    select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/></assert>
        </rule>
    </pattern>

    <pattern id="epub_nordic_267_b">
        <rule context="html:section[tokenize(@epub:type,'\s+')='rearnotes']/html:ol/html:li | html:body[tokenize(@epub:type,'\s+')='rearnotes']/html:ol/html:li">
            <assert test="tokenize(@epub:type,'\s+')='rearnote'">[nordic267b] List items inside a rearnotes list must use epub:type="rearnote": <value-of
                    select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/></assert>
        </rule>
    </pattern>

    <!-- Rule 268: Check that the heading levels are nested correctly (necessary for sidebars and poems, and maybe other structures as well where the RelaxNG is unable to enforce the level) -->
    <pattern id="epub_nordic_268">
        <rule context="html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6">
            <let name="sectioning-element" value="ancestor::*[self::html:section or self::html:article or self::html:aside or self::html:nav or self::html:body][1]"/>
            <let name="this-level" value="xs:integer(replace(name(),'.*(\d)$','$1')) + (if (ancestor::html:header[parent::html:body]) then -1 else 0)"/>
            <let name="child-sectioning-elements"
                value="$sectioning-element//*[self::html:section or self::html:article or self::html:aside or self::html:nav or self::html:figure][ancestor::*[self::html:section or self::html:article or self::html:aside or self::html:nav or self::html:body][1] intersect $sectioning-element]"/>
            <let name="child-sectioning-element-with-wrong-level"
                value="$child-sectioning-elements[count(html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6) != 0 and (html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6)/xs:integer(replace(name(),'.*(\d)$','$1')) != min((6, $this-level + 1))][1]"/>
            <assert test="count($child-sectioning-element-with-wrong-level) = 0">[nordic268] The subsections of <value-of
                    select="concat('&lt;',$sectioning-element/name(),string-join(for $a in ($sectioning-element/@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/> (which contains
                the headline <value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"/><value-of
                    select="string-join(.//text(),' ')"/>&lt;/<name/>&gt;) must only use &lt;h<value-of select="min((6, $this-level + 1))"/>&gt; for headlines. It contains the element <value-of
                    select="concat('&lt;',$child-sectioning-element-with-wrong-level/name(),string-join(for $a in ($child-sectioning-element-with-wrong-level/@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;')"
                /> which contains the headline <value-of
                    select="concat('&lt;',$child-sectioning-element-with-wrong-level/(html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6)[1]/name(),string-join(for $a in ($child-sectioning-element-with-wrong-level/(html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6)[1]/@*) return concat(' ',$a/name(),'=&quot;',$a,'&quot;'),''),'&gt;',string-join($child-sectioning-element-with-wrong-level/(html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6)[1]//text(),' '),'&lt;/',$child-sectioning-element-with-wrong-level/(html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6)[1]/name(),'&gt;')"
                />
            </assert>
        </rule>
    </pattern>

</schema>
