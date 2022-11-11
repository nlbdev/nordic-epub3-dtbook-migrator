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
               xmlns:a11y="http://www.idpf.org/epub/vocab/package/a11y/#"
               xmlns:m="http://www.w3.org/1998/Math/MathML"
               xmlns:msv="http://www.idpf.org/epub/vocab/structure/magazine/#"
               xmlns:prism="http://www.prismstandard.org/specifications/3.0/PRISM_CV_Spec_3.0.htm#"
               version="2.0">
   <rdf:Description xmlns:dct="http://purl.org/dc/terms/" xmlns:dc="http://purl.org/dc/elements/1.1/"
                    xmlns:skos="http://www.w3.org/2004/02/skos/core#">
      <dct:creator>
         <dct:Agent>
            <skos:prefLabel>SchXslt/1.9.4 SAXON/9.2.0.6</skos:prefLabel>
            <schxslt.compile.typed-variables xmlns="https://doi.org/10.5281/zenodo.1495494#">true</schxslt.compile.typed-variables>
         </dct:Agent>
      </dct:creator>
      <dct:created>2022-11-11T09:09:58.469+01:00</dct:created>
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
                  <dct:created>2022-11-11T09:09:58.469+01:00</dct:created>
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
                              title="Nordic EPUB3 and HTML5 rules (based on MTMs DTBook schematron rules, targeting nordic guidelines 2020-1)">
         <svrl:ns-prefix-in-attribute-values prefix="html" uri="http://www.w3.org/1999/xhtml"/>
         <svrl:ns-prefix-in-attribute-values prefix="epub" uri="http://www.idpf.org/2007/ops"/>
         <svrl:ns-prefix-in-attribute-values prefix="nordic" uri="http://www.mtm.se/epub/"/>
         <svrl:ns-prefix-in-attribute-values prefix="a11y" uri="http://www.idpf.org/epub/vocab/package/a11y/#"/>
         <svrl:ns-prefix-in-attribute-values prefix="m" uri="http://www.w3.org/1998/Math/MathML"/>
         <svrl:ns-prefix-in-attribute-values prefix="msv" uri="http://www.idpf.org/epub/vocab/structure/magazine/#"/>
         <svrl:ns-prefix-in-attribute-values prefix="prism"
                                             uri="http://www.prismstandard.org/specifications/3.0/PRISM_CV_Spec_3.0.htm#"/>
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
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 8" id="epub_nordic_8">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e39">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 9" id="epub_nordic_9">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e57">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 11" id="epub_nordic_11">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e78">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 12" id="epub_nordic_12">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e95">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 13" id="epub_nordic_13_a">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e122">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 13b" id="epub_nordic_13_b">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e138">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 13c" id="epub_nordic_13_c">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e155">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 13d" id="epub_nordic_13_d">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e176">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 13e" id="epub_nordic_13_e">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e194">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 15" id="epub_nordic_15">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e221">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 21" id="epub_nordic_21">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e239">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 23" id="epub_nordic_23">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e261">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 24" id="epub_nordic_24">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e281">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 26a" id="epub_nordic_26_a">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e301">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 26b" id="epub_nordic_26_b">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e322">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 26c" id="epub_nordic_26_c">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e342">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 27a" id="epub_nordic_27_a">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e362">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 27b" id="epub_nordic_27_b">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e382">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 29a" id="epub_nordic_29a">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e404">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 29b" id="epub_nordic_29b">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e435">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 50a" id="epub_nordic_50_a">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e453">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 51 &amp; 52"
                                    id="epub_nordic_5152">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e481">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 59" id="epub_nordic_59">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e499">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 63" id="epub_nordic_63">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e517">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 64" id="epub_nordic_64">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e534">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 93" id="epub_nordic_93">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e559">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 96b" id="epub_nordic_96_b">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e576">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 96a" id="epub_nordic_96_c">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e596">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 101" id="epub_nordic_101">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e616">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 102" id="epub_nordic_102">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e639">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 104" id="epub_nordic_104">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e657">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 105" id="epub_nordic_105">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e679">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 110" id="epub_nordic_110">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e697">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 116" id="epub_nordic_116">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e715">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 121" id="epub_nordic_121">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e733">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 123 (39)"
                                    id="epub_nordic_123">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e754">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 131a"
                                    id="epub_nordic_131_a">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e771">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 131b"
                                    id="epub_nordic_131_b">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e788">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 135a"
                                    id="epub_nordic_135_a">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e827">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 140" id="epub_nordic_140">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e867">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 143a"
                                    id="epub_nordic_143_a">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e886">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 143b"
                                    id="epub_nordic_143_b">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e903">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 200" id="epub_nordic_200">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e921">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 202" id="epub_nordic_202">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e947">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 203a"
                                    id="epub_nordic_203_a">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e965">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 203c"
                                    id="epub_nordic_203_c">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e986">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 203d"
                                    id="epub_nordic_203_d">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e1004">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 204a"
                                    id="epub_nordic_204_a">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e1025">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 204d"
                                    id="epub_nordic_204_d">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e1046">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 208" id="epub_nordic_208">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e1072">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 211" id="epub_nordic_211">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e1100">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 215" id="epub_nordic_215">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e1126">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 225" id="epub_nordic_225">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e1145">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 247" id="epub_nordic_247">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e1162">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 251" id="epub_nordic_251">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e1180">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 253a"
                                    id="epub_nordic_253_a">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e1208">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 253b"
                                    id="epub_nordic_253_b">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e1229">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 253c"
                                    id="epub_nordic_253_c">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e1250">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 253d"
                                    id="epub_nordic_253_d">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e1274">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 256" id="epub_nordic_256">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e1292">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 257" id="epub_nordic_257">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e1310">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 258" id="epub_nordic_258">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e1328">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 259" id="epub_nordic_259">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e1350">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 260b"
                                    id="epub_nordic_260_b">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e1367">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 261" id="epub_nordic_261">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e1388">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 263" id="epub_nordic_263">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e1405">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 264" id="epub_nordic_264">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e1427">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 267a"
                                    id="epub_nordic_267_a">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e1446">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 267b"
                                    id="epub_nordic_267_b">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e1463">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 268" id="epub_nordic_268">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e1503">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 269" id="epub_nordic_269">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e1536">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 270" id="epub_nordic_270">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e1555">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 273" id="epub_nordic_273">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e1574">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 273b"
                                    id="epub_nordic_273b">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e1594">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 279a"
                                    id="epub_nordic_279a">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e1612">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 279b"
                                    id="epub_nordic_279b">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e1631">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 280" id="epub_nordic_280">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e1654">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 281" id="epub_nordic_281">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e1674">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 282" id="epub_nordic_282">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e1699">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 283" id="epub_nordic_283">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e1718">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 290" id="epub_nordic_290">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e1736">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 291" id="epub_nordic_291">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e1755">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 292" id="epub_nordic_292">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <schxslt:pattern id="d7e1773">
            <xsl:if test="exists(base-uri(root()))">
               <xsl:attribute name="documents" select="base-uri(root())"/>
            </xsl:if>
            <xsl:for-each select="root()">
               <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" name="Rule 293" id="epub_nordic_293">
                  <xsl:attribute name="documents" select="base-uri(.)"/>
               </svrl:active-pattern>
            </xsl:for-each>
         </schxslt:pattern>
         <xsl:apply-templates mode="d7e21" select="root()"/>
      </schxslt:document>
   </xsl:template>
   <xsl:template match="html:*[tokenize(@epub:type, '\s+') = 'pagebreak' and tokenize(@class, '\s+') = 'page-front']"
                 priority="83"
                 mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e21']">
            <schxslt:rule pattern="d7e21">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:*[tokenize(@epub:type, '\s+') = 'pagebreak' and tokenize(@class, '\s+') = 'page-front']" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type, '\s+') = 'pagebreak' and tokenize(@class, '\s+') = 'page-front']</xsl:attribute>
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
                  <xsl:attribute name="context">html:*[tokenize(@epub:type, '\s+') = 'pagebreak' and tokenize(@class, '\s+') = 'page-front']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(ancestor::html:*[self::html:section or self::html:article or self::html:body]/tokenize(@epub:type, '\s+') = ('frontmatter', 'cover'))">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">ancestor::html:*[self::html:section or self::html:article or self::html:body]/tokenize(@epub:type, '\s+') = ('frontmatter', 'cover')</xsl:attribute>
                     <svrl:text>[nordic08] &lt;span epub:type="pagebreak" class="page-front"/&gt; may only occur in frontmatter and cover. <xsl:value-of select="$context"/>
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
   <xsl:template match="html:*" priority="82" mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e39']">
            <schxslt:rule pattern="d7e39">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:*" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*</xsl:attribute>
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
                  <xsl:attribute name="context">html:*</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="normalize-space(.) = '' and not(*) and not(self::html:img or self::html:br or self::html:meta or self::html:link or self::html:col or self::html:th or self::html:td or self::html:dd or self::html:*[tokenize(@epub:type, '\s+') = 'pagebreak'] or self::html:hr or self::html:script)">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">normalize-space(.) = '' and not(*) and not(self::html:img or self::html:br or self::html:meta or self::html:link or self::html:col or self::html:th or self::html:td or self::html:dd or self::html:*[tokenize(@epub:type, '\s+') = 'pagebreak'] or self::html:hr or self::html:script)</xsl:attribute>
                     <svrl:text>[nordic09] Only the following elements can be empty: img, br, meta, link, col, th, td, dd, hr, script, and pagebreaks (span/div). <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e39')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:html" priority="81" mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e57']">
            <schxslt:rule pattern="d7e57">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:html" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:html</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e57">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:html</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(@xml:lang)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">@xml:lang</xsl:attribute>
                     <svrl:text>[nordic11] The &lt;html&gt; element must have an xml:lang attribute.</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
               <xsl:if test="not(@lang)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">@lang</xsl:attribute>
                     <svrl:text>[nordic11] The &lt;html&gt; element must have a lang attribute.</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e57')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:body/html:header" priority="80" mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e78']">
            <schxslt:rule pattern="d7e78">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:body/html:header" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:body/html:header</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e78">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:body/html:header</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(html:*[1][self::html:h1[tokenize(@epub:type, '\s+') = 'fulltitle']])">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">html:*[1][self::html:h1[tokenize(@epub:type, '\s+') = 'fulltitle']]</xsl:attribute>
                     <svrl:text>[nordic12] Single-HTML document must begin with a fulltitle heading in its header element (xpath:
                /html/body/header/h1).</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e78')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:body[html:header]" priority="79" mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e95']">
            <schxslt:rule pattern="d7e95">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:body[html:header]" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:body[html:header]</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e95">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:body[html:header]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(((html:section | html:article)/tokenize(@epub:type, '\s+') = ('cover', 'frontmatter')) = true())">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">((html:section | html:article)/tokenize(@epub:type, '\s+') = ('cover', 'frontmatter')) = true()</xsl:attribute>
                     <svrl:text>[nordic13a] A single-HTML document must have at least one frontmatter or cover section.</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
               <xsl:if test="not(((html:section | html:article)/tokenize(@epub:type, '\s+') = 'bodymatter') = true())">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">((html:section | html:article)/tokenize(@epub:type, '\s+') = 'bodymatter') = true()</xsl:attribute>
                     <svrl:text>[nordic13a] A single-HTML document must have at least one bodymatter section.</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
               <xsl:if test="not(not(tokenize(@epub:type, '\s+') = ('cover', 'frontmatter', 'bodymatter', 'backmatter')))">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">not(tokenize(@epub:type, '\s+') = ('cover', 'frontmatter', 'bodymatter', 'backmatter'))</xsl:attribute>
                     <svrl:text>[nordic13a] The single-HTML document must not have cover, frontmatter, bodymatter or backmatter as epub:type on its body element.</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e95')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:*[self::html:section or self::html:article][ancestor::html:body[html:header] and not(parent::html:body) and not(parent::html:section[tokenize(@epub:type, '\s+') = 'part'])]"
                 priority="78"
                 mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e122']">
            <schxslt:rule pattern="d7e122">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:*[self::html:section or self::html:article][ancestor::html:body[html:header] and not(parent::html:body) and not(parent::html:section[tokenize(@epub:type, '\s+') = 'part'])]" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[self::html:section or self::html:article][ancestor::html:body[html:header] and not(parent::html:body) and not(parent::html:section[tokenize(@epub:type, '\s+') = 'part'])]</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e122">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[self::html:section or self::html:article][ancestor::html:body[html:header] and not(parent::html:body) and not(parent::html:section[tokenize(@epub:type, '\s+') = 'part'])]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(not((tokenize(@epub:type, '\s+') = ('cover', 'frontmatter', 'bodymatter', 'backmatter')) = true()))">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">not((tokenize(@epub:type, '\s+') = ('cover', 'frontmatter', 'bodymatter', 'backmatter')) = true())</xsl:attribute>
                     <svrl:text>[nordic13b] The single-HTML document must not have cover, frontmatter, bodymatter or backmatter on any of its sectioning elements other than the top-level elements that has body as its parent.</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e122')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:body/html:section" priority="77" mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e138']">
            <schxslt:rule pattern="d7e138">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:body/html:section" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:body/html:section</xsl:attribute>
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
                  <xsl:attribute name="context">html:body/html:section</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(tokenize(@epub:type, '\s+') = ('cover', 'frontmatter', 'bodymatter', 'backmatter'))">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">tokenize(@epub:type, '\s+') = ('cover', 'frontmatter', 'bodymatter', 'backmatter')</xsl:attribute>
                     <svrl:text>[nordic13c] The top-level section element must have either cover, frontmatter, bodymatter or backmatter as one of the values on its epub:type. <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e138')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:section[not(parent::html:body)]" priority="76" mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e155']">
            <schxslt:rule pattern="d7e155">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:section[not(parent::html:body)]" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:section[not(parent::html:body)]</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e155">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:section[not(parent::html:body)]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(parent::html:section[tokenize(@epub:type, '\s+') = 'part']) and tokenize(@epub:type, '\s+') = ('cover', 'frontmatter', 'bodymatter', 'backmatter')">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">not(parent::html:section[tokenize(@epub:type, '\s+') = 'part']) and tokenize(@epub:type, '\s+') = ('cover', 'frontmatter', 'bodymatter', 'backmatter')</xsl:attribute>
                     <svrl:text>[nordic13d] Section elements that are not top-level sections must not have cover, frontmatter, bodymatter or backmatter as one of the values on its epub:type attribute. It is allowed (but optional) to use the bodymatter type on section elements that are direct children of sections with epub:type="part"). <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
               <xsl:if test="parent::html:section[tokenize(@epub:type, '\s+') = 'part'] and tokenize(@epub:type, '\s+') = ('cover', 'frontmatter', 'backmatter')">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">parent::html:section[tokenize(@epub:type, '\s+') = 'part'] and tokenize(@epub:type, '\s+') = ('cover', 'frontmatter', 'backmatter')</xsl:attribute>
                     <svrl:text>[nordic13d] Section elements in parts must not have cover, frontmatter or backmatter as one of the values on its epub:type attribute. <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e155')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:body" priority="75" mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e176']">
            <schxslt:rule pattern="d7e176">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:body" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:body</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e176">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:body</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(not(@epub:type))">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">not(@epub:type)</xsl:attribute>
                     <svrl:text>[nordic13e] The body element must not have a epub:type attribute.</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e176')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:body[html:header]/html:*[self::html:section or self::html:article]"
                 priority="74"
                 mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e194']">
            <schxslt:rule pattern="d7e194">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:body[html:header]/html:*[self::html:section or self::html:article]" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:body[html:header]/html:*[self::html:section or self::html:article]</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e194">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:body[html:header]/html:*[self::html:section or self::html:article]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="tokenize(@epub:type, '\s+')[. = 'cover'] and preceding-sibling::html:*[self::html:section or self::html:article]">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">tokenize(@epub:type, '\s+')[. = 'cover'] and preceding-sibling::html:*[self::html:section or self::html:article]</xsl:attribute>
                     <svrl:text>[nordic15] Cover must not be preceded by any other top-level sections. <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
               <xsl:if test="tokenize(@epub:type, '\s+')[. = 'frontmatter'] and preceding-sibling::html:*[self::html:section or self::html:article]/tokenize(@epub:type, '\s') = ('bodymatter', 'backmatter')">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">tokenize(@epub:type, '\s+')[. = 'frontmatter'] and preceding-sibling::html:*[self::html:section or self::html:article]/tokenize(@epub:type, '\s') = ('bodymatter', 'backmatter')</xsl:attribute>
                     <svrl:text>[nordic15] Frontmatter must not be preceded by bodymatter or rearmatter. <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
               <xsl:if test="tokenize(@epub:type, '\s+')[. = 'frontmatter'] and preceding-sibling::html:*[self::html:section or self::html:article]/tokenize(@epub:type, '\s') = ('backmatter')">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">tokenize(@epub:type, '\s+')[. = 'frontmatter'] and preceding-sibling::html:*[self::html:section or self::html:article]/tokenize(@epub:type, '\s') = ('backmatter')</xsl:attribute>
                     <svrl:text>[nordic15] Bodymatter must not be preceded by backmatter. <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e194')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:table" priority="73" mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e221']">
            <schxslt:rule pattern="d7e221">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:table" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:table</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e221">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:table</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="ancestor::html:table">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">ancestor::html:table</xsl:attribute>
                     <svrl:text>[nordic21] Nested tables are not allowed. <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e221')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:*[tokenize(@epub:type, '\s+') = 'pagebreak' and tokenize(@class, '\s+') = 'page-normal' and preceding::html:*[tokenize(@epub:type, '\s+') = 'pagebreak'][tokenize(@class, '\s+') = 'page-normal']]"
                 priority="72"
                 mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:variable name="preceding"
                    select="preceding::html:*[tokenize(@epub:type, '\s+') = 'pagebreak' and tokenize(@class, '\s+') = 'page-normal'][1]"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e239']">
            <schxslt:rule pattern="d7e239">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:*[tokenize(@epub:type, '\s+') = 'pagebreak' and tokenize(@class, '\s+') = 'page-normal' and preceding::html:*[tokenize(@epub:type, '\s+') = 'pagebreak'][tokenize(@class, '\s+') = 'page-normal']]" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type, '\s+') = 'pagebreak' and tokenize(@class, '\s+') = 'page-normal' and preceding::html:*[tokenize(@epub:type, '\s+') = 'pagebreak'][tokenize(@class, '\s+') = 'page-normal']]</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e239">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type, '\s+') = 'pagebreak' and tokenize(@class, '\s+') = 'page-normal' and preceding::html:*[tokenize(@epub:type, '\s+') = 'pagebreak'][tokenize(@class, '\s+') = 'page-normal']]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(number(current()/@aria-label) &gt; number($preceding/@aria-label))">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">number(current()/@aria-label) &gt; number($preceding/@aria-label)</xsl:attribute>
                     <svrl:text>[nordic23] pagebreak values must increase for pagebreaks with class="page-normal". <xsl:value-of select="concat('(see pagebreak with aria-label=&#34;', @aria-label, '&#34; and compare with pagebreak with aria-label=&#34;', $preceding/@aria-label, '&#34;)')"/> 
                        <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e239')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:*[tokenize(@epub:type, '\s+') = 'pagebreak'][tokenize(@class, '\s+') = 'page-front']"
                 priority="71"
                 mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e261']">
            <schxslt:rule pattern="d7e261">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:*[tokenize(@epub:type, '\s+') = 'pagebreak'][tokenize(@class, '\s+') = 'page-front']" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type, '\s+') = 'pagebreak'][tokenize(@class, '\s+') = 'page-front']</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e261">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type, '\s+') = 'pagebreak'][tokenize(@class, '\s+') = 'page-front']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(count(//html:*[tokenize(@epub:type, '\s+') = 'pagebreak' and tokenize(@class, '\s+') = 'page-front' and @aria-label = current()/@aria-label]) = 1)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count(//html:*[tokenize(@epub:type, '\s+') = 'pagebreak' and tokenize(@class, '\s+') = 'page-front' and @aria-label = current()/@aria-label]) = 1</xsl:attribute>
                     <svrl:text>[nordic24] pagebreak values must be unique for pagebreaks with class="page-front". <xsl:value-of select="concat('(see pagebreak with aria-label=&#34;', @aria-label, '&#34;)')"/> 
                        <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e261')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:*[ancestor::html:body[html:header] and tokenize(@epub:type, '\s+') = ('note', 'endnote', 'footnote')]"
                 priority="70"
                 mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e281']">
            <schxslt:rule pattern="d7e281">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:*[ancestor::html:body[html:header] and tokenize(@epub:type, '\s+') = ('note', 'endnote', 'footnote')]" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[ancestor::html:body[html:header] and tokenize(@epub:type, '\s+') = ('note', 'endnote', 'footnote')]</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e281">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[ancestor::html:body[html:header] and tokenize(@epub:type, '\s+') = ('note', 'endnote', 'footnote')]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(count(//html:a[tokenize(@epub:type, '\s+') = 'noteref'][substring-after(@href, '#') = current()/@id]) &gt;= 1)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count(//html:a[tokenize(@epub:type, '\s+') = 'noteref'][substring-after(@href, '#') = current()/@id]) &gt;= 1</xsl:attribute>
                     <svrl:text>[nordic26a] Each note must have at least one &lt;a epub:type="noteref"
                ...&gt; referencing it. <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e281')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:a[ancestor::html:body[html:header] and tokenize(@epub:type, '\s+') = 'noteref']"
                 priority="69"
                 mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e301']">
            <schxslt:rule pattern="d7e301">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:a[ancestor::html:body[html:header] and tokenize(@epub:type, '\s+') = 'noteref']" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:a[ancestor::html:body[html:header] and tokenize(@epub:type, '\s+') = 'noteref']</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e301">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:a[ancestor::html:body[html:header] and tokenize(@epub:type, '\s+') = 'noteref']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(count(//html:*[tokenize(@epub:type, '\s+') = ('note', 'endnote', 'footnote') and @id = current()/substring-after(@href, '#')]) &gt;= 1)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count(//html:*[tokenize(@epub:type, '\s+') = ('note', 'endnote', 'footnote') and @id = current()/substring-after(@href, '#')]) &gt;= 1</xsl:attribute>
                     <svrl:text>[nordic26b] The note reference must point to a note, endnote or footnote in the publication using its href attribute. <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e301')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:*[tokenize(@epub:type, '\s+') = ('note', 'endnote', 'footnote')]"
                 priority="68"
                 mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e322']">
            <schxslt:rule pattern="d7e322">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:*[tokenize(@epub:type, '\s+') = ('note', 'endnote', 'footnote')]" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type, '\s+') = ('note', 'endnote', 'footnote')]</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e322">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type, '\s+') = ('note', 'endnote', 'footnote')]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(count(.//html:a[tokenize(@role, '\s+') = 'doc-backlink']) = 1)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count(.//html:a[tokenize(@role, '\s+') = 'doc-backlink']) = 1</xsl:attribute>
                     <svrl:text>[nordic26c] Each note must have one &lt;a role="doc-backlink" ...&gt;. <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e322')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:*[ancestor::html:body[html:header] and tokenize(@epub:type, '\s+') = 'annotation']"
                 priority="67"
                 mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e342']">
            <schxslt:rule pattern="d7e342">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:*[ancestor::html:body[html:header] and tokenize(@epub:type, '\s+') = 'annotation']" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[ancestor::html:body[html:header] and tokenize(@epub:type, '\s+') = 'annotation']</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e342">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[ancestor::html:body[html:header] and tokenize(@epub:type, '\s+') = 'annotation']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(count(//html:a[tokenize(@epub:type, '\s+') = 'annoref'][substring-after(@href, '#') = current()/@id]) &gt;= 1)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count(//html:a[tokenize(@epub:type, '\s+') = 'annoref'][substring-after(@href, '#') = current()/@id]) &gt;= 1</xsl:attribute>
                     <svrl:text>[nordic27a] Each annotation must have at least one &lt;a epub:type="annoref" ...&gt; referencing it. <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e342')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:a[ancestor::html:body[html:header] and tokenize(@epub:type, '\s+') = 'annoref']"
                 priority="66"
                 mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e362']">
            <schxslt:rule pattern="d7e362">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:a[ancestor::html:body[html:header] and tokenize(@epub:type, '\s+') = 'annoref']" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:a[ancestor::html:body[html:header] and tokenize(@epub:type, '\s+') = 'annoref']</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e362">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:a[ancestor::html:body[html:header] and tokenize(@epub:type, '\s+') = 'annoref']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(count(//html:*[tokenize(@epub:type, '\s+') = ('annotation') and @id = current()/substring-after(@href, '#')]) &gt;= 1)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count(//html:*[tokenize(@epub:type, '\s+') = ('annotation') and @id = current()/substring-after(@href, '#')]) &gt;= 1</xsl:attribute>
                     <svrl:text>[nordic27b] The annotation must point to a annotation in the publication using its href attribute. <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e362')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:address | html:aside | html:blockquote | html:p | html:caption | html:div | html:dl | html:ul | html:ol | html:figure | html:table | html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6 | html:details | html:summary"
                 priority="65"
                 mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:variable name="inline-ancestor"
                    select="ancestor::*[namespace-uri() = 'http://www.w3.org/1999/xhtml' and local-name() = ('a', 'abbr', 'bdo', 'code', 'dfn', 'em', 'kbd', 'q', 'samp', 'span', 'strong', 'sub', 'sup')][1]"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e382']">
            <schxslt:rule pattern="d7e382">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:address | html:aside | html:blockquote | html:p | html:caption | html:div | html:dl | html:ul | html:ol | html:figure | html:table | html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6 | html:details | html:summary" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:address | html:aside | html:blockquote | html:p | html:caption | html:div | html:dl | html:ul | html:ol | html:figure | html:table | html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6 | html:details | html:summary</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e382">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:address | html:aside | html:blockquote | html:p | html:caption | html:div | html:dl | html:ul | html:ol | html:figure | html:table | html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6 | html:details | html:summary</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="count($inline-ancestor)">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count($inline-ancestor)</xsl:attribute>
                     <svrl:text>[nordic29] Block element <xsl:value-of select="$context"/> used in inline context. <xsl:value-of select="concat(                 '(inside the inline element &lt;', $inline-ancestor/name(),                                                    string-join(for $a in ($inline-ancestor/@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''),                                                    '&gt;)')"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e382')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:address | html:aside | html:blockquote | html:p | html:caption | html:div | html:dl | html:ul | html:ol | html:figure | html:table | html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6 | html:details | html:summary | html:section | html:article"
                 priority="64"
                 mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:variable name="inline-sibling-element"
                    select="../*[namespace-uri() = 'http://www.w3.org/1999/xhtml' and local-name() = ('a', 'abbr', 'bdo', 'code', 'dfn', 'em', 'kbd', 'q', 'samp', 'span', 'strong', 'sub', 'sup')][1]"/>
      <xsl:variable name="inline-sibling-text" select="../text()[normalize-space()][1]"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e404']">
            <schxslt:rule pattern="d7e404">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:address | html:aside | html:blockquote | html:p | html:caption | html:div | html:dl | html:ul | html:ol | html:figure | html:table | html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6 | html:details | html:summary | html:section | html:article" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:address | html:aside | html:blockquote | html:p | html:caption | html:div | html:dl | html:ul | html:ol | html:figure | html:table | html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6 | html:details | html:summary | html:section | html:article</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e404">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:address | html:aside | html:blockquote | html:p | html:caption | html:div | html:dl | html:ul | html:ol | html:figure | html:table | html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6 | html:details | html:summary | html:section | html:article</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="count($inline-sibling-element) and not((self::html:ol or self::html:ul) and parent::html:li)">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count($inline-sibling-element) and not((self::html:ol or self::html:ul) and parent::html:li)</xsl:attribute>
                     <svrl:text>[nordic29] Block elements <xsl:value-of select="$context"/> are not allowed as siblings to inline elements. <xsl:value-of select="                     concat('(&lt;', $inline-sibling-element/name(),                                     string-join(for $a in ($inline-sibling-element/@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''),                                     '&gt;')"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
               <xsl:if test="count($inline-sibling-text) and not((self::html:ol or self::html:ul) and parent::html:li)">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count($inline-sibling-text) and not((self::html:ol or self::html:ul) and parent::html:li)</xsl:attribute>
                     <svrl:text>[nordic29] Block elements <xsl:value-of select="$context"/> are not allowed as siblings to text content. <xsl:value-of select="                 concat('(',                     if (string-length(normalize-space($inline-sibling-text)) &lt; 100) then                         normalize-space($inline-sibling-text)                     else                         concat(substring(normalize-space($inline-sibling-text), 1, 100), ' (...)'),                 ')')"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e404')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:img[parent::html:figure/tokenize(@class, '\s+') = 'image']"
                 priority="63"
                 mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e435']">
            <schxslt:rule pattern="d7e435">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:img[parent::html:figure/tokenize(@class, '\s+') = 'image']" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:img[parent::html:figure/tokenize(@class, '\s+') = 'image']</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e435">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:img[parent::html:figure/tokenize(@class, '\s+') = 'image']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(@alt and @alt != '')">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">@alt and @alt != ''</xsl:attribute>
                     <svrl:text>[nordic50a] an image inside a figure with class='image' must have a non-empty alt attribute. <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e435')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:img" priority="62" mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e453']">
            <schxslt:rule pattern="d7e453">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:img" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:img</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e453">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:img</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(substring(@src, string-length(@src) - 2) = ('jpg', 'png'))">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">substring(@src, string-length(@src) - 2) = ('jpg', 'png')</xsl:attribute>
                     <svrl:text>[nordic52] Images must have either the .jpg file extension or the .png file extension. <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
               <xsl:if test="substring(@src, string-length(@src) - 2) = ('jpg', 'png') and string-length(@src) = 4">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">substring(@src, string-length(@src) - 2) = ('jpg', 'png') and string-length(@src) = 4</xsl:attribute>
                     <svrl:text>[nordic52] Images must have a base name, not just an extension. <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
               <xsl:if test="not(matches(@src, '^images/[^/]+$'))">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">not(matches(@src, '^images/[^/]+$'))</xsl:attribute>
                     <svrl:text>[nordic51] Images must be in the "images" folder (relative to the HTML file).</svrl:text>
                  </svrl:successful-report>
               </xsl:if>
               <xsl:if test="not(string-length(translate(substring(@src, 1, string-length(@src) - 4), '-_abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/', '')) = 0)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">string-length(translate(substring(@src, 1, string-length(@src) - 4), '-_abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/', '')) = 0</xsl:attribute>
                     <svrl:text>[nordic52] Image file names can only contain the characters a-z, A-Z, 0-9, underscore (_) or hyphen (-). <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e453')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:dl/html:*[tokenize(@epub:type, '\s+') = 'pagebreak']" priority="61"
                 mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e481']">
            <schxslt:rule pattern="d7e481">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:dl/html:*[tokenize(@epub:type, '\s+') = 'pagebreak']" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:dl/html:*[tokenize(@epub:type, '\s+') = 'pagebreak']</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e481">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:dl/html:*[tokenize(@epub:type, '\s+') = 'pagebreak']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(not(parent::*/html:dd or parent::*/html:dt))">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">not(parent::*/html:dd or parent::*/html:dt)</xsl:attribute>
                     <svrl:text>[nordic59] pagebreak in definition list must not occur as siblings to dd or dt. <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e481')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:a[tokenize(@epub:type, '\s+') = 'noteref']" priority="60"
                 mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e499']">
            <schxslt:rule pattern="d7e499">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:a[tokenize(@epub:type, '\s+') = 'noteref']" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:a[tokenize(@epub:type, '\s+') = 'noteref']</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e499">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:a[tokenize(@epub:type, '\s+') = 'noteref']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="matches(@href, '^[^/]+:')">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">matches(@href, '^[^/]+:')</xsl:attribute>
                     <svrl:text>[nordic63] Only note references within the same publication are allowed. <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e499')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:a[tokenize(@epub:type, '\s+') = 'annoref']" priority="59"
                 mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e517']">
            <schxslt:rule pattern="d7e517">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:a[tokenize(@epub:type, '\s+') = 'annoref']" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:a[tokenize(@epub:type, '\s+') = 'annoref']</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e517">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:a[tokenize(@epub:type, '\s+') = 'annoref']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="matches(@href, '^[^/]+:')">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">matches(@href, '^[^/]+:')</xsl:attribute>
                     <svrl:text>[nordic64] Only annotation references within the same publication are allowed.</svrl:text>
                  </svrl:successful-report>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e517')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:*[self::html:h1 or self::html:h2 or self::html:h3 or self::html:h4 or self::html:h5 or self::html:h6]"
                 priority="58"
                 mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e534']">
            <schxslt:rule pattern="d7e534">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:*[self::html:h1 or self::html:h2 or self::html:h3 or self::html:h4 or self::html:h5 or self::html:h6]" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[self::html:h1 or self::html:h2 or self::html:h3 or self::html:h4 or self::html:h5 or self::html:h6]</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e534">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[self::html:h1 or self::html:h2 or self::html:h3 or self::html:h4 or self::html:h5 or self::html:h6]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="matches((.//text()[normalize-space()])[1], '^\s')">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">matches((.//text()[normalize-space()])[1], '^\s')</xsl:attribute>
                     <svrl:text>[nordic93] Headings (h1-h6) may not have leading whitespace. <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
               <xsl:if test="matches((.//text()[normalize-space()])[last()], '\s$')">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">matches((.//text()[normalize-space()])[last()], '\s$')</xsl:attribute>
                     <svrl:text>[nordic93] Headings (h1-h6) may not have trailing whitespace. <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e534')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:figure[tokenize(@class, '\s+') = 'image-series']" priority="57"
                 mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e559']">
            <schxslt:rule pattern="d7e559">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:figure[tokenize(@class, '\s+') = 'image-series']" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:figure[tokenize(@class, '\s+') = 'image-series']</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e559">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:figure[tokenize(@class, '\s+') = 'image-series']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="ancestor::html:figure[tokenize(@class, '\s+') = 'image-series']">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">ancestor::html:figure[tokenize(@class, '\s+') = 'image-series']</xsl:attribute>
                     <svrl:text>[nordic96b] Nested image series figures are not allowed. Image figures must use the class "image", while image series figures must use the class "image-series". <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e559')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:figure[html:img[tokenize(@role, '\s+') = 'doc-cover']]"
                 priority="56"
                 mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e576']">
            <schxslt:rule pattern="d7e576">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:figure[html:img[tokenize(@role, '\s+') = 'doc-cover']]" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:figure[html:img[tokenize(@role, '\s+') = 'doc-cover']]</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e576">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:figure[html:img[tokenize(@role, '\s+') = 'doc-cover']]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="html:aside[tokenize(@class, '\s+') = 'fig-desc']">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">html:aside[tokenize(@class, '\s+') = 'fig-desc']</xsl:attribute>
                     <svrl:text>[nordic96c] Aside elements with class="fig-desc" are not allowed in figure elements containing an img with role="doc-cover". <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e576')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:figure[tokenize(@class, '\s+') = 'image-series']" priority="55"
                 mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e596']">
            <schxslt:rule pattern="d7e596">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:figure[tokenize(@class, '\s+') = 'image-series']" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:figure[tokenize(@class, '\s+') = 'image-series']</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e596">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:figure[tokenize(@class, '\s+') = 'image-series']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(html:figure[tokenize(@class, '\s+') = 'image'])">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">html:figure[tokenize(@class, '\s+') = 'image']</xsl:attribute>
                     <svrl:text>[nordic101] There must be at least one figure with class="image" in a image series figure. <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e596')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:figure[tokenize(@class, '\s+') = 'image']" priority="54"
                 mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e616']">
            <schxslt:rule pattern="d7e616">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:figure[tokenize(@class, '\s+') = 'image']" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:figure[tokenize(@class, '\s+') = 'image']</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e616">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:figure[tokenize(@class, '\s+') = 'image']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(html:img)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">html:img</xsl:attribute>
                     <svrl:text>[nordic102] There must be an img element in every figure with class="image". <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
               <xsl:if test="parent::html:figure[tokenize(@class, '\s+') = 'image']">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">parent::html:figure[tokenize(@class, '\s+') = 'image']</xsl:attribute>
                     <svrl:text>[nordic102] Nested images figures are not allowed. Image figures must use the class "image", while image series figures must use the class "image-series". <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e616')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6" priority="53"
                 mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e639']">
            <schxslt:rule pattern="d7e639">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e639">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="normalize-space(.) = ''">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">normalize-space(.) = ''</xsl:attribute>
                     <svrl:text>[nordic104] Headings may not be empty. <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e639')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:*[tokenize(@epub:type, '\s+') = 'pagebreak']" priority="52"
                 mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e657']">
            <schxslt:rule pattern="d7e657">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:*[tokenize(@epub:type, '\s+') = 'pagebreak']" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type, '\s+') = 'pagebreak']</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e657">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type, '\s+') = 'pagebreak']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(tokenize(@class, '\s+') = ('page-front', 'page-normal', 'page-special'))">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">tokenize(@class, '\s+') = ('page-front', 'page-normal', 'page-special')</xsl:attribute>
                     <svrl:text>[nordic105] Page breaks must have either a 'page-front', a 'page-normal' or a 'page-special' class. <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
               <xsl:if test="not(count(* | comment()) = 0 and ( not(text()) or text() = normalize-space(text()) ))">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count(* | comment()) = 0 and ( not(text()) or text() = normalize-space(text()) )</xsl:attribute>
                     <svrl:text>[nordic105] Pagebreaks must not contain elements or comments. Text content, if present, must not contain extra whitespace. <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e657')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:*[tokenize(@epub:type, '\s+') = 'pagebreak']" priority="51"
                 mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e679']">
            <schxslt:rule pattern="d7e679">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:*[tokenize(@epub:type, '\s+') = 'pagebreak']" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type, '\s+') = 'pagebreak']</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e679">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type, '\s+') = 'pagebreak']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="ancestor::*[self::html:h1 or self::html:h2 or self::html:h3 or self::html:h4 or self::html:h5 or self::html:h6]">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">ancestor::*[self::html:h1 or self::html:h2 or self::html:h3 or self::html:h4 or self::html:h5 or self::html:h6]</xsl:attribute>
                     <svrl:text>[nordic110] Pagebreak elements are not allowed in headings. <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e679')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:*[tokenize(@epub:type, '\s+') = 'pagebreak']" priority="50"
                 mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e697']">
            <schxslt:rule pattern="d7e697">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:*[tokenize(@epub:type, '\s+') = 'pagebreak']" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type, '\s+') = 'pagebreak']</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e697">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type, '\s+') = 'pagebreak']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="tokenize(@class, '\s+') = 'page-front' and translate(., '0123456789', 'xxxxxxxxxx') != .">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">tokenize(@class, '\s+') = 'page-front' and translate(., '0123456789', 'xxxxxxxxxx') != .</xsl:attribute>
                     <svrl:text>[nordic116] Hindu-Arabic numbers (0-9) when @class="page-front" are not allowed. <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e697')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:*[tokenize(@epub:type, '\s+') = 'pagebreak'][ancestor::html:table]"
                 priority="49"
                 mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e715']">
            <schxslt:rule pattern="d7e715">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:*[tokenize(@epub:type, '\s+') = 'pagebreak'][ancestor::html:table]" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type, '\s+') = 'pagebreak'][ancestor::html:table]</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e715">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type, '\s+') = 'pagebreak'][ancestor::html:table]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(not(../html:tr))">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">not(../html:tr)</xsl:attribute>
                     <svrl:text>[nordic121] Page numbers in tables must not be placed between table rows. <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e715')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:*[tokenize(@epub:type, '\s+') = 'cover']" priority="48"
                 mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e733']">
            <schxslt:rule pattern="d7e733">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:*[tokenize(@epub:type, '\s+') = 'cover']" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type, '\s+') = 'cover']</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e733">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type, '\s+') = 'cover']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="ancestor-or-self::*/tokenize(@epub:type, '\s+') = ('frontmatter', 'bodymatter', 'backmatter')">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">ancestor-or-self::*/tokenize(@epub:type, '\s+') = ('frontmatter', 'bodymatter', 'backmatter')</xsl:attribute>
                     <svrl:text>[nordic123] Cover (Jacket copy) is a document partition and can not be part the other document partitions frontmatter, bodymatter and rearmatter. <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e733')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="*[@xml:lang]" priority="47" mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e754']">
            <schxslt:rule pattern="d7e754">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "*[@xml:lang]" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">*[@xml:lang]</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e754">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">*[@xml:lang]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(matches(@xml:lang, '^[a-z]{2,3}(-[A-Za-z0-9]+)*$'))">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">matches(@xml:lang, '^[a-z]{2,3}(-[A-Za-z0-9]+)*$')</xsl:attribute>
                     <svrl:text>[nordic131a] xml:lang must must be either a "two- or three-letter lower case" code or a "two- or three-letter lower case and groups of hyphen followed by numbers or letters" (i.e. zh-Hanz-UTF8) code. <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e754')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="*[@lang]" priority="46" mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e771']">
            <schxslt:rule pattern="d7e771">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "*[@lang]" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">*[@lang]</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e771">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">*[@lang]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(matches(@lang, '^[a-z]{2,3}(-[A-Za-z0-9]+)*$'))">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">matches(@lang, '^[a-z]{2,3}(-[A-Za-z0-9]+)*$')</xsl:attribute>
                     <svrl:text>[nordic131b] lang must must be either a "two- or three-letter lower case" code or a "two- or three-letter lower case and groups of hyphen followed by numbers or letters" (i.e. zh-Hanz-UTF8) code. <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e771')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:*[tokenize(@class, '\s+') = 'verse' and not(ancestor::html:*[tokenize(@class, '\s+') = 'verse'])]"
                 priority="45"
                 mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e788']">
            <schxslt:rule pattern="d7e788">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:*[tokenize(@class, '\s+') = 'verse' and not(ancestor::html:*[tokenize(@class, '\s+') = 'verse'])]" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@class, '\s+') = 'verse' and not(ancestor::html:*[tokenize(@class, '\s+') = 'verse'])]</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e788">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@class, '\s+') = 'verse' and not(ancestor::html:*[tokenize(@class, '\s+') = 'verse'])]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(html:*[tokenize(@class, '\s+') = 'linegroup'])">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">html:*[tokenize(@class, '\s+') = 'linegroup']</xsl:attribute>
                     <svrl:text>[nordic135] Every poem must contain a linegroup. <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
               <xsl:if test="html:p[tokenize(@class, '\s+') = 'line']">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">html:p[tokenize(@class, '\s+') = 'line']</xsl:attribute>
                     <svrl:text>[nordic135] Poem lines must be wrapped in a linegroup. <xsl:value-of select="$context"/> contains; <xsl:value-of select="                 concat(                     '&lt;',                     html:p[tokenize(@class, '\s+') = 'line'][1]/name(),                     string-join(for $a in (html:p[tokenize(@class, '\s+') = 'line'][1]/@*)                         return concat(' ', $a/name(), '=&#34;', $a, '&#34;'),                         ''                     ),                     '&gt;'                 )"/>.</svrl:text>
                  </svrl:successful-report>
               </xsl:if>
               <xsl:if test="html:p[tokenize(@class, '\s+') = 'line_indent']">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">html:p[tokenize(@class, '\s+') = 'line_indent']</xsl:attribute>
                     <svrl:text>[nordic135] Poem lines must be wrapped in a linegroup. <xsl:value-of select="$context"/> contains; <xsl:value-of select="                 concat(                     '&lt;',                     html:p[tokenize(@class, '\s+') = 'line_indent'][1]/name(),                     string-join(for $a in (html:p[tokenize(@class, '\s+') = 'line_indent'][1]/@*)                         return concat(' ', $a/name(), '=&#34;', $a, '&#34;'),                         ''                     ),                     '&gt;'                 )"/>.</svrl:text>
                  </svrl:successful-report>
               </xsl:if>
               <xsl:if test="html:p[tokenize(@class, '\s+') = 'line_longindent']">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">html:p[tokenize(@class, '\s+') = 'line_longindent']</xsl:attribute>
                     <svrl:text>[nordic135] Poem lines must be wrapped in a linegroup. <xsl:value-of select="$context"/> contains; <xsl:value-of select="                 concat(                     '&lt;',                     html:p[tokenize(@class, '\s+') = 'line_longindent'][1]/name(),                     string-join(for $a in (html:p[tokenize(@class, '\s+') = 'line_longindent'][1]/@*)                         return concat(' ', $a/name(), '=&#34;', $a, '&#34;'),                         ''                     ),                     '&gt;'                 )"/>.</svrl:text>
                  </svrl:successful-report>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e788')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:body[tokenize(@epub:type, '\s+') = 'cover'] | html:section[tokenize(@epub:type, '\s+') = 'cover']"
                 priority="44"
                 mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e827']">
            <schxslt:rule pattern="d7e827">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:body[tokenize(@epub:type, '\s+') = 'cover'] | html:section[tokenize(@epub:type, '\s+') = 'cover']" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:body[tokenize(@epub:type, '\s+') = 'cover'] | html:section[tokenize(@epub:type, '\s+') = 'cover']</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e827">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:body[tokenize(@epub:type, '\s+') = 'cover'] | html:section[tokenize(@epub:type, '\s+') = 'cover']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(count(*[not(matches(local-name(), 'h\d'))]) = count(html:section[tokenize(@class, '\s+') = ('frontcover', 'rearcover', 'leftflap', 'rightflap')]))">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count(*[not(matches(local-name(), 'h\d'))]) = count(html:section[tokenize(@class, '\s+') = ('frontcover', 'rearcover', 'leftflap', 'rightflap')])</xsl:attribute>
                     <svrl:text>[nordic140] Only sections with one of the classes 'frontcover', 'rearcover', 'leftflap' or 'rightflap' is allowed in cover.</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
               <xsl:if test="not(count(html:section[tokenize(@class, '\s+') = ('frontcover', 'rearcover', 'leftflap', 'rightflap')]) &gt;= 1)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count(html:section[tokenize(@class, '\s+') = ('frontcover', 'rearcover', 'leftflap', 'rightflap')]) &gt;= 1</xsl:attribute>
                     <svrl:text>[nordic140] There must be at least one section with one of the classes 'frontcover', 'rearcover', 'leftflap' or 'rightflap' in cover. <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
               <xsl:if test="count(html:section[tokenize(@class, '\s+') = 'frontcover']) &gt; 1">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count(html:section[tokenize(@class, '\s+') = 'frontcover']) &gt; 1</xsl:attribute>
                     <svrl:text>[nordic140] There can not be more than one section with class="frontcover" in cover. <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
               <xsl:if test="count(html:section[tokenize(@class, '\s+') = 'rearcover']) &gt; 1">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count(html:section[tokenize(@class, '\s+') = 'rearcover']) &gt; 1</xsl:attribute>
                     <svrl:text>[nordic140] There can not be more than one section with class="rearcover" in cover. <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
               <xsl:if test="count(html:section[tokenize(@class, '\s+') = 'leftflap']) &gt; 1">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count(html:section[tokenize(@class, '\s+') = 'leftflap']) &gt; 1</xsl:attribute>
                     <svrl:text>[nordic140] There can not be more than one section with class="leftflap" in cover. <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
               <xsl:if test="count(html:section[tokenize(@class, '\s+') = 'rightflap']) &gt; 1">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count(html:section[tokenize(@class, '\s+') = 'rightflap']) &gt; 1</xsl:attribute>
                     <svrl:text>[nordic140] There can not be more than one section with class="rightflap" in cover. <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e827')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:*[tokenize(@epub:type, '\s+') = 'pagebreak'][parent::html:ul or parent::html:ol]"
                 priority="43"
                 mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e867']">
            <schxslt:rule pattern="d7e867">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:*[tokenize(@epub:type, '\s+') = 'pagebreak'][parent::html:ul or parent::html:ol]" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type, '\s+') = 'pagebreak'][parent::html:ul or parent::html:ol]</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e867">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type, '\s+') = 'pagebreak'][parent::html:ul or parent::html:ol]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="../html:li">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">../html:li</xsl:attribute>
                     <svrl:text>[nordic143a] Pagebreaks are not allowed as siblings to list items. <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e867')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:*[tokenize(@epub:type, '\s+') = 'pagebreak'][parent::html:li]"
                 priority="42"
                 mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e886']">
            <schxslt:rule pattern="d7e886">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:*[tokenize(@epub:type, '\s+') = 'pagebreak'][parent::html:li]" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type, '\s+') = 'pagebreak'][parent::html:li]</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e886">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type, '\s+') = 'pagebreak'][parent::html:li]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(../preceding-sibling::html:li or preceding-sibling::* or preceding-sibling::text()[normalize-space()])">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">../preceding-sibling::html:li or preceding-sibling::* or preceding-sibling::text()[normalize-space()]</xsl:attribute>
                     <svrl:text>[nordic143b] It is not allowed to have a pagebreak at the beginning of the first list item; it should be placed before the list. <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e886')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:title" priority="41" mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e903']">
            <schxslt:rule pattern="d7e903">
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
            <schxslt:rule pattern="d7e903">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:title</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(text() and not(normalize-space(.) = ''))">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">text() and not(normalize-space(.) = '')</xsl:attribute>
                     <svrl:text>[nordic200] The title element must not be empty. <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e903')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:body/html:section[tokenize(@epub:type, '\s+') = 'frontmatter']"
                 priority="40"
                 mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:variable name="always-allowed-types"
                    select="('abstract', 'acknowledgments', 'afterword', 'answers', 'appendix', 'assessment', 'assessments', 'bibliography', 'z3998:biographical-note', 'case-study', 'chapter', 'colophon', 'conclusion', 'contributors', 'copyright-page', 'credits', 'dedication', 'z3998:discography', 'division', 'z3998:editorial-note', 'epigraph', 'epilogue', 'errata', 'z3998:filmography', 'footnotes', 'foreword', 'glossary', 'dictionary', 'z3998:grant-acknowledgment', 'halftitlepage', 'imprimatur', 'imprint', 'index', 'index-group', 'index-headnotes', 'index-legend', 'introduction', 'keywords', 'landmarks', 'loa', 'loi', 'lot', 'lov', 'notice', 'other-credits', 'page-list', 'practices', 'preamble', 'preface', 'prologue', 'z3998:promotional-copy', 'z3998:published-works', 'z3998:publisher-address', 'qna', 'endnotes', 'revision-history', 'z3998:section', 'seriespage', 'subchapter', 'z3998:subsection', 'toc', 'toc-brief', 'z3998:translator-note', 'volume')"/>
      <xsl:variable name="allowed-types" select="($always-allowed-types, 'titlepage')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e921']">
            <schxslt:rule pattern="d7e921">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:body/html:section[tokenize(@epub:type, '\s+') = 'frontmatter']" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:body/html:section[tokenize(@epub:type, '\s+') = 'frontmatter']</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e921">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:body/html:section[tokenize(@epub:type, '\s+') = 'frontmatter']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(count(tokenize(@epub:type, '\s+')) = 1 or tokenize(@epub:type, '\s+') = $allowed-types)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count(tokenize(@epub:type, '\s+')) = 1 or tokenize(@epub:type, '\s+') = $allowed-types</xsl:attribute>
                     <svrl:text>[nordic202] '<xsl:value-of select="(tokenize(@epub:type, '\s+')[not(. = 'frontmatter')], '(missing type)')[1]"/>' is not an allowed type in frontmatter. On elements with the epub:type "frontmatter", you can either leave the type blank (and just use 'frontmatter' as the type in the filename), or you can use one of the allowed types. <xsl:value-of select="concat('Allowed types: ', string-join($allowed-types[position() != last()], ''', '''), ' or ', $allowed-types[last()], '.')"/> 
                        <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e921')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:*[tokenize(@epub:type, '\s+') = 'endnote']" priority="39"
                 mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e947']">
            <schxslt:rule pattern="d7e947">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:*[tokenize(@epub:type, '\s+') = 'endnote']" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type, '\s+') = 'endnote']</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e947">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type, '\s+') = 'endnote']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not((ancestor::html:section | ancestor::html:body)[tokenize(@epub:type, '\s+') = 'endnotes'])">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">(ancestor::html:section | ancestor::html:body)[tokenize(@epub:type, '\s+') = 'endnotes']</xsl:attribute>
                     <svrl:text>[nordic203a] 'endnote' must have a section ancestor with 'endnotes'. <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e947')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:body[tokenize(@epub:type, '\s+') = 'endnotes'] | html:section[tokenize(@epub:type, '\s+') = 'endnotes']"
                 priority="38"
                 mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e965']">
            <schxslt:rule pattern="d7e965">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:body[tokenize(@epub:type, '\s+') = 'endnotes'] | html:section[tokenize(@epub:type, '\s+') = 'endnotes']" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:body[tokenize(@epub:type, '\s+') = 'endnotes'] | html:section[tokenize(@epub:type, '\s+') = 'endnotes']</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e965">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:body[tokenize(@epub:type, '\s+') = 'endnotes'] | html:section[tokenize(@epub:type, '\s+') = 'endnotes']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(descendant::html:*[tokenize(@epub:type, '\s+') = 'endnote'])">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">descendant::html:*[tokenize(@epub:type, '\s+') = 'endnote']</xsl:attribute>
                     <svrl:text>[nordic203c] Sections with the epub:type 'endnotes' must have descendants with 'endnote'. <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
               <xsl:if test="not(.//html:ol)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">.//html:ol</xsl:attribute>
                     <svrl:text>[nordic203c] Sections with the epub:type 'endnotes' must have &lt;ol&gt; descendant elements. <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e965')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:*[tokenize(@epub:type, '\s+') = 'endnote']" priority="37"
                 mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e986']">
            <schxslt:rule pattern="d7e986">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:*[tokenize(@epub:type, '\s+') = 'endnote']" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type, '\s+') = 'endnote']</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e986">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type, '\s+') = 'endnote']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(self::html:li)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">self::html:li</xsl:attribute>
                     <svrl:text>[nordic203d] 'endnote' can only be applied to &lt;li&gt; elements. <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e986')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:*[tokenize(@epub:type, '\s+') = 'footnote']" priority="36"
                 mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e1004']">
            <schxslt:rule pattern="d7e1004">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:*[tokenize(@epub:type, '\s+') = 'footnote']" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type, '\s+') = 'footnote']</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e1004">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type, '\s+') = 'footnote']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not((parent::html:section))">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">(parent::html:section)</xsl:attribute>
                     <svrl:text>[nordic204a] 'footnote' must have a parent section. <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
               <xsl:if test="not(not(following-sibling::html:*[not(local-name()='aside' and tokenize(@epub:type, '\s+')='footnote')]))">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">not(following-sibling::html:*[not(local-name()='aside' and tokenize(@epub:type, '\s+')='footnote')])</xsl:attribute>
                     <svrl:text>[nordic204a] 'footnote' must be placed at the end of a section.</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e1004')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:*[tokenize(@epub:type, '\s+') = 'footnote']" priority="35"
                 mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e1025']">
            <schxslt:rule pattern="d7e1025">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:*[tokenize(@epub:type, '\s+') = 'footnote']" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type, '\s+') = 'footnote']</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e1025">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type, '\s+') = 'footnote']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(self::html:aside)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">self::html:aside</xsl:attribute>
                     <svrl:text>[nordic204d] 'footnote' can only be applied to &lt;aside&gt; elements. <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
               <xsl:if test="not(tokenize(@role, '\s+') = 'doc-footnote')">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">tokenize(@role, '\s+') = 'doc-footnote'</xsl:attribute>
                     <svrl:text>[nordic204d] The 'doc-footnote' role must be applied to all footnotes. <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e1025')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:*[tokenize(@epub:type, '\s+') = 'bodymatter']" priority="34"
                 mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:variable name="always-allowed-types"
                    select="('abstract', 'acknowledgments', 'afterword', 'answers', 'appendix', 'assessment', 'assessments', 'bibliography', 'z3998:biographical-note', 'case-study', 'chapter', 'colophon', 'conclusion', 'contributors', 'copyright-page', 'credits', 'dedication', 'z3998:discography', 'division', 'z3998:editorial-note', 'epigraph', 'epilogue', 'errata', 'z3998:filmography', 'footnotes', 'foreword', 'glossary', 'dictionary', 'z3998:grant-acknowledgment', 'halftitlepage', 'imprimatur', 'imprint', 'index', 'index-group', 'index-headnotes', 'index-legend', 'introduction', 'keywords', 'landmarks', 'loa', 'loi', 'lot', 'lov', 'notice', 'other-credits', 'page-list', 'practices', 'preamble', 'preface', 'prologue', 'z3998:promotional-copy', 'z3998:published-works', 'z3998:publisher-address', 'qna', 'endnotes', 'revision-history', 'z3998:section', 'seriespage', 'subchapter', 'z3998:subsection', 'toc', 'toc-brief', 'z3998:translator-note', 'volume')"/>
      <xsl:variable name="allowed-types" select="($always-allowed-types, 'part')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e1046']">
            <schxslt:rule pattern="d7e1046">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:*[tokenize(@epub:type, '\s+') = 'bodymatter']" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type, '\s+') = 'bodymatter']</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e1046">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type, '\s+') = 'bodymatter']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(tokenize(@epub:type, '\s+') = $allowed-types)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">tokenize(@epub:type, '\s+') = $allowed-types</xsl:attribute>
                     <svrl:text>[nordic208] Elements with the type "bodymatter" must also have one of the allowed epub:type values allowed for such sections. <xsl:value-of select="concat('&#34;', (tokenize(@epub:type, '\s+')[not(. = 'bodymatter')], '(missing type)')[1], '&#34; is not an allowed type in bodymatter)')"/> 
                        <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e1046')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:*[self::html:section or self::html:article][parent::html:*[tokenize(@epub:type, '\s+') = ('part', 'volume')]]"
                 priority="33"
                 mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:variable name="always-allowed-types"
                    select="('abstract', 'acknowledgments', 'afterword', 'answers', 'appendix', 'assessment', 'assessments', 'bibliography', 'z3998:biographical-note', 'case-study', 'chapter', 'colophon', 'conclusion', 'contributors', 'copyright-page', 'credits', 'dedication', 'z3998:discography', 'division', 'z3998:editorial-note', 'epigraph', 'epilogue', 'errata', 'z3998:filmography', 'footnotes', 'foreword', 'glossary', 'dictionary', 'z3998:grant-acknowledgment', 'halftitlepage', 'imprimatur', 'imprint', 'index', 'index-group', 'index-headnotes', 'index-legend', 'introduction', 'keywords', 'landmarks', 'loa', 'loi', 'lot', 'lov', 'notice', 'other-credits', 'page-list', 'practices', 'preamble', 'preface', 'prologue', 'z3998:promotional-copy', 'z3998:published-works', 'z3998:publisher-address', 'qna', 'endnotes', 'revision-history', 'z3998:section', 'seriespage', 'subchapter', 'z3998:subsection', 'toc', 'toc-brief', 'z3998:translator-note', 'volume')"/>
      <xsl:variable name="document-components"
                    select="('z3998:pgroup', 'z3998:example', 'z3998:epigraph', 'z3998:annotation', 'z3998:introductory-note', 'z3998:commentary', 'z3998:clarification', 'z3998:correction', 'z3998:alteration', 'z3998:presentation', 'z3998:production', 'z3998:attribution', 'z3998:author', 'z3998:editor', 'z3998:general-editor', 'z3998:commentator', 'z3998:translator', 'z3998:republisher', 'z3998:structure', 'z3998:geographic', 'z3998:postal', 'z3998:email', 'z3998:ftp', 'z3998:http', 'z3998:ip', 'z3998:aside', 'z3998:sidebar', 'z3998:practice', 'z3998:notice', 'z3998:warning', 'z3998:marginalia', 'z3998:help', 'z3998:drama', 'z3998:scene', 'z3998:stage-direction', 'z3998:dramatis-personae', 'z3998:persona', 'z3998:actor', 'z3998:role-description', 'z3998:speech', 'z3998:diary', 'z3998:diary-entry', 'z3998:figure', 'z3998:plate', 'z3998:gallery', 'z3998:letter', 'z3998:sender', 'z3998:recipient', 'z3998:salutation', 'z3998:valediction', 'z3998:postscript', 'z3998:email-message', 'z3998:to', 'z3998:from', 'z3998:cc', 'z3998:bcc', 'z3998:subject', 'z3998:collection', 'z3998:orderedlist', 'z3998:unorderedlist', 'z3998:abbreviations', 'z3998:timeline', 'z3998:note', 'z3998:footnotes', 'z3998:footnote', 'z3998:verse', 'z3998:poem', 'z3998:song', 'z3998:hymn', 'z3998:lyrics')"/>
      <xsl:variable name="allowed-types" select="($always-allowed-types, $document-components)"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e1072']">
            <schxslt:rule pattern="d7e1072">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:*[self::html:section or self::html:article][parent::html:*[tokenize(@epub:type, '\s+') = ('part', 'volume')]]" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[self::html:section or self::html:article][parent::html:*[tokenize(@epub:type, '\s+') = ('part', 'volume')]]</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e1072">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[self::html:section or self::html:article][parent::html:*[tokenize(@epub:type, '\s+') = ('part', 'volume')]]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(tokenize(@epub:type, '\s+') = $allowed-types)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">tokenize(@epub:type, '\s+') = $allowed-types</xsl:attribute>
                     <svrl:text>[nordic211] Sections inside a part must also have one of the allowed epub:type values allowed for such sections. <xsl:value-of select="concat('&#34;', (tokenize(@epub:type, '\s+')[not(. = ('part', 'volume'))], '(missing type)')[1], '&#34; is not an allowed type in a part)')"/> 
                        <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e1072')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:*[tokenize(@epub:type, '\s+') = 'backmatter']" priority="32"
                 mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:variable name="always-allowed-types"
                    select="('abstract', 'acknowledgments', 'afterword', 'answers', 'appendix', 'assessment', 'assessments', 'bibliography', 'z3998:biographical-note', 'case-study', 'chapter', 'colophon', 'conclusion', 'contributors', 'copyright-page', 'credits', 'dedication', 'z3998:discography', 'division', 'z3998:editorial-note', 'epigraph', 'epilogue', 'errata', 'z3998:filmography', 'footnotes', 'foreword', 'glossary', 'dictionary', 'z3998:grant-acknowledgment', 'halftitlepage', 'imprimatur', 'imprint', 'index', 'index-group', 'index-headnotes', 'index-legend', 'introduction', 'keywords', 'landmarks', 'loa', 'loi', 'lot', 'lov', 'notice', 'other-credits', 'page-list', 'practices', 'preamble', 'preface', 'prologue', 'z3998:promotional-copy', 'z3998:published-works', 'z3998:publisher-address', 'qna', 'endnotes', 'revision-history', 'z3998:section', 'seriespage', 'subchapter', 'z3998:subsection', 'toc', 'toc-brief', 'z3998:translator-note', 'volume')"/>
      <xsl:variable name="allowed-types" select="($always-allowed-types)"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e1100']">
            <schxslt:rule pattern="d7e1100">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:*[tokenize(@epub:type, '\s+') = 'backmatter']" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type, '\s+') = 'backmatter']</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e1100">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type, '\s+') = 'backmatter']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(count(tokenize(@epub:type, '\s+')) = 1 or tokenize(@epub:type, '\s+') = $allowed-types)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count(tokenize(@epub:type, '\s+')) = 1 or tokenize(@epub:type, '\s+') = $allowed-types</xsl:attribute>
                     <svrl:text>[nordic215] If elements with the type "backmatter" has additional types, they must be one of the allowed epub:type values allowed for such sections. <xsl:value-of select="concat('&#34;', (tokenize(@epub:type, '\s+')[not(. = 'backmatter')], '(missing type)')[1], '&#34; is not an allowed type in backmatter)')"/> 
                        <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e1100')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:*[tokenize(@epub:type, '\s+') = 'pagebreak' and text()]"
                 priority="31"
                 mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e1126']">
            <schxslt:rule pattern="d7e1126">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:*[tokenize(@epub:type, '\s+') = 'pagebreak' and text()]" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type, '\s+') = 'pagebreak' and text()]</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e1126">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type, '\s+') = 'pagebreak' and text()]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(matches(@aria-label, '.+'))">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">matches(@aria-label, '.+')</xsl:attribute>
                     <svrl:text>[nordic225] The aria-label attribute must be used to describe the page number. <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e1126')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:body/html:section[tokenize(@epub:type, '\s+') = 'titlepage']/html:h1"
                 priority="30"
                 mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e1145']">
            <schxslt:rule pattern="d7e1145">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:body/html:section[tokenize(@epub:type, '\s+') = 'titlepage']/html:h1" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:body/html:section[tokenize(@epub:type, '\s+') = 'titlepage']/html:h1</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e1145">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:body/html:section[tokenize(@epub:type, '\s+') = 'titlepage']/html:h1</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(tokenize(@epub:type, '\s+') = 'fulltitle')">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">tokenize(@epub:type, '\s+') = 'fulltitle'</xsl:attribute>
                     <svrl:text>[nordic247] The first (h1) heading on the titlepage must have the 'fulltitle' epub:type.</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e1145')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:span[tokenize(@class, '\s+') = 'lic']" priority="29" mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e1162']">
            <schxslt:rule pattern="d7e1162">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:span[tokenize(@class, '\s+') = 'lic']" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:span[tokenize(@class, '\s+') = 'lic']</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e1162">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:span[tokenize(@class, '\s+') = 'lic']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(parent::html:li or parent::html:a/parent::html:li)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">parent::html:li or parent::html:a/parent::html:li</xsl:attribute>
                     <svrl:text>[nordic251] The parent of a list item component (span class="lic") must be either a "li" or a "a" (where the "a" has "li" as parent). <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e1162')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:figure" priority="28" mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e1180']">
            <schxslt:rule pattern="d7e1180">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:figure" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:figure</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e1180">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:figure</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(tokenize(@class, '\s+') = ('image', 'image-series', 'table'))">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">tokenize(@class, '\s+') = ('image', 'image-series', 'table')</xsl:attribute>
                     <svrl:text>[nordic253a] &lt;figure&gt; elements must either have a class of "image", "image-series" or "table". <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
               <xsl:if test="count((.[tokenize(@class, '\s+') = 'image'], .[tokenize(@class, '\s+') = 'image-series'], .[tokenize(@class, '\s+') = 'table'])) &gt; 1">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count((.[tokenize(@class, '\s+') = 'image'], .[tokenize(@class, '\s+') = 'image-series'], .[tokenize(@class, '\s+') = 'table'])) &gt; 1</xsl:attribute>
                     <svrl:text>[nordic253a] &lt;figure&gt; elements must either have a class of "image", "image-series" or "table". <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
               <xsl:if test="not(count(html:figcaption) &lt;= 1)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count(html:figcaption) &lt;= 1</xsl:attribute>
                     <svrl:text>[nordic253a] There cannot be more than one &lt;figcaption&gt; in a single figure element. <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e1180')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:figure[tokenize(@class, '\s+') = 'image']" priority="27"
                 mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e1208']">
            <schxslt:rule pattern="d7e1208">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:figure[tokenize(@class, '\s+') = 'image']" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:figure[tokenize(@class, '\s+') = 'image']</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e1208">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:figure[tokenize(@class, '\s+') = 'image']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(count(.//html:img) = 1)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count(.//html:img) = 1</xsl:attribute>
                     <svrl:text>[nordic253b] Image figures must contain exactly one img. <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
               <xsl:if test="not(count(html:img) = 1)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count(html:img) = 1</xsl:attribute>
                     <svrl:text>[nordic253b] The img in image figures must be a direct child of the figure. <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e1208')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:figure[tokenize(@class, '\s+') = 'image-series']" priority="26"
                 mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e1229']">
            <schxslt:rule pattern="d7e1229">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:figure[tokenize(@class, '\s+') = 'image-series']" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:figure[tokenize(@class, '\s+') = 'image-series']</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e1229">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:figure[tokenize(@class, '\s+') = 'image-series']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(count(html:img) = 0)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count(html:img) = 0</xsl:attribute>
                     <svrl:text>[nordic253c] Image series figures cannot contain img childen (the img elements must be contained in children figure elements). <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
               <xsl:if test="not(count(html:figure[tokenize(@class, '\s+') = 'image']) &gt;= 2)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count(html:figure[tokenize(@class, '\s+') = 'image']) &gt;= 2</xsl:attribute>
                     <svrl:text>[nordic253c] Image series must contain at least 2 image figures ("figure" elements with class "image"). <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e1229')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:figure[tokenize(@class, '\s+') = 'image']" priority="25"
                 mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="figdesc-id"
                    select=".//html:aside[tokenize(@class, '\s+') = 'fig-desc']/@id"/>
      <xsl:variable name="aria-id" select=".//html:img/@aria-describedby"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e1250']">
            <schxslt:rule pattern="d7e1250">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:figure[tokenize(@class, '\s+') = 'image']" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:figure[tokenize(@class, '\s+') = 'image']</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e1250">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:figure[tokenize(@class, '\s+') = 'image']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(count(.//html:aside[tokenize(@class, '\s+') = 'fig-desc']) = 0 or $figdesc-id = $aria-id)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count(.//html:aside[tokenize(@class, '\s+') = 'fig-desc']) = 0 or $figdesc-id = $aria-id</xsl:attribute>
                     <svrl:text>
                [nordic253d] Images must reference the extracted text. <xsl:value-of select="$figdesc-id"/> != <xsl:value-of select="$aria-id"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e1250')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:section[ancestor-or-self::*/tokenize(@epub:type, '\s+') = 'bodymatter' and count(* except (html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6 | *[tokenize(@epub:type, '\s+') = 'pagebreak'])) = 0]"
                 priority="24"
                 mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e1274']">
            <schxslt:rule pattern="d7e1274">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:section[ancestor-or-self::*/tokenize(@epub:type, '\s+') = 'bodymatter' and count(* except (html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6 | *[tokenize(@epub:type, '\s+') = 'pagebreak'])) = 0]" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:section[ancestor-or-self::*/tokenize(@epub:type, '\s+') = 'bodymatter' and count(* except (html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6 | *[tokenize(@epub:type, '\s+') = 'pagebreak'])) = 0]</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e1274">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:section[ancestor-or-self::*/tokenize(@epub:type, '\s+') = 'bodymatter' and count(* except (html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6 | *[tokenize(@epub:type, '\s+') = 'pagebreak'])) = 0]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(tokenize(@epub:type, '\s+') = 'part')">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">tokenize(@epub:type, '\s+') = 'part'</xsl:attribute>
                     <svrl:text>[nordic256] Sections in bodymatter must contain more than just headings and pagebreaks, except for when epub:type="part". <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e1274')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="*[@xml:lang or @lang]" priority="23" mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e1292']">
            <schxslt:rule pattern="d7e1292">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "*[@xml:lang or @lang]" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">*[@xml:lang or @lang]</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e1292">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">*[@xml:lang or @lang]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(@xml:lang = @lang)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">@xml:lang = @lang</xsl:attribute>
                     <svrl:text>[nordic257] The `xml:lang` and the `lang` attributes must have the same value. <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e1292')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:div[../html:body and tokenize(@epub:type, '\s') = 'pagebreak']"
                 priority="22"
                 mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e1310']">
            <schxslt:rule pattern="d7e1310">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:div[../html:body and tokenize(@epub:type, '\s') = 'pagebreak']" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:div[../html:body and tokenize(@epub:type, '\s') = 'pagebreak']</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e1310">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:div[../html:body and tokenize(@epub:type, '\s') = 'pagebreak']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="preceding-sibling::html:div[tokenize(@epub:type, '\s') = 'pagebreak']">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">preceding-sibling::html:div[tokenize(@epub:type, '\s') = 'pagebreak']</xsl:attribute>
                     <svrl:text>[nordic258] Only one pagebreak is allowed before any content in each content file. <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e1310')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:*[tokenize(@epub:type, '\s+') = 'pagebreak']" priority="21"
                 mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e1328']">
            <schxslt:rule pattern="d7e1328">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:*[tokenize(@epub:type, '\s+') = 'pagebreak']" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type, '\s+') = 'pagebreak']</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e1328">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type, '\s+') = 'pagebreak']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="ancestor::html:thead">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">ancestor::html:thead</xsl:attribute>
                     <svrl:text>[nordic259] Pagebreaks can not occur within table headers (thead). <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
               <xsl:if test="ancestor::html:tfoot">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">ancestor::html:tfoot</xsl:attribute>
                     <svrl:text>[nordic259] Pagebreaks can not occur within table footers (tfoot). <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e1328')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:figure[tokenize(@class, '\s+') = 'image-series']/html:*[not(self::html:figure[tokenize(@class, '\s+') = 'image'] | self::html:details)]"
                 priority="20"
                 mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e1350']">
            <schxslt:rule pattern="d7e1350">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:figure[tokenize(@class, '\s+') = 'image-series']/html:*[not(self::html:figure[tokenize(@class, '\s+') = 'image'] | self::html:details)]" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:figure[tokenize(@class, '\s+') = 'image-series']/html:*[not(self::html:figure[tokenize(@class, '\s+') = 'image'] | self::html:details)]</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e1350">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:figure[tokenize(@class, '\s+') = 'image-series']/html:*[not(self::html:figure[tokenize(@class, '\s+') = 'image'] | self::html:details)]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="preceding-sibling::html:figure[tokenize(@class, '\s+') = 'image']">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">preceding-sibling::html:figure[tokenize(@class, '\s+') = 'image']</xsl:attribute>
                     <svrl:text>[nordic260b] Content is not allowed between or after image figure elements. <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e1350')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:div[not(tokenize(@epub:type, '\s+') = 'pagebreak')]" priority="19"
                 mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e1367']">
            <schxslt:rule pattern="d7e1367">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:div[not(tokenize(@epub:type, '\s+') = 'pagebreak')]" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:div[not(tokenize(@epub:type, '\s+') = 'pagebreak')]</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e1367">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:div[not(tokenize(@epub:type, '\s+') = 'pagebreak')]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="text()[normalize-space(.)]">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">text()[normalize-space(.)]</xsl:attribute>
                     <svrl:text>[nordic261] Text can't be placed directly inside div elements. Try wrapping it in a p element. <xsl:value-of select="concat('(', normalize-space(string-join(text(), ' ')), ')')"/> 
                        <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e1367')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:body[tokenize(@epub:type, '\s+') = 'titlepage'] | html:section[tokenize(@epub:type, '\s+') = 'titlepage']"
                 priority="18"
                 mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e1388']">
            <schxslt:rule pattern="d7e1388">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:body[tokenize(@epub:type, '\s+') = 'titlepage'] | html:section[tokenize(@epub:type, '\s+') = 'titlepage']" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:body[tokenize(@epub:type, '\s+') = 'titlepage'] | html:section[tokenize(@epub:type, '\s+') = 'titlepage']</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e1388">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:body[tokenize(@epub:type, '\s+') = 'titlepage'] | html:section[tokenize(@epub:type, '\s+') = 'titlepage']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(count(html:*[matches(local-name(), 'h\d')]))">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count(html:*[matches(local-name(), 'h\d')])</xsl:attribute>
                     <svrl:text>[nordic263] the titlepage must have a heading (and the heading must have epub:type="fulltitle" and class="title").</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e1388')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:body[tokenize(@epub:type, '\s+') = 'titlepage']/html:*[matches(local-name(), 'h\d')] | html:section[tokenize(@epub:type, '\s+') = 'titlepage']/html:*[matches(local-name(), 'h\d')]"
                 priority="17"
                 mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e1405']">
            <schxslt:rule pattern="d7e1405">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:body[tokenize(@epub:type, '\s+') = 'titlepage']/html:*[matches(local-name(), 'h\d')] | html:section[tokenize(@epub:type, '\s+') = 'titlepage']/html:*[matches(local-name(), 'h\d')]" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:body[tokenize(@epub:type, '\s+') = 'titlepage']/html:*[matches(local-name(), 'h\d')] | html:section[tokenize(@epub:type, '\s+') = 'titlepage']/html:*[matches(local-name(), 'h\d')]</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e1405">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:body[tokenize(@epub:type, '\s+') = 'titlepage']/html:*[matches(local-name(), 'h\d')] | html:section[tokenize(@epub:type, '\s+') = 'titlepage']/html:*[matches(local-name(), 'h\d')]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(tokenize(@epub:type, '\s+') = 'fulltitle')">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">tokenize(@epub:type, '\s+') = 'fulltitle'</xsl:attribute>
                     <svrl:text>[nordic264] the heading on the titlepage must have a epub:type with the value "fulltitle". <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
               <xsl:if test="not(tokenize(@class, '\s+') = 'title')">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">tokenize(@class, '\s+') = 'title'</xsl:attribute>
                     <svrl:text>[nordic264] the heading on the titlepage must have a class with the value "title". <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e1405')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:*[*[tokenize(@epub:type, '\s+') = 'endnote']]" priority="16"
                 mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e1427']">
            <schxslt:rule pattern="d7e1427">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:*[*[tokenize(@epub:type, '\s+') = 'endnote']]" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[*[tokenize(@epub:type, '\s+') = 'endnote']]</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e1427">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[*[tokenize(@epub:type, '\s+') = 'endnote']]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(self::html:ol)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">self::html:ol</xsl:attribute>
                     <svrl:text>[nordic267a] Endnotes must be wrapped in a "ol" element, but is currently wrapped in a <xsl:value-of select="name()"/>. <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e1427')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:section[tokenize(@epub:type, '\s+') = 'endnotes']/html:ol/html:li | html:body[tokenize(@epub:type, '\s+') = 'endnotes']/html:ol/html:li"
                 priority="15"
                 mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e1446']">
            <schxslt:rule pattern="d7e1446">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:section[tokenize(@epub:type, '\s+') = 'endnotes']/html:ol/html:li | html:body[tokenize(@epub:type, '\s+') = 'endnotes']/html:ol/html:li" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:section[tokenize(@epub:type, '\s+') = 'endnotes']/html:ol/html:li | html:body[tokenize(@epub:type, '\s+') = 'endnotes']/html:ol/html:li</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e1446">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:section[tokenize(@epub:type, '\s+') = 'endnotes']/html:ol/html:li | html:body[tokenize(@epub:type, '\s+') = 'endnotes']/html:ol/html:li</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(tokenize(@epub:type, '\s+') = 'endnote')">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">tokenize(@epub:type, '\s+') = 'endnote'</xsl:attribute>
                     <svrl:text>[nordic267b] List items inside a endnotes list must use epub:type="endnote". <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e1446')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6" priority="14"
                 mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:variable name="sectioning-element"
                    select="ancestor::*[self::html:section or self::html:article or self::html:aside or self::html:nav or self::html:body][1]"/>
      <xsl:variable name="this-level"
                    select="                     xs:integer(replace(name(), '.*(\d)$', '$1')) + (if (ancestor::html:header[parent::html:body]) then                         -1                     else                         0)"/>
      <xsl:variable name="child-sectioning-elements"
                    select="$sectioning-element//*[self::html:section or self::html:article or self::html:aside or self::html:nav or self::html:figure][ancestor::*[self::html:section or self::html:article or self::html:aside or self::html:nav or self::html:body][1] intersect $sectioning-element]"/>
      <xsl:variable name="child-sectioning-element-with-wrong-level"
                    select="$child-sectioning-elements[count(html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6) != 0 and (html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6)/xs:integer(replace(name(), '.*(\d)$', '$1')) != min((6, $this-level + 1))][1]"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e1463']">
            <schxslt:rule pattern="d7e1463">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e1463">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(count($child-sectioning-element-with-wrong-level) = 0)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count($child-sectioning-element-with-wrong-level) = 0</xsl:attribute>
                     <svrl:text>[nordic268] The subsections of <xsl:value-of select="                     concat('&lt;', $sectioning-element/name(), string-join(for $a in ($sectioning-element/@*)                     return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;')"/> (which contains the heading <xsl:value-of select="$context"/>
                        <xsl:value-of select="string-join(.//text(), ' ')"/>&lt;/<xsl:value-of select="name()"/>&gt;) must only use &lt;h<xsl:value-of select="min((6, $this-level + 1))"/>&gt; for headings. It contains the element <xsl:value-of select="                     concat('&lt;', $child-sectioning-element-with-wrong-level/name(), string-join(for $a in ($child-sectioning-element-with-wrong-level/@*)                     return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;')"/> which contains the heading <xsl:value-of select="                     concat('&lt;', $child-sectioning-element-with-wrong-level/(html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6)[1]/name(), string-join(for $a in ($child-sectioning-element-with-wrong-level/(html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6)[1]/@*)                     return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;', string-join($child-sectioning-element-with-wrong-level/(html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6)[1]//text(), ' '), '&lt;/', $child-sectioning-element-with-wrong-level/(html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6)[1]/name(), '&gt;')"/> .</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e1463')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:body/html:section" priority="13" mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:variable name="filename-regex"
                    select="'^.*/[A-Za-z0-9_-]+-\d+-([a-z-]+)(-\d+)?\.xhtml$'"/>
      <xsl:variable name="base-uri-type"
                    select="                     if (matches(base-uri(.), $filename-regex)) then                         replace(base-uri(.), $filename-regex, '$1')                     else                         ()"/>
      <xsl:variable name="document-partitions"
                    select="('cover', 'frontmatter', 'bodymatter', 'backmatter')"/>
      <xsl:variable name="document-divisions" select="('volume', 'part', 'chapter', 'division')"/>
      <xsl:variable name="values"
                    select="(                 for $t in tokenize(@role, '\s+') return tokenize(replace($t, '^doc-', ''), ':'),                 for $t in tokenize(@epub:type, '\s+') return if ($t = ($document-partitions, $document-divisions)) then () else tokenize($t, ':'),                 for $t in tokenize(@epub:type, '\s+') return if ($t = $document-divisions) then $t else (),                 for $t in tokenize(@epub:type, '\s+') return if ($t = $document-partitions) then $t else ()             )"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e1503']">
            <schxslt:rule pattern="d7e1503">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:body/html:section" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:body/html:section</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e1503">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:body/html:section</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(                 not(matches(base-uri(.), $filename-regex))                 or $values[1] = $base-uri-type)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">                 not(matches(base-uri(.), $filename-regex))                 or $values[1] = $base-uri-type</xsl:attribute>
                     <svrl:text>[nordic269] The type used in the filename (<xsl:value-of select="$base-uri-type"/>) must be present on the section element, and be the most specific (<xsl:value-of select="$values[1]"/>). <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e1503')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:p[tokenize(@epub:type, '\t+') = 'bridgehead']" priority="12"
                 mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e1536']">
            <schxslt:rule pattern="d7e1536">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:p[tokenize(@epub:type, '\t+') = 'bridgehead']" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:p[tokenize(@epub:type, '\t+') = 'bridgehead']</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e1536">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:p[tokenize(@epub:type, '\t+') = 'bridgehead']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(parent::html:section | parent::html:article | parent::html:div | parent::html:aside)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">parent::html:section | parent::html:article | parent::html:div | parent::html:aside</xsl:attribute>
                     <svrl:text>[nordic270] Bridgehead is only allowed as a child of section, article, div and aside. <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e1536')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:a[starts-with(@href, '#')]" priority="11" mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e1555']">
            <schxslt:rule pattern="d7e1555">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:a[starts-with(@href, '#')]" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:a[starts-with(@href, '#')]</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e1555">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:a[starts-with(@href, '#')]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(count(//html:*[@id = substring(current()/@href, 2)]) = 1)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count(//html:*[@id = substring(current()/@href, 2)]) = 1</xsl:attribute>
                     <svrl:text>[nordic273] Internal link <xsl:value-of select="concat('(&#34;', @href, '&#34;)')"/> does not resolve. <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e1555')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:a[not(matches(@href, '^([a-z]+:/+|mailto:|tel:)'))]" priority="10"
                 mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e1574']">
            <schxslt:rule pattern="d7e1574">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:a[not(matches(@href, '^([a-z]+:/+|mailto:|tel:)'))]" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:a[not(matches(@href, '^([a-z]+:/+|mailto:|tel:)'))]</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e1574">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:a[not(matches(@href, '^([a-z]+:/+|mailto:|tel:)'))]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(matches(@href, '.*#.+'))">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">matches(@href, '.*#.+')</xsl:attribute>
                     <svrl:text>[nordic273b] Internal links must contain a non-empty fragment identifier. <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e1574')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:ul | html:ol[matches(@style, 'list-style-type:\s*none;')]"
                 priority="9"
                 mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e1594']">
            <schxslt:rule pattern="d7e1594">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:ul | html:ol[matches(@style, 'list-style-type:\s*none;')]" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:ul | html:ol[matches(@style, 'list-style-type:\s*none;')]</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e1594">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:ul | html:ol[matches(@style, 'list-style-type:\s*none;')]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="@start">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">@start</xsl:attribute>
                     <svrl:text>[nordic279a] The start attribute must not be used in lists without markers (numbers/letters). <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e1594')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:ol[@start]" priority="8" mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e1612']">
            <schxslt:rule pattern="d7e1612">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:ol[@start]" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:ol[@start]</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e1612">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:ol[@start]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="@start = '' or string-length(translate(@start, '0123456789', '')) != 0">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">@start = '' or string-length(translate(@start, '0123456789', '')) != 0</xsl:attribute>
                     <svrl:text>[nordic279b] The start attribute must be a positive integer. <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e1612')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:meta" priority="7" mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e1631']">
            <schxslt:rule pattern="d7e1631">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:meta" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:meta</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e1631">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:meta</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="starts-with(@name, 'dc:') and not(@name = 'dc:title' or @name = 'dc:subject' or @name = 'dc:description' or @name = 'dc:type' or @name = 'dc:source' or @name = 'dc:relation' or @name = 'dc:coverage' or @name = 'dc:creator' or @name = 'dc:publisher' or @name = 'dc:publisher.original' or @name = 'dc:contributor' or @name = 'dc:rights' or @name = 'dc:date' or @name = 'dc:format' or @name = 'dc:identifier' or @name = 'dc:language')">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">starts-with(@name, 'dc:') and not(@name = 'dc:title' or @name = 'dc:subject' or @name = 'dc:description' or @name = 'dc:type' or @name = 'dc:source' or @name = 'dc:relation' or @name = 'dc:coverage' or @name = 'dc:creator' or @name = 'dc:publisher' or @name = 'dc:publisher.original' or @name = 'dc:contributor' or @name = 'dc:rights' or @name = 'dc:date' or @name = 'dc:format' or @name = 'dc:identifier' or @name = 'dc:language')</xsl:attribute>
                     <svrl:text>[nordic280] Metadata with the dc prefix are only allowed for the 15 official Dublin Core metadata elements: dc:title, dc:subject, dc:description, dc:type, dc:source, dc:relation, dc:coverage, dc:creator, dc:publisher, dc:publisher.original, dc:contributor, dc:rights, dc:date, dc:format, dc:identifier and dc:language. <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
               <xsl:if test="starts-with(@name, 'DC:') or starts-with(@name, 'Dc:') or starts-with(@name, 'dC:')">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">starts-with(@name, 'DC:') or starts-with(@name, 'Dc:') or starts-with(@name, 'dC:')</xsl:attribute>
                     <svrl:text>[nordic280] The dc metadata prefix must be in lower case. <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e1631')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:col | html:colgroup" priority="6" mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e1654']">
            <schxslt:rule pattern="d7e1654">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:col | html:colgroup" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:col | html:colgroup</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e1654">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:col | html:colgroup</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="@span and (translate(@span, '0123456789', '') != '' or starts-with(@span, '0'))">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">@span and (translate(@span, '0123456789', '') != '' or starts-with(@span, '0'))</xsl:attribute>
                     <svrl:text>[nordic281] The span attribute on col and colgroup elements must be a positive integer. <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e1654')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:td | html:th" priority="5" mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e1674']">
            <schxslt:rule pattern="d7e1674">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:td | html:th" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:td | html:th</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e1674">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:td | html:th</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="@rowspan and (translate(@rowspan, '0123456789', '') != '' or starts-with(@rowspan, '0'))">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">@rowspan and (translate(@rowspan, '0123456789', '') != '' or starts-with(@rowspan, '0'))</xsl:attribute>
                     <svrl:text>[nordic282] The rowspan attribute value on td and th elements must be a positive integer. <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
               <xsl:if test="@colspan and (translate(@colspan, '0123456789', '') != '' or starts-with(@colspan, '0'))">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">@colspan and (translate(@colspan, '0123456789', '') != '' or starts-with(@colspan, '0'))</xsl:attribute>
                     <svrl:text>[nordic282] The colspan attribute value on td and th elements must be a positive integer. <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
               <xsl:if test="@rowspan and number(@rowspan) &gt; count(parent::html:tr/following-sibling::html:tr | parent::html:tr/(parent::html:thead | parent::tbody | parent::tfoot)/following-sibling::html:*/html:tr) + 1">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">@rowspan and number(@rowspan) &gt; count(parent::html:tr/following-sibling::html:tr | parent::html:tr/(parent::html:thead | parent::tbody | parent::tfoot)/following-sibling::html:*/html:tr) + 1</xsl:attribute>
                     <svrl:text>[nordic282] The rowspan attribute value on td and th elements must not be larger than the number of rows left in the table. <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e1674')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="m:*[contains(name(), ':')]" priority="4" mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e1699']">
            <schxslt:rule pattern="d7e1699">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "m:*[contains(name(), ':')]" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">m:*[contains(name(), ':')]</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e1699">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">m:*[contains(name(), ':')]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(substring-before(name(), ':') = 'm')">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">substring-before(name(), ':') = 'm'</xsl:attribute>
                     <svrl:text>[nordic283] When using MathML with a namespace prefix, that prefix must be 'm'. <xsl:value-of select="concat('Not ', substring-before(name(), ':'), '.')"/> 
                        <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e1699')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="*" priority="3" mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e1718']">
            <schxslt:rule pattern="d7e1718">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "*" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">*</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e1718">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">*</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(not(tokenize(@epub:type, '\s+') = ('rearnote', 'rearnotes')))">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">not(tokenize(@epub:type, '\s+') = ('rearnote', 'rearnotes'))</xsl:attribute>
                     <svrl:text>[nordic290] Rearnotes are deprecated. Endnotes are required to be used instead. <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e1718')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:section[tokenize(@epub:type, '\s+') = 'backmatter' and @role]"
                 priority="2"
                 mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e1736']">
            <schxslt:rule pattern="d7e1736">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:section[tokenize(@epub:type, '\s+') = 'backmatter' and @role]" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:section[tokenize(@epub:type, '\s+') = 'backmatter' and @role]</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e1736">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:section[tokenize(@epub:type, '\s+') = 'backmatter' and @role]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(tokenize(@role, '\s+') = ('doc-acknowledgments', 'doc-afterword', 'doc-appendix', 'doc-bibliography', 'doc-colophon', 'doc-conclusion', 'doc-dedication', 'doc-endnotes', 'doc-epigraph', 'doc-epilogue', 'doc-glossary', 'doc-index', 'doc-toc'))">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">tokenize(@role, '\s+') = ('doc-acknowledgments', 'doc-afterword', 'doc-appendix', 'doc-bibliography', 'doc-colophon', 'doc-conclusion', 'doc-dedication', 'doc-endnotes', 'doc-epigraph', 'doc-epilogue', 'doc-glossary', 'doc-index', 'doc-toc')</xsl:attribute>
                     <svrl:text>
                [nordic291] Backmatter can only use roles (doc-acknowledgments, doc-afterword, doc-appendix, doc-bibliography, doc-colophon, doc-conclusion, doc-dedication, doc-epigraph, doc-epilogue, doc-glossary, doc-index, doc-toc) <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e1736')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:aside" priority="1" mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e1755']">
            <schxslt:rule pattern="d7e1755">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:aside" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:aside</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e1755">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:aside</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="tokenize(@class, '\s+') = 'sidebar'">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">tokenize(@class, '\s+') = 'sidebar'</xsl:attribute>
                     <svrl:text>[nordic292] The aside attribute class is set to sidebar which is deprecated. <xsl:value-of select="$context"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e1755')"/>
            </xsl:next-match>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="html:details[preceding-sibling::*[1]/tokenize(@class, '\s+') = 'image']"
                 priority="0"
                 mode="d7e21">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <xsl:choose>
         <xsl:when test="$schxslt:patterns-matched[. = 'd7e1773']">
            <schxslt:rule pattern="d7e1773">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:details[preceding-sibling::*[1]/tokenize(@class, '\s+') = 'image']" shadowed by preceding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:details[preceding-sibling::*[1]/tokenize(@class, '\s+') = 'image']</xsl:attribute>
               </svrl:suppressed-rule>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="$schxslt:patterns-matched"/>
            </xsl:next-match>
         </xsl:when>
         <xsl:otherwise>
            <schxslt:rule pattern="d7e1773">
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:details[preceding-sibling::*[1]/tokenize(@class, '\s+') = 'image']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(preceding-sibling::*[1]/html:img/@aria-details = @id)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">preceding-sibling::*[1]/html:img/@aria-details = @id</xsl:attribute>
                     <svrl:text>The img element must correctly reference the details element with the aria-details attribute. <xsl:value-of select="concat(string(preceding-sibling::*[1]/html:img/@aria-details), ' != ', @id)"/> 
                        <xsl:value-of select="concat(' ', $context)"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </schxslt:rule>
            <xsl:next-match>
               <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                               select="($schxslt:patterns-matched, 'd7e1773')"/>
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