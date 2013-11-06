<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:f="http://www.daisy.org/ns/pipeline/internal-functions" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0" xmlns:epub="http://www.idpf.org/2007/ops"
    xmlns="http://www.w3.org/1999/xhtml" xpath-default-namespace="http://www.w3.org/1999/xhtml" exclude-result-prefixes="#all" xmlns:xs="http://www.w3.org/2001/XMLSchema">

    <xsl:param name="output-dir" required="yes"/>
    <xsl:param name="xspec" select="false()"/>

    <xsl:variable name="split-types" select="('cover','titlepage','colophon','toc','part','chapter','index','appendix','glossary','footnotes','rearnotes')"/>

    <xsl:template match="/*">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:attribute name="xml:base" select="base-uri(/*)"/>
            <xsl:copy-of select="head"/>
            <xsl:for-each select="body">
                <xsl:copy>
                    <xsl:copy-of select="@*"/>
                    <xsl:for-each select="*">
                        <xsl:copy>
                            <xsl:variable name="content-type" select="(f:types(.)[.=$split-types],'chapter')[1]"/>
                            <xsl:variable name="position">
                                <xsl:choose>
                                    <xsl:when test="parent::*/*[f:types(.)=$content-type]">
                                        <xsl:sequence select="count(preceding-sibling::*[f:types(.)=$content-type])+1"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:sequence select="count(preceding-sibling::*)+1"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:variable>
                            <xsl:variable name="filename" select="if ($content-type=('part','chapter','appendix')) then concat($content-type,$position) else $content-type"/>

                            <xsl:copy-of select="@*"/>
                            <xsl:attribute name="xml:base" select="concat($output-dir,$filename,'.xhtml')"/>
                            <xsl:copy-of select="*"/>
                        </xsl:copy>
                    </xsl:for-each>
                </xsl:copy>
            </xsl:for-each>

        </xsl:copy>
    </xsl:template>

    <xsl:function name="f:types" as="xs:string*">
        <xsl:param name="element" as="element()"/>
        <xsl:sequence select="tokenize($element/@epub:type,'\s+')"/>
    </xsl:function>

</xsl:stylesheet>
