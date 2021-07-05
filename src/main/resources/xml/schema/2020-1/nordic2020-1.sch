<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2" xml:lang="en">
    <title>Nordic EPUB3 and HTML5 rules (based on MTMs DTBook schematron rules, targeting nordic guidelines 2020-1)</title>

    <ns prefix="html" uri="http://www.w3.org/1999/xhtml"/>
    <ns prefix="epub" uri="http://www.idpf.org/2007/ops"/>
    <ns prefix="nordic" uri="http://www.mtm.se/epub/"/>
    <ns prefix="a11y" uri="http://www.idpf.org/epub/vocab/package/a11y/#"/>
    <ns prefix="m" uri="http://www.w3.org/1998/Math/MathML"/>
    <ns prefix="msv" uri="http://www.idpf.org/epub/vocab/structure/magazine/#"/>
    <ns prefix="prism" uri="http://www.prismstandard.org/specifications/3.0/PRISM_CV_Spec_3.0.htm#"/>

    <pattern id="epub_nordic_8">
        <title>Rule 8</title>
        <p>Only allow pagebreak w/page-front in frontmatter</p>
        <rule context="html:*[tokenize(@epub:type, '\s+') = 'pagebreak' and tokenize(@class, '\s+') = 'page-front']">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <assert test="ancestor::html:*[self::html:section or self::html:article or self::html:body]/tokenize(@epub:type, '\s+') = ('frontmatter', 'cover')"
                >[nordic08] &lt;span epub:type="pagebreak" class="page-front"/&gt; may only occur in frontmatter and cover. <value-of select="$context"/></assert>
        </rule>
    </pattern>

    <pattern id="epub_nordic_9">
        <title>Rule 9</title>
        <p>Disallow empty elements (with a few exceptions)</p>
        <rule context="html:*">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <report test="normalize-space(.) = '' and not(*) and not(self::html:img or self::html:br or self::html:meta or self::html:link or self::html:col or self::html:th or self::html:td or self::html:dd or self::html:*[tokenize(@epub:type, '\s+') = 'pagebreak'] or self::html:hr or self::html:script)">[nordic09] Only the following elements can be empty: img, br, meta, link, col, th, td, dd, hr, script, and pagebreaks (span/div). <value-of select="$context"/></report>
        </rule>
    </pattern>

    <pattern id="epub_nordic_11">
        <title>Rule 11</title>
        <p>Root element must have @xml:lang and @lang</p>
        <rule context="html:html">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <assert test="@xml:lang">[nordic11] The &lt;html&gt; element must have an xml:lang attribute.</assert>
            <assert test="@lang">[nordic11] The &lt;html&gt; element must have a lang attribute.</assert>
        </rule>
    </pattern>

    <pattern id="epub_nordic_12">
        <title>Rule 12</title>
        <p>Frontmatter starts with doctitle and docauthor</p>
        <rule context="html:body/html:header">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <assert test="html:*[1][self::html:h1[tokenize(@epub:type, '\s+') = 'fulltitle']]">[nordic12] Single-HTML document must begin with a fulltitle heading in its header element (xpath:
                /html/body/header/h1).</assert>
        </rule>
    </pattern>

    <pattern id="epub_nordic_13_a">
        <!--TO DO: check if title/p is relevant to all "rule 13" patterns-->
        <title>Rule 13</title>
        <p>All books must have frontmatter and bodymatter</p>
        <!-- see also nordic2015-1.opf-and-html.sch for multi-document version -->
        <rule context="html:body[html:header]">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <assert test="((html:section | html:article)/tokenize(@epub:type, '\s+') = ('cover', 'frontmatter')) = true()">[nordic13a] A single-HTML document must have at least one frontmatter or cover section.</assert>
            <assert test="((html:section | html:article)/tokenize(@epub:type, '\s+') = 'bodymatter') = true()">[nordic13a] A single-HTML document must have at least one bodymatter section.</assert>
            <assert test="not(tokenize(@epub:type, '\s+') = ('cover', 'frontmatter', 'bodymatter', 'backmatter'))">[nordic13a] The single-HTML document must not have cover, frontmatter, bodymatter or backmatter as epub:type on its body element.</assert>
        </rule>
    </pattern>

    <pattern id="epub_nordic_13_b">
        <title>Rule 13b</title>
        <p></p>
        <rule context="html:*[self::html:section or self::html:article][ancestor::html:body[html:header] and not(parent::html:body) and not(parent::html:section[tokenize(@epub:type, '\s+') = 'part'])]">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <assert test="not((tokenize(@epub:type, '\s+') = ('cover', 'frontmatter', 'bodymatter', 'backmatter')) = true())">[nordic13b] The single-HTML document must not have cover, frontmatter, bodymatter or backmatter on any of its sectioning elements other than the top-level elements that has body as its parent.</assert>
        </rule>
    </pattern>

    <pattern id="epub_nordic_13_c">
        <title>Rule 13c</title>
        <p></p>
        <rule context="html:body/html:section">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <assert test="tokenize(@epub:type, '\s+') = ('cover', 'frontmatter', 'bodymatter', 'backmatter')"
                >[nordic13c] The top-level section element must have either cover, frontmatter, bodymatter or backmatter as one of the values on its epub:type. <value-of select="$context"/></assert>
        </rule>
    </pattern>

    <pattern id="epub_nordic_13_d">
        <title>Rule 13d</title>
        <p></p>
        <rule context="html:section[not(parent::html:body)]">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <report test="not(parent::html:section[tokenize(@epub:type, '\s+') = 'part']) and tokenize(@epub:type, '\s+') = ('cover', 'frontmatter', 'bodymatter', 'backmatter')"
                >[nordic13d] Section elements that are not top-level sections must not have cover, frontmatter, bodymatter or backmatter as one of the values on its epub:type attribute. It is allowed (but optional) to use the bodymatter type on section elements that are direct children of sections with epub:type="part"). <value-of select="$context"/></report>
            <report test="parent::html:section[tokenize(@epub:type, '\s+') = 'part'] and tokenize(@epub:type, '\s+') = ('cover', 'frontmatter', 'backmatter')"
                >[nordic13d] Section elements in parts must not have cover, frontmatter or backmatter as one of the values on its epub:type attribute. <value-of select="$context"/></report>
        </rule>
    </pattern>

    <pattern id="epub_nordic_13_e">
        <title>Rule 13e</title>
        <p>The body element must not have a epub:type attribute.</p>
        <rule context="html:body">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <assert test="not(@epub:type)">[nordic13e] The body element must not have a epub:type attribute.</assert>
        </rule>
    </pattern>

    <pattern id="epub_nordic_15">
        <title>Rule 15</title>
        <p></p>
        <!-- see also nordic2015-1.opf-and-html.sch for multi-document version -->
        <rule context="html:body[html:header]/html:*[self::html:section or self::html:article]">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <report test="tokenize(@epub:type, '\s+')[. = 'cover'] and preceding-sibling::html:*[self::html:section or self::html:article]">[nordic15] Cover must not be preceded by any other top-level sections. <value-of select="$context"/></report>
            <report test="tokenize(@epub:type, '\s+')[. = 'frontmatter'] and preceding-sibling::html:*[self::html:section or self::html:article]/tokenize(@epub:type, '\s') = ('bodymatter', 'backmatter')">[nordic15] Frontmatter must not be preceded by bodymatter or rearmatter. <value-of select="$context"/></report>
            <report test="tokenize(@epub:type, '\s+')[. = 'frontmatter'] and preceding-sibling::html:*[self::html:section or self::html:article]/tokenize(@epub:type, '\s') = ('backmatter')">[nordic15] Bodymatter must not be preceded by backmatter. <value-of select="$context"/></report>
        </rule>
    </pattern>

    <pattern id="epub_nordic_21">
        <title>Rule 21</title>
        <p>No nested tables</p>
        <rule context="html:table">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <report test="ancestor::html:table">[nordic21] Nested tables are not allowed. <value-of select="$context"/></report>
        </rule>
    </pattern>

    <pattern id="epub_nordic_23">
        <title>Rule 23</title>
        <p>Increasing pagebreak values for page-normal</p>
        <rule context="html:*[tokenize(@epub:type, '\s+') = 'pagebreak' and tokenize(@class, '\s+') = 'page-normal' and preceding::html:*[tokenize(@epub:type, '\s+') = 'pagebreak'][tokenize(@class, '\s+') = 'page-normal']]">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <let name="preceding" value="preceding::html:*[tokenize(@epub:type, '\s+') = 'pagebreak' and tokenize(@class, '\s+') = 'page-normal'][1]"/>
            <assert test="number(current()/@aria-label) &gt; number($preceding/@aria-label)">[nordic23] pagebreak values must increase for pagebreaks with class="page-normal". <value-of select="concat('(see pagebreak with aria-label=&quot;', @aria-label, '&quot; and compare with pagebreak with aria-label=&quot;', $preceding/@aria-label, '&quot;)')"/> <value-of select="$context"/></assert>
        </rule>
    </pattern>

    <pattern id="epub_nordic_24">
        <title>Rule 24</title>
        <p>Values of pagebreak must be unique for page-front</p>
        <rule context="html:*[tokenize(@epub:type, '\s+') = 'pagebreak'][tokenize(@class, '\s+') = 'page-front']">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <assert test="count(//html:*[tokenize(@epub:type, '\s+') = 'pagebreak' and tokenize(@class, '\s+') = 'page-front' and @aria-label = current()/@aria-label]) = 1">[nordic24] pagebreak values must be unique for pagebreaks with class="page-front". <value-of select="concat('(see pagebreak with aria-label=&quot;', @aria-label, '&quot;)')"/> <value-of select="$context"/></assert>
        </rule>
    </pattern>

    <pattern id="epub_nordic_26_a">
        <title>Rule 26a</title>
        <p>Each note must have a noteref</p>
        <rule context="html:*[ancestor::html:body[html:header] and tokenize(@epub:type, '\s+') = ('note', 'endnote', 'footnote')]">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <!-- this is the single-HTML version of the rule; the multi-HTML version of this rule is in nordic2015-1.opf-and-html.sch -->
            <assert test="count(//html:a[tokenize(@epub:type, '\s+') = 'noteref'][substring-after(@href, '#') = current()/@id]) &gt;= 1">[nordic26a] Each note must have at least one &lt;a epub:type="noteref"
                ...&gt; referencing it. <value-of select="$context"/></assert>
        </rule>
    </pattern>

    <pattern id="epub_nordic_26_b">
        <title>Rule 26b</title>
        <p>Each noteref must reference a note</p>
        <rule context="html:a[ancestor::html:body[html:header] and tokenize(@epub:type, '\s+') = 'noteref']">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <!-- this is the single-HTML version of the rule; the multi-HTML version of this rule is in nordic2015-1.opf-and-html.sch -->
            <assert test="count(//html:*[tokenize(@epub:type, '\s+') = ('note', 'endnote', 'footnote') and @id = current()/substring-after(@href, '#')]) &gt;= 1">[nordic26b] The note reference must point to a note, endnote or footnote in the publication using its href attribute. <value-of select="$context"/></assert>
        </rule>
    </pattern>

    <!-- Rule 27a:  -->
    <pattern id="epub_nordic_27_a">
        <title>Rule 27a</title>
        <p>Each annotation must have an annoref</p>
        <rule context="html:*[ancestor::html:body[html:header] and tokenize(@epub:type, '\s+') = 'annotation']">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <!-- this is the single-HTML version of the rule; the multi-HTML version of this rule is in nordic2015-1.opf-and-html.sch -->
            <assert test="count(//html:a[tokenize(@epub:type, '\s+') = 'annoref'][substring-after(@href, '#') = current()/@id]) &gt;= 1">[nordic27a] Each annotation must have at least one &lt;a epub:type="annoref" ...&gt; referencing it. <value-of select="$context"/></assert>
        </rule>
    </pattern>

    <pattern id="epub_nordic_27_b">
        <title>Rule 27b</title>
        <p>Each annoref must reference a annotation</p>
        <rule context="html:a[ancestor::html:body[html:header] and tokenize(@epub:type, '\s+') = 'annoref']">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <!-- this is the single-HTML version of the rule; the multi-HTML version of this rule is in nordic2015-1.opf-and-html.sch -->
            <assert test="count(//html:*[tokenize(@epub:type, '\s+') = ('annotation') and @id = current()/substring-after(@href, '#')]) &gt;= 1">[nordic27b] The annotation must point to a annotation in the publication using its href attribute. <value-of select="$context"/></assert>
        </rule>
    </pattern>

    <pattern id="epub_nordic_29a">
        <title>Rule 29a</title>
        <p>No block elements in inline context (as child). Inline elements: a, abbr, bdo, code, dfn, em, kbd, q, samp, span, strong, sub, sup. Block elements: address, aside, blockquote, p, caption, div, dl, ul, ol, figure, table, h1, h2, h3, h4, h5, h6.</p>
        <rule context="html:address | html:aside | html:blockquote | html:p | html:caption | html:div | html:dl | html:ul | html:ol | html:figure | html:table | html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <let name="inline-ancestor" value="ancestor::*[namespace-uri() = 'http://www.w3.org/1999/xhtml' and local-name() = ('a', 'abbr', 'bdo', 'code', 'dfn', 'em', 'kbd', 'q', 'samp', 'span', 'strong', 'sub', 'sup')][1]"/>
            <report test="count($inline-ancestor)">[nordic29] Block element <value-of select="$context"/> used in inline context. <value-of select="concat(
                '(inside the inline element &lt;', $inline-ancestor/name(),
                                                   string-join(for $a in ($inline-ancestor/@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''),
                                                   '&gt;)')"/></report>
        </rule>
    </pattern>

    <pattern id="epub_nordic_29b">
        <title>Rule 29b</title>
        <p>No block elements in inline context (as sibling). Inline elements: a, abbr, bdo, code, dfn, em, kbd, q, samp, span, strong, sub, sup. Block elements: address, aside, blockquote, p, caption, div, dl, ul, ol, figure, table, h1, h2, h3, h4, h5, h6, section, article.</p>
        <rule context="html:address | html:aside | html:blockquote | html:p | html:caption | html:div | html:dl | html:ul | html:ol | html:figure | html:table | html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6 | html:section | html:article">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <let name="inline-sibling-element" value="../*[namespace-uri() = 'http://www.w3.org/1999/xhtml' and local-name() = ('a', 'abbr', 'bdo', 'code', 'dfn', 'em', 'kbd', 'q', 'samp', 'span', 'strong', 'sub', 'sup')][1]"/>
            <let name="inline-sibling-text" value="../text()[normalize-space()][1]"/>
            <report test="count($inline-sibling-element) and not((self::html:ol or self::html:ul) and parent::html:li)">[nordic29] Block elements <value-of select="$context"/> are not allowed as siblings to inline elements. <value-of select="
                    concat('(&lt;', $inline-sibling-element/name(),
                                    string-join(for $a in ($inline-sibling-element/@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''),
                                    '&gt;')"/></report>
            <report test="count($inline-sibling-text) and not((self::html:ol or self::html:ul) and parent::html:li)">[nordic29] Block elements <value-of select="$context"/> are not allowed as siblings to text content. <value-of select="
                concat('(',
                    if (string-length(normalize-space($inline-sibling-text)) &lt; 100) then
                        normalize-space($inline-sibling-text)
                    else
                        concat(substring(normalize-space($inline-sibling-text), 1, 100), ' (...)'),
                ')')"/></report>
        </rule>
    </pattern>

    <pattern id="epub_nordic_50_a">
        <title>Rule 50a</title>
        <p>image alt attribute</p>
        <rule context="html:img[parent::html:figure/tokenize(@class, '\s+') = 'image']">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <assert test="@alt and @alt != ''">[nordic50a] an image inside a figure with class='image' must have a non-empty alt attribute. <value-of select="$context"/></assert>
        </rule>
    </pattern>

    <pattern id="epub_nordic_5152">
        <title>Rule 51 &amp; 52</title>
        <p></p>
        <rule context="html:img">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <assert test="substring(@src, string-length(@src) - 2) = ('jpg', 'png')">[nordic52] Images must have either the .jpg file extension or the .png file extension. <value-of select="$context"/></assert>
            <report test="substring(@src, string-length(@src) - 2) = ('jpg', 'png') and string-length(@src) = 4">[nordic52] Images must have a base name, not just an extension. <value-of select="$context"/></report>
            <report test="not(matches(@src, '^images/[^/]+$'))">[nordic51] Images must be in the "images" folder (relative to the HTML file).</report>
            <assert test="string-length(translate(substring(@src, 1, string-length(@src) - 4), '-_abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/', '')) = 0">[nordic52] Image file names can only contain the characters a-z, A-Z, 0-9, underscore (_) or hyphen (-). <value-of select="$context"/></assert>
        </rule>
    </pattern>

    <pattern id="epub_nordic_59">
        <title>Rule 59</title>
        <p>No pagegnum between a term and a definition in definition lists</p>
        <rule context="html:dl/html:*[tokenize(@epub:type, '\s+') = 'pagebreak']">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <assert test="not(parent::*/html:dd or parent::*/html:dt)">[nordic59] pagebreak in definition list must not occur as siblings to dd or dt. <value-of select="$context"/></assert>
        </rule>
    </pattern>

    <pattern id="epub_nordic_63">
        <title>Rule 63</title>
        <p>Only note references within the same document</p>
        <rule context="html:a[tokenize(@epub:type, '\s+') = 'noteref']">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <report test="matches(@href, '^[^/]+:')">[nordic63] Only note references within the same publication are allowed. <value-of select="$context"/></report>
        </rule>
    </pattern>

    <pattern id="epub_nordic_64">
        <title>Rule 64</title>
        <p>Only annotation references within the same document</p>
        <rule context="html:a[tokenize(@epub:type, '\s+') = 'annoref']">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <report test="matches(@href, '^[^/]+:')">[nordic64] Only annotation references within the same publication are allowed.</report>
        </rule>
    </pattern>

    <pattern id="epub_nordic_93">
        <title>Rule 93</title>
        <p>Some elements may not start of end with whitespace</p>
        <rule context="html:*[self::html:h1 or self::html:h2 or self::html:h3 or self::html:h4 or self::html:h5 or self::html:h6]">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <report test="matches((.//text()[normalize-space()])[1], '^\s')">[nordic93] Headings (h1-h6) may not have leading whitespace. <value-of select="$context"/></report>
            <report test="matches((.//text()[normalize-space()])[last()], '\s$')">[nordic93] Headings (h1-h6) may not have trailing whitespace. <value-of select="$context"/></report>
        </rule>
    </pattern>

    <!-- TODO: Depending on https://github.com/nlbdev/epub3-guidelines-update/issues/98 -->
    <pattern id="epub_nordic_96_b">
        <title>Rule 96b</title>
        <p></p>
        <rule context="html:figure[tokenize(@class, '\s+') = 'image-series']">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <report test="ancestor::html:figure[tokenize(@class, '\s+') = 'image-series']">[nordic96b] Nested image series figures are not allowed. Image figures must use the class "image", while image series figures must use the class "image-series". <value-of select="$context"/></report>
        </rule>
    </pattern>

    <pattern id="epub_nordic_96_c">
        <title>Rule 96a</title>
        <p>No fig-desc allowed for doc-cover</p>
        <rule context="html:figure[html:img[tokenize(@role, '\s+') = 'doc-cover']]">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <report test="html:aside[tokenize(@class, '\s+') = 'fig-desc']">[nordic96c] Aside elements with class="fig-desc" are not allowed in figure elements containing an img with role="doc-cover". <value-of select="$context"/></report>
        </rule>
    </pattern>

    <!-- TODO: Depending on https://github.com/nlbdev/epub3-guidelines-update/issues/98 -->
    <pattern id="epub_nordic_101">
        <title>Rule 101</title>
        <p>All image series must have at least one image figure</p>
        <rule context="html:figure[tokenize(@class, '\s+') = 'image-series']">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <assert test="html:figure[tokenize(@class, '\s+') = 'image']">[nordic101] There must be at least one figure with class="image" in a image series figure. <value-of select="$context"/></assert>
        </rule>
    </pattern>

    <!-- TODO: Depending on https://github.com/nlbdev/epub3-guidelines-update/issues/98 -->
    <pattern id="epub_nordic_102">
        <title>Rule 102</title>
        <p>All image figures must have a image</p>
        <rule context="html:figure[tokenize(@class, '\s+') = 'image']">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <assert test="html:img">[nordic102] There must be an img element in every figure with class="image". <value-of select="$context"/></assert>
            <report test="parent::html:figure[tokenize(@class, '\s+') = 'image']">[nordic102] Nested images figures are not allowed. Image figures must use the class "image", while image series figures must use the class "image-series". <value-of select="$context"/></report>
        </rule>
    </pattern>

    <pattern id="epub_nordic_104">
        <title>Rule 104</title>
        <p>Headings may not be empty elements</p>
        <rule context="html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <report test="normalize-space(.) = ''">[nordic104] Headings may not be empty. <value-of select="$context"/></report>
        </rule>
    </pattern>

    <pattern id="epub_nordic_105">
        <title>Rule 105</title>
        <p>Pagebreaks must have a page-* class and must not contain anything</p>
        <rule context="html:*[tokenize(@epub:type, '\s+') = 'pagebreak']">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <assert test="tokenize(@class, '\s+') = ('page-front', 'page-normal', 'page-special')">[nordic105] Page breaks must have either a 'page-front', a 'page-normal' or a 'page-special' class. <value-of select="$context"/></assert>
            <assert test="count(* | comment()) = 0 and ( not(text()) or text() = normalize-space(text()) )">[nordic105] Pagebreaks must not contain elements or comments. Text content, if present, must not contain extra whitespace. <value-of select="$context"/></assert>
        </rule>
    </pattern>

    <pattern id="epub_nordic_110">
        <title>Rule 110</title>
        <p>pagebreak in headings</p>
        <rule context="html:*[tokenize(@epub:type, '\s+') = 'pagebreak']">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <report test="ancestor::*[self::html:h1 or self::html:h2 or self::html:h3 or self::html:h4 or self::html:h5 or self::html:h6]">[nordic110] Pagebreak elements are not allowed in headings. <value-of select="$context"/></report>
        </rule>
    </pattern>

    <pattern id="epub_nordic_116">
        <title>Rule 116</title>
        <p>Don't allow arabic numbers in pagebreak w/page-front</p>
        <rule context="html:*[tokenize(@epub:type, '\s+') = 'pagebreak']">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <report test="tokenize(@class, '\s+') = 'page-front' and translate(., '0123456789', 'xxxxxxxxxx') != .">[nordic116] Hindu-Arabic numbers (0-9) when @class="page-front" are not allowed. <value-of select="$context"/></report>
        </rule>
    </pattern>

    <pattern id="epub_nordic_121">
        <title>Rule 121</title>
        <p>pagebreaks in tables must not occur between table rows</p>
        <rule context="html:*[tokenize(@epub:type, '\s+') = 'pagebreak'][ancestor::html:table]">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <assert test="not(../html:tr)">[nordic121] Page numbers in tables must not be placed between table rows. <value-of select="$context"/></assert>
        </rule>
    </pattern>

    <pattern id="epub_nordic_123">
        <title>Rule 123 (39)</title>
        <p>Cover is not part of frontmatter, bodymatter or backmatter</p>
        <rule context="html:*[tokenize(@epub:type, '\s+') = 'cover']">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <report test="ancestor-or-self::*/tokenize(@epub:type, '\s+') = ('frontmatter', 'bodymatter', 'backmatter')">[nordic123] Cover (Jacket copy) is a document partition and can not be part the other document partitions frontmatter, bodymatter and rearmatter. <value-of select="$context"/></report>
        </rule>
    </pattern>

    <!-- Rule 131 (35): Allowed values in xml:lang -->
    <pattern id="epub_nordic_131_a">
        <title>Rule 131a</title>
        <p></p>
        <rule context="*[@xml:lang]">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <assert test="matches(@xml:lang, '^[a-z]{2,3}(-[A-Za-z0-9]+)*$')">[nordic131a] xml:lang must must be either a "two- or three-letter lower case" code or a "two- or three-letter lower case and groups of hyphen followed by numbers or letters" (i.e. zh-Hanz-UTF8) code. <value-of select="$context"/></assert>
        </rule>
    </pattern>
    <pattern id="epub_nordic_131_b">
        <title>Rule 131b</title>
        <p></p>
        <rule context="*[@lang]">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <assert test="matches(@lang, '^[a-z]{2,3}(-[A-Za-z0-9]+)*$')">[nordic131b] lang must must be either a "two- or three-letter lower case" code or a "two- or three-letter lower case and groups of hyphen followed by numbers or letters" (i.e. zh-Hanz-UTF8) code. <value-of select="$context"/></assert>
        </rule>
    </pattern>

    <pattern id="epub_nordic_135_a">
        <title>Rule 135a</title>
        <p>Poem contents</p>
        <rule context="html:*[tokenize(@class, '\s+') = 'verse' and not(ancestor::html:*[tokenize(@class, '\s+') = 'verse'])]">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <assert test="html:*[tokenize(@class, '\s+') = 'linegroup']">[nordic135] Every poem must contain a linegroup. <value-of select="$context"/></assert>
            <report test="html:p[tokenize(@class, '\s+') = 'line']">[nordic135] Poem lines must be wrapped in a linegroup. <value-of select="$context"/> contains; <value-of select="
                concat(
                    '&lt;',
                    html:p[tokenize(@class, '\s+') = 'line'][1]/name(),
                    string-join(for $a in (html:p[tokenize(@class, '\s+') = 'line'][1]/@*)
                        return concat(' ', $a/name(), '=&quot;', $a, '&quot;'),
                        ''
                    ),
                    '&gt;'
                )"/>.</report>
            <report test="html:p[tokenize(@class, '\s+') = 'line_indent']">[nordic135] Poem lines must be wrapped in a linegroup. <value-of select="$context"/> contains; <value-of select="
                concat(
                    '&lt;',
                    html:p[tokenize(@class, '\s+') = 'line_indent'][1]/name(),
                    string-join(for $a in (html:p[tokenize(@class, '\s+') = 'line_indent'][1]/@*)
                        return concat(' ', $a/name(), '=&quot;', $a, '&quot;'),
                        ''
                    ),
                    '&gt;'
                )"/>.</report>
            <report test="html:p[tokenize(@class, '\s+') = 'line_longindent']">[nordic135] Poem lines must be wrapped in a linegroup. <value-of select="$context"/> contains; <value-of select="
                concat(
                    '&lt;',
                    html:p[tokenize(@class, '\s+') = 'line_longindent'][1]/name(),
                    string-join(for $a in (html:p[tokenize(@class, '\s+') = 'line_longindent'][1]/@*)
                        return concat(' ', $a/name(), '=&quot;', $a, '&quot;'),
                        ''
                    ),
                    '&gt;'
                )"/>.</report>
        </rule>
    </pattern>

    <pattern id="epub_nordic_140">
        <title>Rule 140</title>
        <p>Jacket copy must contain at least one part of the cover, at most one of each @class value and no other elements</p>
        <rule context="html:body[tokenize(@epub:type, '\s+') = 'cover'] | html:section[tokenize(@epub:type, '\s+') = 'cover']">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <assert test="count(*[not(matches(local-name(), 'h\d'))]) = count(html:section[tokenize(@class, '\s+') = ('frontcover', 'rearcover', 'leftflap', 'rightflap')])"
                >[nordic140] Only sections with one of the classes 'frontcover', 'rearcover', 'leftflap' or 'rightflap' is allowed in cover.</assert>
            <assert test="count(html:section[tokenize(@class, '\s+') = ('frontcover', 'rearcover', 'leftflap', 'rightflap')]) &gt;= 1"
                >[nordic140] There must be at least one section with one of the classes 'frontcover', 'rearcover', 'leftflap' or 'rightflap' in cover. <value-of select="$context"/></assert>
            <report test="count(html:section[tokenize(@class, '\s+') = 'frontcover']) &gt; 1">[nordic140] There can not be more than one section with class="frontcover" in cover. <value-of select="$context"/></report>
            <report test="count(html:section[tokenize(@class, '\s+') = 'rearcover']) &gt; 1">[nordic140] There can not be more than one section with class="rearcover" in cover. <value-of select="$context"/></report>
            <report test="count(html:section[tokenize(@class, '\s+') = 'leftflap']) &gt; 1">[nordic140] There can not be more than one section with class="leftflap" in cover. <value-of select="$context"/></report>
            <report test="count(html:section[tokenize(@class, '\s+') = 'rightflap']) &gt; 1">[nordic140] There can not be more than one section with class="rightflap" in cover. <value-of select="$context"/></report>
        </rule>
    </pattern>

    <!-- TODO: check if handled by epubcheck -->
    <pattern id="epub_nordic_143_a">
        <title>Rule 143a</title>
        <p>Don't allow pagebreak as siblings to list items or inside the first list item</p>
        <rule context="html:*[tokenize(@epub:type, '\s+') = 'pagebreak'][parent::html:ul or parent::html:ol]">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <report test="../html:li">[nordic143a] Pagebreaks are not allowed as siblings to list items. <value-of select="$context"/></report>
        </rule>
    </pattern>

    <pattern id="epub_nordic_143_b">
        <title>Rule 143b</title>
        <p></p>
        <rule context="html:*[tokenize(@epub:type, '\s+') = 'pagebreak'][parent::html:li]">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <assert test="../preceding-sibling::html:li or preceding-sibling::* or preceding-sibling::text()[normalize-space()]"
                >[nordic143b] It is not allowed to have a pagebreak at the beginning of the first list item; it should be placed before the list. <value-of select="$context"/></assert>
        </rule>
    </pattern>

    <pattern id="epub_nordic_200">
        <title>Rule 200</title>
        <p>The title element must not be empty</p>
        <rule context="html:title">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <assert test="text() and not(normalize-space(.) = '')">[nordic200] The title element must not be empty. <value-of select="$context"/></assert>
        </rule>
    </pattern>

    <pattern id="epub_nordic_202">
        <title>Rule 202</title>
        <p>frontmatter</p>
        <rule context="html:body/html:section[tokenize(@epub:type, '\s+') = 'frontmatter']">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <let name="always-allowed-types" value="('abstract', 'acknowledgments', 'afterword', 'answers', 'appendix', 'assessment', 'assessments', 'bibliography', 'z3998:biographical-note', 'case-study', 'chapter', 'colophon', 'conclusion', 'contributors', 'copyright-page', 'credits', 'dedication', 'z3998:discography', 'division', 'z3998:editorial-note', 'epigraph', 'epilogue', 'errata', 'z3998:filmography', 'footnotes', 'foreword', 'glossary', 'dictionary', 'z3998:grant-acknowledgment', 'halftitlepage', 'imprimatur', 'imprint', 'index', 'index-group', 'index-headnotes', 'index-legend', 'introduction', 'keywords', 'landmarks', 'loa', 'loi', 'lot', 'lov', 'notice', 'other-credits', 'page-list', 'practices', 'preamble', 'preface', 'prologue', 'z3998:promotional-copy', 'z3998:published-works', 'z3998:publisher-address', 'qna', 'endnotes', 'revision-history', 'z3998:section', 'seriespage', 'subchapter', 'z3998:subsection', 'toc', 'toc-brief', 'z3998:translator-note', 'volume')"/>
            <let name="allowed-types" value="($always-allowed-types, 'titlepage')"/>
            <assert test="count(tokenize(@epub:type, '\s+')) = 1 or tokenize(@epub:type, '\s+') = $allowed-types">[nordic202] '<value-of select="(tokenize(@epub:type, '\s+')[not(. = 'frontmatter')], '(missing type)')[1]"/>' is not an allowed type in frontmatter. On elements with the epub:type "frontmatter", you can either leave the type blank (and just use 'frontmatter' as the type in the filename), or you can use one of the allowed types. <value-of select="concat('Allowed types: ', string-join($allowed-types[position() != last()], ''', '''), ' or ', $allowed-types[last()], '.')"/> <value-of select="$context"/></assert>
        </rule>
    </pattern>

    <pattern id="epub_nordic_203_a">
        <title>Rule 203a</title>
        <p>Check that both the epub:types "endnote" and "endnotes" are used in endnotes</p>
        <rule context="html:*[tokenize(@epub:type, '\s+') = 'endnote']">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <assert test="(ancestor::html:section | ancestor::html:body)[tokenize(@epub:type, '\s+') = 'endnotes']">[nordic203a] 'endnote' must have a section ancestor with 'endnotes'. <value-of select="$context"/></assert>
        </rule>
    </pattern>

    <pattern id="epub_nordic_203_c">
        <title>Rule 203c</title>
        <p></p>
        <rule context="html:body[tokenize(@epub:type, '\s+') = 'endnotes'] | html:section[tokenize(@epub:type, '\s+') = 'endnotes']">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <assert test="descendant::html:*[tokenize(@epub:type, '\s+') = 'endnote']">[nordic203c] Sections with the epub:type 'endnotes' must have descendants with 'endnote'. <value-of select="$context"/></assert>
            <assert test=".//html:ol">[nordic203c] Sections with the epub:type 'endnotes' must have &lt;ol&gt; descendant elements. <value-of select="$context"/></assert>
        </rule>
    </pattern>

    <pattern id="epub_nordic_203_d">
        <title>Rule 203d</title>
        <p></p>
        <rule context="html:*[tokenize(@epub:type, '\s+') = 'endnote']">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <assert test="self::html:li">[nordic203d] 'endnote' can only be applied to &lt;li&gt; elements. <value-of select="$context"/></assert>
        </rule>
    </pattern>

    <pattern id="epub_nordic_204_a">
        <title>Rule 204a</title>
        <p>Check that footnotes are placed correctly in a section.</p>
        <rule context="html:*[tokenize(@epub:type, '\s+') = 'footnote']">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <assert test="(parent::html:section)">[nordic204a] 'footnote' must have a parent section. <value-of select="$context"/></assert>
            <assert test="not(following-sibling::html:*[not(local-name()='aside' and tokenize(@epub:type, '\s+')='footnote')])">[nordic204a] 'footnote' must be placed at the end of a section.</assert>
        </rule>
    </pattern>

    <pattern id="epub_nordic_204_d">
        <title>Rule 204d</title>
        <p></p>
        <rule context="html:*[tokenize(@epub:type, '\s+') = 'footnote']">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <assert test="self::html:aside">[nordic204d] 'footnote' can only be applied to &lt;aside&gt; elements. <value-of select="$context"/></assert>
            <assert test="tokenize(@role, '\s+') = 'doc-footnote'">[nordic204d] The 'doc-footnote' role must be applied to all footnotes. <value-of select="$context"/></assert>
        </rule>
    </pattern>

    <pattern id="epub_nordic_208">
        <title>Rule 208</title>
        <p>bodymatter</p> <!-- TODO: document which types are allowed -->
        <rule context="html:*[tokenize(@epub:type, '\s+') = 'bodymatter']">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <let name="always-allowed-types" value="('abstract', 'acknowledgments', 'afterword', 'answers', 'appendix', 'assessment', 'assessments', 'bibliography', 'z3998:biographical-note', 'case-study', 'chapter', 'colophon', 'conclusion', 'contributors', 'copyright-page', 'credits', 'dedication', 'z3998:discography', 'division', 'z3998:editorial-note', 'epigraph', 'epilogue', 'errata', 'z3998:filmography', 'footnotes', 'foreword', 'glossary', 'dictionary', 'z3998:grant-acknowledgment', 'halftitlepage', 'imprimatur', 'imprint', 'index', 'index-group', 'index-headnotes', 'index-legend', 'introduction', 'keywords', 'landmarks', 'loa', 'loi', 'lot', 'lov', 'notice', 'other-credits', 'page-list', 'practices', 'preamble', 'preface', 'prologue', 'z3998:promotional-copy', 'z3998:published-works', 'z3998:publisher-address', 'qna', 'endnotes', 'revision-history', 'z3998:section', 'seriespage', 'subchapter', 'z3998:subsection', 'toc', 'toc-brief', 'z3998:translator-note', 'volume')"/>
            <let name="allowed-types" value="($always-allowed-types, 'part')"/>
            <assert test="tokenize(@epub:type, '\s+') = $allowed-types">[nordic208] Elements with the type "bodymatter" must also have one of the allowed epub:type values allowed for such sections. <value-of select="concat('&quot;', (tokenize(@epub:type, '\s+')[not(. = 'bodymatter')], '(missing type)')[1], '&quot; is not an allowed type in bodymatter)')"/> <value-of select="$context"/></assert>
        </rule>
    </pattern>

    <pattern id="epub_nordic_211">
        <title>Rule 211</title>
        <p>bodymatter.part</p> <!-- TODO: document which types are allowed -->
        <rule context="html:*[self::html:section or self::html:article][parent::html:*[tokenize(@epub:type, '\s+') = ('part', 'volume')]]">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <let name="always-allowed-types" value="('abstract', 'acknowledgments', 'afterword', 'answers', 'appendix', 'assessment', 'assessments', 'bibliography', 'z3998:biographical-note', 'case-study', 'chapter', 'colophon', 'conclusion', 'contributors', 'copyright-page', 'credits', 'dedication', 'z3998:discography', 'division', 'z3998:editorial-note', 'epigraph', 'epilogue', 'errata', 'z3998:filmography', 'footnotes', 'foreword', 'glossary', 'dictionary', 'z3998:grant-acknowledgment', 'halftitlepage', 'imprimatur', 'imprint', 'index', 'index-group', 'index-headnotes', 'index-legend', 'introduction', 'keywords', 'landmarks', 'loa', 'loi', 'lot', 'lov', 'notice', 'other-credits', 'page-list', 'practices', 'preamble', 'preface', 'prologue', 'z3998:promotional-copy', 'z3998:published-works', 'z3998:publisher-address', 'qna', 'endnotes', 'revision-history', 'z3998:section', 'seriespage', 'subchapter', 'z3998:subsection', 'toc', 'toc-brief', 'z3998:translator-note', 'volume')"/>
            <let name="document-components" value="('z3998:pgroup', 'z3998:example', 'z3998:epigraph', 'z3998:annotation', 'z3998:introductory-note', 'z3998:commentary', 'z3998:clarification', 'z3998:correction', 'z3998:alteration', 'z3998:presentation', 'z3998:production', 'z3998:attribution', 'z3998:author', 'z3998:editor', 'z3998:general-editor', 'z3998:commentator', 'z3998:translator', 'z3998:republisher', 'z3998:structure', 'z3998:geographic', 'z3998:postal', 'z3998:email', 'z3998:ftp', 'z3998:http', 'z3998:ip', 'z3998:aside', 'z3998:sidebar', 'z3998:practice', 'z3998:notice', 'z3998:warning', 'z3998:marginalia', 'z3998:help', 'z3998:drama', 'z3998:scene', 'z3998:stage-direction', 'z3998:dramatis-personae', 'z3998:persona', 'z3998:actor', 'z3998:role-description', 'z3998:speech', 'z3998:diary', 'z3998:diary-entry', 'z3998:figure', 'z3998:plate', 'z3998:gallery', 'z3998:letter', 'z3998:sender', 'z3998:recipient', 'z3998:salutation', 'z3998:valediction', 'z3998:postscript', 'z3998:email-message', 'z3998:to', 'z3998:from', 'z3998:cc', 'z3998:bcc', 'z3998:subject', 'z3998:collection', 'z3998:orderedlist', 'z3998:unorderedlist', 'z3998:abbreviations', 'z3998:timeline', 'z3998:note', 'z3998:footnotes', 'z3998:footnote', 'z3998:verse', 'z3998:poem', 'z3998:song', 'z3998:hymn', 'z3998:lyrics')"/>
            <let name="allowed-types" value="($always-allowed-types, $document-components)"/>
            <assert test="tokenize(@epub:type, '\s+') = $allowed-types">[nordic211] Sections inside a part must also have one of the allowed epub:type values allowed for such sections. <value-of select="concat('&quot;', (tokenize(@epub:type, '\s+')[not((. = 'part', 'volume'))], '(missing type)')[1], '&quot; is not an allowed type in a part)')"/> <value-of select="$context"/></assert>
        </rule>
    </pattern>

    <pattern id="epub_nordic_215">
        <title>Rule 215</title>
        <p>backmatter</p> <!-- TODO: document which types are allowed -->
        <rule context="html:*[tokenize(@epub:type, '\s+') = 'backmatter']">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <let name="always-allowed-types" value="('abstract', 'acknowledgments', 'afterword', 'answers', 'appendix', 'assessment', 'assessments', 'bibliography', 'z3998:biographical-note', 'case-study', 'chapter', 'colophon', 'conclusion', 'contributors', 'copyright-page', 'credits', 'dedication', 'z3998:discography', 'division', 'z3998:editorial-note', 'epigraph', 'epilogue', 'errata', 'z3998:filmography', 'footnotes', 'foreword', 'glossary', 'dictionary', 'z3998:grant-acknowledgment', 'halftitlepage', 'imprimatur', 'imprint', 'index', 'index-group', 'index-headnotes', 'index-legend', 'introduction', 'keywords', 'landmarks', 'loa', 'loi', 'lot', 'lov', 'notice', 'other-credits', 'page-list', 'practices', 'preamble', 'preface', 'prologue', 'z3998:promotional-copy', 'z3998:published-works', 'z3998:publisher-address', 'qna', 'endnotes', 'revision-history', 'z3998:section', 'seriespage', 'subchapter', 'z3998:subsection', 'toc', 'toc-brief', 'z3998:translator-note', 'volume')"/>
            <let name="allowed-types" value="($always-allowed-types)"/>
            <assert test="count(tokenize(@epub:type, '\s+')) = 1 or tokenize(@epub:type, '\s+') = $allowed-types">[nordic215] If elements with the type "backmatter" has additional types, they must be one of the allowed epub:type values allowed for such sections. <value-of select="concat('&quot;', (tokenize(@epub:type, '\s+')[not(. = 'backmatter')], '(missing type)')[1], '&quot; is not an allowed type in backmatter)')"/> <value-of select="$context"/></assert>
        </rule>
    </pattern>

    <pattern id="epub_nordic_225">
        <title>Rule 225</title>
        <p>pagebreak</p>
        <rule context="html:*[tokenize(@epub:type, '\s+') = 'pagebreak' and text()]">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <assert test="matches(@aria-label, '.+')">[nordic225] The aria-label attribute must be used to describe the page number. <value-of select="$context"/></assert>
        </rule>
    </pattern>

    <pattern id="epub_nordic_247">
        <title>Rule 247</title>
        <p>doctitle.heading - h1</p>
        <rule context="html:body/html:section[tokenize(@epub:type, '\s+') = 'titlepage']/html:h1">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <assert test="tokenize(@epub:type, '\s+') = 'fulltitle'">[nordic247] The first (h1) heading on the titlepage must have the 'fulltitle' epub:type.</assert>
        </rule>
    </pattern>

    <pattern id="epub_nordic_251">
        <title>Rule 251</title>
        <p>lic - span</p>
        <rule context="html:span[tokenize(@class, '\s+') = 'lic']">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <assert test="parent::html:li or parent::html:a/parent::html:li">[nordic251] The parent of a list item component (span class="lic") must be either a "li" or a "a" (where the "a" has "li" as parent). <value-of select="$context"/></assert>
        </rule>
    </pattern>

    <pattern id="epub_nordic_253_a">
        <title>Rule 253a</title>
        <p>figures and captions</p>
        <rule context="html:figure">
            <!--
                The class "table" is undocumented to avoid unwanted use of that markup.
                It should only be used by suppliers explicitly instructed to do so.
            -->
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <assert test="tokenize(@class, '\s+') = ('image', 'image-series', 'table')"
                >[nordic253a] &lt;figure&gt; elements must either have a class of "image", "image-series" or "table". <value-of select="$context"/></assert>
            <report test="count((.[tokenize(@class, '\s+') = 'image'], .[tokenize(@class, '\s+') = 'image-series'], .[tokenize(@class, '\s+') = 'table'])) &gt; 1"
                >[nordic253a] &lt;figure&gt; elements must either have a class of "image", "image-series" or "table". <value-of select="$context"/></report>
            <assert test="count(html:figcaption) &lt;= 1">[nordic253a] There cannot be more than one &lt;figcaption&gt; in a single figure element. <value-of select="$context"/></assert>
        </rule>
    </pattern>

    <pattern id="epub_nordic_253_b">
        <title>Rule 253b</title>
        <p></p>
        <rule context="html:figure[tokenize(@class, '\s+') = 'image']">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <assert test="count(.//html:img) = 1">[nordic253b] Image figures must contain exactly one img. <value-of select="$context"/></assert>
            <assert test="count(html:img) = 1">[nordic253b] The img in image figures must be a direct child of the figure. <value-of select="$context"/></assert>
        </rule>
    </pattern>

    <pattern id="epub_nordic_253_c">
        <title>Rule 253c</title>
        <p></p>
        <rule context="html:figure[tokenize(@class, '\s+') = 'image-series']">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <assert test="count(html:img) = 0">[nordic253c] Image series figures cannot contain img childen (the img elements must be contained in children figure elements). <value-of select="$context"/></assert>
            <assert test="count(html:figure[tokenize(@class, '\s+') = 'image']) &gt;= 2">[nordic253c] Image series must contain at least 2 image figures ("figure" elements with class "image"). <value-of select="$context"/></assert>
        </rule>
    </pattern>

    <pattern id="epub_nordic_256">
        <title>Rule 256</title>
        <p>HTML documents with only a heading</p>
        <rule context="html:section[ancestor-or-self::*/tokenize(@epub:type, '\s+') = 'bodymatter' and count(* except (html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6 | *[tokenize(@epub:type, '\s+') = 'pagebreak'])) = 0]">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <assert test="tokenize(@epub:type, '\s+') = 'part'">[nordic256] Sections in bodymatter must contain more than just headings and pagebreaks, except for when epub:type="part". <value-of select="$context"/></assert>
        </rule>
    </pattern>

    <pattern id="epub_nordic_257">
        <title>Rule 257</title>
        <p>always require both xml:lang and lang</p>
        <rule context="*[@xml:lang or @lang]">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <assert test="@xml:lang = @lang">[nordic257] The `xml:lang` and the `lang` attributes must have the same value. <value-of select="$context"/></assert>
        </rule>
    </pattern>

    <pattern id="epub_nordic_258">
        <title>Rule 258</title>
        <p>allow at most one pagebreak before any content in each content file</p>
        <rule context="html:div[../html:body and tokenize(@epub:type, '\s') = 'pagebreak']">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <report test="preceding-sibling::html:div[tokenize(@epub:type, '\s') = 'pagebreak']">[nordic258] Only one pagebreak is allowed before any content in each content file. <value-of select="$context"/></report>
        </rule>
    </pattern>

    <pattern id="epub_nordic_259">
        <title>Rule 259</title>
        <p>don't allow pagebreak in thead</p>
        <rule context="html:*[tokenize(@epub:type, '\s+') = 'pagebreak']">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <report test="ancestor::html:thead">[nordic259] Pagebreaks can not occur within table headers (thead). <value-of select="$context"/></report>
            <report test="ancestor::html:tfoot">[nordic259] Pagebreaks can not occur within table footers (tfoot). <value-of select="$context"/></report>
        </rule>
    </pattern>

    <pattern id="epub_nordic_260_b">
        <title>Rule 260b</title>
        <p></p>
        <rule context="html:figure[tokenize(@class, '\s+') = 'image-series']/html:*[not(self::html:figure[tokenize(@class, '\s+') = 'image'])]">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <report test="preceding-sibling::html:figure[tokenize(@class, '\s+') = 'image']">[nordic260b] Content is not allowed between or after image figure elements. <value-of select="$context"/></report>
        </rule>
    </pattern>

    <pattern id="epub_nordic_261">
        <title>Rule 261</title>
        <p>Text can't be direct child of div</p>
        <rule context="html:div[not(tokenize(@epub:type, '\s+') = 'pagebreak')]">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <report test="text()[normalize-space(.)]">[nordic261] Text can't be placed directly inside div elements. Try wrapping it in a p element. <value-of select="concat('(', normalize-space(string-join(text(), ' ')), ')')"/> <value-of select="$context"/></report>
        </rule>
    </pattern>

    <pattern id="epub_nordic_263">
        <title>Rule 263</title>
        <p>there must be a heading on the titlepage</p>
        <rule context="html:body[tokenize(@epub:type, '\s+') = 'titlepage'] | html:section[tokenize(@epub:type, '\s+') = 'titlepage']">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <assert test="count(html:*[matches(local-name(), 'h\d')])">[nordic263] the titlepage must have a heading (and the heading must have epub:type="fulltitle" and class="title").</assert>
        </rule>
    </pattern>

    <pattern id="epub_nordic_264">
        <title>Rule 264</title>
        <p>h1 on titlepage must be epub:type=fulltitle with class=title</p>
        <rule context="html:body[tokenize(@epub:type, '\s+') = 'titlepage']/html:*[matches(local-name(), 'h\d')] | html:section[tokenize(@epub:type, '\s+') = 'titlepage']/html:*[matches(local-name(), 'h\d')]">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <assert test="tokenize(@epub:type, '\s+') = 'fulltitle'">[nordic264] the heading on the titlepage must have a epub:type with the value "fulltitle". <value-of select="$context"/></assert>
            <assert test="tokenize(@class, '\s+') = 'title'">[nordic264] the heading on the titlepage must have a class with the value "title". <value-of select="$context"/></assert>
        </rule>
    </pattern>

    <pattern id="epub_nordic_267_a">
        <title>Rule 267a</title>
        <p></p>
        <rule context="html:*[*[tokenize(@epub:type, '\s+') = 'endnote']]">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <assert test="self::html:ol">[nordic267a] Endnotes must be wrapped in a "ol" element, but is currently wrapped in a <name/>. <value-of select="$context"/></assert>
        </rule>
    </pattern>

    <pattern id="epub_nordic_267_b">
        <title>Rule 267b</title>
        <p></p>
        <rule context="html:section[tokenize(@epub:type, '\s+') = 'endnotes']/html:ol/html:li | html:body[tokenize(@epub:type, '\s+') = 'endnotes']/html:ol/html:li">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <assert test="tokenize(@epub:type, '\s+') = 'endnote'">[nordic267b] List items inside a endnotes list must use epub:type="endnote". <value-of select="$context"/></assert>
        </rule>
    </pattern>

    <pattern id="epub_nordic_268">
        <title>Rule 268</title>
        <p>Check that the heading levels are nested correctly (necessary for sidebars and poems, and maybe other structures as well where the RelaxNG is unable to enforce the level)</p>
        <rule context="html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <let name="sectioning-element" value="ancestor::*[self::html:section or self::html:article or self::html:aside or self::html:nav or self::html:body][1]"/>
            <let name="this-level" value="
                    xs:integer(replace(name(), '.*(\d)$', '$1')) + (if (ancestor::html:header[parent::html:body]) then
                        -1
                    else
                        0)"/>
            <let name="child-sectioning-elements" value="$sectioning-element//*[self::html:section or self::html:article or self::html:aside or self::html:nav or self::html:figure][ancestor::*[self::html:section or self::html:article or self::html:aside or self::html:nav or self::html:body][1] intersect $sectioning-element]"/>
            <let name="child-sectioning-element-with-wrong-level" value="$child-sectioning-elements[count(html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6) != 0 and (html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6)/xs:integer(replace(name(), '.*(\d)$', '$1')) != min((6, $this-level + 1))][1]"/>
            <assert test="count($child-sectioning-element-with-wrong-level) = 0">[nordic268] The subsections of <value-of select="
                    concat('&lt;', $sectioning-element/name(), string-join(for $a in ($sectioning-element/@*)
                    return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;')"/> (which contains the heading <value-of select="$context"/><value-of select="string-join(.//text(), ' ')"/>&lt;/<name/>&gt;) must only use &lt;h<value-of select="min((6, $this-level + 1))"/>&gt; for headings. It contains the element <value-of select="
                    concat('&lt;', $child-sectioning-element-with-wrong-level/name(), string-join(for $a in ($child-sectioning-element-with-wrong-level/@*)
                    return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;')"/> which contains the heading <value-of select="
                    concat('&lt;', $child-sectioning-element-with-wrong-level/(html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6)[1]/name(), string-join(for $a in ($child-sectioning-element-with-wrong-level/(html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6)[1]/@*)
                    return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;', string-join($child-sectioning-element-with-wrong-level/(html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6)[1]//text(), ' '), '&lt;/', $child-sectioning-element-with-wrong-level/(html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6)[1]/name(), '&gt;')"/> .</assert>
        </rule>
    </pattern>

    <pattern id="epub_nordic_269">
        <title>Rule 269</title>
        <p></p>
        <rule context="html:body/html:section">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <let name="filename-regex" value="'^.*/[A-Za-z0-9_-]+-\d+-([a-z-]+)(-\d+)?\.xhtml$'"/>
            <let name="base-uri-type" value="
                    if (matches(base-uri(.), $filename-regex)) then
                        replace(base-uri(.), $filename-regex, '$1')
                    else
                        ()"/>
            <let name="document-partitions" value="('cover', 'frontmatter', 'bodymatter', 'backmatter')"/>
            <let name="document-divisions" value="('volume', 'part', 'chapter', 'division')"/>
            <let name="values" value="(
                for $t in tokenize(@role, '\s+') return tokenize(replace($t, '^doc-', ''), ':'),
                for $t in tokenize(@epub:type, '\s+') return if ($t = ($document-partitions, $document-divisions)) then () else tokenize($t, ':'),
                for $t in tokenize(@epub:type, '\s+') return if ($t = $document-divisions) then $t else (),
                for $t in tokenize(@epub:type, '\s+') return if ($t = $document-partitions) then $t else ()
            )"/>
            <assert test="
                not(matches(base-uri(.), $filename-regex))
                or $values[1] = $base-uri-type">[nordic269] The type used in the filename (<value-of select="$base-uri-type"/>) must be present on the section element, and be the most specific (<value-of select="$values[1]"/>). <value-of select="$context"/></assert>
        </rule>
    </pattern>

    <pattern id="epub_nordic_270">
        <title>Rule 270</title>
        <p></p>
        <rule context="html:p[tokenize(@epub:type, '\t+') = 'bridgehead']">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <assert test="parent::html:section | parent::html:article | parent::html:div | parent::html:aside">[nordic270] Bridgehead is only allowed as a child of section, article, div and aside. <value-of select="$context"/></assert>
        </rule>
    </pattern>

    <!-- Imported from Pipeline 1 DTBook validator and adapted to EPUB3 -->
    <pattern id="epub_nordic_273">
        <title>Rule 273</title>
        <p></p>
        <rule context="html:a[starts-with(@href, '#')]">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <assert test="count(//html:*[@id = substring(current()/@href, 2)]) = 1">[nordic273] Internal link <value-of select="concat('(&quot;', @href, '&quot;)')"/> does not resolve. <value-of select="$context"/></assert>
        </rule>
    </pattern>

    <pattern id="epub_nordic_273b">
        <title>Rule 273b</title>
        <p>Disallow internal links without fragment identifiers (see https://github.com/nlbdev/nordic-epub3-dtbook-migrator/issues/372)</p>
        <rule context="html:a[not(matches(@href, '^([a-z]+:/+|mailto:|tel:)'))]">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <assert test="matches(@href, '.*#.+')">[nordic273b] Internal links must contain a non-empty fragment identifier. <value-of select="$context"/></assert>
        </rule>
    </pattern>

    <!--
        MG20061101: added as a consequence of zedval feature request #1565049: http://sourceforge.net/p/zedval/feature-requests/12/
        JAJ20150225: Imported from Pipeline 1 DTBook validator and adapted to EPUB3
    -->
    <pattern id="epub_nordic_279a">
        <title>Rule 279a</title>
        <p></p>
        <rule context="html:ul | html:ol[matches(@style, 'list-style-type:\s*none;')]">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <report test="@start">[nordic279a] The start attribute must not be used in lists without markers (numbers/letters). <value-of select="$context"/></report>
        </rule>
    </pattern>

    <pattern id="epub_nordic_279b">
        <title>Rule 279b</title>
        <p></p>
        <rule context="html:ol[@start]">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <report test="@start = '' or string-length(translate(@start, '0123456789', '')) != 0">[nordic279b] The start attribute must be a positive integer. <value-of select="$context"/></report>
        </rule>
    </pattern>

    <!--
        MG20061101: added as a consequence of zedval feature request #1565049: http://sourceforge.net/p/zedval/feature-requests/12/
        JAJ20150225: Imported from Pipeline 1 DTBook validator and adapted to EPUB3
    -->
    <pattern id="epub_nordic_280">
        <title>Rule 280</title>
        <p></p>
        <rule context="html:meta">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <report test="starts-with(@name, 'dc:') and not(@name = 'dc:title' or @name = 'dc:subject' or @name = 'dc:description' or @name = 'dc:type' or @name = 'dc:source' or @name = 'dc:relation' or @name = 'dc:coverage' or @name = 'dc:creator' or @name = 'dc:publisher' or @name = 'dc:publisher.original' or @name = 'dc:contributor' or @name = 'dc:rights' or @name = 'dc:date' or @name = 'dc:format' or @name = 'dc:identifier' or @name = 'dc:language')"
                >[nordic280] Metadata with the dc prefix are only allowed for the 15 official Dublin Core metadata elements: dc:title, dc:subject, dc:description, dc:type, dc:source, dc:relation, dc:coverage, dc:creator, dc:publisher, dc:publisher.original, dc:contributor, dc:rights, dc:date, dc:format, dc:identifier and dc:language. <value-of select="$context"/></report>
            <report test="starts-with(@name, 'DC:') or starts-with(@name, 'Dc:') or starts-with(@name, 'dC:')">[nordic280] The dc metadata prefix must be in lower case. <value-of select="$context"/></report>
        </rule>
    </pattern>

    <!--
        MG20061101: added as a consequence of zedval feature request #1565049: http://sourceforge.net/p/zedval/feature-requests/12/
        JAJ20150225: Imported from Pipeline 1 DTBook validator and adapted to EPUB3
    -->
    <pattern id="epub_nordic_281">
        <title>Rule 281</title>
        <p></p>
        <rule context="html:col | html:colgroup">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <report test="@span and (translate(@span, '0123456789', '') != '' or starts-with(@span, '0'))">[nordic281] The span attribute on col and colgroup elements must be a positive integer. <value-of select="$context"/></report>
        </rule>
    </pattern>

    <!--
        MG20061101: added as a consequence of zedval feature request #1565049: http://sourceforge.net/p/zedval/feature-requests/12/
        JAJ20150225: Imported from Pipeline 1 DTBook validator and adapted to EPUB3
    -->
    <pattern id="epub_nordic_282">
        <title>Rule 282</title>
        <p></p>
        <rule context="html:td | html:th">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <report test="@rowspan and (translate(@rowspan, '0123456789', '') != '' or starts-with(@rowspan, '0'))">[nordic282] The rowspan attribute value on td and th elements must be a positive integer. <value-of select="$context"/></report>
            <report test="@colspan and (translate(@colspan, '0123456789', '') != '' or starts-with(@colspan, '0'))">[nordic282] The colspan attribute value on td and th elements must be a positive integer. <value-of select="$context"/></report>
            <report test="@rowspan and number(@rowspan) &gt; count(parent::html:tr/following-sibling::html:tr | parent::html:tr/(parent::html:thead | parent::tbody | parent::tfoot)/following-sibling::html:*/html:tr) + 1"
                >[nordic282] The rowspan attribute value on td and th elements must not be larger than the number of rows left in the table. <value-of select="$context"/></report>
        </rule>
    </pattern>

    <pattern id="epub_nordic_283">
        <title>Rule 283</title>
        <p></p>
        <rule context="m:*[contains(name(), ':')]">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <assert test="substring-before(name(), ':') = 'm'">[nordic283] When using MathML with a namespace prefix, that prefix must be 'm'. <value-of select="concat('Not ', substring-before(name(), ':'), '.')"/> <value-of select="$context"/></assert>
        </rule>
    </pattern>

    <pattern id="epub_nordic_290">
        <title>Rule 290</title>
        <p>Rearnotes should not be used. Use endnotes instead.</p>
        <rule context="*">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <assert test="not(tokenize(@epub:type, '\s+') = ('rearnote', 'rearnotes'))">[nordic290] Rearnotes are deprecated. Endnotes are required to be used instead. <value-of select="$context"/></assert>
        </rule>
    </pattern>

    <pattern id="epub_nordic_291">
        <title>Rule 291</title>
        <p>Backmatter sections require specific roles</p>
        <rule context="html:section[tokenize(@epub:type, '\s+') = 'backmatter' and @role]">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <assert test="tokenize(@role, '\s+') = ('doc-acknowledgments', 'doc-afterword', 'doc-appendix', 'doc-bibliography', 'doc-colophon', 'doc-conclusion', 'doc-dedication', 'doc-endnotes', 'doc-epigraph', 'doc-epilogue', 'doc-glossary', 'doc-index')">
                [nordic291] Backmatter can only use roles (doc-acknowledgments, doc-afterword, doc-appendix, doc-bibliography, doc-colophon, doc-conclusion, doc-dedication, doc-epigraph, doc-epilogue, doc-glossary, doc-index) <value-of select="$context"/>
            </assert>
        </rule>
    </pattern>

    <pattern id="epub_nordic_292">
        <title>Rule 292</title>
        <p>Class sidebar is deprecated for asides</p>
        <rule context="html:aside">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <report test="tokenize(@class, '\s+') = 'sidebar'">[nordic292] The aside attribute class is set to sidebar which is deprecated. <value-of select="$context"/></report>
        </rule>
    </pattern>
</schema>
