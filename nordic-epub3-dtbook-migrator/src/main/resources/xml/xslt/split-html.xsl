<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:f="http://www.daisy.org/ns/pipeline/split-html/internal-functions" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0" xmlns:epub="http://www.idpf.org/2007/ops"
    xmlns="http://www.w3.org/1999/xhtml" xpath-default-namespace="http://www.w3.org/1999/xhtml" exclude-result-prefixes="#all" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:pf="http://www.daisy.org/ns/pipeline/functions" xmlns:svg="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:m="http://www.w3.org/1998/Math/MathML">

    <xsl:import href="http://www.daisy.org/pipeline/modules/file-utils/uri-functions.xsl"/>
    <!--    <xsl:import href="../../../../test/xspec/mock/uri-functions.xsl"/>-->

    <xsl:param name="output-dir" required="yes"/>

    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="/*">
        <wrapper>
            <xsl:attribute name="xml:base" select="base-uri(/*)"/>

            <xsl:variable name="base" select="base-uri(/*)"/>
            <xsl:for-each select="/html/body/*">
                <xsl:variable name="body" select="."/>

                <html>
                    <xsl:namespace name="nordic" select="'http://www.mtm.se/epub/'"/>
                    <xsl:copy-of select="/*/@* | @xml:base"/>
                    <head>
                        <xsl:copy-of select="/html/head/@*"/>
                        <xsl:for-each select="/html/head/*">
                            <xsl:choose>
                                <xsl:when test="self::link[@rel=('prev','next')]"/>
                                <xsl:otherwise>
                                    <xsl:copy-of select="."/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:for-each>
                        <xsl:if test="position()&gt;1">
                            <link rel="prev" href="{pf:relativize-uri(base-uri(preceding-sibling::*[1]),base-uri(.))}"/>
                        </xsl:if>
                        <xsl:if test="position()&lt;last()">
                            <link rel="next" href="{pf:relativize-uri(base-uri(following-sibling::*[1]),base-uri(.))}"/>
                        </xsl:if>
                    </head>
                    <body>
                        <xsl:apply-templates select="$body/(@* except @xml:base)"/>
                        <xsl:apply-templates select="$body/*"/>
                    </body>
                </html>
            </xsl:for-each>

        </wrapper>
    </xsl:template>

    <xsl:template match="@src | @href | @data[parent::object] | @xlink:href | @altimg | @longdesc">
        <xsl:variable name="original-uri" select="if (replace(.,'^(.*)#(.*)$','$1')='') then base-uri(/*) else resolve-uri(replace(.,'^(.*)#(.*)$','$1'), base-uri(/*))"/>
        <xsl:variable name="original-uri-relative" select="pf:relativize-uri($original-uri, base-uri(/*))"/>
        <xsl:choose>
            <xsl:when test="$original-uri-relative=replace(base-uri(/*),'^.*/([^/]*)$','$1')">
                <xsl:variable name="target-id" select="substring-after(.,'#')"/>
                <xsl:variable name="target" select="(//*[(@id,@xml:id)=$target-id])[1]"/>
                <xsl:choose>
                    <xsl:when test="$target">
                        <xsl:attribute name="{name()}" select="concat(pf:relativize-uri(base-uri($target),$original-uri),'#',$target-id)"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:attribute name="{name()}" select="'#'"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:copy-of select="."/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:function name="f:types" as="xs:string*">
        <xsl:param name="element" as="element()"/>
        <xsl:sequence select="tokenize($element/@epub:type,'\s+')"/>
    </xsl:function>

</xsl:stylesheet>
