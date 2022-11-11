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
               version="2.0">
   <rdf:Description xmlns:dct="http://purl.org/dc/terms/"
                    xmlns:skos="http://www.w3.org/2004/02/skos/core#">
      <dct:creator>
         <dct:Agent>
            <skos:prefLabel>SchXslt/1.6.2 SAXON/9.2.0.6</skos:prefLabel>
            <schxslt.compile.typed-variables xmlns="https://doi.org/10.5281/zenodo.1495494#">true</schxslt.compile.typed-variables>
         </dct:Agent>
      </dct:creator>
      <dct:created>2022-10-18T12:59:50.274+02:00</dct:created>
   </rdf:Description>
   <xsl:output indent="yes"/>
   <xsl:param name="ids" select="//xs:string(@id)"/>
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
                  <dct:created>2022-10-18T12:59:50.274+02:00</dct:created>
               </rdf:Description>
            </dct:source>
         </svrl:metadata>
      </xsl:variable>
      <xsl:variable name="report" as="element(schxslt:report)">
         <schxslt:report>
            <xsl:call-template name="d7e21"/>
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
                              title="Nordic EPUB3 Package Document and Content Document cross-reference rules">
         <svrl:ns-prefix-in-attribute-values prefix="html" uri="http://www.w3.org/1999/xhtml"/>
         <svrl:ns-prefix-in-attribute-values prefix="opf" uri="http://www.idpf.org/2007/opf"/>
         <svrl:ns-prefix-in-attribute-values prefix="dc" uri="http://purl.org/dc/elements/1.1/"/>
         <svrl:ns-prefix-in-attribute-values prefix="epub" uri="http://www.idpf.org/2007/ops"/>
         <svrl:ns-prefix-in-attribute-values prefix="nordic" uri="http://www.mtm.se/epub/"/>
         <xsl:sequence select="$schxslt:report"/>
      </svrl:schematron-output>
   </xsl:template>
   <xsl:template match="text() | @*" mode="#all" priority="-10"/>
   <xsl:template match="*" mode="#all" priority="-10">
      <xsl:apply-templates mode="#current" select="@*"/>
      <xsl:apply-templates mode="#current" select="node()"/>
   </xsl:template>
   <xsl:template name="d7e21">
      <schxslt:pattern id="d7e21">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="opf_and_html_nordic_1">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e21" select="/"/>
      <schxslt:pattern id="d7e44">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="nordic_opf_and_html_13_a">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e21" select="/"/>
      <schxslt:pattern id="d7e66">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="nordic_opf_and_html_15">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e21" select="/"/>
      <schxslt:pattern id="d7e124">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="nordic_opf_and_html_23">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e21" select="/"/>
      <schxslt:pattern id="d7e151">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="nordic_opf_and_html_24">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e21" select="/"/>
      <schxslt:pattern id="d7e172">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="nordic_opf_and_html_26_a">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e21" select="/"/>
      <schxslt:pattern id="d7e198">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="nordic_opf_and_html_26_b">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e21" select="/"/>
      <schxslt:pattern id="d7e223">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="nordic_opf_and_html_27_a">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e21" select="/"/>
      <schxslt:pattern id="d7e248">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="nordic_opf_and_html_27_b">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e21" select="/"/>
      <schxslt:pattern id="d7e274">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="nordic_opf_and_html_28">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e21" select="/"/>
      <schxslt:pattern id="d7e297">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="nordic_opf_and_html_29">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e21" select="/"/>
   </xsl:template>
   <xsl:template match="*[@id]" priority="10" mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:variable name="id" select="@id"/>
      <schxslt:rule pattern="d7e21">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e21']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "*[@id]" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">*[@id]</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">*[@id]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(count($ids[.=$id]) = 1)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count($ids[.=$id]) = 1</xsl:attribute>
                     <svrl:text>[nordic_opf_and_html_1] id attributes must be unique; <xsl:value-of select="@id"/> in <xsl:value-of select="replace(base-uri(.),'^.*/','')"/> also exists
                in <xsl:value-of select="(//*[@id=$id] except .)/replace(base-uri(.),'^.*/','')"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e21')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:html[not(preceding-sibling::html:html)]" priority="9" mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <schxslt:rule pattern="d7e44">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e44']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:html[not(preceding-sibling::html:html)]" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:html[not(preceding-sibling::html:html)]</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:html[not(preceding-sibling::html:html)]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(((.|following-sibling::html:html)/html:body/html:section/tokenize(@epub:type,'\s+')=('cover','frontmatter')) = true())">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">((.|following-sibling::html:html)/html:body/html:section/tokenize(@epub:type,'\s+')=('cover','frontmatter')) = true()</xsl:attribute>
                     <svrl:text>[nordic_opf_and_html_13a] There must be at least one frontmatter or
                cover document</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
               <xsl:if test="not(((.|following-sibling::html:html)/html:body/html:section/tokenize(@epub:type,'\s+')='bodymatter') = true())">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">((.|following-sibling::html:html)/html:body/html:section/tokenize(@epub:type,'\s+')='bodymatter') = true()</xsl:attribute>
                     <svrl:text>[nordic_opf_and_html_13a] There must be at least one bodymatter
                document</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e44')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="opf:itemref" priority="8" mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:variable name="this" select="."/>
      <xsl:variable name="this-item" select="../../opf:manifest/opf:item[@id = $this/@idref]"/>
      <xsl:variable name="this-type"
                    select="/*/html:html/html:body[replace(base-uri(),'.*/','') = $this-item/@href]/(tokenize(@epub:type,'\s+')[.=('cover','frontmatter','bodymatter','backmatter')],'bodymatter')[1]"/>
      <xsl:variable name="preceding-items"
                    select="../../opf:manifest/opf:item[@id = $this/preceding-sibling::opf:item/@idref]"/>
      <xsl:variable name="preceding-cover"
                    select="/*/html:html/html:body[replace(base-uri(),'.*/','') = $preceding-items/@href and tokenize(@epub:type,'\s+') = 'cover']"/>
      <xsl:variable name="preceding-frontmatter"
                    select="/*/html:html/html:body[replace(base-uri(),'.*/','') = $preceding-items/@href and tokenize(@epub:type,'\s+') = 'frontmatter']"/>
      <xsl:variable name="preceding-bodymatter"
                    select="/*/html:html/html:body[replace(base-uri(),'.*/','') = $preceding-items/@href and (tokenize(@epub:type,'\s+') = 'bodymatter' or not(tokenize(@epub:type,'\s+') = ('cover','frontmatter','backmatter')))]"/>
      <xsl:variable name="preceding-backmatter"
                    select="/*/html:html/html:body[replace(base-uri(),'.*/','') = $preceding-items/@href and tokenize(@epub:type,'\s+') = 'backmatter']"/>
      <schxslt:rule pattern="d7e66">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e66']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "opf:itemref" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">opf:itemref</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">opf:itemref</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="$this-type = 'cover' and count($preceding-items)">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">$this-type = 'cover' and count($preceding-items)</xsl:attribute>
                     <svrl:text>[nordic_opf_and_html_15] Cover must not be preceded by any other itemrefs in the OPF spine: <xsl:value-of select="$context"/> (in <xsl:value-of select="replace(base-uri(),'.*/','')"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
               <xsl:if test="$this-type = 'frontmatter' and $preceding-bodymatter">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">$this-type = 'frontmatter' and $preceding-bodymatter</xsl:attribute>
                     <svrl:text>[nordic_opf_and_html_15] Frontmatter must be placed before all bodymatter in the spine: <xsl:value-of select="$context"/> (in <xsl:value-of select="replace(base-uri(),'.*/','')"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
               <xsl:if test="$this-type = 'frontmatter' and $preceding-backmatter">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">$this-type = 'frontmatter' and $preceding-backmatter</xsl:attribute>
                     <svrl:text>[nordic_opf_and_html_15] Frontmatter must be placed before all backmatter in the spine: <xsl:value-of select="$context"/> (in <xsl:value-of select="replace(base-uri(),'.*/','')"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
               <xsl:if test="$this-type = 'bodymatter' and $preceding-backmatter">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">$this-type = 'bodymatter' and $preceding-backmatter</xsl:attribute>
                     <svrl:text>[nordic_opf_and_html_15] Bodymatter must be placed before all backmatter in the spine: <xsl:value-of select="$context"/> (in <xsl:value-of select="replace(base-uri(),'.*/','')"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e66')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:*[tokenize(@epub:type,'\s+')='pagebreak' and tokenize(@class,'\s+')='page-normal' and preceding::html:*[tokenize(@epub:type,'\s+')='pagebreak'][tokenize(@class,'\s+')='page-normal']]"
                 priority="7"
                 mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:variable name="preceding"
                    select="preceding::html:*[tokenize(@epub:type,'\s+')='pagebreak' and tokenize(@class,'\s+')='page-normal'][1]"/>
      <schxslt:rule pattern="d7e124">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e124']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:*[tokenize(@epub:type,'\s+')='pagebreak' and tokenize(@class,'\s+')='page-normal' and preceding::html:*[tokenize(@epub:type,'\s+')='pagebreak'][tokenize(@class,'\s+')='page-normal']]" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type,'\s+')='pagebreak' and tokenize(@class,'\s+')='page-normal' and preceding::html:*[tokenize(@epub:type,'\s+')='pagebreak'][tokenize(@class,'\s+')='page-normal']]</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type,'\s+')='pagebreak' and tokenize(@class,'\s+')='page-normal' and preceding::html:*[tokenize(@epub:type,'\s+')='pagebreak'][tokenize(@class,'\s+')='page-normal']]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(number(current()/@aria-label) &gt; number($preceding/@aria-label))">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">number(current()/@aria-label) &gt; number($preceding/@aria-label)</xsl:attribute>
                     <svrl:text>[nordic_opf_and_html_23] pagebreak values must increase for pagebreaks with class="page-normal" (see pagebreak with
                aria-label="<xsl:value-of select="@aria-label"/>" in <xsl:value-of select="replace(base-uri(.),'^.*/','')"/> and compare with pagebreak with aria-label="<xsl:value-of select="$preceding/@aria-label"/> in
                    <xsl:value-of select="replace(base-uri($preceding),'^.*/','')"/>)</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e124')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:*[tokenize(@epub:type,' ')='pagebreak'][tokenize(@class,' ')='page-front']"
                 priority="6"
                 mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <schxslt:rule pattern="d7e151">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e151']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:*[tokenize(@epub:type,' ')='pagebreak'][tokenize(@class,' ')='page-front']" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type,' ')='pagebreak'][tokenize(@class,' ')='page-front']</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type,' ')='pagebreak'][tokenize(@class,' ')='page-front']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(count(//html:*[tokenize(@epub:type,'\s+')='pagebreak' and tokenize(@class,'\s+')='page-front' and @aria-label=current()/@aria-label])=1)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count(//html:*[tokenize(@epub:type,'\s+')='pagebreak' and tokenize(@class,'\s+')='page-front' and @aria-label=current()/@aria-label])=1</xsl:attribute>
                     <svrl:text>[nordic_opf_and_html_24] pagebreak values must
                be unique for pagebreaks with class="page-front" (see pagebreak with aria-label="<xsl:value-of select="@aria-label"/>" in <xsl:value-of select="replace(base-uri(.),'^.*/','')"/>)</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e151')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:*[tokenize(@epub:type,'\s+')=('note','endnote','footnote')]"
                 priority="5"
                 mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <schxslt:rule pattern="d7e172">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e172']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:*[tokenize(@epub:type,'\s+')=('note','endnote','footnote')]" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type,'\s+')=('note','endnote','footnote')]</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type,'\s+')=('note','endnote','footnote')]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(count(//html:a[tokenize(@epub:type,'\s+')='noteref' and substring-after(@href,'#') = current()/@id]) &gt;= 1)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count(//html:a[tokenize(@epub:type,'\s+')='noteref' and substring-after(@href,'#') = current()/@id]) &gt;= 1</xsl:attribute>
                     <svrl:text>[nordic_opf_and_html_26a] The <xsl:value-of select="(tokenize(@epub:type,'\s+')[.=('note','endnote','footnote')],'note')[1]"/>
                        <xsl:value-of select="if (@id) then concat(' with the id &#34;',@id,'&#34;') else ''"/> must have
                at least one &lt;a epub:type="noteref" ...&gt; referencing it: <xsl:value-of select="$context"/> (in <xsl:value-of select="replace(base-uri(),'.*/','')"/>)</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e172')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:a[tokenize(@epub:type,'\s+')='noteref']" priority="4" mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <schxslt:rule pattern="d7e198">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e198']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:a[tokenize(@epub:type,'\s+')='noteref']" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:a[tokenize(@epub:type,'\s+')='noteref']</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:a[tokenize(@epub:type,'\s+')='noteref']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(count(//html:*[tokenize(@role,'\s+')=('doc-endnote','doc-footnote') and @id = current()/substring-after(@href,'#')]) &gt;= 1)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count(//html:*[tokenize(@role,'\s+')=('doc-endnote','doc-footnote') and @id = current()/substring-after(@href,'#')]) &gt;= 1</xsl:attribute>
                     <svrl:text>[nordic_opf_and_html_26b] The note
                reference with the href "<xsl:value-of select="@href"/>" attribute must resolve to a note, endnote or footnote in the publication: <xsl:value-of select="$context"/> (in <xsl:value-of select="replace(base-uri(),'.*/','')"/>)</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e198')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:*[tokenize(@epub:type,'\s+')=('annotation')]" priority="3"
                 mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <schxslt:rule pattern="d7e223">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e223']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:*[tokenize(@epub:type,'\s+')=('annotation')]" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type,'\s+')=('annotation')]</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type,'\s+')=('annotation')]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(count(//html:a[tokenize(@epub:type,'\s+')='annoref' and substring-after(@href,'#') = current()/@id]) &gt;= 1)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count(//html:a[tokenize(@epub:type,'\s+')='annoref' and substring-after(@href,'#') = current()/@id]) &gt;= 1</xsl:attribute>
                     <svrl:text>[nordic_opf_and_html_27a] The annotation<xsl:value-of select="if (@id) then concat(' with the id &#34;',@id,'&#34;') else ''"/> must have at least one &lt;a epub:type="annoref" ...&gt; referencing it: <xsl:value-of select="$context"/> (in <xsl:value-of select="replace(base-uri(),'.*/','')"/>)</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e223')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:a[tokenize(@epub:type,'\s+')='annoref']" priority="2" mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <schxslt:rule pattern="d7e248">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e248']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:a[tokenize(@epub:type,'\s+')='annoref']" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:a[tokenize(@epub:type,'\s+')='annoref']</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:a[tokenize(@epub:type,'\s+')='annoref']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(count(//html:*[tokenize(@epub:type,'\s+')=('annotation') and @id = current()/substring-after(@href,'#')]) &gt;= 1)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count(//html:*[tokenize(@epub:type,'\s+')=('annotation') and @id = current()/substring-after(@href,'#')]) &gt;= 1</xsl:attribute>
                     <svrl:text>[nordic_opf_and_html_26b] The annotation with the href
                    "<xsl:value-of select="@href"/>" must resolve to a annotation in the publication: <xsl:value-of select="$context"/> (in <xsl:value-of select="replace(base-uri(),'.*/','')"/>)</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e248')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:title" priority="1" mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <schxslt:rule pattern="d7e274">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e274']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:title" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:title</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:title</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(text() = /*/opf:package/opf:metadata/dc:title[not(@refines)]/text())">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">text() = /*/opf:package/opf:metadata/dc:title[not(@refines)]/text()</xsl:attribute>
                     <svrl:text>[nordic_opf_and_html_28] The HTML title element in <xsl:value-of select="replace(base-uri(.),'.*/','')"/>
                must contain the same text as the dc:title element in the OPF metadata. The HTML title element contains "<xsl:value-of select="."/>" while the dc:title element in the OPF contains
                    "<xsl:value-of select="/*/opf:package/opf:metadata/dc:title[not(@refines)]/text()"/>".</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e274')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:meta[@name='dc:identifier']" priority="0" mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <schxslt:rule pattern="d7e297">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e297']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:meta[@name='dc:identifier']" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:meta[@name='dc:identifier']</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:meta[@name='dc:identifier']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(@content = /*/opf:package/opf:metadata/dc:identifier[not(@refines)]/text())">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">@content = /*/opf:package/opf:metadata/dc:identifier[not(@refines)]/text()</xsl:attribute>
                     <svrl:text>[nordic_opf_and_html_29] The HTML meta element in <xsl:value-of select="replace(base-uri(.),'.*/','')"/> with dc:identifier must have as content the same as the OPF publication dc:identifier. The OPF dc:identifier is "<xsl:value-of select="/*/opf:package/opf:metadata/dc:identifier[not(@refines)]/text()"/>" while the HTML dc:identifier is "<xsl:value-of select="@content"/>".</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e297')"/>
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