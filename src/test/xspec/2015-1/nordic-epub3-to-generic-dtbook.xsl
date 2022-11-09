<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:my="my"
                exclude-result-prefixes="#all">

    <xsl:import href="../../../main/resources/xml/xslt/nordic-to-generic-epub3.xsl"/>
    <xsl:include href="http://www.daisy.org/pipeline/modules/html-to-dtbook/epub3-to-dtbook.xsl"/>

    <xsl:template match="@*|node()" priority="1000">
        <xsl:param name="my:mode" as="xs:string" tunnel="yes" required="yes"/>
        <xsl:choose>
            <xsl:when test="$my:mode='nordic-to-generic-epub3'">
                <xsl:apply-imports/>
            </xsl:when>
            <xsl:when test="$my:mode='epub3-to-dtbook'">
                <xsl:next-match/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:message terminate="yes" select="concat('Unexpected mode: ',$my:mode)"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>
