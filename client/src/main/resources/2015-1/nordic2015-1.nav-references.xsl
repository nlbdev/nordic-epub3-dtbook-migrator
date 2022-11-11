<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform xmlns:sch="http://purl.oclc.org/dsdl/schematron"
               xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
               xmlns:error="https://doi.org/10.5281/zenodo.1495494#error"
               xmlns:schxslt="https://doi.org/10.5281/zenodo.1495494"
               xmlns:xs="http://www.w3.org/2001/XMLSchema"
               xmlns:schxslt-api="https://doi.org/10.5281/zenodo.1495494#api"
               xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
               xmlns:html="http://www.w3.org/1999/xhtml"
               xmlns:opf="http://www.idpf.org/2007/opf"
               xmlns:dc="http://purl.org/dc/elements/1.1/"
               xmlns:epub="http://www.idpf.org/2007/ops"
               xmlns:nordic="http://www.mtm.se/epub/"
               xmlns:c="http://www.w3.org/ns/xproc-step"
               version="2.0">
   <rdf:Description xmlns:dct="http://purl.org/dc/terms/"
                    xmlns:skos="http://www.w3.org/2004/02/skos/core#">
      <dct:creator>
         <dct:Agent>
            <skos:prefLabel>SchXslt/1.6.2 SAXON/9.2.0.6</skos:prefLabel>
            <schxslt.compile.typed-variables xmlns="https://doi.org/10.5281/zenodo.1495494#">true</schxslt.compile.typed-variables>
         </dct:Agent>
      </dct:creator>
      <dct:created>2022-10-18T12:59:39.518+02:00</dct:created>
   </rdf:Description>
   <xsl:output indent="yes"/>
   <xsl:template match="/">
      <xsl:variable name="metadata" as="element()?">
         <svrl:metadata xmlns:dct="http://purl.org/dc/terms/"
                        xmlns:skos="http://www.w3.org/2004/02/skos/core#"
                        xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
            <dct:creator>
               <dct:Agent>
                  <skos:prefLabel>
                     <xsl:variable name="prefix" as="xs:string?"
                                   select="if (doc-available('')) then in-scope-prefixes(document('')/*[1])[namespace-uri-for-prefix(., document('')/*[1]) eq 'http://www.w3.org/1999/XSL/Transform'][1] else ()"/>
                     <xsl:choose>
                        <xsl:when test="empty($prefix)">Unknown</xsl:when>
                        <xsl:otherwise>
                           <xsl:value-of separator="/"
                                         select="(system-property(concat($prefix, ':product-name')), system-property(concat($prefix,':product-version')))"/>
                        </xsl:otherwise>
                     </xsl:choose>
                  </skos:prefLabel>
               </dct:Agent>
            </dct:creator>
            <dct:created>
               <xsl:value-of select="current-dateTime()"/>
            </dct:created>
            <dct:source>
               <rdf:Description>
                  <dct:creator>
                     <dct:Agent>
                        <skos:prefLabel>SchXslt/1.6.2 SAXON/9.2.0.6</skos:prefLabel>
                        <schxslt.compile.typed-variables xmlns="https://doi.org/10.5281/zenodo.1495494#">true</schxslt.compile.typed-variables>
                     </dct:Agent>
                  </dct:creator>
                  <dct:created>2022-10-18T12:59:39.518+02:00</dct:created>
               </rdf:Description>
            </dct:source>
         </svrl:metadata>
      </xsl:variable>
      <xsl:variable name="report" as="element(schxslt:report)">
         <schxslt:report>
            <xsl:call-template name="d7e23"/>
         </schxslt:report>
      </xsl:variable>
      <xsl:variable name="schxslt:report" as="node()*">
         <xsl:sequence select="$metadata"/>
         <xsl:for-each select="$report/schxslt:pattern">
            <xsl:sequence select="node()"/>
            <xsl:sequence select="$report/schxslt:rule[@pattern = current()/@id]/node()"/>
         </xsl:for-each>
      </xsl:variable>
      <svrl:schematron-output xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                              title="Nordic EPUB3 Navigation Document content reference rules">
         <svrl:ns-prefix-in-attribute-values prefix="html" uri="http://www.w3.org/1999/xhtml"/>
         <svrl:ns-prefix-in-attribute-values prefix="opf" uri="http://www.idpf.org/2007/opf"/>
         <svrl:ns-prefix-in-attribute-values prefix="dc" uri="http://purl.org/dc/elements/1.1/"/>
         <svrl:ns-prefix-in-attribute-values prefix="epub" uri="http://www.idpf.org/2007/ops"/>
         <svrl:ns-prefix-in-attribute-values prefix="nordic" uri="http://www.mtm.se/epub/"/>
         <svrl:ns-prefix-in-attribute-values prefix="c" uri="http://www.w3.org/ns/xproc-step"/>
         <xsl:sequence select="$schxslt:report"/>
      </svrl:schematron-output>
   </xsl:template>
   <xsl:template match="text() | @*" mode="#all" priority="-10"/>
   <xsl:template match="*" mode="#all" priority="-10">
      <xsl:apply-templates mode="#current" select="@*"/>
      <xsl:apply-templates mode="#current" select="node()"/>
   </xsl:template>
   <xsl:template name="d7e23">
      <schxslt:pattern id="d7e23">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="nav_references_1">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e60">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="nav_references_2">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e133">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="nav_references_3">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e174">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="nav_references_4">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
   </xsl:template>
   <xsl:template match="c:result/c:result[@data-sectioning-element]" priority="3" mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="sectioning-ref"
                    select="if (@data-sectioning-id) then concat(replace(@xml:base,'.*/',''),'#',@data-sectioning-id) else ()"/>
      <xsl:variable name="heading-ref"
                    select="if (@data-heading-id) then concat(replace(@xml:base,'.*/',''),'#',@data-heading-id) else ()"/>
      <xsl:variable name="nav-ref"
                    select="//html:nav[tokenize(@epub:type,'\s+')='toc']//html:a[$sectioning-ref and ends-with(@href, $sectioning-ref) or $heading-ref and ends-with(@href, $heading-ref)]"/>
      <schxslt:rule pattern="d7e23">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e23']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "c:result/c:result[@data-sectioning-element]" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">c:result/c:result[@data-sectioning-element]</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">c:result/c:result[@data-sectioning-element]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(count($nav-ref) = 1)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count($nav-ref) = 1</xsl:attribute>
                     <svrl:text>[nordic_nav_references_1] All headings in the content documents must be referenced exactly once in the navigation document. In the content document
                    "<xsl:value-of select="replace(@xml:base,'.*/','')"/>", the <xsl:value-of select="if (@data-heading-element) then concat('heading &#34;', text(), '&#34;', if (@data-heading-id) then concat(' with id=&#34;', @data-heading-id,'&#34;') else '', ' inside the ') else ''"/> "<xsl:value-of select="@data-sectioning-element"/>" element<xsl:value-of select="if (@data-sectioning-id) then concat(' with id=&#34;', @data-sectioning-id,'&#34;') else ''"/> is
                    <xsl:value-of select="if (count($nav-ref)=0) then 'not referenced' else 'referenced multiple times'"/> from the navigation document.</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
               <xsl:if test="not(count($nav-ref) = 0 or not(@data-heading-id) or normalize-space(string-join(.//text(),'')) = normalize-space(string-join($nav-ref//text(),'')))">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count($nav-ref) = 0 or not(@data-heading-id) or normalize-space(string-join(.//text(),'')) = normalize-space(string-join($nav-ref//text(),''))</xsl:attribute>
                     <svrl:text>[nordic_nav_references_1] The
                text for the heading in the navigation document ("<xsl:value-of select="normalize-space(string-join($nav-ref//text(),''))"/>") should match the headline in the content document ("<xsl:value-of select="normalize-space(string-join(.//text(),''))"/>" at <xsl:value-of select="($heading-ref, $sectioning-ref)[1]"/>)</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e23')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:a[ancestor::html:nav[tokenize(@epub:type,'\s+')='toc']]"
                 priority="2"
                 mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="href" select="substring-before(@href,'#')"/>
      <xsl:variable name="fragment" select="substring-after(@href,'#')"/>
      <xsl:variable name="result-ref"
                    select="/*/c:result/c:result[(@data-sectioning-id, @data-heading-id) = $fragment]"/>
      <xsl:variable name="result-ref-first" select="$result-ref[1]"/>
      <xsl:variable name="document-in-nav"
                    select="((preceding::html:a | self::*) intersect ancestor::html:nav//html:a)[substring-before(@href,'#') = $href][1]"/>
      <xsl:variable name="document-in-nav-depth" select="count($document-in-nav/ancestor::html:li)"/>
      <xsl:variable name="depth-in-nav" select="count(ancestor::html:li)"/>
      <xsl:variable name="depth-in-content"
                    select="$result-ref-first/xs:integer((@data-heading-depth, @data-sectioning-depth)[1])"/>
      <schxslt:rule pattern="d7e60">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e60']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:a[ancestor::html:nav[tokenize(@epub:type,'\s+')='toc']]" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:a[ancestor::html:nav[tokenize(@epub:type,'\s+')='toc']]</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:a[ancestor::html:nav[tokenize(@epub:type,'\s+')='toc']]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not($result-ref)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">$result-ref</xsl:attribute>
                     <svrl:text>[nordic_nav_references_2a] All references from the navigation document must reference either a sectioning element or a headline in one of the content documents:
                    <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
               <xsl:if test="count($result-ref) &gt; 1">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count($result-ref) &gt; 1</xsl:attribute>
                     <svrl:text>[nordic_nav_references_2a] All references from the navigation document must reference exactly one sectioning element or headline in one of the
                content documents, there are multiple sections or headlines matching the href="<xsl:value-of select="@href"/>" in <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>; <xsl:value-of select="string-join($result-ref/concat(replace(@xml:base,'.*/',''),'#',$fragment), ',')"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
               <xsl:if test="not(not($result-ref-first) or $depth-in-nav = $depth-in-content + $document-in-nav-depth - 1)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">not($result-ref-first) or $depth-in-nav = $depth-in-content + $document-in-nav-depth - 1</xsl:attribute>
                     <svrl:text>[nordic_nav_references_2b] The nesting of headlines in the content does not match the
                nesting of headlines in the navigation document. The toc item `<xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>` in the navigation document is not nested at the correct
                level. The referenced document (<xsl:value-of select="$href"/>) occurs in the navigation document at nesting depth <xsl:value-of select="$document-in-nav-depth"/> (<xsl:value-of select="if ($document-in-nav-depth = 1) then 'it is not contained inside other sections such as a part or a chapter'                     else concat('it is contained inside ',string-join($document-in-nav/ancestor::html:li[1]/ancestor::html:li/concat('&#34;',(text(),*[not(local-name()=('ol','ul'))]/string-join(.//text(),''))[normalize-space()][1],'&#34;'),', which is contained inside'))"/>). The referenced headline (<xsl:value-of select="@href"/>) occurs in the navigation document at nesting depth <xsl:value-of select="$depth-in-nav"/> (<xsl:value-of select="if ($depth-in-nav = 1) then 'it is not contained inside other sections such as a part or a chapter'                     else concat('it is contained inside ',string-join(ancestor::html:li[1]/ancestor::html:li/concat('&#34;',(text(),*/string-join(.//text(),''))[normalize-space()][1],'&#34;'),', which is contained inside'))"/>). The referenced headline (`&lt;<xsl:value-of select="$result-ref-first/@data-heading-element"/>
                        <xsl:value-of select="$result-ref-first/@data-heading-id/concat(' id=&#34;',.,'&#34;')"/>&gt;<xsl:value-of select="$result-ref-first/text()"/>&lt;/<xsl:value-of select="$result-ref-first/@data-heading-element"/>&gt;) occurs in the content document <xsl:value-of select="$href"/> as a `<xsl:value-of select="$result-ref-first/@data-heading-element"/>` which implies that it should be referenced at nesting depth <xsl:value-of select="$depth-in-content + $document-in-nav-depth - 1"/> in the
                navigation document.</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e60')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="c:result/c:result[@data-pagebreak-element]" priority="1" mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="pagebreak-ref"
                    select="if (@data-pagebreak-id) then concat(replace(@xml:base,'.*/',''),'#',@data-pagebreak-id) else ()"/>
      <xsl:variable name="nav-ref"
                    select="//html:nav[tokenize(@epub:type,'\s+')='page-list']//html:a[$pagebreak-ref and ends-with(@href, $pagebreak-ref)]"/>
      <schxslt:rule pattern="d7e133">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e133']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "c:result/c:result[@data-pagebreak-element]" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">c:result/c:result[@data-pagebreak-element]</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">c:result/c:result[@data-pagebreak-element]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(count($nav-ref) = 1)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count($nav-ref) = 1</xsl:attribute>
                     <svrl:text>[nordic_nav_references_3] All pagebreaks in the content documents must be referenced exactly once in the navigation document. In the content document
                    "<xsl:value-of select="replace(@xml:base,'.*/','')"/>", the pagebreak "<xsl:value-of select="text()"/>"<xsl:value-of select="if (@data-pagebreak-id) then concat(' with id=&#34;', @data-pagebreak-id,'&#34;') else ''"/> is <xsl:value-of select="if (count($nav-ref)=0) then 'not referenced' else 'referenced multiple times'"/> from the navigation document.</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
               <xsl:if test="count($nav-ref) and not(normalize-space(string-join(.//text(),'')) = ('', normalize-space(string-join($nav-ref//text(),''))))">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count($nav-ref) and not(normalize-space(string-join(.//text(),'')) = ('', normalize-space(string-join($nav-ref//text(),''))))</xsl:attribute>
                     <svrl:text>[nordic_nav_references_3] The page number for
                the pagebreak in the navigation document ("<xsl:value-of select="normalize-space(string-join($nav-ref//text(),''))"/>") should match the page number of the referenced pagebreak in the
                content document ("<xsl:value-of select="normalize-space(string-join(.//text(),''))"/>" at <xsl:value-of select="$pagebreak-ref"/>)</svrl:text>
                  </svrl:successful-report>
               </xsl:if>
               <xsl:if test="count($nav-ref) and normalize-space(string-join(.//text(),'')) = '' and not(normalize-space(string-join($nav-ref//text(),'')) = '-')">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count($nav-ref) and normalize-space(string-join(.//text(),'')) = '' and not(normalize-space(string-join($nav-ref//text(),'')) = '-')</xsl:attribute>
                     <svrl:text>[nordic_nav_references_3] The page
                number for the pagebreak in the navigation document ("<xsl:value-of select="normalize-space(string-join($nav-ref//text(),''))"/>") should be a dash ("-") when the referenced pagebreak in
                the content document is unnumbered ("<xsl:value-of select="normalize-space(string-join(.//text(),''))"/>" at <xsl:value-of select="$pagebreak-ref"/>)</svrl:text>
                  </svrl:successful-report>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e133')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:a[ancestor::html:nav[tokenize(@epub:type,'\s+')='page-list']]"
                 priority="0"
                 mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="result-ref"
                    select="/*/c:result/c:result[@data-pagebreak-id = substring-after(@href,'#')]"/>
      <xsl:variable name="preceding-refs-which-is-following-in-content"
                    select="(preceding::html:a intersect ancestor::html:nav//html:a)[@href = $result-ref/following-sibling::c:result/concat(replace(@xml:base,'.*/',''),@data-pagebreak-id)]"/>
      <schxslt:rule pattern="d7e174">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e174']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:a[ancestor::html:nav[tokenize(@epub:type,'\s+')='page-list']]" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:a[ancestor::html:nav[tokenize(@epub:type,'\s+')='page-list']]</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:a[ancestor::html:nav[tokenize(@epub:type,'\s+')='page-list']]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="count($preceding-refs-which-is-following-in-content)">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count($preceding-refs-which-is-following-in-content)</xsl:attribute>
                     <svrl:text>[nordic_nav_references_4] The page list in the navigation document must reference the pagebreaks in the correct order.
                The pagebreak with id="<xsl:value-of select="substring-after(@href,'#')"/>" in the document "<xsl:value-of select="substring-before(@href,'#')"/>" is referenced from the navigation document
                after the pagebreak with id="<xsl:value-of select="$preceding-refs-which-is-following-in-content[1]/substring-after(@href,'#')"/>" in the document "<xsl:value-of select="$preceding-refs-which-is-following-in-content[1]/substring-before(@href,'#')"/>", but in the content document it occurs before it.</svrl:text>
                  </svrl:successful-report>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e174')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:function name="schxslt:location" as="xs:string">
      <xsl:param name="node" as="node()"/>
      <xsl:variable name="segments" as="xs:string*">
         <xsl:for-each select="($node/ancestor-or-self::node())">
            <xsl:variable name="position">
               <xsl:number level="single"/>
            </xsl:variable>
            <xsl:choose>
               <xsl:when test=". instance of element()">
                  <xsl:value-of select="concat('Q{', namespace-uri(.), '}', local-name(.), '[', $position, ']')"/>
               </xsl:when>
               <xsl:when test=". instance of attribute()">
                  <xsl:value-of select="concat('@Q{', namespace-uri(.), '}', local-name(.))"/>
               </xsl:when>
               <xsl:when test=". instance of processing-instruction()">
                  <xsl:value-of select="concat('processing-instruction(&#34;', name(.), '&#34;)[', $position, ']')"/>
               </xsl:when>
               <xsl:when test=". instance of comment()">
                  <xsl:value-of select="concat('comment()[', $position, ']')"/>
               </xsl:when>
               <xsl:when test=". instance of text()">
                  <xsl:value-of select="concat('text()[', $position, ']')"/>
               </xsl:when>
               <xsl:otherwise/>
            </xsl:choose>
         </xsl:for-each>
      </xsl:variable>
      <xsl:value-of select="concat('/', string-join($segments, '/'))"/>
   </xsl:function>
</xsl:transform>