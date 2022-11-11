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
            <skos:prefLabel>SchXslt/1.9.4 SAXON/9.2.0.6</skos:prefLabel>
            <schxslt.compile.typed-variables xmlns="https://doi.org/10.5281/zenodo.1495494#">true</schxslt.compile.typed-variables>
         </dct:Agent>
      </dct:creator>
      <dct:created>2022-11-11T09:09:54.277+01:00</dct:created>
   </rdf:Description>
   <xsl:output indent="yes"/>
   <xsl:param name="ids" select="//xs:string(@id)"/>
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
               <rdf:Description>
                  <dct:creator>
                     <dct:Agent>
                        <skos:prefLabel>SchXslt/1.9.4 SAXON/9.2.0.6</skos:prefLabel>
                        <schxslt.compile.typed-variables xmlns="https://doi.org/10.5281/zenodo.1495494#">true</schxslt.compile.typed-variables>
                     </dct:Agent>
                  </dct:creator>
                  <dct:created>2022-11-11T09:09:54.277+01:00</dct:created>
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
         <xsl:for-each select="$report/schxslt:document">
            <xsl:for-each select="schxslt:pattern">
               <xsl:sequence select="node()"/>
               <xsl:sequence select="../schxslt:rule[@pattern = current()/@id]/node()"/>
            </xsl:for-each>
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
   <xsl:template match="/" mode="#all" priority="-10">
      <xsl:apply-templates mode="#current" select="node()"/>
   </xsl:template>
   <xsl:template match="*" mode="#all" priority="-10">
      <xsl:apply-templates mode="#current" select="@*"/>
      <xsl:apply-templates mode="#current" select="node()"/>
   </xsl:template>
   <xsl:template name="d7e21">
      <schxslt:document>
         <schxslt:pattern id="d7e21">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="opf_and_html_nordic_1"
                                    id="opf_and_html_nordic_1">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e39">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="nordic_opf_and_html_13_a"
                                    id="nordic_opf_and_html_13_a">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e54">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="nordic_opf_and_html_15"
                                    id="nordic_opf_and_html_15">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e106">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="nordic_opf_and_html_40"
                                    id="nordic_opf_and_html_40">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e127">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="nordic_opf_and_html_23"
                                    id="nordic_opf_and_html_23">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e149">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="nordic_opf_and_html_24"
                                    id="nordic_opf_and_html_24">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e164">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="nordic_opf_and_html_26_a"
                                    id="nordic_opf_and_html_26_a">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e184">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="nordic_opf_and_html_26_b"
                                    id="nordic_opf_and_html_26_b">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e204">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="nordic_opf_and_html_27_a"
                                    id="nordic_opf_and_html_27_a">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e223">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="nordic_opf_and_html_27_b"
                                    id="nordic_opf_and_html_27_b">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e242">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="nordic_opf_and_html_28"
                                    id="nordic_opf_and_html_28">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e260">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="nordic_opf_and_html_29"
                                    id="nordic_opf_and_html_29">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e277">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="nordic_opf_and_html_32"
                                    id="nordic_opf_and_html_32">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e289">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="nordic_opf_and_html_276"
                                    id="nordic_opf_and_html_276">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <xsl:apply-templates mode="d7e21" select="root()"/>
      </schxslt:document>
   </xsl:template>
   <xsl:template match="*[@id]" priority="13" mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="id" select="@id"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e21']">
            <schxslt:rule pattern="d7e21">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "*[@id]" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">*[@id]</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e21">
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
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e21')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:html[not(preceding-sibling::html:html)]" priority="12" mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e39']">
            <schxslt:rule pattern="d7e39">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:html[not(preceding-sibling::html:html)]" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:html[not(preceding-sibling::html:html)]</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e39">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:html[not(preceding-sibling::html:html)]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(((.|following-sibling::html:html)/html:body/tokenize(@epub:type,'\s+')=('cover','frontmatter')) = true())">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">((.|following-sibling::html:html)/html:body/tokenize(@epub:type,'\s+')=('cover','frontmatter')) = true()</xsl:attribute>
                     <svrl:text>[nordic_opf_and_html_13a] There must be at least one frontmatter or
                cover document</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
               <xsl:if test="not(((.|following-sibling::html:html)/html:body/tokenize(@epub:type,'\s+')='bodymatter') = true())">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">((.|following-sibling::html:html)/html:body/tokenize(@epub:type,'\s+')='bodymatter') = true()</xsl:attribute>
                     <svrl:text>[nordic_opf_and_html_13a] There must be at least one bodymatter
                document</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e39')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="opf:itemref" priority="11" mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
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
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e54']">
            <schxslt:rule pattern="d7e54">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "opf:itemref" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">opf:itemref</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e54">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">opf:itemref</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="$this-type = 'cover' and count($preceding-items)">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">$this-type = 'cover' and count($preceding-items)</xsl:attribute>
                     <svrl:text>[nordic_opf_and_html_15] Cover must not be preceded by any other itemrefs in the OPF spine: <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/> (in <xsl:value-of select="replace(base-uri(),'.*/','')"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
               <xsl:if test="$this-type = 'frontmatter' and $preceding-bodymatter">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">$this-type = 'frontmatter' and $preceding-bodymatter</xsl:attribute>
                     <svrl:text>[nordic_opf_and_html_15] Frontmatter must be placed before all bodymatter in the spine: <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/> (in <xsl:value-of select="replace(base-uri(),'.*/','')"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
               <xsl:if test="$this-type = 'frontmatter' and $preceding-backmatter">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">$this-type = 'frontmatter' and $preceding-backmatter</xsl:attribute>
                     <svrl:text>[nordic_opf_and_html_15] Frontmatter must be placed before all backmatter in the spine: <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/> (in <xsl:value-of select="replace(base-uri(),'.*/','')"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
               <xsl:if test="$this-type = 'bodymatter' and $preceding-backmatter">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">$this-type = 'bodymatter' and $preceding-backmatter</xsl:attribute>
                     <svrl:text>[nordic_opf_and_html_15] Bodymatter must be placed before all backmatter in the spine: <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/> (in <xsl:value-of select="replace(base-uri(),'.*/','')"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e54')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:*[tokenize(@epub:type,'\s+')='pagebreak' and tokenize(@class,'\s+')='page-normal' and count(preceding::html:*[tokenize(@epub:type,'\s+')='pagebreak' and tokenize(@class,'\s+')='page-normal'])]"
                 priority="10"
                 mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="preceding-pagebreak"
                    select="preceding::html:*[tokenize(@epub:type,'\s+')='pagebreak' and tokenize(@class,'\s+')='page-normal'][1]"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e106']">
            <schxslt:rule pattern="d7e106">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:*[tokenize(@epub:type,'\s+')='pagebreak' and tokenize(@class,'\s+')='page-normal' and count(preceding::html:*[tokenize(@epub:type,'\s+')='pagebreak' and tokenize(@class,'\s+')='page-normal'])]" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type,'\s+')='pagebreak' and tokenize(@class,'\s+')='page-normal' and count(preceding::html:*[tokenize(@epub:type,'\s+')='pagebreak' and tokenize(@class,'\s+')='page-normal'])]</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e106">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type,'\s+')='pagebreak' and tokenize(@class,'\s+')='page-normal' and count(preceding::html:*[tokenize(@epub:type,'\s+')='pagebreak' and tokenize(@class,'\s+')='page-normal'])]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="number($preceding-pagebreak/@title) != number(@title)-1">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">number($preceding-pagebreak/@title) != number(@title)-1</xsl:attribute>
                     <svrl:text>[nordic_opf_and_html_40b] No gaps may occur in page numbering (see pagebreak with title="<xsl:value-of select="@title"/>"
                in <xsl:value-of select="replace(base-uri(.),'^.*/','')"/> and compare with pagebreak with title="<xsl:value-of select="$preceding-pagebreak/@title"/>" in <xsl:value-of select="replace(base-uri($preceding-pagebreak),'^.*/','')"/>)</svrl:text>
                  </svrl:successful-report>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e106')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:*[tokenize(@epub:type,'\s+')='pagebreak' and tokenize(@class,'\s+')='page-normal' and preceding::html:*[tokenize(@epub:type,'\s+')='pagebreak'][tokenize(@class,'\s+')='page-normal']]"
                 priority="9"
                 mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="preceding"
                    select="preceding::html:*[tokenize(@epub:type,'\s+')='pagebreak' and tokenize(@class,'\s+')='page-normal'][1]"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e127']">
            <schxslt:rule pattern="d7e127">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:*[tokenize(@epub:type,'\s+')='pagebreak' and tokenize(@class,'\s+')='page-normal' and preceding::html:*[tokenize(@epub:type,'\s+')='pagebreak'][tokenize(@class,'\s+')='page-normal']]" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type,'\s+')='pagebreak' and tokenize(@class,'\s+')='page-normal' and preceding::html:*[tokenize(@epub:type,'\s+')='pagebreak'][tokenize(@class,'\s+')='page-normal']]</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e127">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type,'\s+')='pagebreak' and tokenize(@class,'\s+')='page-normal' and preceding::html:*[tokenize(@epub:type,'\s+')='pagebreak'][tokenize(@class,'\s+')='page-normal']]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(number(current()/@title) &gt; number($preceding/@title))">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">number(current()/@title) &gt; number($preceding/@title)</xsl:attribute>
                     <svrl:text>[nordic_opf_and_html_23] pagebreak values must increase for pagebreaks with class="page-normal" (see pagebreak with
                    title="<xsl:value-of select="@title"/>" in <xsl:value-of select="replace(base-uri(.),'^.*/','')"/> and compare with pagebreak with title="<xsl:value-of select="$preceding/@title"/> in
                    <xsl:value-of select="replace(base-uri($preceding),'^.*/','')"/>)</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e127')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:*[tokenize(@epub:type,' ')='pagebreak'][tokenize(@class,' ')='page-front']"
                 priority="8"
                 mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e149']">
            <schxslt:rule pattern="d7e149">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:*[tokenize(@epub:type,' ')='pagebreak'][tokenize(@class,' ')='page-front']" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type,' ')='pagebreak'][tokenize(@class,' ')='page-front']</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e149">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type,' ')='pagebreak'][tokenize(@class,' ')='page-front']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(count(//html:*[tokenize(@epub:type,'\s+')='pagebreak' and tokenize(@class,'\s+')='page-front' and @title=current()/@title])=1)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count(//html:*[tokenize(@epub:type,'\s+')='pagebreak' and tokenize(@class,'\s+')='page-front' and @title=current()/@title])=1</xsl:attribute>
                     <svrl:text>[nordic_opf_and_html_24] pagebreak values must
                be unique for pagebreaks with class="page-front" (see pagebreak with title="<xsl:value-of select="@title"/>" in <xsl:value-of select="replace(base-uri(.),'^.*/','')"/>)</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e149')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:*[tokenize(@epub:type,'\s+')=('note','rearnote','footnote')]"
                 priority="7"
                 mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e164']">
            <schxslt:rule pattern="d7e164">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:*[tokenize(@epub:type,'\s+')=('note','rearnote','footnote')]" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type,'\s+')=('note','rearnote','footnote')]</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e164">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type,'\s+')=('note','rearnote','footnote')]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(count(//html:a[tokenize(@epub:type,'\s+')='noteref' and substring-after(@href,'#') = current()/@id]) &gt;= 1)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count(//html:a[tokenize(@epub:type,'\s+')='noteref' and substring-after(@href,'#') = current()/@id]) &gt;= 1</xsl:attribute>
                     <svrl:text>[nordic_opf_and_html_26a] The <xsl:value-of select="(tokenize(@epub:type,'\s+')[.=('note','rearnote','footnote')],'note')[1]"/>
                        <xsl:value-of select="if (@id) then concat(' with the id &#34;',@id,'&#34;') else ''"/> must have
                at least one &lt;a epub:type="noteref" ...&gt; referencing it: <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/> (in <xsl:value-of select="replace(base-uri(),'.*/','')"/>)</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e164')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:a[tokenize(@epub:type,'\s+')='noteref']" priority="6" mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e184']">
            <schxslt:rule pattern="d7e184">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:a[tokenize(@epub:type,'\s+')='noteref']" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:a[tokenize(@epub:type,'\s+')='noteref']</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e184">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:a[tokenize(@epub:type,'\s+')='noteref']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(count(//html:*[tokenize(@epub:type,'\s+')=('note','rearnote','footnote') and @id = current()/substring-after(@href,'#')]) &gt;= 1)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count(//html:*[tokenize(@epub:type,'\s+')=('note','rearnote','footnote') and @id = current()/substring-after(@href,'#')]) &gt;= 1</xsl:attribute>
                     <svrl:text>[nordic_opf_and_html_26b] The note
                reference with the href "<xsl:value-of select="@href"/>" attribute must resolve to a note, rearnote or footnote in the publication: <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/> (in <xsl:value-of select="replace(base-uri(),'.*/','')"/>)</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e184')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:*[tokenize(@epub:type,'\s+')=('annotation')]" priority="5"
                 mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e204']">
            <schxslt:rule pattern="d7e204">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:*[tokenize(@epub:type,'\s+')=('annotation')]" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type,'\s+')=('annotation')]</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e204">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type,'\s+')=('annotation')]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(count(//html:a[tokenize(@epub:type,'\s+')='annoref' and substring-after(@href,'#') = current()/@id]) &gt;= 1)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count(//html:a[tokenize(@epub:type,'\s+')='annoref' and substring-after(@href,'#') = current()/@id]) &gt;= 1</xsl:attribute>
                     <svrl:text>[nordic_opf_and_html_27a] The annotation<xsl:value-of select="if (@id) then concat(' with the id &#34;',@id,'&#34;') else ''"/> must have at least one &lt;a epub:type="annoref" ...&gt; referencing it: <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/> (in <xsl:value-of select="replace(base-uri(),'.*/','')"/>)</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e204')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:a[tokenize(@epub:type,'\s+')='annoref']" priority="4" mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e223']">
            <schxslt:rule pattern="d7e223">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:a[tokenize(@epub:type,'\s+')='annoref']" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:a[tokenize(@epub:type,'\s+')='annoref']</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e223">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:a[tokenize(@epub:type,'\s+')='annoref']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(count(//html:*[tokenize(@epub:type,'\s+')=('annotation') and @id = current()/substring-after(@href,'#')]) &gt;= 1)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count(//html:*[tokenize(@epub:type,'\s+')=('annotation') and @id = current()/substring-after(@href,'#')]) &gt;= 1</xsl:attribute>
                     <svrl:text>[nordic_opf_and_html_26b] The annotation with the href
                    "<xsl:value-of select="@href"/>" must resolve to a annotation in the publication: <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/> (in <xsl:value-of select="replace(base-uri(),'.*/','')"/>)</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e223')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:title" priority="3" mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e242']">
            <schxslt:rule pattern="d7e242">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:title" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:title</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e242">
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
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e242')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:meta[@name='dc:identifier']" priority="2" mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e260']">
            <schxslt:rule pattern="d7e260">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:meta[@name='dc:identifier']" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:meta[@name='dc:identifier']</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e260">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:meta[@name='dc:identifier']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(@content = /*/opf:package/opf:metadata/dc:identifier[not(@refines)]/text())">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">@content = /*/opf:package/opf:metadata/dc:identifier[not(@refines)]/text()</xsl:attribute>
                     <svrl:text>[nordic_opf_and_html_29] The HTML meta element in <xsl:value-of select="replace(base-uri(.),'.*/','')"/> with dc:identifier must have as content the same as the OPF publication dc:identifier. The OPF dc:identifier is "<xsl:value-of select="/*/opf:package/opf:metadata/dc:identifier[not(@refines)]/text()"/>" while the HTML dc:identifier is "<xsl:value-of select="@content"/>".</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e260')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:img[@longdesc]" priority="1" mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e277']">
            <schxslt:rule pattern="d7e277">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:img[@longdesc]" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:img[@longdesc]</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e277">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:img[@longdesc]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(substring-after(normalize-space(@longdesc),'#') = //@id)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">substring-after(normalize-space(@longdesc),'#') = //@id</xsl:attribute>
                     <svrl:text>[nordic_opf_and_html_32] The URL in the img longdesc attribute does not reference any element in the publication:
                    <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e277')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:a" priority="0" mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e289']">
            <schxslt:rule pattern="d7e289">
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
            <schxslt:rule pattern="d7e289">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:a</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="@accesskey and count(//html:a/@accesskey=@accesskey)!=1">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">@accesskey and count(//html:a/@accesskey=@accesskey)!=1</xsl:attribute>
                     <svrl:text>[nordic_opf_and_html_276] The accesskey attribute value is not unique within the publication.</svrl:text>
                  </svrl:successful-report>
               </xsl:if>
               <xsl:if test="@tabindex and count(//html:a/@tabindex=@tabindex)!=1">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">@tabindex and count(//html:a/@tabindex=@tabindex)!=1</xsl:attribute>
                     <svrl:text>[nordic_opf_and_html_276] The tabindex attribute value is not unique within the publication.</svrl:text>
                  </svrl:successful-report>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e289')"/>
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