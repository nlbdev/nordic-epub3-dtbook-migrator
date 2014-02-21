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

  <!-- Rule 8: Only allow pagenum[@front] in frontmatter -->
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
        test="normalize-space(.)='' and not(*) and not(self::html:img or self::html:br or self::html:meta or self::html:link or self::html:col or self::html:th or self::html:td or self::html:dd or self::html:*[tokenize(@epub:type,'\s+')='pagebreak'])"
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
    <sch:rule context="html:p[parent::html:header[parent::html:body] and tokenize(@epub:type,' ')='author']">
      <sch:assert test="preceding-sibling::*[self::html:h1[tokenize(@epub:type,' ')='fulltitle'] or self::html:p[parent::html:header[parent::html:body] and tokenize(@epub:type,' ')='author']]">[tpb12]
        Docauthor may only be preceded by fulltitle headline</sch:assert>
    </sch:rule>
  </sch:pattern>

  <!-- Rule 13: All documents must have frontmatter and bodymatter -->
  <sch:pattern id="dtbook_TPB_13">
    <sch:rule context="html:body[html:header]">
      <sch:assert test="((html:section|html:article)/tokenize(@epub:type,' ')='frontmatter') = true()">[tpb13] A Single-HTML document must have at least one frontmatter section</sch:assert>
      <sch:assert test="((html:section|html:article)/tokenize(@epub:type,' ')='bodymatter') = true()">[tpb13] A Single-HTML document must have at least one bodymatter section</sch:assert>
      <sch:assert test="not(tokenize(@epub:type,' ')=('cover','frontmatter','bodymatter','backmatter'))">[tpb13] The Single-HTML document must not have cover, frontmatter, bodymatter or backmatter as
        epub:type on its body element</sch:assert>
    </sch:rule>
    <sch:rule context="html:*[self::html:section or self::html:article][ancestor::html:body[html:header] and not(parent::html:body) and not(parent::html:section[tokenize(@epub:type,' ')='part'])]">
      <sch:assert test="not((tokenize(@epub:type,' ')=('cover','frontmatter','bodymatter','backmatter')) = true())">[tpb13] The Single-HTML document must not have cover, frontmatter, bodymatter or
        backmatter on any of its sectioning elements other than the top-level elements that has body as its parent</sch:assert>
    </sch:rule>
    <sch:rule context="html:body[not(html:header|html:nav)]">
      <sch:assert test="tokenize(@epub:type,' ')=('frontmatter','bodymatter','backmatter')">[tpb13] The document must have either frontmatter, bodymatter or backmatter as epub:type on its body
        element</sch:assert>
    </sch:rule>
    <sch:rule context="html:*[self::html:section or self::html:article][ancestor::html:body[not(html:header|html:nav)]]">
      <sch:assert test="not((tokenize(@epub:type,' ')=('cover','frontmatter','bodymatter','backmatter')) = true())">[tpb13] The document must not have cover, frontmatter, bodymatter or backmatter on
        any of its sectioning elements</sch:assert>
    </sch:rule>
  </sch:pattern>

  <!-- Rule 14:  Don't allow <h x+1> in <level x+1> unless <h x> in <level x> is present -->
  <sch:pattern id="dtbook_TPB_14">
    <sch:rule context="html:*[self::html:body[not(html:header)] or self::html:section or self::html:article][html:section|html:article]">
      <sch:assert test="html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6">[tpb14] section with no headline (h1-h6) when sub-section is present</sch:assert>
    </sch:rule>
  </sch:pattern>

  <!-- Rule 18: Disallow level -->
  <!--<sch:pattern id="dtbook_TPB_18">
    <sch:rule context="html:level">
      <sch:report test="true()">[tpb18] Element level is not allowed</sch:report>
    </sch:rule>
  </sch:pattern>-->

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
                          ancestor::html:cite     or ancestor::html:*[tokenize(@epub:type,' ')='z3998:covertitle'] or ancestor::html:*[tokenize(@class,' ')='dateline']   or ancestor::html:p[parent::html:header[parent::html:body] and tokenize(@epub:type,' ')='author'] or
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

  <!-- Rule 23: Increasing pagenum[tokenize(@class,' ')='page-normal'] values -->
  <sch:pattern id="dtbook_TPB_23">
    <sch:rule context="html:*[tokenize(@epub:type,' ')='pagebreak'][tokenize(@class,' ')='page-normal' and preceding::html:*[tokenize(@epub:type,' ')='pagebreak'][tokenize(@class,' ')='page-normal']]">
      <sch:assert test="number(current()/@title) > number(preceding::html:*[tokenize(@epub:type,' ')='pagebreak'][tokenize(@class,' ')='page-normal'][1]/@title)">[tpb23] pagenum[tokenize(@class,'
        ')='page-normal'] values must increase</sch:assert>
    </sch:rule>
  </sch:pattern>

  <!-- Rule 24: Values of pagenum[tokenize(@class,' ')='page-front'] must be unique -->
  <sch:pattern id="dtbook_TPB_24">
    <sch:rule context="html:*[tokenize(@epub:type,' ')='pagebreak'][tokenize(@class,' ')='page-front']">
      <!--  		<sch:assert test="count(key('pageFrontValues', .))=1">[tpb24] pagenum[tokenize(@class,' ')='page-front'] values must be unique</sch:assert>-->
      <sch:assert test="count(//html:*[tokenize(@epub:type,' ')='pagebreak'][tokenize(@class,' ')='page-front' and @title=current()/@title])=1">[tpb24] pagenum[tokenize(@class,' ')='page-front']
        values must be unique</sch:assert>
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
  	                          self::html:p[parent::html:header[parent::html:body] and tokenize(@epub:type,' ')='author']  or self::html:h1[tokenize(@epub:type,' ')='fulltitle']   or
  	                          self::html:aside[tokenize(@epub:type,' ')='epigraph']   or self::html:p[tokenize(@class,' ')='line']     or
  	                          self::html:*[tokenize(@class,' ')='linegroup']  or
  	                          self::html:*[self::html:ul or self::html:ol][not(ancestor::html:nav)]       or self::html:a[tokenize(@epub:type,' ')='note']       or self::html:p        or
  	                          self::html:*[tokenize(@epub:type,' ')='z3998:poem']       or self::html:sidebar    or self::html:table    or
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
  	                          self::html:*[tokenize(@epub:type,' ')='z3998:poem']       or self::html:sidebar    or self::html:table    or
  	                          self::html:*[matches(local-name(),'^h\d$') and tokenize(@class,' ')='title']      or self::html:section or self::html:article]">
      <sch:report
        test="following-sibling::html:a      or following-sibling::html:abbr or following-sibling::html:acronym or following-sibling::html:a[tokenize(@epub:type,' ')='annoref'] or
  	                    following-sibling::html:bdo    or following-sibling::html:code or following-sibling::html:dfn     or following-sibling::html:em      or
  	                    following-sibling::html:kbd or following-sibling::html:p[tokenize(@class,' ')='linenum'] or following-sibling::html:a[tokenize(@epub:type,' ')='noteref'] or
  	                    following-sibling::html:q      or following-sibling::html:samp or following-sibling::html:span[tokenize(@epub:type,' ')='z3998:sentence']    or following-sibling::html:span[not(tokenize(@epub:type,'\s+')='pagebreak')]    or
  	                    following-sibling::html:strong or following-sibling::html:sub  or following-sibling::html:sup     or following-sibling::html:span[tokenize(@epub:type,' ')='z3998:word']       or
  	                    (following-sibling::text()/normalize-space()!='' and not(parent::html:li))"
        >Block element as sibling to inline element</sch:report>
      <sch:report
        test="preceding-sibling::html:a      or preceding-sibling::html:abbr or preceding-sibling::html:acronym or preceding-sibling::html:a[tokenize(@epub:type,' ')='annoref'] or
  	                    preceding-sibling::html:bdo    or preceding-sibling::html:code or preceding-sibling::html:dfn     or preceding-sibling::html:em      or
  	                    preceding-sibling::html:kbd or preceding-sibling::html:p[tokenize(@class,' ')='linenum'] or preceding-sibling::html:a[tokenize(@epub:type,' ')='noteref'] or
  	                    preceding-sibling::html:q      or preceding-sibling::html:samp or preceding-sibling::html:span[tokenize(@epub:type,' ')='z3998:sentence']    or preceding-sibling::html:span[not(tokenize(@epub:type,'\s+')='pagebreak')]    or
  	                    preceding-sibling::html:strong or preceding-sibling::html:sub  or preceding-sibling::html:sup     or preceding-sibling::html:span[tokenize(@epub:type,' ')='z3998:word']       or
  	                    (preceding-sibling::text()/normalize-space(.)!='' and not(parent::html:li))"
        >[tpb29] Block element <sch:name/> as sibling to inline element</sch:report>
    </sch:rule>
  </sch:pattern>

  <!-- Rule 29: No block elements in inline context - continued -->
  <sch:pattern id="dtbook_TPB_29c">
    <sch:rule
      context="html:aside[tokenize(@epub:type,' ')='z3998:production'][ancestor::html:a        or ancestor::html:abbr       or ancestor::html:acronym    or ancestor::html:a[tokenize(@epub:type,' ')='annoref']   or
                                     ancestor::html:bdo      or ancestor::html:code       or ancestor::html:dfn        or ancestor::html:em        or
                                     ancestor::html:kbd      or ancestor::html:p[tokenize(@class,' ')='linenum']    or ancestor::html:a[tokenize(@epub:type,' ')='noteref']    or
                                     ancestor::html:q        or ancestor::html:samp       or ancestor::html:span[tokenize(@epub:type,' ')='z3998:sentence']       or ancestor::html:span      or
                                     ancestor::html:strong   or ancestor::html:sub        or ancestor::html:sup        or ancestor::html:span[tokenize(@epub:type,' ')='z3998:word']         or
                                     ancestor::html:address  or ancestor::html:*[tokenize(@epub:type,' ')='z3998:author' and not(parent::html:header[parent::html:body])]     or ancestor::html:p[tokenize(@epub:type,' ')='bridgehead'] or ancestor::html:*[tokenize(@class,' ')='byline']    or
                                     ancestor::html:cite     or ancestor::html:*[tokenize(@epub:type,' ')='z3998:covertitle'] or ancestor::html:*[tokenize(@class,' ')='dateline']   or ancestor::html:p[parent::html:header[parent::html:body] and tokenize(@epub:type,' ')='author'] or
                                     ancestor::html:h1[tokenize(@epub:type,' ')='fulltitle'] or ancestor::html:dt         or ancestor::html:h1         or ancestor::html:h2        or
                                     ancestor::html:h3       or ancestor::html:h4         or ancestor::html:h5         or ancestor::html:h6        or
                                     ancestor::html:p[tokenize(@class,' ')='line']       or ancestor::html:p]">
      <sch:report
        test="descendant::html:*[self::html:address    or self::html:aside[tokenize(@epub:type,' ')='annotation'] or self::html:*[tokenize(@epub:type,' ')='z3998:author' and not(parent::html:header[parent::html:body])]   or
  	                                       self::html:blockquote or self::html:p[tokenize(@epub:type,' ')='bridgehead'] or self::html:caption  or
                                           self::html:*[tokenize(@class,' ')='dateline']   or self::html:div        or self::html:dl       or
                                           self::html:p[parent::html:header[parent::html:body] and tokenize(@epub:type,' ')='author']  or self::html:h1[tokenize(@epub:type,' ')='fulltitle']   or
                                           self::html:aside[tokenize(@epub:type,' ')='epigraph']   or self::html:p[tokenize(@class,' ')='line']     or
  	                                       self::html:*[tokenize(@class,' ')='linegroup']  or
                                           self::html:*[self::html:ul or self::html:ol]       or self::html:a[tokenize(@epub:type,' ')='note']       or self::html:p        or
                                           self::html:*[tokenize(@epub:type,' ')='z3998:poem']       or self::html:sidebar    or self::html:table    or
                                           self::html:*[matches(local-name(),'^h\d$') and tokenize(@class,' ')='title']]"
        >[tpb29] Prodnote in inline context used as block element</sch:report>
    </sch:rule>
  </sch:pattern>

  <!-- Rule 40: No page numbering gaps for pagenum[tokenize(@class,' ')='page-normal'] -->
  <sch:pattern id="dtbook_TPB_40">
    <sch:rule context="html:*[tokenize(@epub:type,' ')='pagebreak'][tokenize(@class,' ')='page-normal']">
      <sch:report
        test="preceding::html:*[tokenize(@epub:type,' ')='pagebreak'][tokenize(@class,' ')='page-normal'] and number(preceding::html:*[tokenize(@epub:type,' ')='pagebreak'][tokenize(@class,' ')='page-normal'][1]/@title) != number(@title)-1"
        >[tpb40] No gaps may occur in page numbering</sch:report>
    </sch:rule>
  </sch:pattern>

  <!-- Rule 43: dc:publisher must be 'TPB', 'MTM', 'SPSM', 'Nota', 'NLB', 'Celia' or 'SBS' -->
  <sch:pattern id="dtbook_TPB_43">
    <sch:rule context="html:head">
      <!-- dc:publisher -->
      <sch:assert test="count(html:meta[@name='dc:publisher' and @content=('TPB','MTM','SPSM','Nota','NLB','Celia','SBS')])=1">[tpb43] Meta dc:publisher must exist and have value 'TPB', 'MTM', 'SPSM',
        'Nota', 'NLB', 'Celia' or 'SBS'.</sch:assert>
    </sch:rule>
  </sch:pattern>

  <!-- Rule 50: image alt attribute -->
  <sch:pattern id="dtbook_TPB_50">
    <sch:rule context="html:img">
      <sch:report test="lang('sv') and @alt!='illustration'">[tpb50] an image in swedish language context must have attribute alt="illustration"</sch:report>
      <sch:report test="lang('en') and @alt!='image'">[tpb50] an image in english language context must have attribute alt="image"</sch:report>
    </sch:rule>
  </sch:pattern>

  <!-- Rule 51 & 52: -->
  <sch:pattern id="dtbook_TPB_5152">
    <sch:rule context="html:img">
      <sch:assert test="contains(@src,'.jpg') and substring-after(@src,'.jpg')=''">[tpb52] Images must have the .jpg file extension.</sch:assert>
      <sch:report test="contains(@src,'.jpg') and string-length(@src)=4">[tpb52] Images must have a base name, not just an extension.</sch:report>
      <sch:report test="not(matches(@src,'^images/[^/]+$'))">[tpb51] Images must be in the "images" folder (relative to the HTML file).</sch:report>
      <sch:assert test="string-length(translate(substring(@src,1,string-length(@src)-4),'-_abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/',''))=0">[tpb52] Image file name contains an
        illegal character (must be -_a-zA-Z0-9).</sch:assert>
    </sch:rule>
  </sch:pattern>

  <!-- Rule 59: No pagegnum between a term and a definition in definition lists -->
  <sch:pattern id="dtbook_TPB_59">
    <sch:rule context="html:dl/html:*[tokenize(@epub:type,' ')='pagebreak']">
      <sch:assert test="not(parent::*/html:dd or parent::*/html:dt)">[tpb59] pagenum in definition list must not occur as siblings to dd or dt</sch:assert>
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

  <!-- Rule 67: doctitle and docauthor only allowed in frontmatter -->
  <sch:pattern id="dtbook_TPB_67">
    <sch:rule context="html:h1[tokenize(@epub:type,' ')='fulltitle'][not(ancestor::html:header[parent::html:body])]">
      <sch:assert test="ancestor::html:*[tokenize(@epub:type,' ')='frontmatter']">[tpb67] doctitle is only allowed in frontmatter</sch:assert>
    </sch:rule>
    <!--<sch:rule context="html:p[parent::html:header[parent::html:body] and tokenize(@epub:type,' ')='author']">
      <sch:assert test="ancestor::html:*[tokenize(@epub:type,' ')='frontmatter']">[tpb67] docauthor is only allowed in frontmatter</sch:assert>
    </sch:rule>-->
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
      <sch:report test="normalize-space(substring(.,string-length(.),1))='' and not(html:* and normalize-space(html:*[last()]/following-sibling::text())='')">[tpb93] element <sch:name/> may not have
        trailing whitespace</sch:report>
    </sch:rule>
  </sch:pattern>

  <!-- Rule 96: no nested prodnotes or image groups -->
  <sch:pattern id="dtbook_TPB_96">
    <sch:rule context="html:aside[tokenize(@epub:type,' ')='z3998:production']">
      <sch:report test="ancestor::html:aside[tokenize(@epub:type,' ')='z3998:production']">[tpb96] nested production notes are not allowed</sch:report>
    </sch:rule>
    <sch:rule context="html:figure">
      <sch:report test="ancestor::html:figure">[tpb96] nested figures are not allowed</sch:report>
    </sch:rule>
  </sch:pattern>

  <!-- Rule 101: All imggroup elements must have a img element -->
  <sch:pattern id="dtbook_TPB_101">
    <sch:rule context="html:figure">
      <sch:assert test="html:img">[tpb101] There must be an img element in every figure</sch:assert>
    </sch:rule>
  </sch:pattern>

  <!-- Rule 103: No img without imggroup -->
  <sch:pattern id="dtbook_TPB_103">
    <sch:rule context="html:img">
      <sch:assert test="parent::html:figure">[tpb103] There must be a figure element wrapping every img</sch:assert>
    </sch:rule>
  </sch:pattern>

  <!-- Rule 104: Headings may not be empty elements -->
  <sch:pattern id="dtbook_TPB_104">
    <sch:rule context="html:*[self::html:h1 or self::html:h2 or self::html:h3 or self::html:h4 or self::html:h5 or self::html:h6]">
      <sch:report test="normalize-space(.)=''">[tpb104] Heading <sch:name/> may not be empty</sch:report>
    </sch:rule>
  </sch:pattern>

  <!-- Rule 105: Page attribute must appear on all pagenum elements -->
  <sch:pattern id="dtbook_TPB_105">
    <sch:rule context="html:*[tokenize(@epub:type,' ')='pagebreak']">
      <sch:assert test="tokenize(@class,' ')=('page-front','page-normal','page-special')">[tpb105] Page breaks must have either a 'page-front', a 'page-normal' or a 'page-special' class.</sch:assert>
    </sch:rule>
  </sch:pattern>

  <!-- Rule 110: pagenum in headings -->
  <sch:pattern id="dtbook_TPB_110">
    <sch:rule context="html:*[tokenize(@epub:type,' ')='pagebreak']">
      <sch:report test="ancestor::*[self::html:h1 or self::html:h2 or self::html:h3 or self::html:h4 or self::html:h5 or self::html:h6]">[tpb110] pagenum elements are not allowed in
        headings</sch:report>
    </sch:rule>
  </sch:pattern>

  <!-- Rule 116: Don't allow arabic numbers in pagenum/@class="page-front" -->
  <sch:pattern id="dtbook_TPB_116">
    <sch:rule context="html:*[tokenize(@epub:type,' ')='pagebreak']">
      <sch:report test="tokenize(@class,' ')='page-front' and translate(.,'0123456789','xxxxxxxxxx')!=.">[tpb116] Arabic numbers when @class="page-front" are not allowed</sch:report>
    </sch:rule>
  </sch:pattern>

  <!-- Rule 120:  Allow only pagenum before hx in levelx -->
  <sch:pattern id="dtbook_TPB_120">
    <sch:rule context="html:*[self::html:h1 or self::html:h2 or self::html:h3 or self::html:h4 or self::html:h5 or self::html:h6]">
      <sch:assert test="not(preceding-sibling::html:*) or preceding-sibling::html:*[tokenize(@epub:type,' ')='pagebreak']">[tpb120] Only pagebreaks are allowed before the heading
        <sch:name/>.</sch:assert>
    </sch:rule>
  </sch:pattern>

  <!-- Rule 121:  pagenum in tables must not occur between table rows -->
  <sch:pattern id="dtbook_TPB_121">
    <sch:rule context="html:*[tokenize(@epub:type,' ')='pagebreak'][ancestor::html:table]">
      <sch:assert test="not(parent::*[self::html:table or self::html:thead or self::html:tfoot or self::html:tbody or self::html:tr])">[tpb121] Page numbers in tables must not be placed between table rows.</sch:assert>
    </sch:rule>
  </sch:pattern>

  <!-- Rule 123 (39): No class attributes on level[2-6]. level1 allows 'part', 'nonstandardpagination', 'colophon' (if located in frontmatter) and 'cover' (if located in frontmatter and immediately after docauthor or doctitle) -->
  <sch:pattern id="dtbook_TPB_123">
    <sch:rule context="html:*[(self::html:section or self::html:article) and /*/html:body/html:header and count(ancestor::html:section | ancestor::html:article) = 0]">
      <sch:assert test="not(@class) or @class='part' or @class='cover' or @class='colophon' or @class='nonstandardpagination'">[tpb123] No class attributes except 'part', 'cover', 'colophon' and
        'nonstandardpagination' are allowed on level1</sch:assert>

      <sch:report test="@class='cover' and (not(parent::html:frontmatter))">[tpb123] Jacket copy must be in frontmatter</sch:report>
      <sch:report
        test="@class='cover' and (not(preceding-sibling::*[1][self::html:p[parent::html:header[parent::html:body] and tokenize(@epub:type,' ')='author'] or self::html:h1[tokenize(@epub:type,' ')='fulltitle']]))"
        >[tpb123] Jacket copy must follow immediately after docauthor or doctitle</sch:report>

      <sch:report test="@class='colophon' and parent::html:bodymatter">[tpb123] Colophon is not allowed in bodymatter</sch:report>
    </sch:rule>
    <!--<sch:rule context="html:*[(self::html:section or self::html:article) and count(ancestor::html:section | ancestor::html:article) &gt; 0]">
      <sch:assert test="not(@class)">[tpb123] No class attributes are allowed on level2 to level6</sch:assert>
    </sch:rule>-->
  </sch:pattern>

  <!-- Rule 124 (106): All documents must have at least one pagenum -->
  <sch:pattern id="dtbook_TPB_124">
    <sch:rule context="html:body[not(html:nav)]">
      <sch:assert test="count(//html:*[tokenize(@epub:type,' ')='pagebreak'])>=1">[tpb124] All documents in the spine must contain page numbers</sch:assert>
    </sch:rule>
  </sch:pattern>

  <!-- Rule 125 (109): Only allow images in JPG format -->
  <sch:pattern id="dtbook_TPB_125">
    <sch:rule context="html:img">
      <sch:assert test="string-length(@src)>=5">[tpb125] Invalid image filename.</sch:assert>
      <sch:assert test="substring(@src,string-length(@src) - 3, 4)='.jpg'">[tpb125] Images must be in JPG (*.jpg) format.</sch:assert>
    </sch:rule>
  </sch:pattern>

  <!-- Rule 126: pagenum must not occur directly after hx unless the hx is preceded by a pagenum -->
  <sch:pattern id="dtbook_TPB_126">
    <sch:rule context="html:*[tokenize(@epub:type,' ')='pagebreak']">
      <sch:report
        test="preceding-sibling::*[1][self::html:h1 or self::html:h2 or self::html:h3 or self::html:h4 or self::html:h5 or self::html:h6] and
  		                  not(preceding-sibling::*[2][self::html:*[tokenize(@epub:type,' ')='pagebreak']])"
        >[tpb126] pagenum must not occur directly after hx unless the hx is preceded by a pagenum</sch:report>
    </sch:rule>
  </sch:pattern>

  <!-- Rule 127: Table of contents must be inside a level1 -->
  <sch:pattern id="dtbook_TPB_127">
    <sch:rule context="html:*[@class='toc']">
      <sch:assert test="self::html:nav[parent::html:body or parent::html:section/parent::html:body/html:header]">[tpb127] The "toc" class is only allowed on the main nav element.</sch:assert>
      <sch:assert test="self::html:nav/tokenize(@epub:type,' ')='nav'">[tpb127] The main nav element must use the epub:type "nav".</sch:assert>
      <!--<sch:assert test="parent::html:*[(self::html:section or self::html:article) and /*/html:body/html:header and count(ancestor::html:section | ancestor::html:article) = 0]">[tpb127] Table of contents (&lt;list class="toc"&gt;)must be inside a level1</sch:assert>
      <sch:report test="ancestor::html:*[self::html:ul or self::html:ol][@class='toc']">[tpb127] Nested lists in table of contents must not have a 'toc' attribute</sch:report>-->
    </sch:rule>
  </sch:pattern>

  <!-- Rule 128: tracking metadata must exist (nordic:guidelines) -->
  <sch:pattern id="dtbook_TPB_128">
    <sch:rule context="html:html">
      <sch:assert test="namespace-uri-for-prefix('nordic',/*)='http://www.mtm.se/epub/'">[tpb128] xmlns:nordic="http://www.mtm.se/epub/" must be defined on the root html element.</sch:assert>
    </sch:rule>
    <sch:rule context="html:head">
      <sch:assert test="count(html:meta[@name='nordic:guidelines'])=1">[tpb128] nordic:guidelines metadata must occur once.</sch:assert>
    </sch:rule>
    <sch:rule context="html:meta[@name='nordic:guidelines']">
      <sch:assert test="@content='2015-1'">[tpb128] nordic:guidelines metadata value must be 2015-1.</sch:assert>
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
      <sch:assert
        test="@xml:lang='sv' or @xml:lang='en' or @xml:lang='da' or @xml:lang='it' or @xml:lang='la' or @xml:lang='el' or @xml:lang='de' or @xml:lang='fr' or @xml:lang='es' or @xml:lang='fi' or @xml:lang='no' or @xml:lang='is'"
        >[tpb131] xml:lang must be one of: 'sv', 'en', 'da', 'it', 'la', 'el', 'de', 'fr', 'es', 'fi', 'no' or 'is'</sch:assert>
    </sch:rule>
  </sch:pattern>

  <!-- Rule 133: Disallowed elements -->
  <sch:pattern id="dtbook_TPB_133">
    <sch:rule
      context="html:*[self::html:aside[tokenize(@epub:type,' ')='epigraph'] or self::html:*[tokenize(@class,' ')='byline'] or
  	                          self::html:*[tokenize(@class,' ')='dateline'] or self::html:cite or self::html:span[tokenize(@epub:type,' ')='z3998:sentence'] or self::html:span[tokenize(@epub:type,' ')='z3998:word'] or
  	                          self::html:*[tokenize(@epub:type,' ')='z3998:covertitle'] or self::html:p[tokenize(@epub:type,' ')='bridgehead'] or self::html:thead or
  	                          self::html:tfoot or self::html:colgroup or self::html:col or
  	                          self::html:address or self::html:aside[tokenize(@epub:type,' ')='annotation'] or self::html:dfn or
  	                          self::html:kbd or self::html:samp or
  	                          self::html:q or self::html:bdo or self::html:bdo or self::html:a[tokenize(@epub:type,' ')='annoref']]">
      <sch:assert test="false()">[tpb133] Element <sch:name/> is disallowed</sch:assert>
    </sch:rule>
  </sch:pattern>

  <!-- Rule 134: Disallowed attributes -->
  <sch:pattern id="dtbook_TPB_134">
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
  </sch:pattern>

  <!-- Rule 135: Poem contents -->
  <sch:pattern id="dtbook_TPB_135">
    <sch:rule
      context="html:*[self::html:*[matches(local-name(),'^h\d$') and tokenize(@class,' ')='title'] or self::html:*[tokenize(@epub:type,' ')='z3998:author' and not(parent::html:header[parent::html:body])]]">
      <sch:assert test="parent::html:*[tokenize(@epub:type,' ')='z3998:poem']">[tpb135] Element <sch:name/> is only allowed in poem context</sch:assert>
    </sch:rule>
    <sch:rule context="html:*[tokenize(@epub:type,' ')='z3998:poem']">
      <sch:assert test="html:*[tokenize(@class,' ')='linegroup']">[tpb135] Every poem must contain a linegroup</sch:assert>
      <sch:report test="html:p[tokenize(@class,' ')='line']">[tpb135] Poem lines must be wrapped in a linegroup</sch:report>
    </sch:rule>
  </sch:pattern>

  <!-- Rule 136: List types -->
  <!--<sch:pattern id="dtbook_TPB_136">
    <sch:rule context="html:*[self::html:ul or self::html:ol]">
      <sch:assert test="@type='pl'">[tpb136] Lists must be of type 'pl' (with any bullets or numbers in the text node)</sch:assert>
    </sch:rule>
  </sch:pattern>-->

  <!-- Rule 137: Language used in unnumbered pages -->
  <sch:pattern id="dtbook_TPB_137">
    <sch:rule context="html:*[tokenize(@epub:type,' ')='pagebreak']">
      <sch:report test="tokenize(@class,' ')='page-special' and .='Onumrerad sida' and lang('en')">[tpb137] Swedish description of unnumbered page used in english context</sch:report>
      <sch:report test="tokenize(@class,' ')='page-special' and .='Unnumbered page' and lang('sv')">[tpb137] English description of unnumbered page used in swedish context</sch:report>
    </sch:rule>
  </sch:pattern>

  <!-- Rule 140: Jacket copy must contain at least one prodnote, at most one of each @class value and no other elements -->
  <sch:pattern id="dtbook_TPB_140">
    <sch:rule context="html:section[@class='cover']">
      <sch:assert test="count(*)=count(html:aside[tokenize(@epub:type,' ')='z3998:production'])">[tpb140] Only prodnote allowed in jacket copy</sch:assert>
      <sch:assert test="count(html:aside[tokenize(@epub:type,' ')='z3998:production'])>=1">[tpb140] There must be at least one prodnote in jacket copy</sch:assert>
      <sch:report test="count(html:aside[tokenize(@epub:type,' ')='z3998:production'][@class='frontcover'])>1">[tpb140] Too many prodnotes with @class='frontcover' in jacket copy</sch:report>
      <sch:report test="count(html:aside[tokenize(@epub:type,' ')='z3998:production'][@class='rearcover'])>1">[tpb140] Too many prodnotes with @class='rearcover' in jacket copy</sch:report>
      <sch:report test="count(html:aside[tokenize(@epub:type,' ')='z3998:production'][@class='leftflap'])>1">[tpb140] Too many prodnotes with @class='leftflap' in jacket copy</sch:report>
      <sch:report test="count(html:aside[tokenize(@epub:type,' ')='z3998:production'][@class='rightflap'])>1">[tpb140] Too many prodnotes with @class='rightflap' in jacket copy</sch:report>
    </sch:rule>
  </sch:pattern>

  <!-- Rule 141: Prodnotes in jacket copy must contain text and have a @class=['frontcover', 'rearcover', 'leftflap' or 'rightflap'] -->
  <sch:pattern id="dtbook_TPB_141">
    <sch:rule context="html:aside[tokenize(@epub:type,' ')='z3998:production'][parent::html:section[@class='cover']]">
      <sch:assert test="@class='frontcover' or @class='rearcover' or @class='leftflap' or @class='rightflap'">[tpb141] prodnote in jacket copy must have a class attribute with one of 'frontcover',
        'rearcover', 'leftflap' or 'rightflap'</sch:assert>
    </sch:rule>
  </sch:pattern>

  <!-- Rule 142: Only tokenize(@class,' ')='page-special' in level1/@class='nonstandardpagination' -->
  <sch:pattern id="dtbook_TPB_142">
    <sch:rule context="html:*[tokenize(@epub:type,' ')='pagebreak'][ancestor::html:section[@class='nonstandardpagination']]">
      <sch:assert test="tokenize(@class,' ')='page-special'">[tpb142] The class page-special must be used in section/@class='nonstandardpagination'</sch:assert>
    </sch:rule>
  </sch:pattern>

  <!-- Rule 143: Don't allow pagenum last in a list -->
  <sch:pattern id="dtbook_TPB_143">
    <sch:rule context="html:*[tokenize(@epub:type,' ')='pagebreak'][parent::html:*[self::html:ul or self::html:ol]]">
      <sch:report test="not(following-sibling::*)">[tpb143] pagenum is not allowed last in a list</sch:report>
    </sch:rule>
  </sch:pattern>

  <!-- Rule 200: The title element must contain the same text as the first headline in the document -->
  <sch:pattern id="epub_nordic_200">
    <sch:rule context="html:title">
      <sch:assert test="text() and not(normalize-space(.)='')">[nordic200] The title element must not be empty.</sch:assert>
      <sch:assert test="normalize-space(.) = normalize-space((//html:h1)[1])">[nordic200] The title element must contain the same text as the first headline in the document.</sch:assert>
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

  <!-- Rule 208: bodymatter -->
  <sch:pattern id="epub_nordic_208">
    <sch:rule context="html:*[tokenize(@epub:type,' ')='bodymatter']">
      <!-- types can be prologue, preface, part, chapter, conclusion, epilogue -->
      <sch:assert test="tokenize(@epub:type,' ')=('prologue','preface','part','chapter','conclusion','epilogue')">[nordic208] top-level sectioning elements with the type "bodymatter" must also have
        one of the types "prologue", "preface", "part", "chapter", "conclusion" or "epilogue"</sch:assert>
    </sch:rule>
  </sch:pattern>

  <!-- Rule 211: bodymatter.part -->
  <sch:pattern id="epub_nordic_211">
    <sch:rule context="html:*[self::html:section or self::html:article][parent::html:section[tokenize(@epub:type,' ')='part']]">
      <!-- types can be prologue, preface, chapter, conclusion, epilogue -->
      <sch:assert test="tokenize(@epub:type,' ')=('prologue','preface','part','chapter','conclusion','epilogue')">[nordic208] top-level sectioning elements inside sectioning elements with the type
        "part" must have one of the types "prologue", "preface", "chapter", "conclusion" or "epilogue"</sch:assert>
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
    <sch:rule context="html:*[tokenize(@epub:type,' ')='pagebreak']">
      <sch:assert test="matches(@title,'.+')">[nordic225] The title attribute must be used to describe the page number.</sch:assert>
    </sch:rule>
  </sch:pattern>

  <!-- Rule 229: attlist.prodnote -->
  <sch:pattern id="epub_nordic_229">
    <sch:rule context="html:aside[tokenize(@epub:type,' ')='z3998:production']">
      <sch:assert test="tokenize(@class,' ')=('render-required','render-optional')">[nordic229] Prodnotes must have either a 'render-required' or a 'render-optional' class.</sch:assert>
    </sch:rule>
  </sch:pattern>

  <!-- Rule 231: attlist.sidebar -->
  <sch:pattern id="epub_nordic_231">
    <sch:rule context="html:section[tokenize(@epub:type,' ')='sidebar']">
      <sch:assert test="tokenize(@class,' ')=('render-required','render-optional')">[nordic229] Sidebars must have either a 'render-required' or a 'render-optional' class.</sch:assert>
    </sch:rule>
  </sch:pattern>

  <!-- Rule 246: doctitle - p -->
  <sch:pattern id="epub_nordic_246">
    <sch:rule context="html:*[tokenize(@epub:type,' ')='fulltitle']">
      <sch:assert test="self::html:h1">[nordic246] The fulltitle (doctitle) must be a h1 element.</sch:assert>
      <sch:assert test="parent::html:header[parent::html:body]">[nordic246] The fulltitle (doctitle) must be inside a header element which must be inside the body element.</sch:assert>
    </sch:rule>
  </sch:pattern>

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

  <!-- Rule 253: figcaption captions -->
  <sch:pattern id="epub_nordic_253">
    <sch:rule context="html:div[parent::html:figcaption]">
      <sch:assert test="tokenize(@class,' ')='img-caption'">[nordic253] divs in figcaptions must use the "img-caption" class.</sch:assert>
      <!--<sch:assert test="html:div[tokenize(@class,' ')='caption'] and not(tokenize(@class,' ')='caption')">[nordic253] figcaptions which contains div elements with the "caption" class must not themselves also use the "caption" class.</sch:assert>
      <sch:assert test="not(html:div[tokenize(@class,' ')='caption']) and tokenize(@class,' ')='caption'">[nordic253] figcaptions which does not contain div elements with the "caption" class must themselves use the "caption" class.</sch:assert>-->
    </sch:rule>
  </sch:pattern>

  <!-- Rule 254: aside types -->
  <sch:pattern id="epub_nordic_254">
    <sch:rule context="html:aside">
      <sch:assert test="tokenize(@epub:type,' ') = ('z3998:production','sidebar','note','annotation','epigraph')">[nordic254] "aside" elements must use one of the following epub:types:
        z3998:production, sidebar, note, annotation, epigraph</sch:assert>
    </sch:rule>
  </sch:pattern>


</sch:schema>