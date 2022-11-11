<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform xmlns:sch="http://purl.oclc.org/dsdl/schematron"
               xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
               xmlns:error="https://doi.org/10.5281/zenodo.1495494#error"
               xmlns:schxslt="https://doi.org/10.5281/zenodo.1495494"
               xmlns:xs="http://www.w3.org/2001/XMLSchema"
               xmlns:schxslt-api="https://doi.org/10.5281/zenodo.1495494#api"
               xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
               xmlns:html="http://www.w3.org/1999/xhtml"
               xmlns:epub="http://www.idpf.org/2007/ops"
               xmlns:nordic="http://www.mtm.se/epub/"
               xmlns:ncx="http://www.daisy.org/z3986/2005/ncx/"
               version="2.0">
   <rdf:Description xmlns:dct="http://purl.org/dc/terms/" xmlns:dc="http://purl.org/dc/elements/1.1/"
                    xmlns:skos="http://www.w3.org/2004/02/skos/core#">
      <dct:creator>
         <dct:Agent>
            <skos:prefLabel>SchXslt/1.9.4 SAXON/9.2.0.6</skos:prefLabel>
            <schxslt.compile.typed-variables xmlns="https://doi.org/10.5281/zenodo.1495494#">true</schxslt.compile.typed-variables>
         </dct:Agent>
      </dct:creator>
      <dct:created>2022-11-11T09:09:53.155+01:00</dct:created>
   </rdf:Description>
   <xsl:output indent="yes"/>
   <xsl:template match="root()">
      <xsl:variable name="metadata" as="element()?">
         <svrl:metadata xmlns:dct="http://purl.org/dc/terms/"
                        xmlns:skos="http://www.w3.org/2004/02/skos/core#"
                        xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
            <dct:creator>
               <dct:Agent>
                  <skos:prefLabel>
                     <xsl:value-of separator="/"
                                   select="(system-property('xsl:product-name'), system-property('xsl:product-version'))"/>
                  </skos:prefLabel>
               </dct:Agent>
            </dct:creator>
            <dct:created>
               <xsl:value-of select="current-dateTime()"/>
            </dct:created>
            <dct:source>
               <rdf:Description xmlns:dc="http://purl.org/dc/elements/1.1/">
                  <dct:creator>
                     <dct:Agent>
                        <skos:prefLabel>SchXslt/1.9.4 SAXON/9.2.0.6</skos:prefLabel>
                        <schxslt.compile.typed-variables xmlns="https://doi.org/10.5281/zenodo.1495494#">true</schxslt.compile.typed-variables>
                     </dct:Agent>
                  </dct:creator>
                  <dct:created>2022-11-11T09:09:53.155+01:00</dct:created>
               </rdf:Description>
            </dct:source>
         </svrl:metadata>
      </xsl:variable>
      <xsl:variable name="report" as="element(schxslt:report)">
         <schxslt:report>
            <xsl:call-template name="d7e17"/>
         </schxslt:report>
      </xsl:variable>
      <xsl:variable name="schxslt:report" as="node()*">
         <xsl:sequence select="$metadata"/>
         <xsl:for-each select="$report/schxslt:document">
            <xsl:for-each select="schxslt:pattern">
               <xsl:sequence select="node()"/>
               <xsl:sequence select="../schxslt:rule[@pattern = current()/@id]/node()"/>
            </xsl:for-each>
         </xsl:for-each>
      </xsl:variable>
      <svrl:schematron-output xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                              title="Nordic EPUB3 Navigation Document and NCX rules">
         <svrl:ns-prefix-in-attribute-values prefix="html" uri="http://www.w3.org/1999/xhtml"/>
         <svrl:ns-prefix-in-attribute-values prefix="epub" uri="http://www.idpf.org/2007/ops"/>
         <svrl:ns-prefix-in-attribute-values prefix="nordic" uri="http://www.mtm.se/epub/"/>
         <svrl:ns-prefix-in-attribute-values prefix="ncx" uri="http://www.daisy.org/z3986/2005/ncx/"/>
         <xsl:sequence select="$schxslt:report"/>
      </svrl:schematron-output>
   </xsl:template>
   <xsl:template match="text() | @*" mode="#all" priority="-10"/>
   <xsl:template match="/" mode="#all" priority="-10">
      <xsl:apply-templates mode="#current" select="node()"/>
   </xsl:template>
   <xsl:template match="*" mode="#all" priority="-10">
      <xsl:apply-templates mode="#current" select="@*"/>
      <xsl:apply-templates mode="#current" select="node()"/>
   </xsl:template>
   <xsl:template name="d7e17">
      <schxslt:document>
         <schxslt:pattern id="d7e17">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e31">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e45">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e100">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e138">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e150">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e163">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e178">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <xsl:apply-templates mode="d7e17" select="root()"/>
      </schxslt:document>
   </xsl:template>
   <xsl:template match="html:a[ancestor::html:nav/tokenize(@epub:type,'\s+')='toc']"
                 priority="7"
                 mode="d7e17">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="navPoint"
                    select="/*/ncx:*[1]/ncx:navMap//ncx:navPoint[ncx:content/@src=current()/@href]"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e17']">
            <schxslt:rule pattern="d7e17">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:a[ancestor::html:nav/tokenize(@epub:type,'\s+')='toc']" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:a[ancestor::html:nav/tokenize(@epub:type,'\s+')='toc']</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e17">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:a[ancestor::html:nav/tokenize(@epub:type,'\s+')='toc']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="count($navPoint) = 0">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count($navPoint) = 0</xsl:attribute>
                     <svrl:text>[nordic_nav_ncx_1_a] toc items in the navigation document must also occur in the NCX. <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e17')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:a[ancestor::html:nav/tokenize(@epub:type,'\s+')='page-list']"
                 priority="6"
                 mode="d7e17">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="pageTarget"
                    select="/*/ncx:*[1]/ncx:pageList/ncx:pageTarget[ncx:content/@src=current()/@href]"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e31']">
            <schxslt:rule pattern="d7e31">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:a[ancestor::html:nav/tokenize(@epub:type,'\s+')='page-list']" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:a[ancestor::html:nav/tokenize(@epub:type,'\s+')='page-list']</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e31">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:a[ancestor::html:nav/tokenize(@epub:type,'\s+')='page-list']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="count($pageTarget) = 0">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count($pageTarget) = 0</xsl:attribute>
                     <svrl:text>[nordic_nav_ncx_2_a] page references in the navigation document must also occur as pageTarget items in the NCX. <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e31')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="ncx:navPoint" priority="5" mode="d7e17">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="navRef"
                    select="/*/html:*[1]/html:body/html:nav[tokenize(@epub:type,'\s+')='toc']//html:a[@href=current()/ncx:content/@src]"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e45']">
            <schxslt:rule pattern="d7e45">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "ncx:navPoint" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">ncx:navPoint</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e45">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">ncx:navPoint</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="count($navRef) = 0">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count($navRef) = 0</xsl:attribute>
                     <svrl:text>[nordic_nav_ncx_3_a] toc items in the NCX must also occur in the navigation document.<xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
               <xsl:if test="not(count($navRef) != 1 or count(ancestor-or-self::ncx:navPoint) = count($navRef/ancestor::html:li))">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count($navRef) != 1 or count(ancestor-or-self::ncx:navPoint) = count($navRef/ancestor::html:li)</xsl:attribute>
                     <svrl:text>
                [nordic_nav_ncx_3_b] The navPoint in the NCX (
                <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                ) has 
                <xsl:value-of select="count(ancestor::ncx:navPoint)"/>
                 ancestors 
                <xsl:value-of select="if (ancestor::ncx:navPoint) then concat('(&#34;',string-join(ancestor::ncx:navPoint/ncx:navLabel/normalize-space(string-join(.//text(),'')),'&#34;, &#34;'),'&#34;)') else ''"/>
                , while the corresponding item in the navigation document (
                <xsl:value-of select="$navRef/concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                ) has 
                <xsl:value-of select="count($navRef/ancestor::html:li)-1"/>
                 ancestors 
                <xsl:value-of select="if ($navRef/ancestor::html:li[1]/ancestor::html:li) then $navRef/concat('(&#34;',string-join(ancestor::html:li[1]/ancestor::html:li/normalize-space(string-join((* except (html:ol | html:ul))//text(),'')),'&#34;, &#34;'),'&#34;)') else ''"/>
                . The item in the navigation document and the navPoint in the NCX must have the same number of ancestors. Maybe the item are placed on the wrong nesting level or under the wrong headline.
            </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
               <xsl:if test="not(count($navRef) != 1 or count(preceding-sibling::ncx:navPoint) = count($navRef/ancestor::html:li[1]/preceding-sibling::html:li))">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count($navRef) != 1 or count(preceding-sibling::ncx:navPoint) = count($navRef/ancestor::html:li[1]/preceding-sibling::html:li)</xsl:attribute>
                     <svrl:text>
                [nordic_nav_ncx_3_c] The navPoint in the NCX (
                <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                ) has 
                <xsl:value-of select="count(preceding-sibling::ncx:navPoint)"/>
                 preceding siblings 
                <xsl:value-of select="if (preceding-sibling::ncx:navPoint) then concat('(&#34;',string-join((preceding-sibling::ncx:navPoint)[position() &lt;= 3]/ncx:navLabel/normalize-space(string-join(.//text(),'')),'&#34;, &#34;'),'&#34;') else ''"/>
                        <xsl:value-of select="if (count(preceding-sibling::ncx:navPoint) &gt; 3) then concat(' and ',count(preceding-sibling::ncx:navPoint)-3,' more') else ''"/>
                        <xsl:value-of select="if (preceding-sibling::ncx:navPoint) then ')' else ''"/>
                , while the corresponding item in the navigation document (
                <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                ) has 
                <xsl:value-of select="count($navRef/ancestor::html:li[1]/preceding-sibling::html:li)"/>
                 preceding siblings 
                <xsl:value-of select="if ($navRef/ancestor::html:li[1]/preceding-sibling::html:li) then $navRef/concat('(&#34;',string-join((ancestor::html:li[1]/preceding-sibling::html:li)[position() &lt;= 3]/normalize-space(string-join((* except (html:ol | html:ul))//text(),'')),'&#34;, &#34;'),'&#34;') else ''"/>
                        <xsl:value-of select="if (count($navRef/ancestor::html:li[1]/preceding-sibling::html:li) &gt; 3) then $navRef/concat(' and ',count(ancestor::html:li[1]/preceding-sibling::html:li)-3,' more') else ''"/>
                        <xsl:value-of select="if ($navRef/ancestor::html:li[1]/preceding-sibling::html:li) then ')' else ''"/>
                . The item in the navigation document and the navPoint in the NCX must have the same number of preceding siblings. Maybe the items are not placed in the correct order or maybe some of the preceding items are missing.
            </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e45')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="ncx:pageTarget" priority="4" mode="d7e17">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="navRef"
                    select="/*/html:*[1]/html:body/html:nav[tokenize(@epub:type,'\s+')='page-list']//html:a[@href=current()/ncx:content/@src]"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e100']">
            <schxslt:rule pattern="d7e100">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "ncx:pageTarget" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">ncx:pageTarget</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e100">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">ncx:pageTarget</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="count($navRef) = 0">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count($navRef) = 0</xsl:attribute>
                     <svrl:text>[nordic_nav_ncx_4_a] pageTarget items in the NCX must also occur as page references in the navigation document. <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
               <xsl:if test="not(count($navRef) != 1 or count(preceding-sibling::ncx:pageTarget) = count($navRef/ancestor::html:li[1]/preceding-sibling::html:li))">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count($navRef) != 1 or count(preceding-sibling::ncx:pageTarget) = count($navRef/ancestor::html:li[1]/preceding-sibling::html:li)</xsl:attribute>
                     <svrl:text>
                [nordic_nav_ncx_4_b] The pageTarget in the NCX (
                <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                ) has 
                <xsl:value-of select="count(preceding-sibling::ncx:pageTarget)"/>
                 preceding siblings 
                <xsl:value-of select="if (preceding-sibling::ncx:pageTarget) then concat('(&#34;',string-join((preceding-sibling::ncx:pageTarget)[position() &lt;= 3]/ncx:navLabel/normalize-space(string-join(.//text(),'')),'&#34;, &#34;'),'&#34;') else ''"/>
                        <xsl:value-of select="if (count(preceding-sibling::ncx:pageTarget) &gt; 3) then concat(' and ',count(preceding-sibling::ncx:pageTarget)-3,' more') else ''"/>
                        <xsl:value-of select="if (preceding-sibling::ncx:pageTarget) then ')' else ''"/>
                , while the page reference in the navigation document (
                <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                ) has 
                <xsl:value-of select="count($navRef/ancestor::html:li[1]/preceding-sibling::html:li)"/>
                 preceding siblings 
                <xsl:value-of select="if ($navRef/ancestor::html:li[1]/preceding-sibling::html:li) then concat('(&#34;',$navRef/string-join((ancestor::html:li[1]/preceding-sibling::html:li)[position() &lt;= 3]/normalize-space(string-join((* except (html:ol | html:ul))//text(),'')),'&#34;, &#34;'),'&#34;') else ''"/>
                        <xsl:value-of select="if (count($navRef/ancestor::html:li[1]/preceding-sibling::html:li) &gt; 3) then $navRef/concat(' and ',count(ancestor::html:li[1]/preceding-sibling::html:li)-3,' more') else ''"/>
                        <xsl:value-of select="if ($navRef/ancestor::html:li[1]/preceding-sibling::html:li) then ')' else ''"/>
                . The page reference in the navigation document and the pageTarget in the NCX must have the same number of preceding siblings. Maybe the items are not placed in the correct order or maybe some of the preceding items are missing.
            </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e100')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:a" priority="3" mode="d7e17">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e138']">
            <schxslt:rule pattern="d7e138">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:a" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:a</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e138">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:a</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="@href = preceding::html:a/@href">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">@href = preceding::html:a/@href</xsl:attribute>
                     <svrl:text>[nordic_nav_ncx_5] Two references in the navigation document can not point to the same location in the content. <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e138')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="ncx:navPoint | ncx:pageTarget" priority="2" mode="d7e17">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e150']">
            <schxslt:rule pattern="d7e150">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "ncx:navPoint | ncx:pageTarget" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">ncx:navPoint | ncx:pageTarget</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e150">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">ncx:navPoint | ncx:pageTarget</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="@href = (preceding::ncx:navPoint/@href | preceding::ncx:pageTarget/@href)">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">@href = (preceding::ncx:navPoint/@href | preceding::ncx:pageTarget/@href)</xsl:attribute>
                     <svrl:text>[nordic_nav_ncx_6] Two references in the NCX (navPoint or pageTarget) can not point to the same
                location in the content. <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e150')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="ncx:navLabel[parent::ncx:navMap]" priority="1" mode="d7e17">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e163']">
            <schxslt:rule pattern="d7e163">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "ncx:navLabel[parent::ncx:navMap]" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">ncx:navLabel[parent::ncx:navMap]</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e163">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">ncx:navLabel[parent::ncx:navMap]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(normalize-space(string-join(.//text(),'')) = /*/html:*/html:body/html:nav[tokenize(@epub:type,'\s+')='toc']/html:h1/normalize-space(string-join(.//text(),'')))">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">normalize-space(string-join(.//text(),'')) = /*/html:*/html:body/html:nav[tokenize(@epub:type,'\s+')='toc']/html:h1/normalize-space(string-join(.//text(),''))</xsl:attribute>
                     <svrl:text>[nordic_nav_ncx_7] The navLabel in the NCX navMap must correspond to the h1 in the toc in the navigation document. The NCX navLabel has the value "<xsl:value-of select="normalize-space(string-join(.//text(),''))"/>", while the page-list h1 in the navigation document <xsl:value-of select="(/*/html:*/html:body/html:nav[tokenize(@epub:type,'\s+')='toc']/html:h1/concat('has the value &#34;',normalize-space(string-join(.//text(),'')),'&#34;'), 'does not exist')[1]"/>.</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e163')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="ncx:navLabel[parent::ncx:pageList]" priority="0" mode="d7e17">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e178']">
            <schxslt:rule pattern="d7e178">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "ncx:navLabel[parent::ncx:pageList]" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">ncx:navLabel[parent::ncx:pageList]</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e178">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">ncx:navLabel[parent::ncx:pageList]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(normalize-space(string-join(.//text(),'')) = /*/html:*/html:body/html:nav[tokenize(@epub:type,'\s+')='page-list']/html:h1/normalize-space(string-join(.//text(),'')))">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">normalize-space(string-join(.//text(),'')) = /*/html:*/html:body/html:nav[tokenize(@epub:type,'\s+')='page-list']/html:h1/normalize-space(string-join(.//text(),''))</xsl:attribute>
                     <svrl:text>[nordic_nav_ncx_8] The navLabel in the NCX pageList must correspond to the h1 in the page-list in the navigation document. The NCX navLabel has the value "<xsl:value-of select="normalize-space(string-join(.//text(),''))"/>", while the page-list h1 in the navigation document <xsl:value-of select="(/*/html:*/html:body/html:nav[tokenize(@epub:type,'\s+')='page-list']/html:h1/concat('has the value &#34;',normalize-space(string-join(.//text(),'')),'&#34;'), 'does not exist')[1]"/>.</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e178')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
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