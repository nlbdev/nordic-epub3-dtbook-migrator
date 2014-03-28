<xsl:stylesheet xmlns:f="http://www.daisy.org/ns/pipeline/internal-functions" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0" xmlns:pf="http://www.daisy.org/ns/pipeline/functions"
    xmlns="http://www.w3.org/1999/xhtml" xpath-default-namespace="http://www.w3.org/1999/xhtml" xmlns:epub="http://www.idpf.org/2007/ops" xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="#all">

    <xsl:variable name="doc-base" select="if (/html/head/base[@href][1]) then resolve-uri(normalize-space(/html/head/base[@href][1]/@href),base-uri(/*)) else base-uri(/*)"/>
    <xsl:variable name="xml-bases" select="//@xml:base"/>

    <xsl:template match="/*|@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="/*//*/@xml:base"/>

    <xsl:template match="@href|@src|@xlink:href|@altimg|@data[parent::object]">
        <xsl:choose>
            <xsl:when test="matches(.,'^[^/]+\.xhtml(#.*)?$')">
                <xsl:attribute name="{name()}" select="concat('#',substring-after(.,'#'))"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:copy-of select="."/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>
