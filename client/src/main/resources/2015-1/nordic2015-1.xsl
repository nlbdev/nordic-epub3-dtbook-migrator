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
            <skos:prefLabel>SchXslt/1.6.2 SAXON/9.2.0.6</skos:prefLabel>
            <schxslt.compile.typed-variables xmlns="https://doi.org/10.5281/zenodo.1495494#">true</schxslt.compile.typed-variables>
         </dct:Agent>
      </dct:creator>
      <dct:created>2022-10-18T12:59:45.199+02:00</dct:created>
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
               <rdf:Description xmlns:dc="http://purl.org/dc/elements/1.1/">
                  <dct:creator>
                     <dct:Agent>
                        <skos:prefLabel>SchXslt/1.6.2 SAXON/9.2.0.6</skos:prefLabel>
                        <schxslt.compile.typed-variables xmlns="https://doi.org/10.5281/zenodo.1495494#">true</schxslt.compile.typed-variables>
                     </dct:Agent>
                  </dct:creator>
                  <dct:created>2022-10-18T12:59:45.199+02:00</dct:created>
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
                              title="Nordic EPUB3 and HTML5 rules (based on MTMs DTBook schematron rules, targeting nordic guidelines 2015-1)">
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
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_7">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e42">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_8">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e54">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_9">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e66">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_10">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e96">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_11">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e107">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_12">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e118">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_13_a">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e135">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_13_b">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e145">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_13_c">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e154">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_13_d">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e165">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_14">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e175">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_15">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e201">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_20">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e214">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_21">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e227">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_23">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e245">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_24">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e258">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_26_a">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e272">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_26_b">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e289">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_27_a">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e303">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_27_b">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e319">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_29a">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e337">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_29b">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e362">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_29c">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e374">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_40">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e392">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_50_a">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e404">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_5152">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e427">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_59">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e440">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_63">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e452">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_64">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e463">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_93">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e482">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_96_a">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e498">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_96_b">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e511">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_101">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e523">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_102">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e540">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_104">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e553">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_105">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e571">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_110">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e584">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_116">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e596">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_120">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e609">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_121">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e622">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_123">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e634">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_124">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e648">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_125">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e665">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_126">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e677">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_127">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e693">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_128_a">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e739">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_128_b">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e749">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_128_c">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e758">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_128_d">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e769">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_130">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e780">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_131">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e794">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_135_a">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e812">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_140">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e839">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_142">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e852">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_143_a">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e862">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_143_b">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e874">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_200">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e885">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_201">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e897">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_202">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e920">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_203_a">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e941">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_203_c">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e970">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_203_d">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e998">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_204_a">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e1010">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_204_c">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e1026">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_204_d">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e1042">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_208">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e1064">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_211">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e1087">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_215">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e1110">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_224">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e1123">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_225">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e1135">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_247">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e1146">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_248">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e1160">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_251">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e1172">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_253_a">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e1190">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_253_b">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e1204">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_253_c">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e1221">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_254">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e1234">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_255">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e1246">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_256">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e1261">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_257">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e1273">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_258">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e1285">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_259">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e1302">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_260_a">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e1312">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_260_b">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e1324">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_261">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e1336">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_263">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e1348">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_264">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e1362">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_265">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e1376">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_266_a">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e1388">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_266_b">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e1398">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_267_a">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e1419">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_267_b">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e1439">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_268">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e1470">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_269">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e1486">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_270">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e1500">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_273">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e1515">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_273b">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e1527">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_274">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e1539">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_275">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e1552">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_276">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e1570">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_277">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e1586">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_278">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e1607">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_279a">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e1617">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_279b">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e1629">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_280">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e1645">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_281">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e1658">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_282">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e1676">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_283">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
      <schxslt:pattern id="d7e1686">
         <xsl:if test="exists(base-uri(/))">
            <xsl:attribute name="documents" select="base-uri(/)"/>
         </xsl:if>
         <xsl:for-each select="/">
            <svrl:active-pattern xmlns:svrl="http://purl.oclc.org/dsdl/svrl" id="epub_nordic_293">
               <xsl:attribute name="documents" select="base-uri(.)"/>
            </svrl:active-pattern>
         </xsl:for-each>
      </schxslt:pattern>
      <xsl:apply-templates mode="d7e23" select="/"/>
   </xsl:template>
   <xsl:template match="html:p" priority="114" mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e23">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e23']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:p" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:p</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:p</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="html:ul | html:ol">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">html:ul | html:ol</xsl:attribute>
                     <svrl:text>[nordic07] Lists (<xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>) are
                not allowed inside paragraphs.</svrl:text>
                  </svrl:successful-report>
               </xsl:if>
               <xsl:if test="html:dl">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">html:dl</xsl:attribute>
                     <svrl:text>[nordic07] Definition lists (<xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>) are
                not allowed inside paragraphs.</svrl:text>
                  </svrl:successful-report>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e23')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:*[tokenize(@epub:type,'\s+')='pagebreak' and tokenize(@class,'\s+')='page-front']"
                 priority="113"
                 mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e42">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e42']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:*[tokenize(@epub:type,'\s+')='pagebreak' and tokenize(@class,'\s+')='page-front']" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type,'\s+')='pagebreak' and tokenize(@class,'\s+')='page-front']</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type,'\s+')='pagebreak' and tokenize(@class,'\s+')='page-front']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(ancestor::html:*[self::html:section or self::html:article or self::html:body]/tokenize(@epub:type,'\s+') = ('frontmatter','cover'))">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">ancestor::html:*[self::html:section or self::html:article or self::html:body]/tokenize(@epub:type,'\s+') = ('frontmatter','cover')</xsl:attribute>
                     <svrl:text>[nordic08] &lt;span epub:type="pagebreak"
                class="page-front"/&gt; may only occur in frontmatter and cover. <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e42')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:*" priority="112" mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e54">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e54']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:*" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="normalize-space(.)='' and not(*) and not(self::html:img or self::html:br or self::html:meta or self::html:link or self::html:col or self::html:th or self::html:td or self::html:dd or self::html:*[tokenize(@epub:type,'\s+')='pagebreak'] or self::html:hr or self::html:script)">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">normalize-space(.)='' and not(*) and not(self::html:img or self::html:br or self::html:meta or self::html:link or self::html:col or self::html:th or self::html:td or self::html:dd or self::html:*[tokenize(@epub:type,'\s+')='pagebreak'] or self::html:hr or self::html:script)</xsl:attribute>
                     <svrl:text>[nordic09] Element may not be empty: <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e54')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:head[following-sibling::html:body/html:header]" priority="111"
                 mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e66">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e66']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:head[following-sibling::html:body/html:header]" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:head[following-sibling::html:body/html:header]</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:head[following-sibling::html:body/html:header]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(count(html:meta[@name='dc:language'])&gt;=1)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count(html:meta[@name='dc:language'])&gt;=1</xsl:attribute>
                     <svrl:text>[nordic10] Meta dc:language must occur at least once in HTML head</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
               <xsl:if test="not(count(html:meta[@name='dc:date'])=1)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count(html:meta[@name='dc:date'])=1</xsl:attribute>
                     <svrl:text>[nordic10] Meta dc:date=YYYY-MM-DD must occur exactly once in HTML head</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
               <xsl:if test="html:meta[@name='dc:date' and translate(@content, '0123456789', '0000000000')!='0000-00-00']">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">html:meta[@name='dc:date' and translate(@content, '0123456789', '0000000000')!='0000-00-00']</xsl:attribute>
                     <svrl:text>[nordic10] Meta dc:date ("<xsl:value-of select="@content"/>") must have format
                YYYY-MM-DD</svrl:text>
                  </svrl:successful-report>
               </xsl:if>
               <xsl:if test="not(count(html:meta[@name='dc:publisher'])=1)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count(html:meta[@name='dc:publisher'])=1</xsl:attribute>
                     <svrl:text>[nordic10] Meta dc:publisher must occur exactly once</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e66')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:html" priority="110" mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e96">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e96']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:html" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:html</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:html</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(@xml:lang)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">@xml:lang</xsl:attribute>
                     <svrl:text>[nordic11] &lt;html&gt; element must have an xml:lang attribute</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e96')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:body/html:header" priority="109" mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e107">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e107']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:body/html:header" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:body/html:header</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:body/html:header</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(html:*[1][self::html:h1[tokenize(@epub:type,' ')='fulltitle']])">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">html:*[1][self::html:h1[tokenize(@epub:type,' ')='fulltitle']]</xsl:attribute>
                     <svrl:text>[nordic12] Single-HTML document must begin with a fulltitle headline in its header element (xpath:
                /html/body/header/h1).</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e107')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:body[html:header]" priority="108" mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e118">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e118']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:body[html:header]" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:body[html:header]</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:body[html:header]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(((html:section|html:article)/tokenize(@epub:type,'\s+')=('cover','frontmatter')) = true())">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">((html:section|html:article)/tokenize(@epub:type,'\s+')=('cover','frontmatter')) = true()</xsl:attribute>
                     <svrl:text>[nordic13a] A single-HTML document must have at least one frontmatter or cover
                section</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
               <xsl:if test="not(((html:section|html:article)/tokenize(@epub:type,'\s+')='bodymatter') = true())">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">((html:section|html:article)/tokenize(@epub:type,'\s+')='bodymatter') = true()</xsl:attribute>
                     <svrl:text>[nordic13a] A single-HTML document must have at least one bodymatter section</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
               <xsl:if test="not(not(tokenize(@epub:type,'\s+')=('cover','frontmatter','bodymatter','backmatter')))">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">not(tokenize(@epub:type,'\s+')=('cover','frontmatter','bodymatter','backmatter'))</xsl:attribute>
                     <svrl:text>[nordic13a] The single-HTML document must not have cover, frontmatter, bodymatter or
                backmatter as epub:type on its body element</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e118')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:*[self::html:section or self::html:article][ancestor::html:body[html:header] and not(parent::html:body) and not(parent::html:section[tokenize(@epub:type,'\s+')='part'])]"
                 priority="107"
                 mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e135">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e135']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:*[self::html:section or self::html:article][ancestor::html:body[html:header] and not(parent::html:body) and not(parent::html:section[tokenize(@epub:type,'\s+')='part'])]" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[self::html:section or self::html:article][ancestor::html:body[html:header] and not(parent::html:body) and not(parent::html:section[tokenize(@epub:type,'\s+')='part'])]</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[self::html:section or self::html:article][ancestor::html:body[html:header] and not(parent::html:body) and not(parent::html:section[tokenize(@epub:type,'\s+')='part'])]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(not((tokenize(@epub:type,'\s+')=('cover','frontmatter','bodymatter','backmatter')) = true()))">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">not((tokenize(@epub:type,'\s+')=('cover','frontmatter','bodymatter','backmatter')) = true())</xsl:attribute>
                     <svrl:text>[nordic13b] The single-HTML document must not have cover, frontmatter,
                bodymatter or backmatter on any of its sectioning elements other than the top-level elements that has body as its parent</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e135')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:body[not(html:header|html:nav)]" priority="106" mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e145">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e145']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:body[not(html:header|html:nav)]" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:body[not(html:header|html:nav)]</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:body[not(html:header|html:nav)]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(tokenize(@epub:type,'\s+')=('cover','frontmatter','bodymatter','backmatter'))">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">tokenize(@epub:type,'\s+')=('cover','frontmatter','bodymatter','backmatter')</xsl:attribute>
                     <svrl:text>[nordic13c] The document must have either cover, frontmatter, bodymatter or backmatter as
                epub:type on its body element.</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e145')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:*[self::html:section or self::html:article][ancestor::html:body[not(html:header|html:nav)]]"
                 priority="105"
                 mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e154">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e154']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:*[self::html:section or self::html:article][ancestor::html:body[not(html:header|html:nav)]]" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[self::html:section or self::html:article][ancestor::html:body[not(html:header|html:nav)]]</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[self::html:section or self::html:article][ancestor::html:body[not(html:header|html:nav)]]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(not((tokenize(@epub:type,'\s+')=('cover','frontmatter','bodymatter','backmatter')) = true()))">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">not((tokenize(@epub:type,'\s+')=('cover','frontmatter','bodymatter','backmatter')) = true())</xsl:attribute>
                     <svrl:text>[nordic13d] The document must not have cover, frontmatter, bodymatter or
                backmatter on any of its sectioning elements (they are only allowed on the body element).</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e154')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:*[self::html:body[not(html:header)] or self::html:section or self::html:article][not(tokenize(@epub:type,'\s+')='cover')][html:section[not(tokenize(@epub:type,'\t+')=('z3998:poem','z3998:verse'))]|html:article]"
                 priority="104"
                 mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e165">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e165']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:*[self::html:body[not(html:header)] or self::html:section or self::html:article][not(tokenize(@epub:type,'\s+')='cover')][html:section[not(tokenize(@epub:type,'\t+')=('z3998:poem','z3998:verse'))]|html:article]" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[self::html:body[not(html:header)] or self::html:section or self::html:article][not(tokenize(@epub:type,'\s+')='cover')][html:section[not(tokenize(@epub:type,'\t+')=('z3998:poem','z3998:verse'))]|html:article]</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[self::html:body[not(html:header)] or self::html:section or self::html:article][not(tokenize(@epub:type,'\s+')='cover')][html:section[not(tokenize(@epub:type,'\t+')=('z3998:poem','z3998:verse'))]|html:article]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6</xsl:attribute>
                     <svrl:text>[nordic14] sectioning element with no headline (h1-h6) when sub-section is present (is only allowed for sectioning
                element with epub:type="cover" or when sub-section is a poem): <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e165')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:body[html:header]/html:*[self::html:section or self::html:article]"
                 priority="103"
                 mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e175">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e175']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:body[html:header]/html:*[self::html:section or self::html:article]" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:body[html:header]/html:*[self::html:section or self::html:article]</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:body[html:header]/html:*[self::html:section or self::html:article]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="tokenize(@epub:type,'\s+')[.='cover'] and preceding-sibling::html:*[self::html:section or self::html:article]">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">tokenize(@epub:type,'\s+')[.='cover'] and preceding-sibling::html:*[self::html:section or self::html:article]</xsl:attribute>
                     <svrl:text>[nordic15] Cover must not be preceded by any other top-level
                sections (<xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>)</svrl:text>
                  </svrl:successful-report>
               </xsl:if>
               <xsl:if test="tokenize(@epub:type,'\s+')[.='frontmatter'] and preceding-sibling::html:*[self::html:section or self::html:article]/tokenize(@epub:type,'\s') = ('bodymatter', 'backmatter')">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">tokenize(@epub:type,'\s+')[.='frontmatter'] and preceding-sibling::html:*[self::html:section or self::html:article]/tokenize(@epub:type,'\s') = ('bodymatter', 'backmatter')</xsl:attribute>
                     <svrl:text>[nordic15] Frontmatter must not be preceded by bodymatter or rearmatter (<xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>)</svrl:text>
                  </svrl:successful-report>
               </xsl:if>
               <xsl:if test="tokenize(@epub:type,'\s+')[.='frontmatter'] and preceding-sibling::html:*[self::html:section or self::html:article]/tokenize(@epub:type,'\s') = ('backmatter')">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">tokenize(@epub:type,'\s+')[.='frontmatter'] and preceding-sibling::html:*[self::html:section or self::html:article]/tokenize(@epub:type,'\s') = ('backmatter')</xsl:attribute>
                     <svrl:text>[nordic15]
                Bodymatter must not be preceded by backmatter (<xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>)</svrl:text>
                  </svrl:successful-report>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e175')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:figure" priority="102" mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e201">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e201']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:figure" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:figure</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:figure</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="ancestor::html:a        or ancestor::html:abbr    or ancestor::html:a[tokenize(@epub:type,' ')='annoref']   or                           ancestor::html:bdo      or ancestor::html:code       or ancestor::html:dfn        or ancestor::html:em        or                           ancestor::html:kbd      or ancestor::html:p[tokenize(@class,' ')='linenum']    or ancestor::html:a[tokenize(@epub:type,' ')='noteref']    or ancestor::html:span[tokenize(@class,' ')='lic']       or                           ancestor::html:q        or ancestor::html:samp       or ancestor::html:span[tokenize(@epub:type,' ')='z3998:sentence']       or ancestor::html:span      or                           ancestor::html:strong   or ancestor::html:sub        or ancestor::html:sup        or ancestor::html:span[tokenize(@epub:type,' ')='z3998:word']         or                           ancestor::html:address  or ancestor::html:*[tokenize(@epub:type,' ')='z3998:author' and not(parent::html:header[parent::html:body])]     or ancestor::html:p[tokenize(@epub:type,' ')='bridgehead'] or ancestor::html:*[tokenize(@class,' ')='byline']    or                           ancestor::html:cite     or ancestor::html:*[tokenize(@epub:type,' ')='covertitle'] or ancestor::html:*[tokenize(@class,' ')='dateline']   or ancestor::html:p[parent::html:header[parent::html:body] and tokenize(@epub:type,' ')='z3998:author'] or                           ancestor::html:h1[tokenize(@epub:type,' ')='fulltitle'] or ancestor::html:dt         or ancestor::html:h1         or ancestor::html:h2        or                           ancestor::html:h3       or ancestor::html:h4         or ancestor::html:h5         or ancestor::html:h6        or                           ancestor::html:p[tokenize(@class,' ')='line']       or ancestor::html:p">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">ancestor::html:a        or ancestor::html:abbr    or ancestor::html:a[tokenize(@epub:type,' ')='annoref']   or                           ancestor::html:bdo      or ancestor::html:code       or ancestor::html:dfn        or ancestor::html:em        or                           ancestor::html:kbd      or ancestor::html:p[tokenize(@class,' ')='linenum']    or ancestor::html:a[tokenize(@epub:type,' ')='noteref']    or ancestor::html:span[tokenize(@class,' ')='lic']       or                           ancestor::html:q        or ancestor::html:samp       or ancestor::html:span[tokenize(@epub:type,' ')='z3998:sentence']       or ancestor::html:span      or                           ancestor::html:strong   or ancestor::html:sub        or ancestor::html:sup        or ancestor::html:span[tokenize(@epub:type,' ')='z3998:word']         or                           ancestor::html:address  or ancestor::html:*[tokenize(@epub:type,' ')='z3998:author' and not(parent::html:header[parent::html:body])]     or ancestor::html:p[tokenize(@epub:type,' ')='bridgehead'] or ancestor::html:*[tokenize(@class,' ')='byline']    or                           ancestor::html:cite     or ancestor::html:*[tokenize(@epub:type,' ')='covertitle'] or ancestor::html:*[tokenize(@class,' ')='dateline']   or ancestor::html:p[parent::html:header[parent::html:body] and tokenize(@epub:type,' ')='z3998:author'] or                           ancestor::html:h1[tokenize(@epub:type,' ')='fulltitle'] or ancestor::html:dt         or ancestor::html:h1         or ancestor::html:h2        or                           ancestor::html:h3       or ancestor::html:h4         or ancestor::html:h5         or ancestor::html:h6        or                           ancestor::html:p[tokenize(@class,' ')='line']       or ancestor::html:p</xsl:attribute>
                     <svrl:text>[nordic20] Image series are not allowed in inline context (<xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>)</svrl:text>
                  </svrl:successful-report>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e201')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:table" priority="101" mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e214">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e214']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:table" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:table</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:table</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="ancestor::html:table">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">ancestor::html:table</xsl:attribute>
                     <svrl:text>[nordic21] Nested tables are not allowed (<xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>)</svrl:text>
                  </svrl:successful-report>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e214')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:*[tokenize(@epub:type,'\s+')='pagebreak' and tokenize(@class,'\s+')='page-normal' and preceding::html:*[tokenize(@epub:type,'\s+')='pagebreak'][tokenize(@class,'\s+')='page-normal']]"
                 priority="100"
                 mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="preceding"
                    select="preceding::html:*[tokenize(@epub:type,'\s+')='pagebreak' and tokenize(@class,'\s+')='page-normal'][1]"/>
      <schxslt:rule pattern="d7e227">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e227']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:*[tokenize(@epub:type,'\s+')='pagebreak' and tokenize(@class,'\s+')='page-normal' and preceding::html:*[tokenize(@epub:type,'\s+')='pagebreak'][tokenize(@class,'\s+')='page-normal']]" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type,'\s+')='pagebreak' and tokenize(@class,'\s+')='page-normal' and preceding::html:*[tokenize(@epub:type,'\s+')='pagebreak'][tokenize(@class,'\s+')='page-normal']]</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type,'\s+')='pagebreak' and tokenize(@class,'\s+')='page-normal' and preceding::html:*[tokenize(@epub:type,'\s+')='pagebreak'][tokenize(@class,'\s+')='page-normal']]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(number(current()/@title) &gt; number($preceding/@title))">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">number(current()/@title) &gt; number($preceding/@title)</xsl:attribute>
                     <svrl:text>[nordic23] pagebreak values must increase for pagebreaks with class="page-normal" (see pagebreak with title="<xsl:value-of select="@title"/>" and compare with pagebreak with title="<xsl:value-of select="$preceding/@title"/>")</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e227')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:*[tokenize(@epub:type,' ')='pagebreak'][tokenize(@class,' ')='page-front']"
                 priority="99"
                 mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e245">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e245']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:*[tokenize(@epub:type,' ')='pagebreak'][tokenize(@class,' ')='page-front']" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type,' ')='pagebreak'][tokenize(@class,' ')='page-front']</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type,' ')='pagebreak'][tokenize(@class,' ')='page-front']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(count(//html:*[tokenize(@epub:type,'\s+')='pagebreak' and tokenize(@class,'\s+')='page-front' and @title=current()/@title])=1)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count(//html:*[tokenize(@epub:type,'\s+')='pagebreak' and tokenize(@class,'\s+')='page-front' and @title=current()/@title])=1</xsl:attribute>
                     <svrl:text>[nordic24] pagebreak values must be unique for
                pagebreaks with class="page-front" (see pagebreak with title="<xsl:value-of select="@title"/>")</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e245')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:*[ancestor::html:body[html:header] and tokenize(@epub:type,'\s+')=('note','rearnote','endnote','footnote')]"
                 priority="98"
                 mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e258">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e258']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:*[ancestor::html:body[html:header] and tokenize(@epub:type,'\s+')=('note','rearnote','endnote','footnote')]" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[ancestor::html:body[html:header] and tokenize(@epub:type,'\s+')=('note','rearnote','endnote','footnote')]</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[ancestor::html:body[html:header] and tokenize(@epub:type,'\s+')=('note','rearnote','endnote','footnote')]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(count(//html:a[tokenize(@epub:type,'\s+')='noteref'][substring-after(@href, '#')=current()/@id])&gt;=1)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count(//html:a[tokenize(@epub:type,'\s+')='noteref'][substring-after(@href, '#')=current()/@id])&gt;=1</xsl:attribute>
                     <svrl:text>[nordic26a] Each note must have at least one &lt;a epub:type="noteref"
                ...&gt; referencing it: <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e258')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:a[ancestor::html:body[html:header] and tokenize(@epub:type,'\s+')='noteref']"
                 priority="97"
                 mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e272">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e272']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:a[ancestor::html:body[html:header] and tokenize(@epub:type,'\s+')='noteref']" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:a[ancestor::html:body[html:header] and tokenize(@epub:type,'\s+')='noteref']</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:a[ancestor::html:body[html:header] and tokenize(@epub:type,'\s+')='noteref']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(count(//html:*[tokenize(@epub:type,'\s+')=('note','rearnote','endnote','footnote') and @id = current()/substring-after(@href,'#')]) &gt;= 1)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count(//html:*[tokenize(@epub:type,'\s+')=('note','rearnote','endnote','footnote') and @id = current()/substring-after(@href,'#')]) &gt;= 1</xsl:attribute>
                     <svrl:text>[nordic26b] The note reference with the
                href "<xsl:value-of select="@href"/>" attribute must resolve to a note, rearnote, endnote or footnote in the publication: <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e272')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:*[ancestor::html:body[html:header] and tokenize(@epub:type,' ')='annotation']"
                 priority="96"
                 mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e289">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e289']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:*[ancestor::html:body[html:header] and tokenize(@epub:type,' ')='annotation']" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[ancestor::html:body[html:header] and tokenize(@epub:type,' ')='annotation']</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[ancestor::html:body[html:header] and tokenize(@epub:type,' ')='annotation']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(count(//html:a[tokenize(@epub:type,' ')='annoref'][substring-after(@href, '#')=current()/@id])&gt;=1)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count(//html:a[tokenize(@epub:type,' ')='annoref'][substring-after(@href, '#')=current()/@id])&gt;=1</xsl:attribute>
                     <svrl:text>[nordic27a] Each annotation must have at least one &lt;a
                epub:type="annoref" ...&gt; referencing it: <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e289')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:a[ancestor::html:body[html:header] and tokenize(@epub:type,'\s+')='annoref']"
                 priority="95"
                 mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e303">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e303']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:a[ancestor::html:body[html:header] and tokenize(@epub:type,'\s+')='annoref']" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:a[ancestor::html:body[html:header] and tokenize(@epub:type,'\s+')='annoref']</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:a[ancestor::html:body[html:header] and tokenize(@epub:type,'\s+')='annoref']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(count(//html:*[tokenize(@epub:type,'\s+')=('annotation') and @id = current()/substring-after(@href,'#')]) &gt;= 1)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count(//html:*[tokenize(@epub:type,'\s+')=('annotation') and @id = current()/substring-after(@href,'#')]) &gt;= 1</xsl:attribute>
                     <svrl:text>[nordic26b] The annotation with the href "<xsl:value-of select="@href"/>" must resolve to a annotation in the publication: <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e303')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:address | html:aside | html:blockquote | html:p | html:caption | html:div | html:dl | html:ul | html:ol | html:figure | html:table | html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6 | html:details | html:summary"
                 priority="94"
                 mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="inline-ancestor"
                    select="ancestor::*[namespace-uri()='http://www.w3.org/1999/xhtml' and local-name()=('a','abbr','bdo','code','dfn','em','kbd','q','samp','span','strong','sub','sup')][1]"/>
      <schxslt:rule pattern="d7e319">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e319']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:address | html:aside | html:blockquote | html:p | html:caption | html:div | html:dl | html:ul | html:ol | html:figure | html:table | html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6 | html:details | html:summary" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:address | html:aside | html:blockquote | html:p | html:caption | html:div | html:dl | html:ul | html:ol | html:figure | html:table | html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6 | html:details | html:summary</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:address | html:aside | html:blockquote | html:p | html:caption | html:div | html:dl | html:ul | html:ol | html:figure | html:table | html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6 | html:details | html:summary</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="count($inline-ancestor)">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count($inline-ancestor)</xsl:attribute>
                     <svrl:text>[nordic29] Block element <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/> used in inline context (inside the inline element
                    <xsl:value-of select="concat('&lt;',$inline-ancestor/name(),string-join(for $a in ($inline-ancestor/@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>)</svrl:text>
                  </svrl:successful-report>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e319')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:address | html:aside | html:blockquote | html:p | html:caption | html:div | html:dl | html:ul | html:ol | html:figure | html:table | html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6 | html:details | html:summary | html:section | html:article"
                 priority="93"
                 mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="inline-sibling-element"
                    select="../*[namespace-uri()='http://www.w3.org/1999/xhtml' and local-name()=('a','abbr','bdo','code','dfn','em','kbd','q','samp','span','strong','sub','sup')][1]"/>
      <xsl:variable name="inline-sibling-text" select="../text()[normalize-space()][1]"/>
      <schxslt:rule pattern="d7e337">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e337']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:address | html:aside | html:blockquote | html:p | html:caption | html:div | html:dl | html:ul | html:ol | html:figure | html:table | html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6 | html:details | html:summary | html:section | html:article" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:address | html:aside | html:blockquote | html:p | html:caption | html:div | html:dl | html:ul | html:ol | html:figure | html:table | html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6 | html:details | html:summary | html:section | html:article</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:address | html:aside | html:blockquote | html:p | html:caption | html:div | html:dl | html:ul | html:ol | html:figure | html:table | html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6 | html:details | html:summary | html:section | html:article</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="count($inline-sibling-element) and not((self::html:ol or self::html:ul) and parent::html:li)">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count($inline-sibling-element) and not((self::html:ol or self::html:ul) and parent::html:li)</xsl:attribute>
                     <svrl:text>[nordic29] Block element <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/> as sibling to inline element <xsl:value-of select="concat('&lt;',$inline-sibling-element/name(),string-join(for $a in ($inline-sibling-element/@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
               <xsl:if test="count($inline-sibling-text) and not((self::html:ol or self::html:ul) and parent::html:li)">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count($inline-sibling-text) and not((self::html:ol or self::html:ul) and parent::html:li)</xsl:attribute>
                     <svrl:text>[nordic29] Block element <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/> as sibling to text content (<xsl:value-of select="if (string-length(normalize-space($inline-sibling-text)) &lt; 100) then normalize-space($inline-sibling-text) else concat(substring(normalize-space($inline-sibling-text),1,100),' (...)')"/>)</svrl:text>
                  </svrl:successful-report>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e337')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:*[tokenize(@epub:type,' ')='z3998:production'][ancestor::html:a        or ancestor::html:abbr    or ancestor::html:a[tokenize(@epub:type,' ')='annoref']   or                                      ancestor::html:bdo      or ancestor::html:code       or ancestor::html:dfn        or ancestor::html:em        or                                      ancestor::html:kbd      or ancestor::html:p[tokenize(@class,' ')='linenum']    or ancestor::html:a[tokenize(@epub:type,' ')='noteref']    or                                      ancestor::html:q        or ancestor::html:samp       or ancestor::html:span[tokenize(@epub:type,' ')='z3998:sentence']       or ancestor::html:span      or                                      ancestor::html:strong   or ancestor::html:sub        or ancestor::html:sup        or ancestor::html:span[tokenize(@epub:type,' ')='z3998:word']         or                                      ancestor::html:address  or ancestor::html:*[tokenize(@epub:type,' ')='z3998:author' and not(parent::html:header[parent::html:body])]     or ancestor::html:p[tokenize(@epub:type,' ')='bridgehead'] or ancestor::html:*[tokenize(@class,' ')='byline']    or                                      ancestor::html:cite     or ancestor::html:*[tokenize(@epub:type,' ')='covertitle'] or ancestor::html:*[tokenize(@class,' ')='dateline']   or ancestor::html:p[parent::html:header[parent::html:body] and tokenize(@epub:type,' ')='z3998:author'] or                                      ancestor::html:h1[tokenize(@epub:type,' ')='fulltitle'] or ancestor::html:dt         or ancestor::html:h1         or ancestor::html:h2        or                                      ancestor::html:h3       or ancestor::html:h4         or ancestor::html:h5         or ancestor::html:h6        or                                      ancestor::html:p[tokenize(@class,' ')='line']       or ancestor::html:p]"
                 priority="92"
                 mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e362">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e362']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:*[tokenize(@epub:type,' ')='z3998:production'][ancestor::html:a or ancestor::html:abbr or ancestor::html:a[tokenize(@epub:type,' ')='annoref'] or ancestor::html:bdo or ancestor::html:code or ancestor::html:dfn or ancestor::html:em or ancestor::html:kbd or ancestor::html:p[tokenize(@class,' ')='linenum'] or ancestor::html:a[tokenize(@epub:type,' ')='noteref'] or ancestor::html:q or ancestor::html:samp or ancestor::html:span[tokenize(@epub:type,' ')='z3998:sentence'] or ancestor::html:span or ancestor::html:strong or ancestor::html:sub or ancestor::html:sup or ancestor::html:span[tokenize(@epub:type,' ')='z3998:word'] or ancestor::html:address or ancestor::html:*[tokenize(@epub:type,' ')='z3998:author' and not(parent::html:header[parent::html:body])] or ancestor::html:p[tokenize(@epub:type,' ')='bridgehead'] or ancestor::html:*[tokenize(@class,' ')='byline'] or ancestor::html:cite or ancestor::html:*[tokenize(@epub:type,' ')='covertitle'] or ancestor::html:*[tokenize(@class,' ')='dateline'] or ancestor::html:p[parent::html:header[parent::html:body] and tokenize(@epub:type,' ')='z3998:author'] or ancestor::html:h1[tokenize(@epub:type,' ')='fulltitle'] or ancestor::html:dt or ancestor::html:h1 or ancestor::html:h2 or ancestor::html:h3 or ancestor::html:h4 or ancestor::html:h5 or ancestor::html:h6 or ancestor::html:p[tokenize(@class,' ')='line'] or ancestor::html:p]" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type,' ')='z3998:production'][ancestor::html:a        or ancestor::html:abbr    or ancestor::html:a[tokenize(@epub:type,' ')='annoref']   or                                      ancestor::html:bdo      or ancestor::html:code       or ancestor::html:dfn        or ancestor::html:em        or                                      ancestor::html:kbd      or ancestor::html:p[tokenize(@class,' ')='linenum']    or ancestor::html:a[tokenize(@epub:type,' ')='noteref']    or                                      ancestor::html:q        or ancestor::html:samp       or ancestor::html:span[tokenize(@epub:type,' ')='z3998:sentence']       or ancestor::html:span      or                                      ancestor::html:strong   or ancestor::html:sub        or ancestor::html:sup        or ancestor::html:span[tokenize(@epub:type,' ')='z3998:word']         or                                      ancestor::html:address  or ancestor::html:*[tokenize(@epub:type,' ')='z3998:author' and not(parent::html:header[parent::html:body])]     or ancestor::html:p[tokenize(@epub:type,' ')='bridgehead'] or ancestor::html:*[tokenize(@class,' ')='byline']    or                                      ancestor::html:cite     or ancestor::html:*[tokenize(@epub:type,' ')='covertitle'] or ancestor::html:*[tokenize(@class,' ')='dateline']   or ancestor::html:p[parent::html:header[parent::html:body] and tokenize(@epub:type,' ')='z3998:author'] or                                      ancestor::html:h1[tokenize(@epub:type,' ')='fulltitle'] or ancestor::html:dt         or ancestor::html:h1         or ancestor::html:h2        or                                      ancestor::html:h3       or ancestor::html:h4         or ancestor::html:h5         or ancestor::html:h6        or                                      ancestor::html:p[tokenize(@class,' ')='line']       or ancestor::html:p]</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type,' ')='z3998:production'][ancestor::html:a        or ancestor::html:abbr    or ancestor::html:a[tokenize(@epub:type,' ')='annoref']   or                                      ancestor::html:bdo      or ancestor::html:code       or ancestor::html:dfn        or ancestor::html:em        or                                      ancestor::html:kbd      or ancestor::html:p[tokenize(@class,' ')='linenum']    or ancestor::html:a[tokenize(@epub:type,' ')='noteref']    or                                      ancestor::html:q        or ancestor::html:samp       or ancestor::html:span[tokenize(@epub:type,' ')='z3998:sentence']       or ancestor::html:span      or                                      ancestor::html:strong   or ancestor::html:sub        or ancestor::html:sup        or ancestor::html:span[tokenize(@epub:type,' ')='z3998:word']         or                                      ancestor::html:address  or ancestor::html:*[tokenize(@epub:type,' ')='z3998:author' and not(parent::html:header[parent::html:body])]     or ancestor::html:p[tokenize(@epub:type,' ')='bridgehead'] or ancestor::html:*[tokenize(@class,' ')='byline']    or                                      ancestor::html:cite     or ancestor::html:*[tokenize(@epub:type,' ')='covertitle'] or ancestor::html:*[tokenize(@class,' ')='dateline']   or ancestor::html:p[parent::html:header[parent::html:body] and tokenize(@epub:type,' ')='z3998:author'] or                                      ancestor::html:h1[tokenize(@epub:type,' ')='fulltitle'] or ancestor::html:dt         or ancestor::html:h1         or ancestor::html:h2        or                                      ancestor::html:h3       or ancestor::html:h4         or ancestor::html:h5         or ancestor::html:h6        or                                      ancestor::html:p[tokenize(@class,' ')='line']       or ancestor::html:p]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="descendant::html:*[self::html:address    or self::html:aside[tokenize(@epub:type,' ')='annotation'] or self::html:*[tokenize(@epub:type,' ')='z3998:author' and not(parent::html:header[parent::html:body])]   or                                              self::html:blockquote or self::html:p[tokenize(@epub:type,' ')='bridgehead'] or self::html:caption  or                                            self::html:*[tokenize(@class,' ')='dateline']   or self::html:div        or self::html:dl       or                                            self::html:p[parent::html:header[parent::html:body] and tokenize(@epub:type,' ')='z3998:author']  or self::html:h1[tokenize(@epub:type,' ')='fulltitle']   or                                            self::html:aside[tokenize(@epub:type,' ')='epigraph']   or self::html:p[tokenize(@class,' ')='line']     or                                              self::html:*[tokenize(@class,' ')='linegroup']  or                                              self::html:*[self::html:ul or self::html:ol]       or self::html:a[tokenize(@epub:type,' ')=('note','rearnote','endnote','footnote')]       or self::html:p        or                                            self::html:*[tokenize(@epub:type,' ')='z3998:poem']       or self::html:*[(self::figure or self::aside) and tokenize(@epub:type,'s')='sidebar']    or self::html:table    or                                            self::html:*[matches(local-name(),'^h\d$') and tokenize(@class,' ')='title'] or                                            self::html:details or self::html:summary]">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">descendant::html:*[self::html:address    or self::html:aside[tokenize(@epub:type,' ')='annotation'] or self::html:*[tokenize(@epub:type,' ')='z3998:author' and not(parent::html:header[parent::html:body])]   or                                              self::html:blockquote or self::html:p[tokenize(@epub:type,' ')='bridgehead'] or self::html:caption  or                                            self::html:*[tokenize(@class,' ')='dateline']   or self::html:div        or self::html:dl       or                                            self::html:p[parent::html:header[parent::html:body] and tokenize(@epub:type,' ')='z3998:author']  or self::html:h1[tokenize(@epub:type,' ')='fulltitle']   or                                            self::html:aside[tokenize(@epub:type,' ')='epigraph']   or self::html:p[tokenize(@class,' ')='line']     or                                              self::html:*[tokenize(@class,' ')='linegroup']  or                                              self::html:*[self::html:ul or self::html:ol]       or self::html:a[tokenize(@epub:type,' ')=('note','rearnote','endnote','footnote')]       or self::html:p        or                                            self::html:*[tokenize(@epub:type,' ')='z3998:poem']       or self::html:*[(self::figure or self::aside) and tokenize(@epub:type,'s')='sidebar']    or self::html:table    or                                            self::html:*[matches(local-name(),'^h\d$') and tokenize(@class,' ')='title'] or                                            self::html:details or self::html:summary]</xsl:attribute>
                     <svrl:text>[nordic29] Prodnote in inline context used as block element: <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e362')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:*[tokenize(@epub:type,'\s+')='pagebreak' and tokenize(@class,'\s+')='page-normal' and count(preceding::html:*[tokenize(@epub:type,'\s+')='pagebreak' and tokenize(@class,'\s+')='page-normal'])]"
                 priority="91"
                 mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="preceding-pagebreak"
                    select="preceding::html:*[tokenize(@epub:type,'\s+')='pagebreak' and tokenize(@class,'\s+')='page-normal'][1]"/>
      <schxslt:rule pattern="d7e374">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e374']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:*[tokenize(@epub:type,'\s+')='pagebreak' and tokenize(@class,'\s+')='page-normal' and count(preceding::html:*[tokenize(@epub:type,'\s+')='pagebreak' and tokenize(@class,'\s+')='page-normal'])]" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type,'\s+')='pagebreak' and tokenize(@class,'\s+')='page-normal' and count(preceding::html:*[tokenize(@epub:type,'\s+')='pagebreak' and tokenize(@class,'\s+')='page-normal'])]</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type,'\s+')='pagebreak' and tokenize(@class,'\s+')='page-normal' and count(preceding::html:*[tokenize(@epub:type,'\s+')='pagebreak' and tokenize(@class,'\s+')='page-normal'])]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="number($preceding-pagebreak/@title) != number(@title)-1">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">number($preceding-pagebreak/@title) != number(@title)-1</xsl:attribute>
                     <svrl:text>[nordic40a] No gaps may occur in page numbering (see pagebreak with title="<xsl:value-of select="@title"/>" and compare
                with pagebreak with title="<xsl:value-of select="$preceding-pagebreak/@title"/>")</svrl:text>
                  </svrl:successful-report>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e374')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:img[parent::html:figure/tokenize(@class,'\s+')='image']"
                 priority="90"
                 mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e392">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e392']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:img[parent::html:figure/tokenize(@class,'\s+')='image']" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:img[parent::html:figure/tokenize(@class,'\s+')='image']</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:img[parent::html:figure/tokenize(@class,'\s+')='image']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(@alt and @alt!='')">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">@alt and @alt!=''</xsl:attribute>
                     <svrl:text>[nordic50a] an image inside a figure with class='image' must have a non-empty alt attribute: <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e392')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:img" priority="89" mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e404">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e404']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:img" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:img</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:img</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(contains(@src,'.jpg') and substring-after(@src,'.jpg')='')">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">contains(@src,'.jpg') and substring-after(@src,'.jpg')=''</xsl:attribute>
                     <svrl:text>[nordic52] Images must have the .jpg file extension: <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
               <xsl:if test="contains(@src,'.jpg') and string-length(@src)=4">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">contains(@src,'.jpg') and string-length(@src)=4</xsl:attribute>
                     <svrl:text>[nordic52] Images must have a base name, not just an extension: <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
               <xsl:if test="not(matches(@src,'^images/[^/]+$'))">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">not(matches(@src,'^images/[^/]+$'))</xsl:attribute>
                     <svrl:text>[nordic51] Images must be in the "images" folder (relative to the HTML file).</svrl:text>
                  </svrl:successful-report>
               </xsl:if>
               <xsl:if test="not(string-length(translate(substring(@src,1,string-length(@src)-4),'-_abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/',''))=0)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">string-length(translate(substring(@src,1,string-length(@src)-4),'-_abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/',''))=0</xsl:attribute>
                     <svrl:text>[nordic52] Image file name
                contains an illegal character (must be -_a-zA-Z0-9): <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e404')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:dl/html:*[tokenize(@epub:type,' ')='pagebreak']" priority="88"
                 mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e427">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e427']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:dl/html:*[tokenize(@epub:type,' ')='pagebreak']" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:dl/html:*[tokenize(@epub:type,' ')='pagebreak']</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:dl/html:*[tokenize(@epub:type,' ')='pagebreak']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(not(parent::*/html:dd or parent::*/html:dt))">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">not(parent::*/html:dd or parent::*/html:dt)</xsl:attribute>
                     <svrl:text>[nordic59] pagebreak in definition list must not occur as siblings to dd or dt: <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e427')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:a[tokenize(@epub:type,' ')='noteref']" priority="87" mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e440">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e440']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:a[tokenize(@epub:type,' ')='noteref']" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:a[tokenize(@epub:type,' ')='noteref']</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:a[tokenize(@epub:type,' ')='noteref']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="matches(@href,'^[^/]+:')">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">matches(@href,'^[^/]+:')</xsl:attribute>
                     <svrl:text>[nordic63] Only note references within the same publication are allowed: <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e440')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:a[tokenize(@epub:type,' ')='annoref']" priority="86" mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e452">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e452']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:a[tokenize(@epub:type,' ')='annoref']" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:a[tokenize(@epub:type,' ')='annoref']</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:a[tokenize(@epub:type,' ')='annoref']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="matches(@href,'^[^/]+:')">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">matches(@href,'^[^/]+:')</xsl:attribute>
                     <svrl:text>[nordic64] Only annotation references within the same publication are allowed</svrl:text>
                  </svrl:successful-report>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e452')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:*[self::html:h1 or self::html:h2 or self::html:h3 or self::html:h4 or self::html:h5 or self::html:h6]"
                 priority="85"
                 mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e463">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e463']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:*[self::html:h1 or self::html:h2 or self::html:h3 or self::html:h4 or self::html:h5 or self::html:h6]" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[self::html:h1 or self::html:h2 or self::html:h3 or self::html:h4 or self::html:h5 or self::html:h6]</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[self::html:h1 or self::html:h2 or self::html:h3 or self::html:h4 or self::html:h5 or self::html:h6]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="matches((.//text()[normalize-space()])[1],'^\s')">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">matches((.//text()[normalize-space()])[1],'^\s')</xsl:attribute>
                     <svrl:text>[nordic93] element <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/> may not have leading whitespace</svrl:text>
                  </svrl:successful-report>
               </xsl:if>
               <xsl:if test="matches((.//text()[normalize-space()])[last()],'\s$')">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">matches((.//text()[normalize-space()])[last()],'\s$')</xsl:attribute>
                     <svrl:text>[nordic93] element <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/> may not have trailing whitespace</svrl:text>
                  </svrl:successful-report>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e463')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:*[tokenize(@epub:type,' ')='z3998:production']" priority="84"
                 mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e482">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e482']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:*[tokenize(@epub:type,' ')='z3998:production']" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type,' ')='z3998:production']</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type,' ')='z3998:production']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="ancestor::html:*[tokenize(@epub:type,'\s+')='z3998:production']">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">ancestor::html:*[tokenize(@epub:type,'\s+')='z3998:production']</xsl:attribute>
                     <svrl:text>[nordic96a] nested production notes are not allowed: <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
               <xsl:if test="parent::html:figure and ancestor::*/tokenize(@epub:type,'\s+') = 'cover'">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">parent::html:figure and ancestor::*/tokenize(@epub:type,'\s+') = 'cover'</xsl:attribute>
                     <svrl:text>[nordic96a] production notes are not allowed inside figures in the cover
                    <xsl:value-of select="if (ancestor::html:body[tokenize(@epub:type,'\s+')='cover']) then 'document' else 'section'"/>: <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e482')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:figure[tokenize(@class,'\s+')='image-series']" priority="83"
                 mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e498">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e498']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:figure[tokenize(@class,'\s+')='image-series']" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:figure[tokenize(@class,'\s+')='image-series']</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:figure[tokenize(@class,'\s+')='image-series']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="ancestor::html:figure[tokenize(@class,'\s+')='image-series']">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">ancestor::html:figure[tokenize(@class,'\s+')='image-series']</xsl:attribute>
                     <svrl:text>[nordic96b] nested image series are not allowed (<xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>). Remember that image figures use the class "image", while
                image series figures use the class "image-series". Maybe this inner figure should be using the "image" class?</svrl:text>
                  </svrl:successful-report>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e498')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:figure[tokenize(@class,'\s+')='image-series']" priority="82"
                 mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e511">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e511']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:figure[tokenize(@class,'\s+')='image-series']" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:figure[tokenize(@class,'\s+')='image-series']</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:figure[tokenize(@class,'\s+')='image-series']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(html:figure[tokenize(@class,'\s+')='image'])">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">html:figure[tokenize(@class,'\s+')='image']</xsl:attribute>
                     <svrl:text>[nordic101] There must be at least one figure with class="image" in a image series figure: <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e511')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:figure[tokenize(@class,'\s+')='image']" priority="81" mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e523">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e523']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:figure[tokenize(@class,'\s+')='image']" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:figure[tokenize(@class,'\s+')='image']</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:figure[tokenize(@class,'\s+')='image']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(html:img)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">html:img</xsl:attribute>
                     <svrl:text>[nordic102] There must be an img element in every figure with class="image": <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
               <xsl:if test="parent::html:figure[tokenize(@class,'\s+')='image']">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">parent::html:figure[tokenize(@class,'\s+')='image']</xsl:attribute>
                     <svrl:text>[nordic102] Wrapping &lt;figure class="image"&gt; inside another &lt;figure class="image"&gt; is not allowed. Did you
                mean to use "image-series" as a class on the outer figure? <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e523')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6" priority="80"
                 mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e540">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e540']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="normalize-space(.)=''">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">normalize-space(.)=''</xsl:attribute>
                     <svrl:text>[nordic104] Heading <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                may not be empty</svrl:text>
                  </svrl:successful-report>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e540')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:*[tokenize(@epub:type,' ')='pagebreak']" priority="79" mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e553">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e553']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:*[tokenize(@epub:type,' ')='pagebreak']" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type,' ')='pagebreak']</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type,' ')='pagebreak']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(tokenize(@class,'\s+')=('page-front','page-normal','page-special'))">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">tokenize(@class,'\s+')=('page-front','page-normal','page-special')</xsl:attribute>
                     <svrl:text>[nordic105] Page breaks must have either a 'page-front', a 'page-normal' or a 'page-special' class:
                    <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
               <xsl:if test="not(count(*|comment())=0 and string-length(string-join(text(),''))=0)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count(*|comment())=0 and string-length(string-join(text(),''))=0</xsl:attribute>
                     <svrl:text>[nordic105] Pagebreaks must not contain anything<xsl:value-of select="if (string-length(text())&gt;0 and normalize-space(text())='') then ' (element contains empty spaces)' else ''"/>: <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e553')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:*[tokenize(@epub:type,' ')='pagebreak']" priority="78" mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e571">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e571']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:*[tokenize(@epub:type,' ')='pagebreak']" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type,' ')='pagebreak']</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type,' ')='pagebreak']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="ancestor::*[self::html:h1 or self::html:h2 or self::html:h3 or self::html:h4 or self::html:h5 or self::html:h6]">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">ancestor::*[self::html:h1 or self::html:h2 or self::html:h3 or self::html:h4 or self::html:h5 or self::html:h6]</xsl:attribute>
                     <svrl:text>[nordic110] pagebreak elements are not allowed in headings:
                    <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e571')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:*[tokenize(@epub:type,' ')='pagebreak']" priority="77" mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e584">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e584']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:*[tokenize(@epub:type,' ')='pagebreak']" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type,' ')='pagebreak']</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type,' ')='pagebreak']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="tokenize(@class,' ')='page-front' and translate(.,'0123456789','xxxxxxxxxx')!=.">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">tokenize(@class,' ')='page-front' and translate(.,'0123456789','xxxxxxxxxx')!=.</xsl:attribute>
                     <svrl:text>[nordic116] Hindu-Arabic numbers when @class="page-front" are not allowed: <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e584')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:*[self::html:h1 or self::html:h2 or self::html:h3 or self::html:h4 or self::html:h5 or self::html:h6]"
                 priority="76"
                 mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e596">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e596']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:*[self::html:h1 or self::html:h2 or self::html:h3 or self::html:h4 or self::html:h5 or self::html:h6]" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[self::html:h1 or self::html:h2 or self::html:h3 or self::html:h4 or self::html:h5 or self::html:h6]</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[self::html:h1 or self::html:h2 or self::html:h3 or self::html:h4 or self::html:h5 or self::html:h6]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(not(preceding-sibling::html:*) or preceding-sibling::html:*[tokenize(@epub:type,' ')='pagebreak'])">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">not(preceding-sibling::html:*) or preceding-sibling::html:*[tokenize(@epub:type,' ')='pagebreak']</xsl:attribute>
                     <svrl:text>[nordic120] Only pagebreaks are allowed before the heading <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;',string-join(.//text(),' '),'&lt;/',name(),'&gt;')"/>.</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e596')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:*[tokenize(@epub:type,' ')='pagebreak'][ancestor::html:table]"
                 priority="75"
                 mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e609">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e609']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:*[tokenize(@epub:type,' ')='pagebreak'][ancestor::html:table]" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type,' ')='pagebreak'][ancestor::html:table]</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type,' ')='pagebreak'][ancestor::html:table]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(not(../html:tr))">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">not(../html:tr)</xsl:attribute>
                     <svrl:text>[nordic121] Page numbers in tables must not be placed between table rows: <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e609')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:body | html:section | html:article" priority="74" mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e622">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e622']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:body | html:section | html:article" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:body | html:section | html:article</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:body | html:section | html:article</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="tokenize(@epub:type,'\s+')='cover' and tokenize(@epub:type,'\s+')=('frontmatter','bodymatter','backmatter')">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">tokenize(@epub:type,'\s+')='cover' and tokenize(@epub:type,'\s+')=('frontmatter','bodymatter','backmatter')</xsl:attribute>
                     <svrl:text>[nordic123] Cover (Jacket copy) is a document partition and can
                not be part the other document partitions frontmatter, bodymatter and rearmatter: <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e622')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:body[html:nav]" priority="73" mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e634">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e634']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:body[html:nav]" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:body[html:nav]</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:body[html:nav]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(count(html:nav[tokenize(@epub:type,'\s+')='page-list']) &gt; 0)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count(html:nav[tokenize(@epub:type,'\s+')='page-list']) &gt; 0</xsl:attribute>
                     <svrl:text>[nordic124] The publication must contain pagebreaks, and they must be referenced from a &lt;nav
                epub:type="page-list"&gt; in the navigation document. There is no such &lt;nav&gt; element in the navigation document.</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
               <xsl:if test="not(count(html:nav[tokenize(@epub:type,'\s+')='page-list']//html:a) &gt; 0)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count(html:nav[tokenize(@epub:type,'\s+')='page-list']//html:a) &gt; 0</xsl:attribute>
                     <svrl:text>[nordic124] The publication must contain pagebreaks, and they must be referenced from the &lt;nav
                epub:type="page-list"&gt; in the navigation document. No pagebreaks are referenced from within this &lt;nav&gt; page list.</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e634')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:img" priority="72" mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e648">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e648']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:img" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:img</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:img</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(string-length(@src)&gt;=5)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">string-length(@src)&gt;=5</xsl:attribute>
                     <svrl:text>[nordic125] Invalid image filename: <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
               <xsl:if test="not(substring(@src,string-length(@src) - 3, 4)='.jpg')">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">substring(@src,string-length(@src) - 3, 4)='.jpg'</xsl:attribute>
                     <svrl:text>[nordic125] Images must be in JPG (*.jpg) format: <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e648')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:*[tokenize(@epub:type,' ')='pagebreak']" priority="71" mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e665">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e665']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:*[tokenize(@epub:type,' ')='pagebreak']" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type,' ')='pagebreak']</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type,' ')='pagebreak']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="preceding-sibling::*[1][self::html:h1 or self::html:h2 or self::html:h3 or self::html:h4 or self::html:h5 or self::html:h6] and                             not(preceding-sibling::*[2][self::html:*[tokenize(@epub:type,' ')='pagebreak']])">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">preceding-sibling::*[1][self::html:h1 or self::html:h2 or self::html:h3 or self::html:h4 or self::html:h5 or self::html:h6] and                             not(preceding-sibling::*[2][self::html:*[tokenize(@epub:type,' ')='pagebreak']])</xsl:attribute>
                     <svrl:text>[nordic126] pagebreak must not occur directly after hx unless the hx is preceded by a pagebreak: <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e665')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:section[tokenize(@epub:type,'\s+')='toc'] | html:body[tokenize(@epub:type,'\s+')='toc']"
                 priority="70"
                 mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e677">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e677']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:section[tokenize(@epub:type,'\s+')='toc'] | html:body[tokenize(@epub:type,'\s+')='toc']" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:section[tokenize(@epub:type,'\s+')='toc'] | html:body[tokenize(@epub:type,'\s+')='toc']</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:section[tokenize(@epub:type,'\s+')='toc'] | html:body[tokenize(@epub:type,'\s+')='toc']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(html:ol)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">html:ol</xsl:attribute>
                     <svrl:text>[nordic127a] The table of contents must contain a "ol" element as a direct child of the parent <xsl:value-of select="if (self::html:body) then 'body' else 'section'"/>
                element.</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
               <xsl:if test="ancestor-or-self::*/tokenize(@epub:type,'\s+')=('bodymatter','cover')">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">ancestor-or-self::*/tokenize(@epub:type,'\s+')=('bodymatter','cover')</xsl:attribute>
                     <svrl:text>[nordic127b] The table of contents must be in either frontmatter or backmatter; it is not allowed in
                bodymatter or cover.</svrl:text>
                  </svrl:successful-report>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e677')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:meta[boolean(@name) and contains(@name, ':') and not(substring-before(@name, ':') = ('epub', 'dc', 'dcterms', 'marc', 'media', 'onix', 'xsd'))]"
                 priority="69"
                 mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="prefix" select="substring-before(@name, ':')"/>
      <xsl:variable name="namespace"
                    select="if ($prefix = 'nordic') then 'http://www.mtm.se/epub/' else                                          if ($prefix = 'z3998') then 'http://www.daisy.org/z3998/2012/vocab/structure/#' else                                          if ($prefix = 'a11y') then 'http://www.idpf.org/epub/vocab/package/a11y/#' else                                          if ($prefix = 'msv') then 'http://www.idpf.org/epub/vocab/structure/magazine/#' else                                          if ($prefix = 'prism') then 'http://www.prismstandard.org/specifications/3.0/PRISM_CV_Spec_3.0.htm#' else                                          ''"/>
      <schxslt:rule pattern="d7e693">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e693']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:meta[boolean(@name) and contains(@name, ':') and not(substring-before(@name, ':') = ('epub', 'dc', 'dcterms', 'marc', 'media', 'onix', 'xsd'))]" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:meta[boolean(@name) and contains(@name, ':') and not(substring-before(@name, ':') = ('epub', 'dc', 'dcterms', 'marc', 'media', 'onix', 'xsd'))]</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:meta[boolean(@name) and contains(@name, ':') and not(substring-before(@name, ':') = ('epub', 'dc', 'dcterms', 'marc', 'media', 'onix', 'xsd'))]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(matches(string(ancestor::html:html[1]/@epub:prefix[1]), concat('(^|\s)', $prefix, ': *[^\s]+(\s|$)')))">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">matches(string(ancestor::html:html[1]/@epub:prefix[1]), concat('(^|\s)', $prefix, ': *[^\s]+(\s|$)'))</xsl:attribute>
                     <svrl:text>[nordic128a] on the html element: the epub:prefix attribute must declare the '<xsl:value-of select="$prefix"/>' prefix</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
               <xsl:if test="not(not($namespace) or matches(string(ancestor::html:html[1]/@epub:prefix[1]), concat('(^|\s)', $prefix, ':\s+', $namespace , '(\s|$)')))">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">not($namespace) or matches(string(ancestor::html:html[1]/@epub:prefix[1]), concat('(^|\s)', $prefix, ':\s+', $namespace , '(\s|$)'))</xsl:attribute>
                     <svrl:text>[nordic128e] in the epub:prefix attribute on the html element: the namespace for the '<xsl:value-of select="$prefix"/>' prefix must be '<xsl:value-of select="$namespace"/>'</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e693')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="*[@epub:type]" priority="68" mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="prefixes"
                    select="distinct-values(for $t in (tokenize(@epub:type,'\s+')) return if (contains($t,':') and not(substring-before($t, ':') = ('epub', 'dc', 'dcterms', 'marc', 'media', 'onix', 'xsd'))) then substring-before($t, ':') else ())"/>
      <xsl:variable name="prefixes-with-namespace"
                    select="for $prefix in $prefixes return (                                                             if ($prefix = 'nordic') then concat($prefix, ': ', 'http://www.mtm.se/epub/') else                                                             if ($prefix = 'z3998') then concat($prefix, ': ', 'http://www.daisy.org/z3998/2012/vocab/structure/#') else                                                             if ($prefix = 'a11y') then concat($prefix, ': ', 'http://www.idpf.org/epub/vocab/package/a11y/#') else                                                             if ($prefix = 'msv') then concat($prefix, ': ', 'http://www.idpf.org/epub/vocab/structure/magazine/#') else                                                             if ($prefix = 'prism') then concat($prefix, ': ', 'http://www.prismstandard.org/specifications/3.0/PRISM_CV_Spec_3.0.htm#') else                                                             ())"/>
      <schxslt:rule pattern="d7e693">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e693']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "*[@epub:type]" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">*[@epub:type]</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">*[@epub:type]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="parent::*/@class='myclass' and count($prefixes) = 0">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">parent::*/@class='myclass' and count($prefixes) = 0</xsl:attribute>
                     <svrl:text>prefixes: <xsl:value-of select="$prefixes"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
               <xsl:if test="not(count($prefixes) = 0 or not(false() = (for $prefix in $prefixes return matches(string(ancestor::html:html[1]/@epub:prefix[1]), concat('(^|\s)', $prefix, ': *[^\s]+(\s|$)')))))">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count($prefixes) = 0 or not(false() = (for $prefix in $prefixes return matches(string(ancestor::html:html[1]/@epub:prefix[1]), concat('(^|\s)', $prefix, ': *[^\s]+(\s|$)'))))</xsl:attribute>
                     <svrl:text>[nordic128e] all of the prefixes in use (<xsl:value-of select="concat('''', string-join($prefixes,''','''), '''')"/>) on the element (<xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>) must be declared in the epub:prefix attribute on the html element: '&lt;html epub:prefix="<xsl:value-of select="ancestor-or-self::html:html/@prefix"/>"&gt;...&lt;/html&gt;</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
               <xsl:if test="not(count($prefixes-with-namespace) = 0 or not(false() = (for $prefix-with-namespace in ($prefixes-with-namespace) return matches(string(ancestor::html:html[1]/@epub:prefix[1]), concat('(^|\s)', substring-before($prefix-with-namespace, ': '), ':\s+', substring-after($prefix-with-namespace, ': '), '(\s|$)')))))">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count($prefixes-with-namespace) = 0 or not(false() = (for $prefix-with-namespace in ($prefixes-with-namespace) return matches(string(ancestor::html:html[1]/@epub:prefix[1]), concat('(^|\s)', substring-before($prefix-with-namespace, ': '), ':\s+', substring-after($prefix-with-namespace, ': '), '(\s|$)'))))</xsl:attribute>
                     <svrl:text>[nordic128e] in the epub:prefix attribute on the html element: the namespaces for the prefixes must be correct. <xsl:value-of select="string-join(for $prefix-with-namespace in ($prefixes-with-namespace) return concat('The prefix ''', substring-before($prefix-with-namespace, ': '), ''' must be associated with the namespace ''', substring-after($prefix-with-namespace, ': '), '''.'), ' ')"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e693')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:head[//html:body/html:header]" priority="67" mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e739">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e739']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:head[//html:body/html:header]" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:head[//html:body/html:header]</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:head[//html:body/html:header]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(count(html:meta[@name='nordic:guidelines'])=1)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count(html:meta[@name='nordic:guidelines'])=1</xsl:attribute>
                     <svrl:text>[nordic128b] nordic:guidelines metadata must occur once.</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e739')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:meta[//html:body/html:header][@name='nordic:guidelines']"
                 priority="66"
                 mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e749">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e749']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:meta[//html:body/html:header][@name='nordic:guidelines']" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:meta[//html:body/html:header][@name='nordic:guidelines']</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:meta[//html:body/html:header][@name='nordic:guidelines']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(@content='2015-1')">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">@content='2015-1'</xsl:attribute>
                     <svrl:text>[nordic128c] nordic:guidelines metadata value must be 2015-1.</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e749')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:head[//html:body/html:header]" priority="65" mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e758">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e758']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:head[//html:body/html:header]" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:head[//html:body/html:header]</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:head[//html:body/html:header]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(count(html:meta[@name='nordic:supplier'])=1)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count(html:meta[@name='nordic:supplier'])=1</xsl:attribute>
                     <svrl:text>[nordic128d] nordic:supplier metadata must occur once.</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e758')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:meta[@name='dc:language']" priority="64" mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e769">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e769']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:meta[@name='dc:language']" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:meta[@name='dc:language']</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:meta[@name='dc:language']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(@content=/html:html/@xml:lang)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">@content=/html:html/@xml:lang</xsl:attribute>
                     <svrl:text>[nordic130] dc:language metadata must equal the root element xml:lang</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e769')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="*[@xml:lang]" priority="63" mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e780">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e780']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "*[@xml:lang]" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">*[@xml:lang]</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">*[@xml:lang]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(matches(@xml:lang,'^[a-z]+(-[A-Z][A-Z]+)?$'))">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">matches(@xml:lang,'^[a-z]+(-[A-Z][A-Z]+)?$')</xsl:attribute>
                     <svrl:text>[nordic131] xml:lang must match '^[a-z]+(-[A-Z][A-Z]+)?$' (<xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>)</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e780')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:*[tokenize(@epub:type,'\s+')='z3998:poem'] | html:*[tokenize(@epub:type,'\s+')='z3998:verse' and not(ancestor::html:*/tokenize(@epub:type,'\s+')='z3998:poem')]"
                 priority="62"
                 mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e794">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e794']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:*[tokenize(@epub:type,'\s+')='z3998:poem'] | html:*[tokenize(@epub:type,'\s+')='z3998:verse' and not(ancestor::html:*/tokenize(@epub:type,'\s+')='z3998:poem')]" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type,'\s+')='z3998:poem'] | html:*[tokenize(@epub:type,'\s+')='z3998:verse' and not(ancestor::html:*/tokenize(@epub:type,'\s+')='z3998:poem')]</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type,'\s+')='z3998:poem'] | html:*[tokenize(@epub:type,'\s+')='z3998:verse' and not(ancestor::html:*/tokenize(@epub:type,'\s+')='z3998:poem')]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(html:*[tokenize(@class,'\s+')='linegroup'])">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">html:*[tokenize(@class,'\s+')='linegroup']</xsl:attribute>
                     <svrl:text>[nordic135] Every poem must contain a linegroup: <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
               <xsl:if test="html:p[tokenize(@class,'\s+')='line']">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">html:p[tokenize(@class,'\s+')='line']</xsl:attribute>
                     <svrl:text>[nordic135] Poem lines must be wrapped in a linegroup: <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/> contains; <xsl:value-of select="concat('&lt;',html:p[tokenize(@class,'\s+')='line'][1]/name(),string-join(for $a in (html:p[tokenize(@class,'\s+')='line'][1]/@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e794')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:body[tokenize(@epub:type,'\s+')='cover'] | html:section[tokenize(@epub:type,'\s+')='cover']"
                 priority="61"
                 mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e812">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e812']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:body[tokenize(@epub:type,'\s+')='cover'] | html:section[tokenize(@epub:type,'\s+')='cover']" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:body[tokenize(@epub:type,'\s+')='cover'] | html:section[tokenize(@epub:type,'\s+')='cover']</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:body[tokenize(@epub:type,'\s+')='cover'] | html:section[tokenize(@epub:type,'\s+')='cover']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(count(*[not(matches(local-name(),'h\d'))])=count(html:section[tokenize(@class,'\s+')=('frontcover','rearcover','leftflap','rightflap')]))">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count(*[not(matches(local-name(),'h\d'))])=count(html:section[tokenize(@class,'\s+')=('frontcover','rearcover','leftflap','rightflap')])</xsl:attribute>
                     <svrl:text>[nordic140] Only sections with one
                of the classes 'frontcover', 'rearcover', 'leftflap' or 'rightflap' is allowed in cover</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
               <xsl:if test="not(count(html:section[tokenize(@class,'\s+')=('frontcover','rearcover','leftflap','rightflap')])&gt;=1)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count(html:section[tokenize(@class,'\s+')=('frontcover','rearcover','leftflap','rightflap')])&gt;=1</xsl:attribute>
                     <svrl:text>[nordic140] There must be at least one section with one of the classes
                'frontcover', 'rearcover', 'leftflap' or 'rightflap' in cover.</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
               <xsl:if test="count(html:section[tokenize(@class,'\s+')='frontcover'])&gt;1">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count(html:section[tokenize(@class,'\s+')='frontcover'])&gt;1</xsl:attribute>
                     <svrl:text>[nordic140] Too many sections with class="frontcover" in cover</svrl:text>
                  </svrl:successful-report>
               </xsl:if>
               <xsl:if test="count(html:section[tokenize(@class,'\s+')='rearcover'])&gt;1">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count(html:section[tokenize(@class,'\s+')='rearcover'])&gt;1</xsl:attribute>
                     <svrl:text>[nordic140] Too many sections with class="rearcover" in cover</svrl:text>
                  </svrl:successful-report>
               </xsl:if>
               <xsl:if test="count(html:section[tokenize(@class,'\s+')='leftflap'])&gt;1">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count(html:section[tokenize(@class,'\s+')='leftflap'])&gt;1</xsl:attribute>
                     <svrl:text>[nordic140] Too many sections with class="leftflap" in cover</svrl:text>
                  </svrl:successful-report>
               </xsl:if>
               <xsl:if test="count(html:section[tokenize(@class,'\s+')='rightflap'])&gt;1">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count(html:section[tokenize(@class,'\s+')='rightflap'])&gt;1</xsl:attribute>
                     <svrl:text>[nordic140] Too many sections with class="rightflap" in cover</svrl:text>
                  </svrl:successful-report>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e812')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:*[tokenize(@epub:type,' ')='pagebreak'][ancestor::html:section[@class='nonstandardpagination']]"
                 priority="60"
                 mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e839">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e839']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:*[tokenize(@epub:type,' ')='pagebreak'][ancestor::html:section[@class='nonstandardpagination']]" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type,' ')='pagebreak'][ancestor::html:section[@class='nonstandardpagination']]</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type,' ')='pagebreak'][ancestor::html:section[@class='nonstandardpagination']]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(tokenize(@class,' ')='page-special')">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">tokenize(@class,' ')='page-special'</xsl:attribute>
                     <svrl:text>[nordic142] The class page-special must be used in section/@class='nonstandardpagination': <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e839')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:*[tokenize(@epub:type,' ')='pagebreak'][parent::html:ul or parent::html:ol]"
                 priority="59"
                 mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e852">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e852']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:*[tokenize(@epub:type,' ')='pagebreak'][parent::html:ul or parent::html:ol]" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type,' ')='pagebreak'][parent::html:ul or parent::html:ol]</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type,' ')='pagebreak'][parent::html:ul or parent::html:ol]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="../html:li">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">../html:li</xsl:attribute>
                     <svrl:text>[nordic143a] pagebreak is not allowed as sibling to list items: <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e852')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:*[tokenize(@epub:type,' ')='pagebreak'][parent::html:li]"
                 priority="58"
                 mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e862">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e862']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:*[tokenize(@epub:type,' ')='pagebreak'][parent::html:li]" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type,' ')='pagebreak'][parent::html:li]</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type,' ')='pagebreak'][parent::html:li]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(../preceding-sibling::html:li or preceding-sibling::* or preceding-sibling::text()[normalize-space()])">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">../preceding-sibling::html:li or preceding-sibling::* or preceding-sibling::text()[normalize-space()]</xsl:attribute>
                     <svrl:text>[nordic143b] pagebreak is not allowed at the beginning of the first
                list item; it should be placed before the list: <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e862')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:title" priority="57" mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e874">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e874']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:title" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:title</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:title</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(text() and not(normalize-space(.)=''))">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">text() and not(normalize-space(.)='')</xsl:attribute>
                     <svrl:text>[nordic200] The title element must not be empty.</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e874')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:*[tokenize(@epub:type,'\s+')='cover']" priority="56" mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e885">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e885']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:*[tokenize(@epub:type,'\s+')='cover']" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type,'\s+')='cover']</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type,'\s+')='cover']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(not(tokenize(@epub:type,'\s+')=('frontmatter','bodymatter','backmatter')))">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">not(tokenize(@epub:type,'\s+')=('frontmatter','bodymatter','backmatter'))</xsl:attribute>
                     <svrl:text>[nordic201] cover is not allowed in frontmatter, bodymatter or backmatter.</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e885')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:*[tokenize(@epub:type,' ')='frontmatter']" priority="55"
                 mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="always-allowed-types"
                    select="('abstract','acknowledgments','afterword','answers','appendix','assessment','assessments','bibliography',                 'z3998:biographical-note','case-study','chapter','colophon','conclusion','contributors','copyright-page','credits','dedication','z3998:discography','division','z3998:editorial-note','epigraph','epilogue',                 'errata','z3998:filmography','footnotes','foreword','glossary','dictionary','z3998:grant-acknowledgment','halftitlepage','imprimatur','imprint','index','index-group','index-headnotes','index-legend','introduction',                 'keywords','landmarks','loa','loi','lot','lov','notice','other-credits','page-list','practices','preamble','preface','prologue','z3998:promotional-copy','z3998:published-works',                 'z3998:publisher-address','qna','rearnotes','endnotes','revision-history','z3998:section','seriespage','subchapter','z3998:subsection','toc','toc-brief','z3998:translator-note','volume')"/>
      <xsl:variable name="allowed-types" select="($always-allowed-types, 'titlepage')"/>
      <schxslt:rule pattern="d7e897">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e897']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:*[tokenize(@epub:type,' ')='frontmatter']" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type,' ')='frontmatter']</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type,' ')='frontmatter']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(count(tokenize(@epub:type,'\s+')) = 1 or tokenize(@epub:type,'\s+')=$allowed-types)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count(tokenize(@epub:type,'\s+')) = 1 or tokenize(@epub:type,'\s+')=$allowed-types</xsl:attribute>
                     <svrl:text>[nordic202] '<xsl:value-of select="(tokenize(@epub:type,'\s+')[not(.='frontmatter')],'(missing type)')[1]"/>' is not an allowed type in frontmatter. On elements with the epub:type "frontmatter", you can
                either leave the type blank<xsl:value-of select="if (ancestor::html:body[not(html:header)]) then '(and just use ''frontmatter'' as the type in the filename)' else ''"/>, or you can use one
                of the following types: <xsl:value-of select="string-join($allowed-types[position() != last()],''', ''')"/> or '<xsl:value-of select="$allowed-types[last()]"/>'.</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e897')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:*[tokenize(@epub:type,'\s+')='rearnote']" priority="54"
                 mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e920">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e920']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:*[tokenize(@epub:type,'\s+')='rearnote']" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type,'\s+')='rearnote']</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type,'\s+')='rearnote']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not((ancestor::html:section | ancestor::html:body)[tokenize(@epub:type,'\s+')='rearnotes'])">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">(ancestor::html:section | ancestor::html:body)[tokenize(@epub:type,'\s+')='rearnotes']</xsl:attribute>
                     <svrl:text>[nordic203a] 'rearnote' must have a section<xsl:value-of select="if (ancestor::html:body[html:section]) then '' else ' or body'"/> ancestor with 'rearnotes': <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e920')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:*[tokenize(@epub:type,'\s+')='endnote']" priority="53" mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e920">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e920']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:*[tokenize(@epub:type,'\s+')='endnote']" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type,'\s+')='endnote']</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type,'\s+')='endnote']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not((ancestor::html:section | ancestor::html:body)[tokenize(@epub:type,'\s+')='endnotes'])">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">(ancestor::html:section | ancestor::html:body)[tokenize(@epub:type,'\s+')='endnotes']</xsl:attribute>
                     <svrl:text>[nordic203a] 'endnote' must have a section<xsl:value-of select="if (ancestor::html:body[html:section]) then '' else ' or body'"/> ancestor with 'endnotes': <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e920')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:body[tokenize(@epub:type,'\s+')='rearnotes'] | html:section[tokenize(@epub:type,'\s+')='rearnotes']"
                 priority="52"
                 mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e941">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e941']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:body[tokenize(@epub:type,'\s+')='rearnotes'] | html:section[tokenize(@epub:type,'\s+')='rearnotes']" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:body[tokenize(@epub:type,'\s+')='rearnotes'] | html:section[tokenize(@epub:type,'\s+')='rearnotes']</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:body[tokenize(@epub:type,'\s+')='rearnotes'] | html:section[tokenize(@epub:type,'\s+')='rearnotes']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(descendant::html:*[tokenize(@epub:type,'\s+')='rearnote'])">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">descendant::html:*[tokenize(@epub:type,'\s+')='rearnote']</xsl:attribute>
                     <svrl:text>[nordic203c] <xsl:value-of select="if (self::html:body) then 'documents' else 'sections'"/> with the epub:type
                'rearnotes' must have descendants with 'rearnote'.</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
               <xsl:if test="not(.//html:ol)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">.//html:ol</xsl:attribute>
                     <svrl:text>[nordic204c] <xsl:value-of select="if (self::html:body) then 'documents' else 'sections'"/> with the epub:type 'rearnotes' must have &lt;ol&gt; descendant
                elements.</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e941')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:body[tokenize(@epub:type,'\s+')='endnotes'] | html:section[tokenize(@epub:type,'\s+')='endnotes']"
                 priority="51"
                 mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e941">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e941']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:body[tokenize(@epub:type,'\s+')='endnotes'] | html:section[tokenize(@epub:type,'\s+')='endnotes']" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:body[tokenize(@epub:type,'\s+')='endnotes'] | html:section[tokenize(@epub:type,'\s+')='endnotes']</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:body[tokenize(@epub:type,'\s+')='endnotes'] | html:section[tokenize(@epub:type,'\s+')='endnotes']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(descendant::html:*[tokenize(@epub:type,'\s+')='endnote'])">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">descendant::html:*[tokenize(@epub:type,'\s+')='endnote']</xsl:attribute>
                     <svrl:text>[nordic203c] <xsl:value-of select="if (self::html:body) then 'documents' else 'sections'"/> with the epub:type
                'endnotes' must have descendants with 'endnote'.</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
               <xsl:if test="not(.//html:ol)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">.//html:ol</xsl:attribute>
                     <svrl:text>[nordic204c] <xsl:value-of select="if (self::html:body) then 'documents' else 'sections'"/> with the epub:type 'endnotes' must have &lt;ol&gt; descendant
                elements.</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e941')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:*[tokenize(@epub:type,'\s+')='rearnote']" priority="50"
                 mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e970">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e970']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:*[tokenize(@epub:type,'\s+')='rearnote']" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type,'\s+')='rearnote']</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type,'\s+')='rearnote']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(self::html:li)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">self::html:li</xsl:attribute>
                     <svrl:text>[nordic203d] 'rearnote' can only be applied to &lt;li&gt; elements: <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
               <xsl:if test="not(tokenize(@class,'\s+')='notebody')">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">tokenize(@class,'\s+')='notebody'</xsl:attribute>
                     <svrl:text>[nordic203d] The 'notebody' class must be applied to all rearnotes: <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e970')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:*[tokenize(@epub:type,'\s+')='endnote']" priority="49" mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e970">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e970']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:*[tokenize(@epub:type,'\s+')='endnote']" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type,'\s+')='endnote']</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type,'\s+')='endnote']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(self::html:li)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">self::html:li</xsl:attribute>
                     <svrl:text>[nordic203d] 'endnote' can only be applied to &lt;li&gt; elements: <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
               <xsl:if test="not(tokenize(@class,'\s+')='notebody')">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">tokenize(@class,'\s+')='notebody'</xsl:attribute>
                     <svrl:text>[nordic203d] The 'notebody' class must be applied to all endnotes: <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e970')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:*[tokenize(@epub:type,'\s+')='footnote']" priority="48"
                 mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e998">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e998']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:*[tokenize(@epub:type,'\s+')='footnote']" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type,'\s+')='footnote']</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type,'\s+')='footnote']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not((ancestor::html:section | ancestor::html:body)[tokenize(@epub:type,'\s+')='footnotes'])">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">(ancestor::html:section | ancestor::html:body)[tokenize(@epub:type,'\s+')='footnotes']</xsl:attribute>
                     <svrl:text>[nordic204a] 'footnote' must have a section<xsl:value-of select="if (ancestor::html:body[html:header]) then '' else ' or body'"/> ancestor with 'footnotes': <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e998')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:body[tokenize(@epub:type,'\s+')='footnotes'] | html:section[tokenize(@epub:type,'\s+')='footnotes']"
                 priority="47"
                 mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e1010">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e1010']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:body[tokenize(@epub:type,'\s+')='footnotes'] | html:section[tokenize(@epub:type,'\s+')='footnotes']" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:body[tokenize(@epub:type,'\s+')='footnotes'] | html:section[tokenize(@epub:type,'\s+')='footnotes']</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:body[tokenize(@epub:type,'\s+')='footnotes'] | html:section[tokenize(@epub:type,'\s+')='footnotes']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(descendant::html:*[tokenize(@epub:type,'\s+')='footnote'])">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">descendant::html:*[tokenize(@epub:type,'\s+')='footnote']</xsl:attribute>
                     <svrl:text>[nordic204c] <xsl:value-of select="if (self::html:body) then 'documents' else 'sections'"/> with the epub:type
                'footnotes' must have descendants with 'footnote'.</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
               <xsl:if test="not(.//html:ol)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">.//html:ol</xsl:attribute>
                     <svrl:text>[nordic204c] <xsl:value-of select="if (self::html:body) then 'documents' else 'sections'"/> with the epub:type 'footnotes' must have &lt;ol&gt; descendant
                elements.</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e1010')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:*[tokenize(@epub:type,'\s+')='footnote']" priority="46"
                 mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e1026">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e1026']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:*[tokenize(@epub:type,'\s+')='footnote']" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type,'\s+')='footnote']</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type,'\s+')='footnote']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(self::html:li)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">self::html:li</xsl:attribute>
                     <svrl:text>[nordic204d] 'footnote' can only be applied to &lt;li&gt; elements: <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
               <xsl:if test="not(tokenize(@class,'\s+')='notebody')">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">tokenize(@class,'\s+')='notebody'</xsl:attribute>
                     <svrl:text>[nordic204d] The 'notebody' class must be applied to all footnotes: <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e1026')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:*[tokenize(@epub:type,' ')='bodymatter']" priority="45"
                 mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="always-allowed-types"
                    select="('abstract','acknowledgments','afterword','answers','appendix','assessment','assessments','bibliography',                 'z3998:biographical-note','case-study','chapter','colophon','conclusion','contributors','copyright-page','credits','dedication','z3998:discography','division','z3998:editorial-note','epigraph','epilogue',                 'errata','z3998:filmography','footnotes','foreword','glossary','dictionary','z3998:grant-acknowledgment','halftitlepage','imprimatur','imprint','index','index-group','index-headnotes','index-legend','introduction',                 'keywords','landmarks','loa','loi','lot','lov','notice','other-credits','page-list','practices','preamble','preface','prologue','z3998:promotional-copy','z3998:published-works',                 'z3998:publisher-address','qna','rearnotes','endnotes','revision-history','z3998:section','seriespage','subchapter','z3998:subsection','toc','toc-brief','z3998:translator-note','volume')"/>
      <xsl:variable name="allowed-types" select="($always-allowed-types, 'part')"/>
      <schxslt:rule pattern="d7e1042">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e1042']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:*[tokenize(@epub:type,' ')='bodymatter']" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type,' ')='bodymatter']</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type,' ')='bodymatter']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(tokenize(@epub:type,'\s+')=$allowed-types)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">tokenize(@epub:type,'\s+')=$allowed-types</xsl:attribute>
                     <svrl:text>[nordic208] '<xsl:value-of select="(tokenize(@epub:type,'\s+')[not(.='bodymatter')],'(missing type)')[1]"/>' is not an allowed type in
                bodymatter. Elements with the type "bodymatter" must also have one of the types <xsl:value-of select="string-join($allowed-types[position() != last()],''', ''')"/> or '<xsl:value-of select="$allowed-types[last()]"/>'.</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e1042')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:*[self::html:section or self::html:article][parent::html:*[tokenize(@epub:type,' ')=('part','volume')]]"
                 priority="44"
                 mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="always-allowed-types"
                    select="('abstract','acknowledgments','afterword','answers','appendix','assessment','assessments','bibliography',                 'z3998:biographical-note','case-study','chapter','colophon','conclusion','contributors','copyright-page','credits','dedication','z3998:discography','division','z3998:editorial-note','epigraph','epilogue',                 'errata','z3998:filmography','footnotes','foreword','glossary','dictionary','z3998:grant-acknowledgment','halftitlepage','imprimatur','imprint','index','index-group','index-headnotes','index-legend','introduction',                 'keywords','landmarks','loa','loi','lot','lov','notice','other-credits','page-list','practices','preamble','preface','prologue','z3998:promotional-copy','z3998:published-works',                 'z3998:publisher-address','qna','rearnotes','endnotes','revision-history','z3998:section','seriespage','subchapter','z3998:subsection','toc','toc-brief','z3998:translator-note','volume')"/>
      <xsl:variable name="document-components"
                    select="('z3998:pgroup','z3998:example','z3998:epigraph','z3998:annotation','z3998:introductory-note','z3998:commentary','z3998:clarification','z3998:correction','z3998:alteration','z3998:presentation',                 'z3998:production','z3998:attribution','z3998:author','z3998:editor','z3998:general-editor','z3998:commentator','z3998:translator','z3998:republisher','z3998:structure','z3998:geographic',                 'z3998:postal','z3998:email','z3998:ftp','z3998:http','z3998:ip','z3998:aside','z3998:sidebar','z3998:practice','z3998:notice','z3998:warning','z3998:marginalia','z3998:help','z3998:drama',                 'z3998:scene','z3998:stage-direction','z3998:dramatis-personae','z3998:persona','z3998:actor','z3998:role-description','z3998:speech','z3998:diary','z3998:diary-entry','z3998:figure','z3998:plate',                 'z3998:gallery','z3998:letter','z3998:sender','z3998:recipient','z3998:salutation','z3998:valediction','z3998:postscript','z3998:email-message','z3998:to','z3998:from','z3998:cc','z3998:bcc',                 'z3998:subject','z3998:collection','z3998:orderedlist','z3998:unorderedlist','z3998:abbreviations','z3998:timeline','z3998:note','z3998:footnotes','z3998:footnote','z3998:rearnote','z3998:rearnotes',                 'z3998:verse','z3998:poem','z3998:song','z3998:hymn','z3998:lyrics')"/>
      <xsl:variable name="allowed-types" select="($always-allowed-types, $document-components)"/>
      <schxslt:rule pattern="d7e1064">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e1064']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:*[self::html:section or self::html:article][parent::html:*[tokenize(@epub:type,' ')=('part','volume')]]" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[self::html:section or self::html:article][parent::html:*[tokenize(@epub:type,' ')=('part','volume')]]</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[self::html:section or self::html:article][parent::html:*[tokenize(@epub:type,' ')=('part','volume')]]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(tokenize(@epub:type,'\s+')=$allowed-types)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">tokenize(@epub:type,'\s+')=$allowed-types</xsl:attribute>
                     <svrl:text>[nordic211] '<xsl:value-of select="(tokenize(@epub:type,'\s+')[not(.=('part','volume'))],'(missing type)')[1]"/>' is not an allowed
                type in a part. Sections inside a part must also have one of the types <xsl:value-of select="string-join($allowed-types[position() != last()],''', ''')"/> or '<xsl:value-of select="$allowed-types[last()]"/>'.</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e1064')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:*[tokenize(@epub:type,'\s+')='backmatter']" priority="43"
                 mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="always-allowed-types"
                    select="('abstract','acknowledgments','afterword','answers','appendix','assessment','assessments','bibliography',                 'z3998:biographical-note','case-study','chapter','colophon','conclusion','contributors','copyright-page','credits','dedication','z3998:discography','division','z3998:editorial-note','epigraph','epilogue',                 'errata','z3998:filmography','footnotes','foreword','glossary','dictionary','z3998:grant-acknowledgment','halftitlepage','imprimatur','imprint','index','index-group','index-headnotes','index-legend','introduction',                 'keywords','landmarks','loa','loi','lot','lov','notice','other-credits','page-list','practices','preamble','preface','prologue','z3998:promotional-copy','z3998:published-works',                 'z3998:publisher-address','qna','rearnotes','endnotes','revision-history','z3998:section','seriespage','subchapter','z3998:subsection','toc','toc-brief','z3998:translator-note','volume')"/>
      <xsl:variable name="allowed-types" select="($always-allowed-types)"/>
      <schxslt:rule pattern="d7e1087">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e1087']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:*[tokenize(@epub:type,'\s+')='backmatter']" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type,'\s+')='backmatter']</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type,'\s+')='backmatter']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(count(tokenize(@epub:type,'\s+')) = 1 or tokenize(@epub:type,'\s+')=$allowed-types)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count(tokenize(@epub:type,'\s+')) = 1 or tokenize(@epub:type,'\s+')=$allowed-types</xsl:attribute>
                     <svrl:text>[nordic215] '<xsl:value-of select="(tokenize(@epub:type,'\s+')[not(.='backmatter')],'(missing type)')[1]"/>' is not an allowed type in backmatter. On elements with the epub:type "backmatter", you can either
                leave the type blank<xsl:value-of select="if (ancestor::html:body[not(html:header)]) then '(and just use ''backmatter'' as the type in the filename)' else ''"/>, or you can use one of the
                following types: <xsl:value-of select="string-join($allowed-types[position() != last()],''', ''')"/> or '<xsl:value-of select="$allowed-types[last()]"/>'.</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e1087')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:span[tokenize(@class,' ')='linenum']" priority="42" mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e1110">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e1110']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:span[tokenize(@class,' ')='linenum']" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:span[tokenize(@class,' ')='linenum']</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:span[tokenize(@class,' ')='linenum']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(parent::html:p[tokenize(@class,' ')='line'])">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">parent::html:p[tokenize(@class,' ')='line']</xsl:attribute>
                     <svrl:text>[nordic224] linenums (span class="linenum") must be the child element of a line (p class="line"): <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;',string-join(.//text()[normalize-space()],' '),'&lt;/',name(),'&gt;')"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e1110')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:*[tokenize(@epub:type,' ')='pagebreak' and text()]" priority="41"
                 mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e1123">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e1123']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:*[tokenize(@epub:type,' ')='pagebreak' and text()]" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type,' ')='pagebreak' and text()]</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type,' ')='pagebreak' and text()]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(matches(@title,'.+'))">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">matches(@title,'.+')</xsl:attribute>
                     <svrl:text>[nordic225] The title attribute must be used to describe the page number: <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;',string-join(.//text()[normalize-space()],' '),'&lt;/',name(),'&gt;')"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e1123')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:body/html:header/html:h1" priority="40" mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e1135">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e1135']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:body/html:header/html:h1" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:body/html:header/html:h1</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:body/html:header/html:h1</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(tokenize(@epub:type,' ')='fulltitle')">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">tokenize(@epub:type,' ')='fulltitle'</xsl:attribute>
                     <svrl:text>[nordic247] The first headline in the html:body/html:header element must have the 'fulltitle' epub:type.</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e1135')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:body/html:header/html:*[not(self::html:h1)]" priority="39"
                 mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e1146">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e1146']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:body/html:header/html:*[not(self::html:h1)]" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:body/html:header/html:*[not(self::html:h1)]</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:body/html:header/html:*[not(self::html:h1)]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(self::html:p)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">self::html:p</xsl:attribute>
                     <svrl:text>[nordic248] The only allowed element inside html/header besides "h1" is "p".</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e1146')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:span[tokenize(@class,' ')='lic']" priority="38" mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e1160">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e1160']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:span[tokenize(@class,' ')='lic']" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:span[tokenize(@class,' ')='lic']</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:span[tokenize(@class,' ')='lic']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(parent::html:li or parent::html:a/parent::html:li)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">parent::html:li or parent::html:a/parent::html:li</xsl:attribute>
                     <svrl:text>[nordic251] The parent of a list item component (span class="lic") must be either a "li" or a "a" (where the "a" has "li"
                as parent): <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e1160')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:figure" priority="37" mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e1172">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e1172']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:figure" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:figure</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:figure</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(tokenize(@epub:type,'\s+')='sidebar' or tokenize(@class,'\s+')=('image','image-series'))">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">tokenize(@epub:type,'\s+')='sidebar' or tokenize(@class,'\s+')=('image','image-series')</xsl:attribute>
                     <svrl:text>[nordic253a] &lt;figure&gt; elements must either have an epub:type of "sidebar" or a
                class of "image" or "image-series": <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
               <xsl:if test="count((.[tokenize(@epub:type,'\s+')='sidebar'], .[tokenize(@class,'\s+')='image'], .[tokenize(@class,'\s+')='image-series'])) &gt; 1">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count((.[tokenize(@epub:type,'\s+')='sidebar'], .[tokenize(@class,'\s+')='image'], .[tokenize(@class,'\s+')='image-series'])) &gt; 1</xsl:attribute>
                     <svrl:text>[nordic253a] &lt;figure&gt; elements
                must either have an epub:type of "sidebar" or a class of "image" or "image-series": <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
               <xsl:if test="not(count(html:figcaption) &lt;= 1)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count(html:figcaption) &lt;= 1</xsl:attribute>
                     <svrl:text>[nordic253a] There cannot be more than one &lt;figcaption&gt; in a single figure element: <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e1172')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:figure[tokenize(@class,'\s+')='image']" priority="36" mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e1190">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e1190']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:figure[tokenize(@class,'\s+')='image']" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:figure[tokenize(@class,'\s+')='image']</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:figure[tokenize(@class,'\s+')='image']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(count(.//html:img) = 1)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count(.//html:img) = 1</xsl:attribute>
                     <svrl:text>[nordic253b] Image figures must contain exactly one img: <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
               <xsl:if test="not(count(html:img) = 1)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count(html:img) = 1</xsl:attribute>
                     <svrl:text>[nordic253b] The img in image figures must be a direct child of the figure: <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e1190')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:figure[tokenize(@class,'\s+')='image-series']" priority="35"
                 mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e1204">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e1204']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:figure[tokenize(@class,'\s+')='image-series']" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:figure[tokenize(@class,'\s+')='image-series']</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:figure[tokenize(@class,'\s+')='image-series']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(count(html:img) = 0)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count(html:img) = 0</xsl:attribute>
                     <svrl:text>[nordic253c] Image series figures cannot contain img childen (the img elements must be contained in children figure elements): <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
               <xsl:if test="not(count(html:figure[tokenize(@class,'\s+')='image']) &gt;= 2)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count(html:figure[tokenize(@class,'\s+')='image']) &gt;= 2</xsl:attribute>
                     <svrl:text>[nordic253c] Image series must contain at least 2 image figures ("figure" elements with class "image"): <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e1204')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:aside" priority="34" mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e1221">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e1221']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:aside" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:aside</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:aside</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(tokenize(@epub:type,' ') = ('z3998:production','sidebar','note','annotation','epigraph'))">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">tokenize(@epub:type,' ') = ('z3998:production','sidebar','note','annotation','epigraph')</xsl:attribute>
                     <svrl:text>[nordic254] &lt;aside&gt; elements must use one of the following epub:types:
                z3998:production, sidebar, note, annotation, epigraph (<xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>)</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e1221')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:abbr" priority="33" mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e1234">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e1234']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:abbr" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:abbr</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:abbr</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(tokenize(@epub:type,' ') = ('z3998:acronym','z3998:initialism','z3998:truncation'))">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">tokenize(@epub:type,' ') = ('z3998:acronym','z3998:initialism','z3998:truncation')</xsl:attribute>
                     <svrl:text>[nordic255] "abbr" elements must use one of the following epub:types: z3998:acronym
                (formed from the first part of a word: "Mr.", "approx.", "lbs.", "rec'd"), z3998:initialism (each letter pronounced separately: "XML", "US"), z3998:truncation (pronounced as a word:
                "NATO"): <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e1234')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:body[ancestor-or-self::*/tokenize(@epub:type,'\s+') = 'bodymatter' and count(* except (html:h1 | *[tokenize(@epub:type,'\s+')='pagebreak'])) = 0] | html:section[ancestor-or-self::*/tokenize(@epub:type,'\s+') = 'bodymatter' and count(* except (html:h1 | *[tokenize(@epub:type,'\s+')='pagebreak'])) = 0]"
                 priority="32"
                 mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e1246">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e1246']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:body[ancestor-or-self::*/tokenize(@epub:type,'\s+') = 'bodymatter' and count(* except (html:h1 | *[tokenize(@epub:type,'\s+')='pagebreak'])) = 0] | html:section[ancestor-or-self::*/tokenize(@epub:type,'\s+') = 'bodymatter' and count(* except (html:h1 | *[tokenize(@epub:type,'\s+')='pagebreak'])) = 0]" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:body[ancestor-or-self::*/tokenize(@epub:type,'\s+') = 'bodymatter' and count(* except (html:h1 | *[tokenize(@epub:type,'\s+')='pagebreak'])) = 0] | html:section[ancestor-or-self::*/tokenize(@epub:type,'\s+') = 'bodymatter' and count(* except (html:h1 | *[tokenize(@epub:type,'\s+')='pagebreak'])) = 0]</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:body[ancestor-or-self::*/tokenize(@epub:type,'\s+') = 'bodymatter' and count(* except (html:h1 | *[tokenize(@epub:type,'\s+')='pagebreak'])) = 0] | html:section[ancestor-or-self::*/tokenize(@epub:type,'\s+') = 'bodymatter' and count(* except (html:h1 | *[tokenize(@epub:type,'\s+')='pagebreak'])) = 0]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(tokenize(@epub:type,'\s+') = 'part')">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">tokenize(@epub:type,'\s+') = 'part'</xsl:attribute>
                     <svrl:text>[nordic256] In bodymatter, "<xsl:value-of select="name()"/>" elements must contain more than just a headline and pagebreaks (except when epub:type="part"):
                    <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e1246')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="*[@xml:lang or @lang]" priority="31" mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e1261">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e1261']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "*[@xml:lang or @lang]" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">*[@xml:lang or @lang]</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">*[@xml:lang or @lang]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(@xml:lang = @lang)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">@xml:lang = @lang</xsl:attribute>
                     <svrl:text>[nordic257] The `xml:lang` and the `lang` attributes must have the same value: <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e1261')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:div[../html:body and tokenize(@epub:type,'\s')='pagebreak']"
                 priority="30"
                 mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e1273">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e1273']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:div[../html:body and tokenize(@epub:type,'\s')='pagebreak']" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:div[../html:body and tokenize(@epub:type,'\s')='pagebreak']</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:div[../html:body and tokenize(@epub:type,'\s')='pagebreak']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="preceding-sibling::html:div[tokenize(@epub:type,'\s')='pagebreak']">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">preceding-sibling::html:div[tokenize(@epub:type,'\s')='pagebreak']</xsl:attribute>
                     <svrl:text>[nordic258] Only one pagebreak is allowed before any content in each content file: <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e1273')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:*[tokenize(@epub:type,'\s+')='pagebreak']" priority="29"
                 mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e1285">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e1285']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:*[tokenize(@epub:type,'\s+')='pagebreak']" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type,'\s+')='pagebreak']</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@epub:type,'\s+')='pagebreak']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="ancestor::html:thead">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">ancestor::html:thead</xsl:attribute>
                     <svrl:text>[nordic259] Pagebreaks can not occur within table headers (thead): <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
               <xsl:if test="ancestor::html:tfoot">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">ancestor::html:tfoot</xsl:attribute>
                     <svrl:text>[nordic259] Pagebreaks can not occur within table footers (tfoot): <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e1285')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:figure[tokenize(@class,'\s+')='image']" priority="28" mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e1302">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e1302']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:figure[tokenize(@class,'\s+')='image']" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:figure[tokenize(@class,'\s+')='image']</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:figure[tokenize(@class,'\s+')='image']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(html:img intersect *[1])">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">html:img intersect *[1]</xsl:attribute>
                     <svrl:text>[nordic260a] The first element in a figure with class="image" must be a "img" element: <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e1302')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:figure[tokenize(@class, '\s+') = 'image-series']/html:*[not(self::html:figure[tokenize(@class, '\s+') = 'image'] | self::html:details)]"
                 priority="27"
                 mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e1312">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e1312']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:figure[tokenize(@class, '\s+') = 'image-series']/html:*[not(self::html:figure[tokenize(@class, '\s+') = 'image'] | self::html:details)]" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:figure[tokenize(@class, '\s+') = 'image-series']/html:*[not(self::html:figure[tokenize(@class, '\s+') = 'image'] | self::html:details)]</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:figure[tokenize(@class, '\s+') = 'image-series']/html:*[not(self::html:figure[tokenize(@class, '\s+') = 'image'] | self::html:details)]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="preceding-sibling::html:figure[tokenize(@class,'\s+')='image']">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">preceding-sibling::html:figure[tokenize(@class,'\s+')='image']</xsl:attribute>
                     <svrl:text>[nordic260b] Content not allowed between or after image figure elements: <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e1312')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:div" priority="26" mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e1324">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e1324']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:div" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:div</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:div</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="text()[normalize-space(.)]">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">text()[normalize-space(.)]</xsl:attribute>
                     <svrl:text>[nordic261] Text can't be placed directly inside div elements. Try wrapping it in a p element: <xsl:value-of select="normalize-space(string-join(text(),' '))"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e1324')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:body[tokenize(@epub:type,'\s+')='titlepage'] | html:section[tokenize(@epub:type,'\s+')='titlepage']"
                 priority="25"
                 mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e1336">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e1336']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:body[tokenize(@epub:type,'\s+')='titlepage'] | html:section[tokenize(@epub:type,'\s+')='titlepage']" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:body[tokenize(@epub:type,'\s+')='titlepage'] | html:section[tokenize(@epub:type,'\s+')='titlepage']</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:body[tokenize(@epub:type,'\s+')='titlepage'] | html:section[tokenize(@epub:type,'\s+')='titlepage']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(count(html:*[matches(local-name(),'h\d')]))">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count(html:*[matches(local-name(),'h\d')])</xsl:attribute>
                     <svrl:text>[nordic263] the titlepage must have a headline (and the headline must have epub:type="fulltitle" and class="title")</svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e1336')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:body[tokenize(@epub:type,'\s+')='titlepage']/html:*[matches(local-name(),'h\d')] | html:section[tokenize(@epub:type,'\s+')='titlepage']/html:*[matches(local-name(),'h\d')]"
                 priority="24"
                 mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e1348">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e1348']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:body[tokenize(@epub:type,'\s+')='titlepage']/html:*[matches(local-name(),'h\d')] | html:section[tokenize(@epub:type,'\s+')='titlepage']/html:*[matches(local-name(),'h\d')]" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:body[tokenize(@epub:type,'\s+')='titlepage']/html:*[matches(local-name(),'h\d')] | html:section[tokenize(@epub:type,'\s+')='titlepage']/html:*[matches(local-name(),'h\d')]</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:body[tokenize(@epub:type,'\s+')='titlepage']/html:*[matches(local-name(),'h\d')] | html:section[tokenize(@epub:type,'\s+')='titlepage']/html:*[matches(local-name(),'h\d')]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(tokenize(@epub:type,'\s+') = 'fulltitle')">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">tokenize(@epub:type,'\s+') = 'fulltitle'</xsl:attribute>
                     <svrl:text>[nordic264] the headline on the titlepage must have a epub:type with the value "fulltitle": <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
               <xsl:if test="not(tokenize(@class,'\s+') = 'title')">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">tokenize(@class,'\s+') = 'title'</xsl:attribute>
                     <svrl:text>[nordic264] the headline on the titlepage must have a class with the value "title": <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e1348')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:*[tokenize(@class,'\s+')='linegroup']" priority="23" mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e1362">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e1362']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:*[tokenize(@class,'\s+')='linegroup']" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@class,'\s+')='linegroup']</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[tokenize(@class,'\s+')='linegroup']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="count(html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6) &gt; 0 and not(self::html:section)">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count(html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6) &gt; 0 and not(self::html:section)</xsl:attribute>
                     <svrl:text>[nordic265] linegroups with headlines must be section elements: <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
               <xsl:if test="count(html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6)   =  0 and not(self::html:div)">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count(html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6)   =  0 and not(self::html:div)</xsl:attribute>
                     <svrl:text>[nordic265] linegroups without headlines must be div elements: <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e1362')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:*[*[tokenize(@epub:type,'\s+')='footnote']]" priority="22"
                 mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e1376">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e1376']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:*[*[tokenize(@epub:type,'\s+')='footnote']]" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[*[tokenize(@epub:type,'\s+')='footnote']]</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[*[tokenize(@epub:type,'\s+')='footnote']]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(self::html:ol)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">self::html:ol</xsl:attribute>
                     <svrl:text>[nordic266a] Footnotes must be wrapped in a "ol" element, but is currently wrapped in a <xsl:value-of select="name()"/>: <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e1376')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:section[tokenize(@epub:type,'\s+')='footnotes']/html:ol/html:li | html:body[tokenize(@epub:type,'\s+')='footnotes']/html:ol/html:li"
                 priority="21"
                 mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e1388">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e1388']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:section[tokenize(@epub:type,'\s+')='footnotes']/html:ol/html:li | html:body[tokenize(@epub:type,'\s+')='footnotes']/html:ol/html:li" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:section[tokenize(@epub:type,'\s+')='footnotes']/html:ol/html:li | html:body[tokenize(@epub:type,'\s+')='footnotes']/html:ol/html:li</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:section[tokenize(@epub:type,'\s+')='footnotes']/html:ol/html:li | html:body[tokenize(@epub:type,'\s+')='footnotes']/html:ol/html:li</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(tokenize(@epub:type,'\s+')='footnote')">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">tokenize(@epub:type,'\s+')='footnote'</xsl:attribute>
                     <svrl:text>[nordic266b] List items inside a footnotes list must use epub:type="footnote": <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e1388')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:*[*[tokenize(@epub:type,'\s+')='rearnote']]" priority="20"
                 mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e1398">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e1398']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:*[*[tokenize(@epub:type,'\s+')='rearnote']]" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[*[tokenize(@epub:type,'\s+')='rearnote']]</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[*[tokenize(@epub:type,'\s+')='rearnote']]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(self::html:ol)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">self::html:ol</xsl:attribute>
                     <svrl:text>[nordic267a] Rearnotes must be wrapped in a "ol" element, but is currently wrapped in a <xsl:value-of select="name()"/>: <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e1398')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:*[*[tokenize(@epub:type,'\s+')='endnote']]" priority="19"
                 mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e1398">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e1398']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:*[*[tokenize(@epub:type,'\s+')='endnote']]" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[*[tokenize(@epub:type,'\s+')='endnote']]</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:*[*[tokenize(@epub:type,'\s+')='endnote']]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(self::html:ol)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">self::html:ol</xsl:attribute>
                     <svrl:text>[nordic267a] Endnotes must be wrapped in a "ol" element, but is currently wrapped in a <xsl:value-of select="name()"/>: <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e1398')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:section[tokenize(@epub:type,'\s+')='rearnotes']/html:ol/html:li | html:body[tokenize(@epub:type,'\s+')='rearnotes']/html:ol/html:li"
                 priority="18"
                 mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e1419">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e1419']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:section[tokenize(@epub:type,'\s+')='rearnotes']/html:ol/html:li | html:body[tokenize(@epub:type,'\s+')='rearnotes']/html:ol/html:li" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:section[tokenize(@epub:type,'\s+')='rearnotes']/html:ol/html:li | html:body[tokenize(@epub:type,'\s+')='rearnotes']/html:ol/html:li</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:section[tokenize(@epub:type,'\s+')='rearnotes']/html:ol/html:li | html:body[tokenize(@epub:type,'\s+')='rearnotes']/html:ol/html:li</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(tokenize(@epub:type,'\s+')='rearnote')">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">tokenize(@epub:type,'\s+')='rearnote'</xsl:attribute>
                     <svrl:text>[nordic267b] List items inside a rearnotes list must use epub:type="rearnote": <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e1419')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:section[tokenize(@epub:type,'\s+')='endnotes']/html:ol/html:li | html:body[tokenize(@epub:type,'\s+')='endnotes']/html:ol/html:li"
                 priority="17"
                 mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e1419">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e1419']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:section[tokenize(@epub:type,'\s+')='endnotes']/html:ol/html:li | html:body[tokenize(@epub:type,'\s+')='endnotes']/html:ol/html:li" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:section[tokenize(@epub:type,'\s+')='endnotes']/html:ol/html:li | html:body[tokenize(@epub:type,'\s+')='endnotes']/html:ol/html:li</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:section[tokenize(@epub:type,'\s+')='endnotes']/html:ol/html:li | html:body[tokenize(@epub:type,'\s+')='endnotes']/html:ol/html:li</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(tokenize(@epub:type,'\s+')='endnote')">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">tokenize(@epub:type,'\s+')='endnote'</xsl:attribute>
                     <svrl:text>[nordic267b] List items inside a endnotes list must use epub:type="endnote": <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e1419')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6" priority="16"
                 mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="sectioning-element"
                    select="ancestor::*[self::html:section or self::html:article or self::html:aside or self::html:nav or self::html:body][1]"/>
      <xsl:variable name="this-level"
                    select="xs:integer(replace(name(),'.*(\d)$','$1')) + (if (ancestor::html:header[parent::html:body]) then -1 else 0)"/>
      <xsl:variable name="child-sectioning-elements"
                    select="$sectioning-element//*[self::html:section or self::html:article or self::html:aside or self::html:nav or self::html:figure][ancestor::*[self::html:section or self::html:article or self::html:aside or self::html:nav or self::html:body][1] intersect $sectioning-element]"/>
      <xsl:variable name="child-sectioning-element-with-wrong-level"
                    select="$child-sectioning-elements[count(html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6) != 0 and (html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6)/xs:integer(replace(name(),'.*(\d)$','$1')) != min((6, $this-level + 1))][1]"/>
      <schxslt:rule pattern="d7e1439">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e1439']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(count($child-sectioning-element-with-wrong-level) = 0)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count($child-sectioning-element-with-wrong-level) = 0</xsl:attribute>
                     <svrl:text>[nordic268] The subsections of <xsl:value-of select="concat('&lt;',$sectioning-element/name(),string-join(for $a in ($sectioning-element/@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/> (which contains
                the headline <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                        <xsl:value-of select="string-join(.//text(),' ')"/>&lt;/<xsl:value-of select="name()"/>&gt;) must only use &lt;h<xsl:value-of select="min((6, $this-level + 1))"/>&gt; for headlines. It contains the element <xsl:value-of select="concat('&lt;',$child-sectioning-element-with-wrong-level/name(),string-join(for $a in ($child-sectioning-element-with-wrong-level/@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/> which contains the headline <xsl:value-of select="concat('&lt;',$child-sectioning-element-with-wrong-level/(html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6)[1]/name(),string-join(for $a in ($child-sectioning-element-with-wrong-level/(html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6)[1]/@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;',string-join($child-sectioning-element-with-wrong-level/(html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6)[1]//text(),' '),'&lt;/',$child-sectioning-element-with-wrong-level/(html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6)[1]/name(),'&gt;')"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e1439')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:body[not(html:header)]" priority="15" mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="filename-regex"
                    select="'^.*/[A-Za-z0-9_-]+-\d+-([a-z-]+)(-\d+)?\.xhtml$'"/>
      <xsl:variable name="base-uri-type"
                    select="if (matches(base-uri(.), $filename-regex)) then replace(base-uri(.), $filename-regex, '$1') else ()"/>
      <schxslt:rule pattern="d7e1470">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e1470']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:body[not(html:header)]" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:body[not(html:header)]</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:body[not(html:header)]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(not(matches(base-uri(.), $filename-regex)) or (for $t in tokenize(@epub:type,'\s+') return tokenize($t,':')[last()]) = $base-uri-type)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">not(matches(base-uri(.), $filename-regex)) or (for $t in tokenize(@epub:type,'\s+') return tokenize($t,':')[last()]) = $base-uri-type</xsl:attribute>
                     <svrl:text>[nordic269] The type used in the
                filename (<xsl:value-of select="$base-uri-type"/>) must be present on the body element: <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e1470')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:p[tokenize(@epub:type,'\t+')='bridgehead']" priority="14"
                 mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e1486">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e1486']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:p[tokenize(@epub:type,'\t+')='bridgehead']" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:p[tokenize(@epub:type,'\t+')='bridgehead']</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:p[tokenize(@epub:type,'\t+')='bridgehead']</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(parent::html:body | parent::html:section | parent::html:article | parent::html:div)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">parent::html:body | parent::html:section | parent::html:article | parent::html:div</xsl:attribute>
                     <svrl:text>[nordic270] Bridgehead is only allowed as a child of <xsl:value-of select="if (ancestor::html:body[not(html:header)]) then 'body, ' else ' '"/>section, article and div: <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e1486')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:a[starts-with(@href, '#')]" priority="13" mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e1500">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e1500']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:a[starts-with(@href, '#')]" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:a[starts-with(@href, '#')]</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:a[starts-with(@href, '#')]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(count(//html:*[@id=substring(current()/@href, 2)])=1)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count(//html:*[@id=substring(current()/@href, 2)])=1</xsl:attribute>
                     <svrl:text>[nordic273] Internal link ("<xsl:value-of select="@href"/>") does not resolve: <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e1500')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:a[not(matches(@href, '^([a-z]+:/+|mailto:|tel:)'))]" priority="12"
                 mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e1515">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e1515']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:a[not(matches(@href, '^([a-z]+:/+|mailto:|tel:)'))]" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:a[not(matches(@href, '^([a-z]+:/+|mailto:|tel:)'))]</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:a[not(matches(@href, '^([a-z]+:/+|mailto:|tel:)'))]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(matches(@href, '.*#.+'))">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">matches(@href, '.*#.+')</xsl:attribute>
                     <svrl:text>[nordic273b] Internal links must contain a non-empty fragment identifier: <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e1515')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:th[@headers] | html:td[@headers]" priority="11" mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e1527">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e1527']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:th[@headers] | html:td[@headers]" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:th[@headers] | html:td[@headers]</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:th[@headers] | html:td[@headers]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(count(                 ancestor::html:table//html:th/@id[contains( concat(' ',current()/@headers,' '), concat(' ',normalize-space(),' ') )]                 ) =                  string-length(normalize-space(@headers)) - string-length(translate(normalize-space(@headers), ' ','')) + 1                 )">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">count(                 ancestor::html:table//html:th/@id[contains( concat(' ',current()/@headers,' '), concat(' ',normalize-space(),' ') )]                 ) =                  string-length(normalize-space(@headers)) - string-length(translate(normalize-space(@headers), ' ','')) + 1                 </xsl:attribute>
                     <svrl:text>[nordic274] Not all the tokens in the headers attribute match the id attributes of 'th' elements in this or a parent table: <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e1527')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:img[@longdesc and ancestor::html:body[html:header]]" priority="10"
                 mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e1539">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e1539']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:img[@longdesc and ancestor::html:body[html:header]]" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:img[@longdesc and ancestor::html:body[html:header]]</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:img[@longdesc and ancestor::html:body[html:header]]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(substring-after(normalize-space(@longdesc),'#') = //@id)">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">substring-after(normalize-space(@longdesc),'#') = //@id</xsl:attribute>
                     <svrl:text>[nordic275] The URL in the img longdesc attribute does not reference any element in the publication: <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e1539')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:a" priority="9" mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e1552">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e1552']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:a" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:a</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:a</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="@accesskey and string-length(@accesskey)!=1">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">@accesskey and string-length(@accesskey)!=1</xsl:attribute>
                     <svrl:text>[nordic276] The accesskey attribute value is not 1 character long: <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
               <xsl:if test="@tabindex and string-length(translate(@width,'0123456789',''))!=0">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">@tabindex and string-length(translate(@width,'0123456789',''))!=0</xsl:attribute>
                     <svrl:text>[nordic276] The tabindex attribute value is not expressed in numbers: <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e1552')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:img" priority="8" mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e1570">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e1570']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:img" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:img</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:img</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(not(@width) or                  string-length(translate(@width,'0123456789',''))=0 or                 (contains(@width,'%') and substring-after(@width,'%')='' and translate(@width,'%0123456789','')='' and string-length(@width)&gt;=2))">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">not(@width) or                  string-length(translate(@width,'0123456789',''))=0 or                 (contains(@width,'%') and substring-after(@width,'%')='' and translate(@width,'%0123456789','')='' and string-length(@width)&gt;=2)</xsl:attribute>
                     <svrl:text>[nordic277] The image width is not expressed in pixels or percentage: <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
               <xsl:if test="not(not(@height) or                  string-length(translate(@height,'0123456789',''))=0 or                 (contains(@height,'%') and substring-after(@height,'%')='' and translate(@height,'%0123456789','')='' and string-length(@height)&gt;=2))">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">not(@height) or                  string-length(translate(@height,'0123456789',''))=0 or                 (contains(@height,'%') and substring-after(@height,'%')='' and translate(@height,'%0123456789','')='' and string-length(@height)&gt;=2)</xsl:attribute>
                     <svrl:text>[nordic277] The image height is not expressed in pixels or percentage: <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e1570')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:table" priority="7" mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e1586">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e1586']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:table" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:table</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:table</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(not(@width) or                  string-length(translate(@width,'0123456789',''))=0 or                 (contains(@width,'%') and substring-after(@width,'%')='' and translate(@width,'%0123456789','')='' and string-length(@width)&gt;=2))">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">not(@width) or                  string-length(translate(@width,'0123456789',''))=0 or                 (contains(@width,'%') and substring-after(@width,'%')='' and translate(@width,'%0123456789','')='' and string-length(@width)&gt;=2)</xsl:attribute>
                     <svrl:text>[nordic278] Table width is not expressed in pixels or percentage: <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
               <xsl:if test="not(not(@cellspacing) or                  string-length(translate(@cellspacing,'0123456789',''))=0 or                 (contains(@cellspacing,'%') and substring-after(@cellspacing,'%')='' and translate(@cellspacing,'%0123456789','')='' and string-length(@cellspacing)&gt;=2))">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">not(@cellspacing) or                  string-length(translate(@cellspacing,'0123456789',''))=0 or                 (contains(@cellspacing,'%') and substring-after(@cellspacing,'%')='' and translate(@cellspacing,'%0123456789','')='' and string-length(@cellspacing)&gt;=2)</xsl:attribute>
                     <svrl:text>[nordic278] Table cellspacing is not expressed in pixels or percentage: <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
               <xsl:if test="not(not(@cellpadding) or                  string-length(translate(@cellpadding,'0123456789',''))=0 or                 (contains(@cellpadding,'%') and substring-after(@cellpadding,'%')='' and translate(@cellpadding,'%0123456789','')='' and string-length(@cellpadding)&gt;=2))">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">not(@cellpadding) or                  string-length(translate(@cellpadding,'0123456789',''))=0 or                 (contains(@cellpadding,'%') and substring-after(@cellpadding,'%')='' and translate(@cellpadding,'%0123456789','')='' and string-length(@cellpadding)&gt;=2)</xsl:attribute>
                     <svrl:text>[nordic278] Table cellpadding is not expressed in pixels or percentage: <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e1586')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:ul | html:ol[matches(@style,'list-style-type:\s*none;')]"
                 priority="6"
                 mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e1607">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e1607']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:ul | html:ol[matches(@style,'list-style-type:\s*none;')]" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:ul | html:ol[matches(@style,'list-style-type:\s*none;')]</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:ul | html:ol[matches(@style,'list-style-type:\s*none;')]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="@start">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">@start</xsl:attribute>
                     <svrl:text>[nordic279a] The start attribute occurs in a non-numbered list: <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e1607')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:ol[@start]" priority="5" mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e1617">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e1617']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:ol[@start]" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:ol[@start]</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:ol[@start]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="@start='' or string-length(translate(@start,'0123456789',''))!=0">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">@start='' or string-length(translate(@start,'0123456789',''))!=0</xsl:attribute>
                     <svrl:text>[nordic279b] The start attribute is not a non negative number: <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e1617')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:meta" priority="4" mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e1629">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e1629']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:meta" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:meta</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:meta</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="starts-with(@name, 'dc:') and not(@name='dc:title' or @name='dc:subject' or @name='dc:description' or                 @name='dc:type' or @name='dc:source' or @name='dc:relation' or                  @name='dc:coverage' or @name='dc:creator' or @name='dc:publisher' or                  @name='dc:contributor' or @name='dc:rights' or @name='dc:date' or                  @name='dc:format' or @name='dc:identifier' or @name='dc:language')">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">starts-with(@name, 'dc:') and not(@name='dc:title' or @name='dc:subject' or @name='dc:description' or                 @name='dc:type' or @name='dc:source' or @name='dc:relation' or                  @name='dc:coverage' or @name='dc:creator' or @name='dc:publisher' or                  @name='dc:contributor' or @name='dc:rights' or @name='dc:date' or                  @name='dc:format' or @name='dc:identifier' or @name='dc:language')</xsl:attribute>
                     <svrl:text>[nordic280] Unrecognized Dublin Core metadata name: <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
               <xsl:if test="starts-with(@name, 'DC:') or starts-with(@name, 'Dc:') or starts-with(@name, 'dC:')">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">starts-with(@name, 'DC:') or starts-with(@name, 'Dc:') or starts-with(@name, 'dC:')</xsl:attribute>
                     <svrl:text>[nordic280] Unrecognized Dublin Core metadata prefix: <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e1629')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:col | html:colgroup" priority="3" mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e1645">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e1645']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:col | html:colgroup" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:col | html:colgroup</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:col | html:colgroup</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="@span and (translate(@span,'0123456789','')!='' or starts-with(@span,'0'))">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">@span and (translate(@span,'0123456789','')!='' or starts-with(@span,'0'))</xsl:attribute>
                     <svrl:text>[nordic281] span attribute is not a positive integer: <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e1645')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:td | html:th" priority="2" mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e1658">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e1658']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:td | html:th" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:td | html:th</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:td | html:th</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="@rowspan and (translate(@rowspan,'0123456789','')!='' or starts-with(@rowspan,'0'))">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">@rowspan and (translate(@rowspan,'0123456789','')!='' or starts-with(@rowspan,'0'))</xsl:attribute>
                     <svrl:text>[nordic282] The rowspan attribute value is not a positive integer: <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
               <xsl:if test="@colspan and (translate(@colspan,'0123456789','')!='' or starts-with(@colspan,'0'))">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">@colspan and (translate(@colspan,'0123456789','')!='' or starts-with(@colspan,'0'))</xsl:attribute>
                     <svrl:text>[nordic282] The colspan attribute value is not a positive integer: <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
               <xsl:if test="@rowspan and number(@rowspan) &gt; count(parent::html:tr/following-sibling::html:tr | parent::html:tr/parent::html:*/following-sibling::html:*/html:tr)+1">
                  <svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">@rowspan and number(@rowspan) &gt; count(parent::html:tr/following-sibling::html:tr | parent::html:tr/parent::html:*/following-sibling::html:*/html:tr)+1</xsl:attribute>
                     <svrl:text>[nordic282] The
                rowspan attribute value is larger than the number of rows left in the table: <xsl:value-of select="concat('&lt;',name(),string-join(for $a in (@*) return concat(' ',$a/name(),'=&#34;',$a,'&#34;'),''),'&gt;')"/>
                     </svrl:text>
                  </svrl:successful-report>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e1658')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="m:*[contains(name(), ':')]" priority="1" mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <schxslt:rule pattern="d7e1676">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e1676']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "m:*[contains(name(), ':')]" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">m:*[contains(name(), ':')]</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
               <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">m:*[contains(name(), ':')]</xsl:attribute>
               </svrl:fired-rule>
               <xsl:if test="not(substring-before(name(), ':') = 'm')">
                  <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" location="{schxslt:location(.)}">
                     <xsl:attribute name="test">substring-before(name(), ':') = 'm'</xsl:attribute>
                     <svrl:text>[nordic283] When using MathML with a namespace prefix, that prefix must be 'm'. Not <xsl:value-of select="substring-before(name(), ':')"/>
                     </svrl:text>
                  </svrl:failed-assert>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e1676')"/>
      </xsl:next-match>
   </xsl:template>
   <xsl:template match="html:details[preceding-sibling::*[1]/tokenize(@class, '\s+') = 'image']"
                 priority="0"
                 mode="d7e23">
      <xsl:param name="schxslt:patterns-matched" as="xs:string*"/>
      <xsl:variable name="context"
                    select="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&#34;', $a, '&#34;'), ''), '&gt;)')"/>
      <schxslt:rule pattern="d7e1686">
         <xsl:choose>
            <xsl:when test="$schxslt:patterns-matched[. = 'd7e1686']">
               <xsl:comment xmlns:svrl="http://purl.oclc.org/dsdl/svrl">WARNING: Rule for context "html:details[preceding-sibling::*[1]/tokenize(@class, '\s+') = 'image']" shadowed by preceeding rule</xsl:comment>
               <svrl:suppressed-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
                  <xsl:attribute name="context">html:details[preceding-sibling::*[1]/tokenize(@class, '\s+') = 'image']</xsl:attribute>
               </svrl:suppressed-rule>
            </xsl:when>
            <xsl:otherwise>
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
            </xsl:otherwise>
         </xsl:choose>
      </schxslt:rule>
      <xsl:next-match>
         <xsl:with-param name="schxslt:patterns-matched" as="xs:string*"
                         select="($schxslt:patterns-matched, 'd7e1686')"/>
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