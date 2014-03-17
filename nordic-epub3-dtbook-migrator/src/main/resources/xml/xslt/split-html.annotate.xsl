<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:f="http://www.daisy.org/ns/pipeline/internal-functions" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0" xmlns:epub="http://www.idpf.org/2007/ops"
    xmlns="http://www.w3.org/1999/xhtml" xpath-default-namespace="http://www.w3.org/1999/xhtml" exclude-result-prefixes="#all" xmlns:xs="http://www.w3.org/2001/XMLSchema">

    <xsl:param name="output-dir" required="yes"/>
    <xsl:param name="xspec" select="false()"/>

    <xsl:template match="/*">
        
        <xsl:variable name="split-types" select="('cover','titlepage','colophon','toc','part','chapter','index','appendix','glossary','footnotes','rearnotes')"/>
        <xsl:variable name="identifier" select="(//html/head/meta[@name='dc:identifier']/string(@content))[1]"/>
        <xsl:variable name="padding-size" select="string-length(string(count(/*/body/(section|article|section[tokenize(@epub:type,'\s+')='part']/(section|article)))))"/>
        
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:attribute name="xml:base" select="base-uri(/*)"/>
            <xsl:copy-of select="head"/>
            <xsl:for-each select="body">
                <xsl:copy>
                    <xsl:copy-of select="@*"/>
                    <xsl:for-each select="section | article | section[tokenize(@epub:type,'\s+')='part']/(section|article)">
                        <xsl:copy>
                            <xsl:variable name="content-type" select="(f:types(.)[.=$split-types],'chapter')[1]"/>
                            <xsl:variable name="filename" select="concat($identifier,'-',f:zero-pad(string(position()),$padding-size),'-',$content-type)"/>

                            <xsl:copy-of select="@*"/>
                            <xsl:attribute name="xml:base" select="concat($output-dir,$filename,'.xhtml')"/>

                            <xsl:choose>
                                <xsl:when test="$content-type='part'">
                                    <xsl:copy-of select="node() except (section | article)"/>

                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:copy-of select="node()"/>

                                </xsl:otherwise>
                            </xsl:choose>
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

    <xsl:function name="f:zero-pad" as="xs:string">
        <xsl:param name="text" as="xs:string"/>
        <xsl:param name="desired-length" as="xs:integer"/>
        <xsl:sequence select="concat(string-join(for $i in (string-length($text)+1 to $desired-length) return '0',''),$text)"/>
    </xsl:function>

</xsl:stylesheet>
