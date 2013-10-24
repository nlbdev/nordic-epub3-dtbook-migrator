<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:f="http://www.daisy.org/ns/pipeline/internal-functions" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0" xmlns:epub="http://www.idpf.org/2007/ops"
    xmlns="http://www.w3.org/1999/xhtml" xpath-default-namespace="http://www.w3.org/1999/xhtml" exclude-result-prefixes="#all" xmlns:xs="http://www.w3.org/2001/XMLSchema">
    
    <xsl:param name="output-dir" required="yes"/>
    
    <xsl:template match="/">
        <primary-output-is-not-used/>
        
        <xsl:variable name="base" select="base-uri(/*)"/>
        <xsl:for-each select="/html/body/*">
            <xsl:variable name="body" select="."/>
            <xsl:variable name="filename" select="replace(if (matches($base,'\.x?html?$')) then replace($base,'\.x?html?$','') else $base, '^.*/([^/]*)$','$1')"/>
            <!-- TODO: filenames should follow the nordic markup guidelines -->
            <xsl:result-document href="{$output-dir}-{$filename}-{position()}.xhtml">
                <html>
                    <xsl:copy-of select="/*/@*"/>
                    <xsl:attribute name="xml:base" select="concat($output-dir,$filename,'-',position(),'.xhtml')"/>
                    <head>
                        <xsl:copy-of select="/html/head/@*"/>
                        <xsl:for-each select="/html/head/*">
                            <xsl:choose>
                                <xsl:when test="self::title">
                                    <title>
                                        <xsl:copy-of select="@*"/>
                                        <xsl:value-of select="normalize-space(string-join(($body//(h1|h2|h3|h4|h5|h6))[1]//text(),' '))"/>
                                    </title>
                                </xsl:when>
                                <xsl:when test="self::link[@rel=('prev','next')]"/>
                                <xsl:otherwise>
                                    <xsl:copy-of select="."/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:for-each>
                        <xsl:if test="position()&gt;1">
                            <link rel="prev" href="{$filename}-{position()-1}.xhtml"/>
                        </xsl:if>
                        <xsl:if test="position()&lt;last()">
                            <link rel="next" href="{$filename}-{position()+1}.xhtml"/>
                        </xsl:if>
                    </head>
                    <body>
                        <xsl:copy-of select="$body/@*"/>
                        <xsl:copy-of select="$body/*"/>
                    </body>
                </html>
            </xsl:result-document>
        </xsl:for-each>
    </xsl:template>

</xsl:stylesheet>
