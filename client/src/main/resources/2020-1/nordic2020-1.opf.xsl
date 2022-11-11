<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform xmlns:sch="http://purl.oclc.org/dsdl/schematron"
               xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
               xmlns:error="https://doi.org/10.5281/zenodo.1495494#error"
               xmlns:schxslt="https://doi.org/10.5281/zenodo.1495494"
               xmlns:xs="http://www.w3.org/2001/XMLSchema"
               xmlns:schxslt-api="https://doi.org/10.5281/zenodo.1495494#api"
               xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
               xmlns:opf="http://www.idpf.org/2007/opf"
               xmlns:dc="http://purl.org/dc/elements/1.1/"
               xmlns:epub="http://www.idpf.org/2007/ops"
               xmlns:nordic="http://www.mtm.se/epub/"
               xmlns:a11y="http://www.idpf.org/epub/vocab/package/a11y/#"
               version="2.0">
   <rdf:Description xmlns:dct="http://purl.org/dc/terms/"
                    xmlns:skos="http://www.w3.org/2004/02/skos/core#">
      <dct:creator>
         <dct:Agent>
            <skos:prefLabel>SchXslt/1.9.4 SAXON/9.2.0.6</skos:prefLabel>
            <schxslt.compile.typed-variables xmlns="https://doi.org/10.5281/zenodo.1495494#">true</schxslt.compile.typed-variables>
         </dct:Agent>
      </dct:creator>
      <dct:created>2022-11-11T09:09:57.86+01:00</dct:created>
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
               <rdf:Description>
                  <dct:creator>
                     <dct:Agent>
                        <skos:prefLabel>SchXslt/1.9.4 SAXON/9.2.0.6</skos:prefLabel>
                        <schxslt.compile.typed-variables xmlns="https://doi.org/10.5281/zenodo.1495494#">true</schxslt.compile.typed-variables>
                     </dct:Agent>
                  </dct:creator>
                  <dct:created>2022-11-11T09:09:57.86+01:00</dct:created>
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
                              title="Nordic EPUB3 Package Document rules">
         <svrl:ns-prefix-in-attribute-values prefix="opf" uri="http://www.idpf.org/2007/opf"/>
         <svrl:ns-prefix-in-attribute-values prefix="dc" uri="http://purl.org/dc/elements/1.1/"/>
         <svrl:ns-prefix-in-attribute-values prefix="epub" uri="http://www.idpf.org/2007/ops"/>
         <svrl:ns-prefix-in-attribute-values prefix="nordic" uri="http://www.mtm.se/epub/"/>
         <svrl:ns-prefix-in-attribute-values prefix="a11y" uri="http://www.idpf.org/epub/vocab/package/a11y/#"/>
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
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 1" id="opf_nordic_1">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e39">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 2" id="opf_nordic_2">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e80">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 3" id="opf_nordic_3">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e170">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 5b" id="opf_nordic_5_b">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e188">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 6" id="opf_nordic_6">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e210">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 7" id="opf_nordic_7">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e228">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 8" id="opf_nordic_8">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e248">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 9" id="opf_nordic_9">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e268">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 10" id="opf_nordic_10">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e295">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 12a" id="opf_nordic_12_a">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e313">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 12b" id="opf_nordic_12_b">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e378">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 13" id="opf_nordic_13">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e395">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 14" id="opf_nordic_14">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e415">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 15a" id="opf_nordic_15_a">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e432">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 15b" id="opf_nordic_15_b">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <xsl:apply-templates mode="d7e17" select="root()"/>
      </schxslt:document>
   </xsl:template>
   <xsl:template match="/*" priority="16" mode="d7e17">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e17']">
            <schxslt:rule pattern="d7e17">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "/*" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">/*</xsl:attribute>
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
                  <xsl:attribute name="context">/*</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(ends-with(base-uri(/*),'.opf'))">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">ends-with(base-uri(/*),'.opf')</xsl:attribute>
                     <svrl:text>[opf1] the OPF file must have the extension .opf</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
               <xsl:if test="not(matches(base-uri(/*),'.*/package.opf'))">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">matches(base-uri(/*),'.*/package.opf')</xsl:attribute>
                     <svrl:text>[opf1] the filename of the OPF must be package.opf</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
               <xsl:if test="not(matches(base-uri(/*),'EPUB/package.opf'))">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">matches(base-uri(/*),'EPUB/package.opf')</xsl:attribute>
                     <svrl:text>[opf1] the OPF must be contained in a folder named EPUB</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e17')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="opf:package" priority="15" mode="d7e17">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e39']">
            <schxslt:rule pattern="d7e39">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "opf:package" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">opf:package</xsl:attribute>
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
                  <xsl:attribute name="context">opf:package</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(@version = '3.0')">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">@version = '3.0'</xsl:attribute>
                     <svrl:text>[opf2] the version attribute must be 3.0</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
               <xsl:if test="not(@unique-identifier = 'pub-identifier')">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">@unique-identifier = 'pub-identifier'</xsl:attribute>
                     <svrl:text>[opf2] on the package element; the unique-identifier-attribute must be present and equal 'pub-identifier'</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
               <xsl:if test="not(namespace-uri-for-prefix('dc',.) = 'http://purl.org/dc/elements/1.1/')">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">namespace-uri-for-prefix('dc',.) = 'http://purl.org/dc/elements/1.1/'</xsl:attribute>
                     <svrl:text>[opf2] on the package element; the dublin core namespace (xmlns:dc="http://purl.org/dc/elements/1.1/")
                must be declared on the package element</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
               <xsl:if test="not(matches(@prefix, '(^|\s)nordic:\s+http://www.mtm.se/epub/(\s|$)') or not(opf:meta[starts-with(@property, 'nordic:')]))">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">matches(@prefix, '(^|\s)nordic:\s+http://www.mtm.se/epub/(\s|$)') or not(opf:meta[starts-with(@property, 'nordic:')])</xsl:attribute>
                     <svrl:text>[opf2] on the package element; the prefix attribute must declare the nordic metadata namespace using the correct namespace URI (prefix="nordic:
                http://www.mtm.se/epub/")</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
               <xsl:if test="not(matches(@prefix, '(^|\s)a11y:\s+http://www.idpf.org/epub/vocab/package/a11y/#(\s|$)') or not(opf:meta[starts-with(@property, 'a11y:')]))">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">matches(@prefix, '(^|\s)a11y:\s+http://www.idpf.org/epub/vocab/package/a11y/#(\s|$)') or not(opf:meta[starts-with(@property, 'a11y:')])</xsl:attribute>
                     <svrl:text>[opf2] on the package element; the prefix attribute must declare the a11y metadata namespace using the correct URI (prefix="a11y:
                http://www.idpf.org/epub/vocab/package/a11y/#")</svrl:text>
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
   <xsl:template match="opf:meta[boolean(@property) and contains(@property, ':') and not(substring-before(@property, ':') = ('dc', 'dcterms', 'a11y', 'schema', 'marc', 'media', 'onix', 'rendition', 'xsd'))]"
                 priority="14"
                 mode="d7e17">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:variable name="prefix" select="substring-before(@property, ':')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e39']">
            <schxslt:rule pattern="d7e39">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "opf:meta[boolean(@property) and contains(@property, ':') and not(substring-before(@property, ':') = ('dc', 'dcterms', 'a11y', 'schema', 'marc', 'media', 'onix', 'rendition', 'xsd'))]" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">opf:meta[boolean(@property) and contains(@property, ':') and not(substring-before(@property, ':') = ('dc', 'dcterms', 'a11y', 'schema', 'marc', 'media', 'onix', 'rendition', 'xsd'))]</xsl:attribute>
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
                  <xsl:attribute name="context">opf:meta[boolean(@property) and contains(@property, ':') and not(substring-before(@property, ':') = ('dc', 'dcterms', 'a11y', 'schema', 'marc', 'media', 'onix', 'rendition', 'xsd'))]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(matches(string(ancestor::opf:package[1]/@prefix[1]), concat('(^|\s)', $prefix, ':(\s|$)')))">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">matches(string(ancestor::opf:package[1]/@prefix[1]), concat('(^|\s)', $prefix, ':(\s|$)'))</xsl:attribute>
                     <svrl:text>[opf2] on the package element; the prefix attribute must declare the '<xsl:value-of select="$prefix"/>' prefix</svrl:text>
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
   <xsl:template match="opf:metadata" priority="13" mode="d7e17">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:variable name="main-title-id"
                    select="opf:meta[text() = 'main' and @property = 'title-type']/translate(@refines, '#', '')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e80']">
            <schxslt:rule pattern="d7e80">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "opf:metadata" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">opf:metadata</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e80">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">opf:metadata</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(count(dc:identifier) = 1)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count(dc:identifier) = 1</xsl:attribute>
                     <svrl:text>[opf3a] there must be exactly one dc:identifier element</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
               <xsl:if test="not(parent::opf:package/@unique-identifier = dc:identifier/@id)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">parent::opf:package/@unique-identifier = dc:identifier/@id</xsl:attribute>
                     <svrl:text>[opf3a] the id of the dc:identifier must equal the value of the package elements unique-identifier
                attribute</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
               <xsl:if test="not(count(dc:title[@id=$main-title-id]) = 1 or count(dc:title) = 1)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count(dc:title[@id=$main-title-id]) = 1 or count(dc:title) = 1</xsl:attribute>
                     <svrl:text>[opf3b] exactly one dc:title must be present in the package document when no title is uniquely defined as main.</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
               <xsl:if test="not(string-length(normalize-space(dc:title[1]/text())))">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">string-length(normalize-space(dc:title[1]/text()))</xsl:attribute>
                     <svrl:text>[opf3b] the dc:title must not be empty.</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
               <xsl:if test="not(count(dc:language[not(@refines)]) = 1)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count(dc:language[not(@refines)]) = 1</xsl:attribute>
                     <svrl:text>[opf3c] exactly one dc:language <xsl:value-of select="if (dc:language[@refines]) then '(without a &#34;refines&#34; attribute)' else ''"/> must be present in the package document.</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
               <xsl:if test="not(count(dc:language[not(@refines)]) = 1 and matches(dc:language[not(@refines)]/text(), '^[a-z]{2,3}(-[A-Za-z0-9]+)*$'))">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count(dc:language[not(@refines)]) = 1 and matches(dc:language[not(@refines)]/text(), '^[a-z]{2,3}(-[A-Za-z0-9]+)*$')</xsl:attribute>
                     <svrl:text>[opf3c] the language code ("<xsl:value-of select="dc:language[not(@refines)]/text()"/>") must be either a "two- or three-letter lower case" code or a "two- or three-letter lower case and groups of hyphen followed by numbers or letters" (i.e. zh-Hanz-UTF8) code.</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
               <xsl:if test="not(count(dc:date[not(@refines)]) = 1)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count(dc:date[not(@refines)]) = 1</xsl:attribute>
                     <svrl:text>[opf3d] exactly one dc:date <xsl:value-of select="if (dc:date[@refines]) then '(without a &#34;refines&#34; attribute)' else ''"/> must be
                present</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
               <xsl:if test="not(count(dc:date[not(@refines)]) = 1 and matches(dc:date[not(@refines)], '\d\d\d\d-\d\d-\d\d'))">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count(dc:date[not(@refines)]) = 1 and matches(dc:date[not(@refines)], '\d\d\d\d-\d\d-\d\d')</xsl:attribute>
                     <svrl:text>[opf3d] the dc:date (<xsl:value-of select="dc:date/text()"/>) must be of the format
                YYYY-MM-DD (year-month-day)</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
               <xsl:if test="not(count(dc:publisher[not(@refines)]) = 1)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count(dc:publisher[not(@refines)]) = 1</xsl:attribute>
                     <svrl:text>[opf3e] exactly one dc:publisher <xsl:value-of select="if (dc:publisher[@refines]) then '(without a &#34;refines&#34; attribute)' else ''"/> must be present</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
               <xsl:if test="not(count(dc:publisher[not(@refines)]) = 1 and dc:publisher[not(@refines)]/normalize-space(text()))">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count(dc:publisher[not(@refines)]) = 1 and dc:publisher[not(@refines)]/normalize-space(text())</xsl:attribute>
                     <svrl:text>[opf3e] the dc:publisher cannot be empty</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
               <xsl:if test="not(count(dc:creator[not(@refines)]) &gt;= 1)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count(dc:creator[not(@refines)]) &gt;= 1</xsl:attribute>
                     <svrl:text>[opf3g] at least dc:creator (i.e. book author) <xsl:value-of select="if (dc:creator[@refines]) then '(without a &#34;refines&#34; attribute)' else ''"/> must be present</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
               <xsl:if test="not(count(dc:source[not(@refines)]) = 1)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count(dc:source[not(@refines)]) = 1</xsl:attribute>
                     <svrl:text>[opf3h] exactly one dc:source <xsl:value-of select="if (dc:source[@refines]) then '(without a &#34;refines&#34; attribute)' else ''"/> must
                be present</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
               <xsl:if test="not(not(matches(dc:source[not(@refines)],'^urn:is[bs]n:')) or matches(dc:source[not(@refines)],'^urn:is[bs]n:[\d-]+X?$'))">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">not(matches(dc:source[not(@refines)],'^urn:is[bs]n:')) or matches(dc:source[not(@refines)],'^urn:is[bs]n:[\d-]+X?$')</xsl:attribute>
                     <svrl:text>[opf3h] the ISBN or ISSN in dc:source ("<xsl:value-of select="dc:source[not(@refines)]/text()"/>") can only contain numbers and hyphens, in addition to the 'urn:isbn:' or 'urn:issn:' prefix. The last digit can also be a 'X' in some
                ISBNs.</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
               <xsl:if test="not(count(opf:meta[@property='nordic:guidelines' and not(@refines)]) = 1)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count(opf:meta[@property='nordic:guidelines' and not(@refines)]) = 1</xsl:attribute>
                     <svrl:text>[opf3i] there must be exactly one meta element with the property "nordic:guidelines" <xsl:value-of select="if (opf:meta[@property='nordic:guidelines' and @refines]) then '(without a &#34;refines&#34; attribute)' else ''"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
               <xsl:if test="not(opf:meta[@property='nordic:guidelines' and not(@refines)] = '2020-1')">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">opf:meta[@property='nordic:guidelines' and not(@refines)] = '2020-1'</xsl:attribute>
                     <svrl:text>[opf3i] the value of nordic:guidelines must be '2020-1'</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
               <xsl:if test="not(count(opf:meta[@property='nordic:supplier' and not(@refines)]) = 1)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count(opf:meta[@property='nordic:supplier' and not(@refines)]) = 1</xsl:attribute>
                     <svrl:text>[opf3j] there must be exactly one meta element with the property "nordic:supplier" <xsl:value-of select="if (opf:meta[@property='nordic:supplier' and @refines]) then '(without a &#34;refines&#34; attribute)' else ''"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e80')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="opf:item[@media-type='application/x-dtbncx+xml']" priority="12"
                 mode="d7e17">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e170']">
            <schxslt:rule pattern="d7e170">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "opf:item[@media-type='application/x-dtbncx+xml']" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">opf:item[@media-type='application/x-dtbncx+xml']</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e170">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">opf:item[@media-type='application/x-dtbncx+xml']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(@href = 'nav.ncx')">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">@href = 'nav.ncx'</xsl:attribute>
                     <svrl:text>[opf5b] the NCX must be located in the same directory as the package document, and must be named "nav.ncx" (not "<xsl:value-of select="@href"/>")</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e170')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="opf:spine" priority="11" mode="d7e17">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:variable name="toc-doc"
                    select="/opf:package/opf:manifest/opf:item[@media-type='application/x-dtbncx+xml']"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e188']">
            <schxslt:rule pattern="d7e188">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "opf:spine" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">opf:spine</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e188">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">opf:spine</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(not($toc-doc) or @toc)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">not($toc-doc) or @toc</xsl:attribute>
                     <svrl:text>[opf6] the toc attribute must be present</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
               <xsl:if test="not(not($toc-doc) or $toc-doc/@id = @toc)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">not($toc-doc) or $toc-doc/@id = @toc</xsl:attribute>
                     <svrl:text>[opf6] the toc attribute must refer to the nav.ncx item in the manifest</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e188')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="opf:item[@media-type='application/xhtml+xml' and tokenize(@properties,'\s+')='nav']"
                 priority="10"
                 mode="d7e17">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e210']">
            <schxslt:rule pattern="d7e210">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "opf:item[@media-type='application/xhtml+xml' and tokenize(@properties,'\s+')='nav']" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">opf:item[@media-type='application/xhtml+xml' and tokenize(@properties,'\s+')='nav']</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e210">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">opf:item[@media-type='application/xhtml+xml' and tokenize(@properties,'\s+')='nav']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(@href = 'nav.xhtml')">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">@href = 'nav.xhtml'</xsl:attribute>
                     <svrl:text>[opf7] the Navigation Document must be located in the same directory as the package document, and must be named 'nav.xhtml' (not "<xsl:value-of select="@href"/>")</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e210')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="opf:item[starts-with(@media-type,'image/')]" priority="9" mode="d7e17">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e228']">
            <schxslt:rule pattern="d7e228">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "opf:item[starts-with(@media-type,'image/')]" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">opf:item[starts-with(@media-type,'image/')]</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e228">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">opf:item[starts-with(@media-type,'image/')]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(matches(@href,'^images/[^/]+$'))">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">matches(@href,'^images/[^/]+$')</xsl:attribute>
                     <svrl:text>[opf8] all images must be stored in the "images" directory (which is a subdirectory relative to the package document). The image file
                    "<xsl:value-of select="replace(@href,'.*/','')"/>" is located in "<xsl:value-of select="replace(@href,'[^/]+$','')"/>".</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e228')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="opf:item[@media-type='application/xhtml+xml' and not(tokenize(@properties,'\s+')='nav')]"
                 priority="8"
                 mode="d7e17">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e248']">
            <schxslt:rule pattern="d7e248">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "opf:item[@media-type='application/xhtml+xml' and not(tokenize(@properties,'\s+')='nav')]" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">opf:item[@media-type='application/xhtml+xml' and not(tokenize(@properties,'\s+')='nav')]</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e248">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">opf:item[@media-type='application/xhtml+xml' and not(tokenize(@properties,'\s+')='nav')]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="contains(@href,'/')">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">contains(@href,'/')</xsl:attribute>
                     <svrl:text>[opf9] all content files must be located in the same directory as the package document. The content file file "<xsl:value-of select="replace(@href,'.*/','')"/>" is located in "<xsl:value-of select="replace(@href,'[^/]+$','')"/>".</svrl:text>
                  </svrl:successful-report>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e248')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="opf:itemref[../../opf:manifest/opf:item[@media-type='application/xhtml+xml' and ends-with(@href,'-cover.xhtml')]/@id = @idref]"
                 priority="7"
                 mode="d7e17">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e268']">
            <schxslt:rule pattern="d7e268">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "opf:itemref[../../opf:manifest/opf:item[@media-type='application/xhtml+xml' and ends-with(@href,'-cover.xhtml')]/@id = @idref]" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">opf:itemref[../../opf:manifest/opf:item[@media-type='application/xhtml+xml' and ends-with(@href,'-cover.xhtml')]/@id = @idref]</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e268">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">opf:itemref[../../opf:manifest/opf:item[@media-type='application/xhtml+xml' and ends-with(@href,'-cover.xhtml')]/@id = @idref]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(@linear = 'no')">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">@linear = 'no'</xsl:attribute>
                     <svrl:text>[opf10] Cover must be marked as secondary in the spine (i.e. set linear="no" on the itemref with idref="<xsl:value-of select="@idref"/>", which refers to the cover)</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
               <xsl:if test="not(count(preceding-sibling::opf:itemref[not(@linear='no')]) = 0)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count(preceding-sibling::opf:itemref[not(@linear='no')]) = 0</xsl:attribute>
                     <svrl:text>[opf10] All preceeding documents to the cover must be marked as secondary in the spine (i.e. set linear="no")</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e268')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="opf:itemref[../../opf:manifest/opf:item[@media-type='application/xhtml+xml' and ends-with(@href,'titlepage.xhtml')][1]/@id = @idref]"
                 priority="6"
                 mode="d7e17">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e268']">
            <schxslt:rule pattern="d7e268">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "opf:itemref[../../opf:manifest/opf:item[@media-type='application/xhtml+xml' and ends-with(@href,'titlepage.xhtml')][1]/@id = @idref]" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">opf:itemref[../../opf:manifest/opf:item[@media-type='application/xhtml+xml' and ends-with(@href,'titlepage.xhtml')][1]/@id = @idref]</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e268">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">opf:itemref[../../opf:manifest/opf:item[@media-type='application/xhtml+xml' and ends-with(@href,'titlepage.xhtml')][1]/@id = @idref]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(count(preceding-sibling::opf:itemref[not(@linear='no')]) = 0)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count(preceding-sibling::opf:itemref[not(@linear='no')]) = 0</xsl:attribute>
                     <svrl:text>[opf10] All preceeding documents to the titlepage or halftitlepage must be marked as secondary in the spine (i.e. set linear="no")</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e268')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="opf:item[@media-type='application/xhtml+xml' and not(@href='nav.xhtml' or tokenize(@properties,'\s+')='nav')]"
                 priority="5"
                 mode="d7e17">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e295']">
            <schxslt:rule pattern="d7e295">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "opf:item[@media-type='application/xhtml+xml' and not(@href='nav.xhtml' or tokenize(@properties,'\s+')='nav')]" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">opf:item[@media-type='application/xhtml+xml' and not(@href='nav.xhtml' or tokenize(@properties,'\s+')='nav')]</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e295">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">opf:item[@media-type='application/xhtml+xml' and not(@href='nav.xhtml' or tokenize(@properties,'\s+')='nav')]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(matches(@href,'^[A-Za-z0-9_-]+-\d+-[a-z-]+(-\d+)?\.xhtml$'))">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">matches(@href,'^[A-Za-z0-9_-]+-\d+-[a-z-]+(-\d+)?\.xhtml$')</xsl:attribute>
                     <svrl:text>[opf12a] The content document "<xsl:value-of select="@href"/>" has a bad filename. Content documents must match the
                "[dc:identifier]-[position in spine]-[role or epub:type].xhtml" file naming convention. Example: "DTB123-01-cover.xhtml". The identifier are allowed to contain the upper- and lower-case
                characters A-Z and a-z as well as digits (0-9), dashes (-) and underscores (_). The position is a positive whole number consisting of the digits 0-9. The role or epub:type must be all
                lower-case characters (a-z) and can contain a dash (-). An optional positive whole number (digits 0-9) can be added after the role or epub:type to be able to easily tell different files with
                the same role or epub:type apart. For instance: "DTB123-13-chapter-7.xhtml".</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e295')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="opf:item[@media-type='application/xhtml+xml' and not(@href='nav.xhtml' or tokenize(@properties,'\s+')='nav') and matches(@href,'^[A-Za-z0-9_-]+-\d+-[a-z-]+(-\d+)?\.xhtml$')]"
                 priority="4"
                 mode="d7e17">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:variable name="identifier"
                    select="replace(@href,'^([A-Za-z0-9_-]+)-\d+-[a-z-]+(-\d+)?\.xhtml$','$1')"/>
      <xsl:variable name="position"
                    select="replace(@href,'^[A-Za-z0-9_-]+-(\d+)-[a-z-]+(-\d+)?\.xhtml$','$1')"/>
      <xsl:variable name="type"
                    select="replace(@href,'^[A-Za-z0-9_-]+-\d+-([a-z-]+)(-\d+)?\.xhtml$','$1')"/>
      <xsl:variable name="number"
                    select="if (matches(@href,'^[A-Za-z0-9_-]+-\d+-[a-z-]+-\d+\.xhtml$')) then replace(@href,'^[A-Za-z0-9_-]+-\d+-[a-z-]+-(\d+)\.xhtml$','$1') else ''"/>
      <xsl:variable name="vocab-default"
                    select="('cover','frontmatter','bodymatter','backmatter','volume','part','chapter','subchapter','division','abstract','foreword','preface','prologue','introduction','preamble','conclusion','epilogue','afterword','epigraph','toc','toc-brief','landmarks','loa','loi','lot','lov','appendix','colophon','credits','keywords','index','index-headnotes','index-legend','index-group','index-entry-list','index-entry','index-term','index-editor-note','index-locator','index-locator-list','index-locator-range','index-xref-preferred','index-xref-related','index-term-category','index-term-categories','glossary','glossterm','glossdef','bibliography','biblioentry','titlepage','halftitlepage','copyright-page','seriespage','acknowledgments','imprint','imprimatur','contributors','other-credits','errata','dedication','revision-history','case-study','help','marginalia','notice','pullquote','sidebar','warning','halftitle','fulltitle','covertitle','title','subtitle','label','ordinal','bridgehead','learning-objective','learning-objectives','learning-outcome','learning-outcomes','learning-resource','learning-resources','learning-standard','learning-standards','answer','answers','assessment','assessments','feedback','fill-in-the-blank-problem','general-problem','qna','match-problem','multiple-choice-problem','practice','practices','question','true-false-problem','panel','panel-group','balloon','text-area','sound-area','annotation','note','footnote','rearnote','footnotes','rearnotes','annoref','biblioref','glossref','noteref','referrer','credit','keyword','topic-sentence','concluding-sentence','pagebreak','page-list','table','table-row','table-cell','list','list-item','figure')"/>
      <xsl:variable name="vocab-aria-epub"
                    select="('abstract', 'acknowledgments', 'afterword', 'appendix', 'backlink', 'biblioentry', 'bibliography', 'biblioref', 'chapter', 'colophon', 'conclusion', 'cover', 'credit', 'credits', 'dedication', 'endnote', 'endnotes', 'epigraph', 'epilogue', 'errata', 'example', 'footnote', 'foreword', 'glossary', 'glossref', 'index', 'introduction', 'noteref', 'notice', 'pagebreak', 'pagelist', 'part', 'preface', 'prologue', 'pullquote', 'qna', 'subtitle', 'tip', 'toc')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e313']">
            <schxslt:rule pattern="d7e313">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "opf:item[@media-type='application/xhtml+xml' and not(@href='nav.xhtml' or tokenize(@properties,'\s+')='nav') and matches(@href,'^[A-Za-z0-9_-]+-\d+-[a-z-]+(-\d+)?\.xhtml$')]" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">opf:item[@media-type='application/xhtml+xml' and not(@href='nav.xhtml' or tokenize(@properties,'\s+')='nav') and matches(@href,'^[A-Za-z0-9_-]+-\d+-[a-z-]+(-\d+)?\.xhtml$')]</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e313">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">opf:item[@media-type='application/xhtml+xml' and not(@href='nav.xhtml' or tokenize(@properties,'\s+')='nav') and matches(@href,'^[A-Za-z0-9_-]+-\d+-[a-z-]+(-\d+)?\.xhtml$')]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not($identifier = ../../opf:metadata/dc:identifier/text())">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">$identifier = ../../opf:metadata/dc:identifier/text()</xsl:attribute>
                     <svrl:text>[opf12b_identifier] The "identifier" part of the filename ("<xsl:value-of select="$identifier"/>") must be the same as
                declared in metadata, i.e.: "<xsl:value-of select="../../opf:metadata/dc:identifier/text()"/>".</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
               <xsl:if test="not($type = ($vocab-default, $vocab-aria-epub))">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">$type = ($vocab-default, $vocab-aria-epub)</xsl:attribute>
                     <svrl:text>[opf12b_type] "<xsl:value-of select="$type"/>" is not a valid type. <xsl:value-of select="if (count(($vocab-default,$vocab-aria-epub)[starts-with(.,substring($type,1,3))])) then concat('Did you mean &#34;',(($vocab-default,$vocab-aria-epub)[starts-with(.,substring($type,1,3))])[1],'&#34;?') else ''"/> The filename of content documents must end with a epub:type defined in either the EPUB3 Structural Semantics Vocabulary (http://www.idpf.org/epub/vocab/structure/#) or the
                ARIA EPUB Digital Publishing Roles (https://www.w3.org/TR/dpub-aria-1.0/#roles).</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
               <xsl:if test="not(not(count(../opf:item[@media-type='application/xhtml+xml' and not(@href='nav.xhtml' or tokenize(@properties,'\s+')='nav') and not(matches(@href,'^[A-Za-z0-9_-]+-\d+-[a-z-]+(-\d+)?\.xhtml$'))])) and string-length($position) = string-length(../opf:item[@media-type='application/xhtml+xml' and not(@href='nav.xhtml' or tokenize(@properties,'\s+')='nav') and matches(@href,'^[A-Za-z0-9_-]+-\d+-[a-z-]+(-\d+)?\.xhtml$')][1]/replace(@href,'^[A-Za-z0-9_-]+-(\d+)-[a-z-]+(-\d+)?.xhtml$','$1')))">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">not(count(../opf:item[@media-type='application/xhtml+xml' and not(@href='nav.xhtml' or tokenize(@properties,'\s+')='nav') and not(matches(@href,'^[A-Za-z0-9_-]+-\d+-[a-z-]+(-\d+)?\.xhtml$'))])) and string-length($position) = string-length(../opf:item[@media-type='application/xhtml+xml' and not(@href='nav.xhtml' or tokenize(@properties,'\s+')='nav') and matches(@href,'^[A-Za-z0-9_-]+-\d+-[a-z-]+(-\d+)?\.xhtml$')][1]/replace(@href,'^[A-Za-z0-9_-]+-(\d+)-[a-z-]+(-\d+)?.xhtml$','$1'))</xsl:attribute>
                     <svrl:text>[opf12b_position] The numbering of the content documents must all have the equal number of digits.</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
               <xsl:if test="not(count(../opf:item[@media-type='application/xhtml+xml' and not(@href='nav.xhtml' or tokenize(@properties,'\s+')='nav') and not(matches(@href,'^[A-Za-z0-9_-]+-\d+-[a-z-]+(-\d+)?\.xhtml$'))])) and number($position) = ( (../opf:item except .)[@media-type='application/xhtml+xml' and not(@href='nav.xhtml' or tokenize(@properties,'\s+')='nav') and matches(@href,'^[A-Za-z0-9_-]+-\d+-[a-z-]+(-\d+)?\.xhtml$')]/number(replace(@href,'^[A-Za-z0-9_-]+-(\d+)-[a-z-]+(-\d+)?.xhtml$','$1')) )">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">not(count(../opf:item[@media-type='application/xhtml+xml' and not(@href='nav.xhtml' or tokenize(@properties,'\s+')='nav') and not(matches(@href,'^[A-Za-z0-9_-]+-\d+-[a-z-]+(-\d+)?\.xhtml$'))])) and number($position) = ( (../opf:item except .)[@media-type='application/xhtml+xml' and not(@href='nav.xhtml' or tokenize(@properties,'\s+')='nav') and matches(@href,'^[A-Za-z0-9_-]+-\d+-[a-z-]+(-\d+)?\.xhtml$')]/number(replace(@href,'^[A-Za-z0-9_-]+-(\d+)-[a-z-]+(-\d+)?.xhtml$','$1')) )</xsl:attribute>
                     <svrl:text>[opf12b_position] The numbering of the content documents must be unique for each content document. <xsl:value-of select="$position"/> is also used by another content document in the
                OPF.</svrl:text>
                  </svrl:successful-report>
               </xsl:if>
               <xsl:if test="not(not(count(../opf:item[@media-type='application/xhtml+xml' and not(@href='nav.xhtml' or tokenize(@properties,'\s+')='nav') and not(matches(@href,'^[A-Za-z0-9_-]+-\d+-[a-z-]+(-\d+)?\.xhtml$'))])) and number($position)-1 = ( 0 , (../opf:item except .)[@media-type='application/xhtml+xml' and not(@href='nav.xhtml' or tokenize(@properties,'\s+')='nav') and matches(@href,'^[A-Za-z0-9_-]+-\d+-[a-z-]+(-\d+)?\.xhtml$')]/number(replace(@href,'^[A-Za-z0-9_-]+-(\d+)-[a-z-]+(-\d+)?.xhtml$','$1')) ))">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">not(count(../opf:item[@media-type='application/xhtml+xml' and not(@href='nav.xhtml' or tokenize(@properties,'\s+')='nav') and not(matches(@href,'^[A-Za-z0-9_-]+-\d+-[a-z-]+(-\d+)?\.xhtml$'))])) and number($position)-1 = ( 0 , (../opf:item except .)[@media-type='application/xhtml+xml' and not(@href='nav.xhtml' or tokenize(@properties,'\s+')='nav') and matches(@href,'^[A-Za-z0-9_-]+-\d+-[a-z-]+(-\d+)?\.xhtml$')]/number(replace(@href,'^[A-Za-z0-9_-]+-(\d+)-[a-z-]+(-\d+)?.xhtml$','$1')) )</xsl:attribute>
                     <svrl:text>[opf12b_position] The numbering of the content documents must start at 1 and increase with 1 for each item.</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
               <xsl:if test="not(not(count(../opf:item[@media-type='application/xhtml+xml' and not(@href='nav.xhtml' or tokenize(@properties,'\s+')='nav') and not(matches(@href,'^[A-Za-z0-9_-]+-\d+-[a-z-]+(-\d+)?\.xhtml$'))])) and ../../opf:spine/opf:itemref[xs:integer(number($position))]/@idref = @id)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">not(count(../opf:item[@media-type='application/xhtml+xml' and not(@href='nav.xhtml' or tokenize(@properties,'\s+')='nav') and not(matches(@href,'^[A-Za-z0-9_-]+-\d+-[a-z-]+(-\d+)?\.xhtml$'))])) and ../../opf:spine/opf:itemref[xs:integer(number($position))]/@idref = @id</xsl:attribute>
                     <svrl:text>[opf12b_position] The <xsl:value-of select="xs:integer(number($position))"/>
                        <xsl:value-of select="if (ends-with($position,'1') and not(number($position)=11)) then 'st' else if (ends-with($position,'2') and not(number($position)=12)) then 'nd' else if (ends-with($position,'3') and not(number($position)=13)) then 'rd' else 'th'"/> itemref (&lt;iremref idref="<xsl:value-of select="../../opf:spine/opf:itemref[xs:integer(number($position))]/@id"/>" href="..."&gt;)
                should refer to &lt;item id="<xsl:value-of select="@id"/>" href="<xsl:value-of select="@href"/>"&gt;.</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e313')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="opf:item[@media-type='application/xhtml+xml' and @href='nav.xhtml']"
                 priority="3"
                 mode="d7e17">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e378']">
            <schxslt:rule pattern="d7e378">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "opf:item[@media-type='application/xhtml+xml' and @href='nav.xhtml']" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">opf:item[@media-type='application/xhtml+xml' and @href='nav.xhtml']</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e378">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">opf:item[@media-type='application/xhtml+xml' and @href='nav.xhtml']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(tokenize(@properties,'\s+')='nav')">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">tokenize(@properties,'\s+')='nav'</xsl:attribute>
                     <svrl:text>[opf13] the Navigation Document must be identified with the attribute properties="nav" in the OPF manifest. It currently <xsl:value-of select="if (not(@properties)) then 'does not have a &#34;properties&#34; attribute' else concat('has the properties: ',string-join(tokenize(@properties,'\s+'),', '),', but not &#34;nav&#34;')"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e378')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="opf:itemref" priority="2" mode="d7e17">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:variable name="itemref" select="."/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e395']">
            <schxslt:rule pattern="d7e395">
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
            <schxslt:rule pattern="d7e395">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">opf:itemref</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="count(//opf:item[@id=$itemref/@idref and (tokenize(@properties,'\s+')='nav' or @href='nav.xhtml')])">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count(//opf:item[@id=$itemref/@idref and (tokenize(@properties,'\s+')='nav' or @href='nav.xhtml')])</xsl:attribute>
                     <svrl:text>[opf14] the Navigation Document must not be present in the OPF spine
                (itemref with idref="<xsl:value-of select="@idref"/>").</svrl:text>
                  </svrl:successful-report>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e395')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="opf:item[substring-after(@href,'/') = 'cover.jpg']" priority="1"
                 mode="d7e17">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e415']">
            <schxslt:rule pattern="d7e415">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "opf:item[substring-after(@href,'/') = 'cover.jpg']" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">opf:item[substring-after(@href,'/') = 'cover.jpg']</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e415">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">opf:item[substring-after(@href,'/') = 'cover.jpg']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(tokenize(@properties,'\s+') = 'cover-image')">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">tokenize(@properties,'\s+') = 'cover-image'</xsl:attribute>
                     <svrl:text>[opf15a] The cover image must have a properties attribute containing the value 'cover-image': <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e415')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="opf:item[tokenize(@properties,'\s+') = 'cover-image']" priority="0"
                 mode="d7e17">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e432']">
            <schxslt:rule pattern="d7e432">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "opf:item[tokenize(@properties,'\s+') = 'cover-image']" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">opf:item[tokenize(@properties,'\s+') = 'cover-image']</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e432">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">opf:item[tokenize(@properties,'\s+') = 'cover-image']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(substring-after(@href,'/') = 'cover.jpg')">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">substring-after(@href,'/') = 'cover.jpg'</xsl:attribute>
                     <svrl:text>[opf15b] The image with property value 'cover-image' must have the filename 'cover.jpg': <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e432')"/>
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