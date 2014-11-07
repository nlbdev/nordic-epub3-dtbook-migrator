<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">

    <sch:title>DTBook 2005 Schematron tests for TPB 2010-1 rules - adapted for HTML5</sch:title>

    <sch:ns prefix="html" uri="http://www.w3.org/1999/xhtml"/>
    <sch:ns prefix="epub" uri="http://www.idpf.org/2007/ops"/>
    <sch:ns prefix="nordic" uri="http://www.mtm.se/epub/"/>

    <!-- Rule 7: No <list> or <dl> inside <p> -->
    <sch:pattern id="dtbook_TPB_7">
        <!--
    	p should only allow inline elements. The lists and definition lists inside p
    	will be converted to span elements in Daisy 2.02
    -->
        <sch:rule context="html:p">
            <sch:report test="html:ul | html:ol">[tpb07] Lists are not allowed inside paragraphs.</sch:report>
            <sch:report test="html:dl">[tpb07] Definition lists are not allowed inside paragraphs.</sch:report>
        </sch:rule>
    </sch:pattern>

    <!-- Rule 8: Only allow pagebreak w/page-front in frontmatter -->
    <sch:pattern id="dtbook_TPB_8">
        <sch:rule context="html:span[tokenize(@epub:type,'\s+')='pagebreak' and tokenize(@class,'\s+')='page-front']">
            <sch:assert test="ancestor::html:*[self::html:section or self::html:article or self::html:body]/tokenize(@epub:type,'\s+') = ('frontmatter','cover')">[tpb08] &lt;span epub:type="pagebreak"
                class="page-front"/&gt; may only occur in frontmatter and cover</sch:assert>
        </sch:rule>
    </sch:pattern>

    <!-- Rule 9: Disallow empty elements (with a few exceptions) -->
    <sch:pattern id="dtbook_TPB_9">
        <sch:rule context="html:*">
            <sch:report
                test="normalize-space(.)='' and not(*) and not(self::html:img or self::html:br or self::html:meta or self::html:link or self::html:col or self::html:th or self::html:td or self::html:dd or self::html:*[tokenize(@epub:type,'\s+')='pagebreak'] or self::html:hr)"
                >[tpb09] Element may not be empty</sch:report>
        </sch:rule>
    </sch:pattern>

    <!-- Rule 10: Metadata for dc:language, dc:date and dc:publisher must exist in the single-HTML representation -->
    <sch:pattern id="dtbook_TPB_10">
        <sch:rule context="html:head[following-sibling::html:body/html:header]">
            <!-- dc:language -->
            <sch:assert test="count(html:meta[@name='dc:language'])>=1">[tpb10] Meta dc:language must occur at least once</sch:assert>
            <!-- dc:date -->
            <sch:assert test="count(html:meta[@name='dc:date'])=1">[tpb10] Meta dc:date=YYYY-MM-DD must occur once</sch:assert>
            <sch:report test="html:meta[@name='dc:date' and translate(@content, '0123456789', '0000000000')!='0000-00-00']">[tpb10] Meta dc:date must have format YYYY-MM-DD</sch:report>
            <!-- dc:publisher -->
            <sch:assert test="count(html:meta[@name='dc:publisher'])=1">[tpb10] Meta dc:publisher must occur once</sch:assert>
        </sch:rule>
    </sch:pattern>

    <!-- Rule 11: Root element must have @xml:lang -->
    <sch:pattern id="dtbook_TPB_11">
        <sch:rule context="html:html">
            <sch:assert test="@xml:lang">[tpb11] Root element must have an xml:lang attribute</sch:assert>
        </sch:rule>
    </sch:pattern>

    <!-- Rule 12: Frontmatter starts with doctitle and docauthor -->
    <sch:pattern id="dtbook_TPB_12">
        <sch:rule context="html:body/html:header">
            <sch:assert test="html:*[1][self::html:h1[tokenize(@epub:type,' ')='fulltitle']]">[tpb12] Single-HTML document must begin with a fulltitle headline</sch:assert>
        </sch:rule>
    </sch:pattern>

    <!-- Rule 13: All documents must have frontmatter and bodymatter -->
    <sch:pattern id="dtbook_TPB_13">
        <sch:rule context="html:body[html:header]">
            <sch:assert test="((html:section|html:article)/tokenize(@epub:type,'\s+')=('cover','frontmatter')) = true()">[tpb13] A Single-HTML document must have at least one frontmatter or cover
                section</sch:assert>
            <sch:assert test="((html:section|html:article)/tokenize(@epub:type,'\s+')='bodymatter') = true()">[tpb13] A Single-HTML document must have at least one bodymatter section</sch:assert>
            <sch:assert test="not(tokenize(@epub:type,'\s+')=('cover','frontmatter','bodymatter','backmatter'))">[tpb13] The Single-HTML document must not have cover, frontmatter, bodymatter or
                backmatter as epub:type on its body element</sch:assert>
        </sch:rule>
        <sch:rule
            context="html:*[self::html:section or self::html:article][ancestor::html:body[html:header] and not(parent::html:body) and not(parent::html:section[tokenize(@epub:type,'\s+')='part'])]">
            <sch:assert test="not((tokenize(@epub:type,'\s+')=('cover','frontmatter','bodymatter','backmatter')) = true())">[tpb13] The Single-HTML document must not have cover, frontmatter,
                bodymatter or backmatter on any of its sectioning elements other than the top-level elements that has body as its parent</sch:assert>
        </sch:rule>
        <sch:rule context="html:body[not(html:header|html:nav)]">
            <sch:assert test="tokenize(@epub:type,'\s+')=('cover','frontmatter','bodymatter','backmatter')">[tpb13] The document must have either cover, frontmatter, bodymatter or backmatter as
                epub:type on its body element</sch:assert>
        </sch:rule>
        <sch:rule context="html:*[self::html:section or self::html:article][ancestor::html:body[not(html:header|html:nav)]]">
            <sch:assert test="not((tokenize(@epub:type,'\s+')=('cover','frontmatter','bodymatter','backmatter')) = true())">[tpb13] The document must not have cover, frontmatter, bodymatter or
                backmatter on any of its sectioning elements</sch:assert>
        </sch:rule>
    </sch:pattern>

    <!-- Rule 14:  Don't allow <h x+1> in <level x+1> unless <h x> in <level x> is present -->
    <sch:pattern id="dtbook_TPB_14">
        <sch:rule context="html:*[self::html:body[not(html:header)] or self::html:section or self::html:article][not(tokenize(@epub:type,'\s+')='cover')][html:section|html:article]">
            <sch:assert test="html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6">[tpb14] sectioning element with no headline (h1-h6) when sub-section is present (is only allowed for sectioning
                element with epub:type="cover")</sch:assert>
        </sch:rule>
    </sch:pattern>

    <!-- Rule 20: No imggroup in inline context -->
    <sch:pattern id="dtbook_TPB_20">
        <sch:rule context="html:figure">
            <sch:report
                test="ancestor::html:a        or ancestor::html:abbr       or ancestor::html:acronym    or ancestor::html:a[tokenize(@epub:type,' ')='annoref']   or
                          ancestor::html:bdo      or ancestor::html:code       or ancestor::html:dfn        or ancestor::html:em        or
                          ancestor::html:kbd      or ancestor::html:p[tokenize(@class,' ')='linenum']    or ancestor::html:a[tokenize(@epub:type,' ')='noteref']    or ancestor::html:span[tokenize(@class,' ')='lic']       or
                          ancestor::html:q        or ancestor::html:samp       or ancestor::html:span[tokenize(@epub:type,' ')='z3998:sentence']       or ancestor::html:span      or
                          ancestor::html:strong   or ancestor::html:sub        or ancestor::html:sup        or ancestor::html:span[tokenize(@epub:type,' ')='z3998:word']         or
                          ancestor::html:address  or ancestor::html:*[tokenize(@epub:type,' ')='z3998:author' and not(parent::html:header[parent::html:body])]     or ancestor::html:p[tokenize(@epub:type,' ')='bridgehead'] or ancestor::html:*[tokenize(@class,' ')='byline']    or
                          ancestor::html:cite     or ancestor::html:*[tokenize(@epub:type,' ')='covertitle'] or ancestor::html:*[tokenize(@class,' ')='dateline']   or ancestor::html:p[parent::html:header[parent::html:body] and tokenize(@epub:type,' ')='z3998:author'] or
                          ancestor::html:h1[tokenize(@epub:type,' ')='fulltitle'] or ancestor::html:dt         or ancestor::html:h1         or ancestor::html:h2        or
                          ancestor::html:h3       or ancestor::html:h4         or ancestor::html:h5         or ancestor::html:h6        or
                          ancestor::html:p[tokenize(@class,' ')='line']       or ancestor::html:p"
                >[tpb20] Image groups are not allowed in inline context</sch:report>
        </sch:rule>
    </sch:pattern>

    <!-- Rule 21: No nested tables -->
    <sch:pattern id="dtbook_TPB_21">
        <sch:rule context="html:table">
            <sch:report test="ancestor::html:table">[tpb21] Nested tables are not allowed</sch:report>
        </sch:rule>
    </sch:pattern>

    <!-- Rule 23: Increasing pagebreak values for page-normal -->
    <sch:pattern id="dtbook_TPB_23">
        <sch:rule
            context="html:*[tokenize(@epub:type,' ')='pagebreak'][tokenize(@class,' ')='page-normal' and preceding::html:*[tokenize(@epub:type,' ')='pagebreak'][tokenize(@class,' ')='page-normal']]">
            <sch:assert test="number(current()/@title) > number(preceding::html:*[tokenize(@epub:type,' ')='pagebreak'][tokenize(@class,' ')='page-normal'][1]/@title)">[tpb23] pagebreak values must
                increase for page-normal</sch:assert>
        </sch:rule>
    </sch:pattern>

    <!-- Rule 24: Values of pagebreak must be unique for page-front -->
    <sch:pattern id="dtbook_TPB_24">
        <sch:rule context="html:*[tokenize(@epub:type,' ')='pagebreak'][tokenize(@class,' ')='page-front']">
            <!--  		<sch:assert test="count(key('pageFrontValues', .))=1">[tpb24] pagebreak values must be unique for page-front</sch:assert>-->
            <sch:assert test="count(//html:*[tokenize(@epub:type,' ')='pagebreak'][tokenize(@class,' ')='page-front' and @title=current()/@title])=1">[tpb24] pagebreak values must be unique for
                page-front</sch:assert>
        </sch:rule>
    </sch:pattern>

    <!-- Rule 26: Each note must have a noteref -->
    <sch:pattern id="dtbook_TPB_26">
        <sch:rule context="html:a[tokenize(@epub:type,' ')='note']">
            <!--  		<sch:assert test="count(key('noterefs', @id))>=1">[tpb26] Each note must have at least one noteref</sch:assert>-->
            <sch:assert test="count(//html:a[tokenize(@epub:type,' ')='noteref'][translate(@idref, '#', '')=current()/@id])>=1">[tpb26] Each note must have at least one noteref</sch:assert>
        </sch:rule>
    </sch:pattern>

    <!-- Rule 27: Each annotation must have an annoref -->
    <sch:pattern id="dtbook_TPB_27">
        <sch:rule context="html:aside[tokenize(@epub:type,' ')='annotation']">
            <!--  		<sch:assert test="count(key('annorefs', @id))>=1">[tpb27] Each annotation must have at least one annoref</sch:assert>-->
            <sch:assert test="count(//html:a[tokenize(@epub:type,' ')='annoref'][translate(@idref, '#', '')=current()/@id])>=1">[tpb27] Each annotation must have at least one annoref</sch:assert>
        </sch:rule>
    </sch:pattern>

    <!-- Rule 29: No block elements in inline context -->
    <sch:pattern id="dtbook_TPB_29a">
        <sch:rule
            context="html:*[self::html:address    or self::html:aside[tokenize(@epub:type,' ')='annotation'] or self::html:*[tokenize(@epub:type,' ')='z3998:author' and not(parent::html:header[parent::html:body])]   or
  	                          self::html:blockquote or self::html:p[tokenize(@epub:type,' ')='bridgehead'] or self::html:caption  or
  	                          self::html:*[tokenize(@class,' ')='dateline']   or self::html:div        or self::html:dl       or
  	                          self::html:p[parent::html:header[parent::html:body] and tokenize(@epub:type,' ')='z3998:author']  or self::html:h1[tokenize(@epub:type,' ')='fulltitle']   or
  	                          self::html:aside[tokenize(@epub:type,' ')='epigraph']   or self::html:p[tokenize(@class,' ')='line']     or
  	                          self::html:*[tokenize(@class,' ')='linegroup']  or
  	                          self::html:*[self::html:ul or self::html:ol][not(ancestor::html:nav)]       or self::html:a[tokenize(@epub:type,' ')='note']       or self::html:p        or
  	                          self::html:*[tokenize(@epub:type,' ')='z3998:poem']       or self::html:*[(self::figure or self::aside) and tokenize(@epub:type,'s')='sidebar']    or self::html:table    or
  	                          self::html:*[matches(local-name(),'^h\d$') and tokenize(@class,' ')='title']]">
            <sch:report
                test="ancestor::html:a      or ancestor::html:abbr or ancestor::html:acronym or ancestor::html:a[tokenize(@epub:type,' ')='annoref'] or
  	                    ancestor::html:bdo    or ancestor::html:code or ancestor::html:dfn     or ancestor::html:em      or
  	                    ancestor::html:kbd or ancestor::html:p[tokenize(@class,' ')='linenum'] or ancestor::html:a[tokenize(@epub:type,' ')='noteref'] or
  	                    ancestor::html:q      or ancestor::html:samp or ancestor::html:span[tokenize(@epub:type,' ')='z3998:sentence']    or ancestor::html:span    or
  	                    ancestor::html:strong or ancestor::html:sub  or ancestor::html:sup     or ancestor::html:span[tokenize(@epub:type,' ')='z3998:word']"
                >[tpb29] Block element <sch:name/> used in inline context</sch:report>
        </sch:rule>
    </sch:pattern>

    <!-- Rule 29: No block elements in inline context - continued -->
    <sch:pattern id="dtbook_TPB_29b">
        <sch:rule
            context="html:*[self::html:address    or self::html:aside[tokenize(@epub:type,' ')='annotation'] or self::html:*[tokenize(@epub:type,' ')='z3998:author' and not(parent::html:header[parent::html:body])]   or
  	                          self::html:blockquote or self::html:p[tokenize(@epub:type,' ')='bridgehead'] or self::html:caption  or
  	                          self::html:*[tokenize(@class,' ')='dateline']   or self::html:div        or self::html:dl       or
  	                          self::html:aside[tokenize(@epub:type,' ')='epigraph']   or self::html:p[tokenize(@class,' ')='linegroup'] or
  	                          self::html:*[self::html:ul or self::html:ol][not(ancestor::html:nav)]       or self::html:a[tokenize(@epub:type,' ')='note']       or self::html:p        or
  	                          self::html:*[tokenize(@epub:type,' ')='z3998:poem']       or self::html:*[(self::figure or self::aside) and tokenize(@epub:type,'s')='sidebar']    or self::html:table    or
  	                          self::html:*[matches(local-name(),'^h\d$') and tokenize(@class,' ')='title']      or self::html:section or self::html:article]">
            <sch:report
                test="following-sibling::html:a      or following-sibling::html:abbr or following-sibling::html:acronym or following-sibling::html:a[tokenize(@epub:type,' ')='annoref'] or
  	                    following-sibling::html:bdo    or following-sibling::html:code or following-sibling::html:dfn     or following-sibling::html:em      or
  	                    following-sibling::html:kbd or following-sibling::html:p[tokenize(@class,' ')='linenum'] or following-sibling::html:a[tokenize(@epub:type,' ')='noteref'] or
  	                    following-sibling::html:q      or following-sibling::html:samp or following-sibling::html:span[tokenize(@epub:type,' ')='z3998:sentence']    or following-sibling::html:span[not(tokenize(@epub:type,'\s+')='pagebreak') and not(tokenize(@class,'\s+')='lic')]    or
  	                    following-sibling::html:strong or following-sibling::html:sub  or following-sibling::html:sup     or following-sibling::html:span[tokenize(@epub:type,' ')='z3998:word']       or
  	                    (following-sibling::text()/normalize-space()!='' and not(parent::html:li))"
                >Block element as sibling to inline element</sch:report>
            <sch:report
                test="preceding-sibling::html:a      or preceding-sibling::html:abbr or preceding-sibling::html:acronym or preceding-sibling::html:a[tokenize(@epub:type,' ')='annoref'] or
  	                    preceding-sibling::html:bdo    or preceding-sibling::html:code or preceding-sibling::html:dfn     or preceding-sibling::html:em      or
  	                    preceding-sibling::html:kbd or preceding-sibling::html:p[tokenize(@class,' ')='linenum'] or preceding-sibling::html:a[tokenize(@epub:type,' ')='noteref'] or
  	                    preceding-sibling::html:q      or preceding-sibling::html:samp or preceding-sibling::html:span[tokenize(@epub:type,' ')='z3998:sentence']    or preceding-sibling::html:span[not(tokenize(@epub:type,'\s+')='pagebreak') and not(tokenize(@class,'\s+')='lic')]    or
  	                    preceding-sibling::html:strong or preceding-sibling::html:sub  or preceding-sibling::html:sup     or preceding-sibling::html:span[tokenize(@epub:type,' ')='z3998:word']       or
  	                    (preceding-sibling::text()/normalize-space(.)!='' and not(parent::html:li))"
                >[tpb29] Block element <sch:name/> as sibling to inline element</sch:report>
        </sch:rule>
    </sch:pattern>

    <!-- Rule 29: No block elements in inline context - continued -->
    <sch:pattern id="dtbook_TPB_29c">
        <sch:rule
            context="html:*[tokenize(@epub:type,' ')='z3998:production'][ancestor::html:a        or ancestor::html:abbr       or ancestor::html:acronym    or ancestor::html:a[tokenize(@epub:type,' ')='annoref']   or
                                     ancestor::html:bdo      or ancestor::html:code       or ancestor::html:dfn        or ancestor::html:em        or
                                     ancestor::html:kbd      or ancestor::html:p[tokenize(@class,' ')='linenum']    or ancestor::html:a[tokenize(@epub:type,' ')='noteref']    or
                                     ancestor::html:q        or ancestor::html:samp       or ancestor::html:span[tokenize(@epub:type,' ')='z3998:sentence']       or ancestor::html:span      or
                                     ancestor::html:strong   or ancestor::html:sub        or ancestor::html:sup        or ancestor::html:span[tokenize(@epub:type,' ')='z3998:word']         or
                                     ancestor::html:address  or ancestor::html:*[tokenize(@epub:type,' ')='z3998:author' and not(parent::html:header[parent::html:body])]     or ancestor::html:p[tokenize(@epub:type,' ')='bridgehead'] or ancestor::html:*[tokenize(@class,' ')='byline']    or
                                     ancestor::html:cite     or ancestor::html:*[tokenize(@epub:type,' ')='covertitle'] or ancestor::html:*[tokenize(@class,' ')='dateline']   or ancestor::html:p[parent::html:header[parent::html:body] and tokenize(@epub:type,' ')='z3998:author'] or
                                     ancestor::html:h1[tokenize(@epub:type,' ')='fulltitle'] or ancestor::html:dt         or ancestor::html:h1         or ancestor::html:h2        or
                                     ancestor::html:h3       or ancestor::html:h4         or ancestor::html:h5         or ancestor::html:h6        or
                                     ancestor::html:p[tokenize(@class,' ')='line']       or ancestor::html:p]">
            <sch:report
                test="descendant::html:*[self::html:address    or self::html:aside[tokenize(@epub:type,' ')='annotation'] or self::html:*[tokenize(@epub:type,' ')='z3998:author' and not(parent::html:header[parent::html:body])]   or
  	                                       self::html:blockquote or self::html:p[tokenize(@epub:type,' ')='bridgehead'] or self::html:caption  or
                                           self::html:*[tokenize(@class,' ')='dateline']   or self::html:div        or self::html:dl       or
                                           self::html:p[parent::html:header[parent::html:body] and tokenize(@epub:type,' ')='z3998:author']  or self::html:h1[tokenize(@epub:type,' ')='fulltitle']   or
                                           self::html:aside[tokenize(@epub:type,' ')='epigraph']   or self::html:p[tokenize(@class,' ')='line']     or
  	                                       self::html:*[tokenize(@class,' ')='linegroup']  or
                                           self::html:*[self::html:ul or self::html:ol]       or self::html:a[tokenize(@epub:type,' ')='note']       or self::html:p        or
                                           self::html:*[tokenize(@epub:type,' ')='z3998:poem']       or self::html:*[(self::figure or self::aside) and tokenize(@epub:type,'s')='sidebar']    or self::html:table    or
                                           self::html:*[matches(local-name(),'^h\d$') and tokenize(@class,' ')='title']]"
                >[tpb29] Prodnote in inline context used as block element</sch:report>
        </sch:rule>
    </sch:pattern>

    <!-- Rule 40: No page numbering gaps for pagebreak w/page-normal -->
    <sch:pattern id="dtbook_TPB_40">
        <sch:rule context="html:*[tokenize(@epub:type,' ')='pagebreak'][tokenize(@class,' ')='page-normal']">
            <sch:report
                test="preceding::html:*[tokenize(@epub:type,' ')='pagebreak'][tokenize(@class,' ')='page-normal'] and number(preceding::html:*[tokenize(@epub:type,' ')='pagebreak'][tokenize(@class,' ')='page-normal'][1]/@title) != number(@title)-1"
                >[tpb40] No gaps may occur in page numbering</sch:report>
        </sch:rule>
    </sch:pattern>

    <!-- Rule 50: image alt attribute -->
    <sch:pattern id="dtbook_TPB_50">
        <sch:rule context="html:img[parent::html:figure/tokenize(@class,'\s+')='image']">
            <sch:report test="string(@alt)!='image'">[tpb50] an image inside a figure with class='image' must have attribute alt="image"</sch:report>
        </sch:rule>
        <sch:rule context="html:img[not(parent::html:figure/tokenize(@class,'\s+')='image')]">
            <sch:report test="string(@alt)!=''">[tpb50] an image which is not inside a figure with class='image' is irrelevant or redundant with regards to the understanding of the book, so the alt
                attribute must be present but empty</sch:report>
        </sch:rule>
    </sch:pattern>

    <!-- Rule 51 & 52: -->
    <sch:pattern id="dtbook_TPB_5152">
        <sch:rule context="html:img">
            <sch:assert test="contains(@src,'.jpg') and substring-after(@src,'.jpg')=''">[tpb52] Images must have the .jpg file extension.</sch:assert>
            <sch:report test="contains(@src,'.jpg') and string-length(@src)=4">[tpb52] Images must have a base name, not just an extension.</sch:report>
            <sch:report test="not(matches(@src,'^images/[^/]+$'))">[tpb51] Images must be in the "images" folder (relative to the HTML file).</sch:report>
            <sch:assert test="string-length(translate(substring(@src,1,string-length(@src)-4),'-_abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/',''))=0">[tpb52] Image file name
                contains an illegal character (must be -_a-zA-Z0-9).</sch:assert>
        </sch:rule>
    </sch:pattern>

    <!-- Rule 59: No pagegnum between a term and a definition in definition lists -->
    <sch:pattern id="dtbook_TPB_59">
        <sch:rule context="html:dl/html:*[tokenize(@epub:type,' ')='pagebreak']">
            <sch:assert test="not(parent::*/html:dd or parent::*/html:dt)">[tpb59] pagebreak in definition list must not occur as siblings to dd or dt</sch:assert>
        </sch:rule>
    </sch:pattern>

    <!-- Rule 63: Only note references within the same document -->
    <sch:pattern id="dtbook_TPB_63">
        <sch:rule context="html:a[tokenize(@epub:type,' ')='noteref']">
            <sch:assert test="not(contains(@idref, '#')) or starts-with(@idref,'#')">[tpb63] Only note references within the same document are allowed</sch:assert>
        </sch:rule>
    </sch:pattern>

    <!-- Rule 64: Only annotation references within the same document -->
    <sch:pattern id="dtbook_TPB_64">
        <sch:rule context="html:a[tokenize(@epub:type,' ')='annoref']">
            <sch:assert test="not(contains(@idref, '#')) or starts-with(@idref,'#')">[tpb64] Only annotation references within the same document are allowed</sch:assert>
        </sch:rule>
    </sch:pattern>

    <!-- Rule 67: fulltitle only allowed in frontmatter -->
    <sch:pattern id="dtbook_TPB_67">
        <sch:rule context="html:h1[tokenize(@epub:type,' ')='fulltitle'][not(ancestor::html:header[parent::html:body])]">
            <sch:assert test="ancestor::html:*[tokenize(@epub:type,' ')='frontmatter']">[tpb67] fulltitle is only allowed in frontmatter</sch:assert>
        </sch:rule>
    </sch:pattern>

    <!-- Rule 68: No smilref attributes -->
    <sch:pattern id="dtbook_TPB_68">
        <sch:rule context="html:*">
            <sch:report test="@smilref">[tpb68] smilref attributes in a plain DTBook file is not allowed</sch:report>
        </sch:rule>
    </sch:pattern>

    <!-- Rule 93: Some elements may not start of end with whitespace -->
    <sch:pattern id="dtbook_TPB_93">
        <sch:rule context="html:*[self::html:h1 or self::html:h2 or self::html:h3 or self::html:h4 or self::html:h5 or self::html:h6]">
            <sch:report test="normalize-space(substring(.,1,1))=''">[tpb93] element <sch:name/> may not have leading whitespace</sch:report>
            <sch:report test="normalize-space(substring(.,string-length(.),1))='' and not(html:* and normalize-space(html:*[last()]/following-sibling::text())='')">[tpb93] element <sch:name/> may not
                have trailing whitespace</sch:report>
        </sch:rule>
    </sch:pattern>

    <!-- Rule 96: no nested prodnotes or image groups -->
    <sch:pattern id="dtbook_TPB_96">
        <sch:rule context="html:*[tokenize(@epub:type,' ')='z3998:production']">
            <sch:report test="ancestor::html:*[tokenize(@epub:type,' ')='z3998:production']">[tpb96] nested production notes are not allowed</sch:report>
        </sch:rule>
        <sch:rule context="html:figure[tokenize(@class,'\s+')='image-series']">
            <sch:report test="ancestor::html:figure[tokenize(@class,'\s+')='image-series']">[tpb96] nested image-series are not allowed</sch:report>
        </sch:rule>
    </sch:pattern>

    <!-- Rule 101: All imggroup elements must have a img element -->
    <sch:pattern id="dtbook_TPB_101">
        <sch:rule context="html:figure[tokenize(@class,'\s+')='image']">
            <sch:assert test="html:img">[tpb101] There must be an img element in every figure with class="image"</sch:assert>
        </sch:rule>
    </sch:pattern>

    <!-- Rule 103: No img without imggroup -->
    <sch:pattern id="dtbook_TPB_103">
        <sch:rule context="html:img[string-length(@alt)!=0]">
            <sch:assert test="parent::html:figure">[tpb103] There must be a figure element wrapping every img with a non-empty alt text</sch:assert>
        </sch:rule>
    </sch:pattern>

    <!-- Rule 104: Headings may not be empty elements -->
    <sch:pattern id="dtbook_TPB_104">
        <sch:rule context="html:*[self::html:h1 or self::html:h2 or self::html:h3 or self::html:h4 or self::html:h5 or self::html:h6]">
            <sch:report test="normalize-space(.)=''">[tpb104] Heading <sch:name/> may not be empty</sch:report>
        </sch:rule>
    </sch:pattern>

    <!-- Rule 105: Page attribute must appear on all pagebreak elements -->
    <sch:pattern id="dtbook_TPB_105">
        <sch:rule context="html:*[tokenize(@epub:type,' ')='pagebreak']">
            <sch:assert test="tokenize(@class,' ')=('page-front','page-normal','page-special')">[tpb105] Page breaks must have either a 'page-front', a 'page-normal' or a 'page-special'
                class.</sch:assert>
        </sch:rule>
    </sch:pattern>

    <!-- Rule 110: pagebreak in headings -->
    <sch:pattern id="dtbook_TPB_110">
        <sch:rule context="html:*[tokenize(@epub:type,' ')='pagebreak']">
            <sch:report test="ancestor::*[self::html:h1 or self::html:h2 or self::html:h3 or self::html:h4 or self::html:h5 or self::html:h6]">[tpb110] pagebreak elements are not allowed in
                headings</sch:report>
        </sch:rule>
    </sch:pattern>

    <!-- Rule 116: Don't allow arabic numbers in pagebreak w/page-front -->
    <sch:pattern id="dtbook_TPB_116">
        <sch:rule context="html:*[tokenize(@epub:type,' ')='pagebreak']">
            <sch:report test="tokenize(@class,' ')='page-front' and translate(.,'0123456789','xxxxxxxxxx')!=.">[tpb116] Arabic numbers when @class="page-front" are not allowed</sch:report>
        </sch:rule>
    </sch:pattern>

    <!-- Rule 120:  Allow only pagebreak before hx in section/article -->
    <sch:pattern id="dtbook_TPB_120">
        <sch:rule context="html:*[self::html:h1 or self::html:h2 or self::html:h3 or self::html:h4 or self::html:h5 or self::html:h6]">
            <sch:assert test="not(preceding-sibling::html:*) or preceding-sibling::html:*[tokenize(@epub:type,' ')='pagebreak']">[tpb120] Only pagebreaks are allowed before the heading
                <sch:name/>.</sch:assert>
        </sch:rule>
    </sch:pattern>

    <!-- Rule 121:  pagebreaks in tables must not occur between table rows -->
    <sch:pattern id="dtbook_TPB_121">
        <sch:rule context="html:*[tokenize(@epub:type,' ')='pagebreak'][ancestor::html:table]">
            <sch:assert test="not(../html:tr)">[tpb121] Page numbers in tables must not be placed between table rows.</sch:assert>
        </sch:rule>
    </sch:pattern>

    <!-- Rule 123 (39): No class attributes on level[2-6]. level1 allows 'part', 'nonstandardpagination', 'colophon' (if located in frontmatter) and 'cover' (if located in frontmatter and immediately after docauthor or doctitle) -->
    <sch:pattern id="dtbook_TPB_123">
        <sch:rule context="html:*[(self::html:section or self::html:article) and count(//html:body/html:header) and count(ancestor::html:section | ancestor::html:article) = 0]">
            <sch:report test="tokenize(@epub:type,'\s+')='cover' and tokenize(@epub:type,'\s+')=('frontmatter','bodymatter','backmatter')">[tpb123] Cover (Jacket copy) is a document partition and can
                not be part the other document partitions frontmatter, bodymatter and rearmatter</sch:report>
        </sch:rule>
    </sch:pattern>

    <!-- Rule 125 (109): Only allow images in JPG format -->
    <sch:pattern id="dtbook_TPB_125">
        <sch:rule context="html:img">
            <sch:assert test="string-length(@src)>=5">[tpb125] Invalid image filename.</sch:assert>
            <sch:assert test="substring(@src,string-length(@src) - 3, 4)='.jpg'">[tpb125] Images must be in JPG (*.jpg) format.</sch:assert>
        </sch:rule>
    </sch:pattern>

    <!-- Rule 126: pagebreak must not occur directly after hx unless the hx is preceded by a pagebreak -->
    <sch:pattern id="dtbook_TPB_126">
        <sch:rule context="html:*[tokenize(@epub:type,' ')='pagebreak']">
            <sch:report
                test="preceding-sibling::*[1][self::html:h1 or self::html:h2 or self::html:h3 or self::html:h4 or self::html:h5 or self::html:h6] and
  		                  not(preceding-sibling::*[2][self::html:*[tokenize(@epub:type,' ')='pagebreak']])"
                >[tpb126] pagebreak must not occur directly after hx unless the hx is preceded by a pagebreak</sch:report>
        </sch:rule>
    </sch:pattern>

    <!-- Rule 127: Table of contents must be inside a level1 -->
    <sch:pattern id="dtbook_TPB_127">
        <sch:rule context="html:*[@class='toc']">
            <sch:assert test="self::html:nav[parent::html:body or parent::html:section/parent::html:body/html:header]">[tpb127] The "toc" class is only allowed on the main nav element.</sch:assert>
            <sch:assert test="self::html:nav[tokenize(@epub:type,' ')='toc']">[tpb127] The main nav element must use the epub:type "toc".</sch:assert>
            <!--<sch:assert test="parent::html:*[(self::html:section or self::html:article) and //html:body/html:header and count(ancestor::html:section | ancestor::html:article) = 0]">[tpb127] Table of contents (&lt;list class="toc"&gt;)must be inside a level1</sch:assert>
      <sch:report test="ancestor::html:*[self::html:ul or self::html:ol][@class='toc']">[tpb127] Nested lists in table of contents must not have a 'toc' attribute</sch:report>-->
        </sch:rule>
    </sch:pattern>

    <sch:pattern id="epub_nordic_127">
        <sch:rule context="html:*[tokenize(@epub:type,' ')='toc']">
            <sch:assert test="ancestor::*[tokenize(@epub:type,' ')=('frontmatter','backmatter') or tokenize(base-uri(),'/')[last()]='nav.xhtml']">[nordic127] The epub:type "toc" is only allowed in
                frontmatter, backmatter, and in the EPUB3 Navigation Document (nav.xhtml).</sch:assert>
        </sch:rule>
    </sch:pattern>

    <!-- Rule 128: tracking metadata must exist (nordic:guidelines) -->
    <sch:pattern id="dtbook_TPB_128">
        <sch:rule context="html:html[//html:body/html:header]">
            <sch:assert test="namespace-uri-for-prefix('nordic',.)='http://www.mtm.se/epub/'">[tpb128] xmlns:nordic="http://www.mtm.se/epub/" must be defined on the root html element.</sch:assert>
        </sch:rule>
        <sch:rule context="html:head[//html:body/html:header]">
            <sch:assert test="count(html:meta[@name='nordic:guidelines'])=1">[tpb128] nordic:guidelines metadata must occur once.</sch:assert>
        </sch:rule>
        <sch:rule context="html:meta[//html:body/html:header][@name='nordic:guidelines']">
            <sch:assert test="@content='2015-1'">[tpb128] nordic:guidelines metadata value must be 2015-1.</sch:assert>
        </sch:rule>
        <sch:rule context="html:head[//html:body/html:header]">
            <sch:assert test="count(html:meta[@name='nordic:supplier'])=1">[tpb128] nordic:supplier metadata must occur once.</sch:assert>
        </sch:rule>
    </sch:pattern>

    <!-- Rule 129: Class attribute of p -->
    <!--<sch:pattern id="dtbook_TPB_129">
    <sch:rule context="html:p[@class]">
      <sch:assert
        test="@class='precedingemptyline' or @class='precedingseparator' or @class='indented' or @class='precedingseparator indented'
  		        or @class='precedingemptyline indented' or @class='asciimath'"
        >[tpb129] Class attribute of &lt;p&gt; must be one (or more) of 'precedingemptyline', 'precedingseparator', 'indented' or 'asciimath'</sch:assert>
    </sch:rule>
  </sch:pattern>-->

    <!-- Rule 130 (44): dc:language must equal root element xml:lang -->
    <sch:pattern id="dtbook_TPB_130">
        <sch:rule context="html:meta[@name='dc:language']">
            <sch:assert test="@content=/html:html/@xml:lang">[tpb130] dc:language metadata must equal the root element xml:lang</sch:assert>
        </sch:rule>
    </sch:pattern>

    <!-- Rule 131 (35): Allowed values in xml:lang -->
    <sch:pattern id="dtbook_TPB_131">
        <sch:rule context="*[@xml:lang]">
            <sch:assert test="matches(@xml:lang,'^[a-z][a-z](-[A-Z][A-Z]+)?$')">[tpb131] xml:lang must match '^[a-z][a-z](-[A-Z][A-Z]+)?$'</sch:assert>
        </sch:rule>
    </sch:pattern>

    <!-- Rule 133: Disallowed elements -->
    <sch:pattern id="dtbook_TPB_133">
        <sch:rule
            context="html:*[self::html:aside[tokenize(@epub:type,' ')='epigraph'] or self::html:*[tokenize(@class,' ')='byline'] or
  	                          self::html:*[tokenize(@class,' ')='dateline'] or self::html:cite or self::html:span[tokenize(@epub:type,' ')='z3998:sentence'] or self::html:span[tokenize(@epub:type,' ')='z3998:word'] or
  	                          self::html:*[tokenize(@epub:type,' ')='covertitle'] or self::html:p[tokenize(@epub:type,' ')='bridgehead'] or
  	                          self::html:colgroup or self::html:col or
  	                          self::html:address or self::html:aside[tokenize(@epub:type,' ')='annotation'] or self::html:dfn or
  	                          self::html:kbd or self::html:samp or
  	                          self::html:q or self::html:bdo or self::html:bdo or self::html:a[tokenize(@epub:type,' ')='annoref']]">
            <sch:assert test="false()">[tpb133] Element <sch:name/> is disallowed</sch:assert>
        </sch:rule>
    </sch:pattern>

    <!-- Rule 134: Disallowed attributes -->
    <!--<sch:pattern id="dtbook_TPB_134">
        <sch:rule context="html:a[tokenize(@epub:type,' ')='note']">
            <sch:report test="@class">[tpb134] Attribute 'class' is not allowed on the <sch:name/> element</sch:report>
        </sch:rule>
        <sch:rule context="html:a[tokenize(@epub:type,' ')='noteref']">
            <sch:report test="@class">[tpb134] Attribute 'class' is not allowed on the <sch:name/> element</sch:report>
        </sch:rule>
        <sch:rule context="html:meta">
            <sch:report test="@scheme">[tpb134] Attribute 'scheme' is not allowed on the <sch:name/> element</sch:report>
            <sch:report test="@http-equiv">[tpb134] Attribute 'http-equiv' is not allowed on the <sch:name/> element</sch:report>
        </sch:rule>
    </sch:pattern>-->

    <!-- Rule 135: Poem contents -->
    <sch:pattern id="dtbook_TPB_135">
        <!--<sch:rule
            context="html:*[self::html:*[matches(local-name(),'^h\d$') and tokenize(@class,' ')='title'] or self::html:*[tokenize(@epub:type,' ')='z3998:author' and not(parent::html:header[parent::html:body])]]">
            <sch:assert test="parent::html:*[tokenize(@epub:type,' ')='z3998:poem']">[tpb135] Element <sch:name/> is only allowed in poem context</sch:assert>
        </sch:rule>-->
        <sch:rule context="html:*[tokenize(@epub:type,' ')='z3998:poem']">
            <sch:assert test="html:*[tokenize(@class,' ')='linegroup']">[tpb135] Every poem must contain a linegroup</sch:assert>
            <sch:report test="html:p[tokenize(@class,' ')='line']">[tpb135] Poem lines must be wrapped in a linegroup</sch:report>
        </sch:rule>
        <sch:rule context="html:*[tokenize(@epub:type,'\s+')='z3998:author']">
            <sch:assert test="parent::html:*/tokenize(@epub:type,'\s+')='z3998:poem' or parent::html:header/parent::html:body">[tpb135] z3998:author is only allowed inside a poem</sch:assert>
        </sch:rule>
        <!-- TODO: in guidelines revision 2015-2, make sure that verses are contained in poems -->
    </sch:pattern>

    <!-- Rule 136: List types -->
    <!--<sch:pattern id="dtbook_TPB_136">
    <sch:rule context="html:*[self::html:ul or self::html:ol]">
      <sch:assert test="@type='pl'">[tpb136] Lists must be of type 'pl' (with any bullets or numbers in the text node)</sch:assert>
    </sch:rule>
  </sch:pattern>-->

    <!-- Rule 140: Jacket copy must contain at least one prodnote, at most one of each @class value and no other elements -->
    <sch:pattern id="dtbook_TPB_140">
        <sch:rule context="html:body[tokenize(@epub:type,'\s+')='cover'] | html:section[tokenize(@epub:type,'\s+')='cover']">
            <sch:assert test="count(*)=count(html:section)">[tpb140] Only prodnote allowed in jacket copy</sch:assert>
            <sch:assert test="count(html:section)>=1">[tpb140] There must be at least one prodnote in jacket copy</sch:assert>
            <sch:report test="count(html:section[@class='frontcover'])>1">[tpb140] Too many prodnotes with @class='frontcover' in jacket copy</sch:report>
            <sch:report test="count(html:section[@class='rearcover'])>1">[tpb140] Too many prodnotes with @class='rearcover' in jacket copy</sch:report>
            <sch:report test="count(html:section[@class='leftflap'])>1">[tpb140] Too many prodnotes with @class='leftflap' in jacket copy</sch:report>
            <sch:report test="count(html:section[@class='rightflap'])>1">[tpb140] Too many prodnotes with @class='rightflap' in jacket copy</sch:report>
        </sch:rule>
    </sch:pattern>

    <!-- Rule 141: Prodnotes in jacket copy must contain text and have a @class=['frontcover', 'rearcover', 'leftflap' or 'rightflap'] -->
    <sch:pattern id="dtbook_TPB_141">
        <sch:rule context="html:section[tokenize(parent::*/@epub:type,' ')='cover']">
            <sch:assert test="tokenize(@class,' ')='frontcover' or tokenize(@class,' ')='rearcover' or tokenize(@class,' ')='leftflap' or tokenize(@class,' ')='rightflap'">[tpb141] prodnote in jacket
                copy must have a class attribute with one of 'frontcover', 'rearcover', 'leftflap' or 'rightflap'</sch:assert>
        </sch:rule>
    </sch:pattern>

    <!-- Rule 142: Only tokenize(@class,' ')='page-special' in level1/@class='nonstandardpagination' -->
    <sch:pattern id="dtbook_TPB_142">
        <sch:rule context="html:*[tokenize(@epub:type,' ')='pagebreak'][ancestor::html:section[@class='nonstandardpagination']]">
            <sch:assert test="tokenize(@class,' ')='page-special'">[tpb142] The class page-special must be used in section/@class='nonstandardpagination'</sch:assert>
        </sch:rule>
    </sch:pattern>

    <!-- Rule 143: Don't allow pagebreak as siblings to list items or inside the first list item -->
    <sch:pattern id="dtbook_TPB_143">
        <sch:rule context="html:*[tokenize(@epub:type,' ')='pagebreak'][parent::html:*[self::html:ul or self::html:ol]]">
            <sch:report test="../html:li">[tpb143] pagebreak is not allowed as sibling to list items</sch:report>
        </sch:rule>
        <sch:rule context="html:*[tokenize(@epub:type,' ')='pagebreak'][parent::html:li]">
            <sch:assert test="../preceding-sibling::html:li or preceding-sibling::* or preceding-sibling::text()[normalize-space()]">[tpb143] pagebreak is not allowed at the beginning of the first
                list item; it should be placed before the list</sch:assert>
        </sch:rule>
    </sch:pattern>

    <!-- Rule 200: The title element must contain the same text as the first headline in the document -->
    <sch:pattern id="epub_nordic_200">
        <sch:rule context="html:title">
            <sch:assert test="text() and not(normalize-space(.)='')">[nordic200] The title element must not be empty.</sch:assert>
            <!--<sch:assert test="normalize-space(.) = normalize-space((//html:h1)[1])">[nordic200] The title element must contain the same text as the first headline in the document.</sch:assert>-->
        </sch:rule>
    </sch:pattern>

    <!-- Rule 201: cover -->
    <sch:pattern id="epub_nordic_201">
        <sch:rule context="html:*[tokenize(@epub:type,' ')='cover']">
            <!-- no required type other than cover  -->
        </sch:rule>
    </sch:pattern>

    <!-- Rule 202: frontmatter -->
    <sch:pattern id="epub_nordic_202">
        <sch:rule context="html:*[tokenize(@epub:type,' ')='frontmatter']">
            <!-- types can be titlepage, colophon, toc, foreword, introduction or blank -->
        </sch:rule>
    </sch:pattern>

    <!-- Rule 203: Check that both the epub:types "rearnote" and "rearnotes" are used in rearnotes -->
    <sch:pattern id="epub_nordic_203">
        <!--
            disable until https://github.com/nlbdev/nordic-epub3-dtbook-migrator/issues/160 is fixed
        <sch:rule context="html:*[ancestor::html:body[html:header] and tokenize(@epub:type,'\s+')='rearnote']">
            <sch:assert test="ancestor::html:section[tokenize(@epub:type,'\s+')='rearnotes']">[nordic203] 'rearnote' must have a section ancestor with 'rearnotes'.</sch:assert>
        </sch:rule>
        <sch:rule context="html:*[not(ancestor::html:body[html:header]) and tokenize(@epub:type,'\s+')='rearnote']">
            <sch:assert test="ancestor::html:body[tokenize(@epub:type,'\s+')='rearnotes']">[nordic203] 'rearnote' must have a body ancestor with 'rearnotes'.</sch:assert>
        </sch:rule>
        -->
        <sch:rule context="html:body[tokenize(@epub:type,'\s+')='rearnotes'] | html:section[tokenize(@epub:type,'\s+')='rearnotes']">
            <sch:assert test="descendant::html:*[tokenize(@epub:type,'\s+')='rearnote']">[nordic203] 'rearnotes' must have descendants with 'rearnote'.</sch:assert>
        </sch:rule>
        <sch:rule context="html:*[tokenize(@epub:type,'\s+')='rearnote']">
            <sch:assert test="self::html:li">[nordic203] 'rearnote' can only be applied to &lt;li&gt; elements.</sch:assert>
            <sch:assert test="tokenize(@class,'\s+')='notebody'">[nordic203] The 'notebody' class must be applied to all rearnotes.</sch:assert>
        </sch:rule>
    </sch:pattern>

    <!-- Rule 204: Check that both the epub:types "rearnote" and "rearnotes" are used in rearnotes -->
    <sch:pattern id="epub_nordic_204">
        <!--
            disable until https://github.com/nlbdev/nordic-epub3-dtbook-migrator/issues/160 is fixed
        <sch:rule context="html:*[ancestor::html:body[html:header] and tokenize(@epub:type,'\s+')='footnote']">
            <sch:assert test="count(ancestor::html:section | ancestor::html:article) = 1">[nordic204] footnotes must be placed in a top-level section. Remember that footnotes should be placed in a
                separate file from the rest of the content.</sch:assert>
            <sch:assert test="ancestor::html:section[tokenize(@epub:type,'\s+')='footnotes']">[nordic204] 'footnote' must have a section ancestor with 'footnotes'.</sch:assert>
        </sch:rule>
        <sch:rule context="html:*[not(ancestor::html:body[html:header]) and tokenize(@epub:type,'\s+')='footnote']">
            <sch:assert test="count(ancestor::html:section | ancestor::html:article) = 0">[nordic204] footnotes must be placed in a top-level sectioning element (i.e. not in section element, only in
                the body element). Remember that footnotes should be placed in a separate file from the rest of the content.</sch:assert>
            <sch:assert test="ancestor::html:body[tokenize(@epub:type,'\s+')='footnotes']">[nordic204] 'footnote' must have a body ancestor with 'footnotes'.</sch:assert>
        </sch:rule>
        -->
        <sch:rule context="html:body[tokenize(@epub:type,'\s+')='footnotes'] | html:section[tokenize(@epub:type,'\s+')='footnotes']">
            <sch:assert test="descendant::html:*[tokenize(@epub:type,'\s+')='footnote']">[nordic204] 'footnotes' must have descendants with 'footnote'.</sch:assert>
        </sch:rule>
        <sch:rule context="html:*[tokenize(@epub:type,'\s+')='footnote']">
            <sch:assert test="self::html:li">[nordic204] 'footnote' can only be applied to &lt;li&gt; elements.</sch:assert>
            <sch:assert test="tokenize(@class,'\s+')='notebody'">[nordic204] The 'notebody' class must be applied to all footnotes.</sch:assert>
        </sch:rule>
    </sch:pattern>

    <!-- Rule 208: bodymatter -->
    <sch:pattern id="epub_nordic_208">
        <sch:rule context="html:*[tokenize(@epub:type,' ')='bodymatter']">
            <!-- types can be prologue, preface, part, chapter, conclusion, epilogue -->
            <sch:assert
                test="tokenize(@epub:type,' ')=('acknowledgments','afterword','appendix','assessment','bibliography','z3998:biographical-note','chapter','colophon','conclusion','contributors','copyright-page','dedication','z3998:discography','division','z3998:editorial-note','epigraph','epilogue','errata','z3998:filmography','footnotes','foreword','z3998:glossary','z3998:grant-acknowledgment','halftitlepage','imprimatur','imprint','index','index-group','index-headnotes','index-legend','introduction','landmarks','loa','loi','lot','lov','notice','other-credits','page-list','part','practices','preamble','preface','prologue','z3998:promotional-copy','z3998:published-works','z3998:publisher-address','qna','rearnotes','revision-history','z3998:section','standard','subchapter','z3998:subsection','titlepage','toc','z3998:translator-note','volume','warning')"
                >[nordic208] top-level sectioning elements with the type "bodymatter" must also have one of the types
                'acknowledgments','afterword','appendix','assessment','bibliography','z3998:biographical-note','chapter','colophon','conclusion','contributors','copyright-page','dedication','z3998:discography','division','z3998:editorial-note','epigraph','epilogue','errata','z3998:filmography','footnotes','foreword','z3998:glossary','z3998:grant-acknowledgment','halftitlepage','imprimatur','imprint','index','index-group','index-headnotes','index-legend','introduction','landmarks','loa','loi','lot','lov','notice','other-credits','page-list','part','practices','preamble','preface','prologue','z3998:promotional-copy','z3998:published-works','z3998:publisher-address','qna','rearnotes','revision-history','z3998:section','standard','subchapter','z3998:subsection','titlepage','toc','z3998:translator-note','volume','warning'</sch:assert>
        </sch:rule>
    </sch:pattern>

    <!-- Rule 211: bodymatter.part -->
    <sch:pattern id="epub_nordic_211">
        <sch:rule context="html:*[self::html:section or self::html:article][parent::html:section[tokenize(@epub:type,' ')=('part','volume')]]">
            <!-- types can be prologue, preface, chapter, conclusion, epilogue -->
            <sch:assert
                test="tokenize(@epub:type,' ')=('acknowledgments','afterword','appendix','assessment','bibliography','z3998:biographical-note','chapter','colophon','conclusion','contributors','copyright-page','dedication','z3998:discography','division','z3998:editorial-note','epigraph','epilogue','errata','z3998:filmography','footnotes','foreword','z3998:glossary','z3998:grant-acknowledgment','halftitlepage','imprimatur','imprint','index','index-group','index-headnotes','index-legend','introduction','landmarks','loa','loi','lot','lov','notice','other-credits','page-list','part','practices','preamble','preface','prologue','z3998:promotional-copy','z3998:published-works','z3998:publisher-address','qna','rearnotes','revision-history','z3998:section','standard','subchapter','z3998:subsection','titlepage','toc','z3998:translator-note','volume','warning')"
                >[nordic208] top-level sectioning elements inside sectioning elements with the type "part" must have one of the types:
                'acknowledgments','afterword','appendix','assessment','bibliography','z3998:biographical-note','chapter','colophon','conclusion','contributors','copyright-page','dedication','z3998:discography','division','z3998:editorial-note','epigraph','epilogue','errata','z3998:filmography','footnotes','foreword','z3998:glossary','z3998:grant-acknowledgment','halftitlepage','imprimatur','imprint','index','index-group','index-headnotes','index-legend','introduction','landmarks','loa','loi','lot','lov','notice','other-credits','page-list','part','practices','preamble','preface','prologue','z3998:promotional-copy','z3998:published-works','z3998:publisher-address','qna','rearnotes','revision-history','z3998:section','standard','subchapter','z3998:subsection','titlepage','toc','z3998:translator-note','volume','warning'</sch:assert>
        </sch:rule>
    </sch:pattern>

    <!-- Rule 215: rearmatter -->
    <sch:pattern id="epub_nordic_215">
        <sch:rule context="html:*[tokenize(@epub:type,' ')='backmatter']">
            <!-- types can be afterword, toc, index, appendix, glossary, footnotes, rearnotes or blank -->
        </sch:rule>
    </sch:pattern>

    <!-- Rule 224: linenum - span -->
    <sch:pattern id="epub_nordic_224">
        <sch:rule context="html:span[tokenize(@class,' ')='linenum']">
            <sch:assert test="ancestor::html:p[tokenize(@class,' ')='line']">[nordic224] linenums (span class="linenum") must be part of a line (p class="line")</sch:assert>
        </sch:rule>
    </sch:pattern>

    <!-- Rule 225: pagebreak -->
    <sch:pattern id="epub_nordic_225">
        <sch:rule context="html:*[tokenize(@epub:type,' ')='pagebreak' and text()]">
            <sch:assert test="matches(@title,'.+')">[nordic225] The title attribute must be used to describe the page number.</sch:assert>
        </sch:rule>
    </sch:pattern>

    <!-- Rule 229: attlist.prodnote -->
    <!--<sch:pattern id="epub_nordic_229">
    <sch:rule context="html:*[tokenize(@epub:type,' ')='z3998:production']">
      <sch:assert test="tokenize(@class,' ')=('render-required','render-optional')">[nordic229] Prodnotes must have either a 'render-required' or a 'render-optional' class.</sch:assert>
    </sch:rule>
  </sch:pattern>-->

    <!-- Rule 231: attlist.sidebar -->
    <!--<sch:pattern id="epub_nordic_231">
    <sch:rule context="html:section[tokenize(@epub:type,' ')='sidebar']">
      <sch:assert test="tokenize(@class,' ')=('render-required','render-optional')">[nordic231] Sidebars must have either a 'render-required' or a 'render-optional' class.</sch:assert>
    </sch:rule>
  </sch:pattern>-->

    <!-- Rule 246: doctitle - p -->
    <!--<sch:pattern id="epub_nordic_246">
    <sch:rule context="html:*[tokenize(@epub:type,' ')='fulltitle']">
      <sch:assert test="self::html:h1">[nordic246] The fulltitle (doctitle) must be a h1 element.</sch:assert>
      <sch:assert test="parent::html:header[parent::html:body]">[nordic246] The fulltitle (doctitle) must be inside a header element which must be inside the body element.</sch:assert>
    </sch:rule>
  </sch:pattern>-->

    <!-- Rule 247: doctitle.headline - h1 -->
    <sch:pattern id="epub_nordic_247">
        <sch:rule context="html:body/html:header/html:h1">
            <sch:assert test="tokenize(@epub:type,' ')='fulltitle'">[nordic247] The first headline in the html:body/html:header element must have the 'fulltitle' epub:type.</sch:assert>
        </sch:rule>
    </sch:pattern>

    <!-- Rule 248: docauthor - p -->
    <sch:pattern id="epub_nordic_248">
        <sch:rule context="html:body/html:header/html:*[not(self::html:h1)]">
            <sch:assert test="self::html:p">[nordic248] The only allowed element inside html/header besides "h1" is "p".</sch:assert>
            <sch:assert test="tokenize(@epub:type,' ')=('z3998:author','covertitle')">[nordic248] Inside body/header; all p elements must have a epub:type and they must be either 'z3998:author' or
                'covertitle'.</sch:assert>
        </sch:rule>
    </sch:pattern>

    <!-- Rule 251: lic - span -->
    <sch:pattern id="epub_nordic_251">
        <sch:rule context="html:span[tokenize(@class,' ')='lic']">
            <sch:assert test="parent::html:li">[nordic251] The parent of a list item component (span class="lic") must be a "li".</sch:assert>
        </sch:rule>
    </sch:pattern>

    <!-- Rule 253: figures and captions -->
    <sch:pattern id="epub_nordic_253">
        <sch:rule context="html:figure">
            <sch:assert test="tokenize(@epub:type,'\s+')='sidebar' or tokenize(@class,'\s+')=('image','image-series')">[nordic253a] Figures must either have an epub:type of "sidebar" or a class of
                "image" or "image-series".</sch:assert>
            <sch:assert test="count((.[tokenize(@epub:type,'\s+')='sidebar'], .[tokenize(@class,'\s+')='image'], .[tokenize(@class,'\s+')='image-series'])) = 1">[nordic253a] Figures must either have
                an epub:type of "sidebar" or a class of "image" or "image-series".</sch:assert>

            <sch:assert test="count(html:figcaption) &lt;= 1">[nordic253b] There cannot be more than one figure caption in a single figure element.</sch:assert>
        </sch:rule>
        <sch:rule context="html:figure[tokenize(@class,'\s+')='image']">
            <sch:assert test="count(.//html:img) = 1">[nordic253c] Image figures must contain exactly one img.</sch:assert>
            <sch:assert test="count(html:img) = 1">[nordic253c] The img in image figures must be a direct child of the figure.</sch:assert>
        </sch:rule>
        <sch:rule context="html:figure[tokenize(@class,'\s+')='image-series']">
            <sch:assert test="count(html:img) = 0">[nordic253d] Image series figures cannot contain img childen (the img elements must be contained in children figure elements).</sch:assert>
            <sch:assert test="count(html:figure[tokenize(@class,'\s+')='image']) &gt;= 2">[nordic253e] Image series must contain at least 2 image figures ("figure" elements with class
                "image").</sch:assert>
        </sch:rule>
    </sch:pattern>

    <!-- Rule 254: aside types -->
    <sch:pattern id="epub_nordic_254">
        <sch:rule context="html:aside">
            <sch:assert test="tokenize(@epub:type,' ') = ('z3998:production','sidebar','note','annotation','epigraph')">[nordic254] "aside" elements must use one of the following epub:types:
                z3998:production, sidebar, note, annotation, epigraph</sch:assert>
        </sch:rule>
    </sch:pattern>

    <!-- Rule 255: abbr types -->
    <sch:pattern id="epub_nordic_255">
        <sch:rule context="html:abbr">
            <sch:assert test="tokenize(@epub:type,' ') = ('z3998:acronym','z3998:initialism','z3998:truncation')">[nordic255] "abbr" elements must use one of the following epub:types: z3998:acronym
                (formed from the first part of a word: "Mr.", "approx.", "lbs.", "rec'd"), z3998:initialism (each letter pronounced separately: "XML", "US"), z3998:truncation (pronounced as a word:
                "NATO").</sch:assert>
        </sch:rule>
    </sch:pattern>

    <!-- Rule 256: HTML documents with only a headline -->
    <sch:pattern id="epub_nordic_256">
        <sch:rule context="html:body[*[last()]/self::html:h1 and *[position() &lt; last()]/self::html:div and tokenize(@epub:type,'\s+')='bodymatter']">
            <sch:assert test="tokenize(@epub:type,'\s+')='part'">[nordic256] In bodymatter, documents only containing a headline are only allowed when epub:type="part".</sch:assert>
        </sch:rule>
    </sch:pattern>

    <!-- Rule 257: always require both xml:lang and lang -->
    <sch:pattern id="epub_nordic_257">
        <sch:rule context="*[@xml:lang or @lang]">
            <sch:assert test="@xml:lang = @lang">[nordic257] The `xml:lang` and the `lang` attributes must have the same value.</sch:assert>
        </sch:rule>
    </sch:pattern>

    <!-- Rule 258: allow at most one pagebreak before any content in each content file -->
    <sch:pattern id="epub_nordic_258">
        <sch:rule context="html:div[../html:body and tokenize(@epub:type,'\s')='pagebreak']">
            <sch:report test="preceding-sibling::html:div[tokenize(@epub:type,'\s')='pagebreak']">[nordic258] Only one pagebreak is allowed before any content in each content file.</sch:report>
        </sch:rule>
    </sch:pattern>

    <!-- Rule 259: don't allow pagenum in thead -->
    <sch:pattern id="epub_nordic_259">
        <sch:rule context=".[tokenize(@epub:type,'\s+')='pagebreak']">
            <sch:report test="ancestor::html:thead">[nordic259] Pagebreaks can not occur within table headers (thead).</sch:report>
            <sch:report test="ancestor::html:tfoot">[nordic259] Pagebreaks can not occur within table footers (tfoot).</sch:report>
        </sch:rule>
    </sch:pattern>

    <!-- Rule 260: img must be first in image figure, and non-image content must be placed first in image-series -->
    <sch:pattern id="epub_nordic_260">
        <sch:rule context="html:figure[tokenize(@class,'\s+')='image']">
            <sch:assert test="html:img intersect *[1]">[nordic260a] The first element in a figure with class="image" must be a "img" element.</sch:assert>
        </sch:rule>
        <sch:rule context="html:figure[tokenize(@class,'\s+')='image-series']/html:*[not(self::html:figure[tokenize(@class,'\s+')='image'])]">
            <sch:report test="preceding-sibling::html:figure">[nordic260b] Content not allowed between or after image figure elements.</sch:report>
        </sch:rule>
    </sch:pattern>

    <!-- Rule 261: Text can't be direct child of div -->
    <sch:pattern id="epub_nordic_261">
        <sch:rule context="html:div">
            <sch:report test="text()[normalize-space(.)]">[nordic 261] Text can't be placed directly inside div elements. Please wrap it in a p element.</sch:report>
        </sch:rule>
    </sch:pattern>

</sch:schema>
