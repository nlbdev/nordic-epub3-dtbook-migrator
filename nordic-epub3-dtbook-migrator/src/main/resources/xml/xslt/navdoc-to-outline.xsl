<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0" xmlns:pf="http://www.daisy.org/ns/pipeline/functions" xmlns="http://www.w3.org/1999/xhtml"
    xpath-default-namespace="http://www.w3.org/1999/xhtml" xmlns:epub="http://www.idpf.org/2007/ops" exclude-result-prefixes="#all">

    <xsl:import href="http://www.daisy.org/pipeline/modules/file-utils/uri-functions.xsl"/>
<!--    <xsl:import href="../../../../test/xspec/mock/uri-functions.xsl"/>-->

    <xsl:template match="node()">
        <xsl:apply-templates select="node()"/>
    </xsl:template>

    <xsl:template match="/*">
        <xsl:copy>
            <xsl:attribute name="xml:base" select="base-uri(/*)"/>
            <xsl:attribute name="epub:prefix" select="'z3998: http://www.daisy.org/z3998/2012/vocab/structure/#'"/>
            <head/>
            <body>
                <xsl:apply-templates select="//nav[matches(@epub:type,'(^|\s)toc(\s|$)')]/ol"/>
            </body>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="li">
        <section>
            <xsl:apply-templates select="node()"/>
        </section>
    </xsl:template>

    <xsl:template match="span">
        <xsl:element name="{concat('h',min((count(ancestor::li),6)))}">
            <xsl:copy-of select="(@*|node())"/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="a">
        <xsl:attribute name="xml:base" select="pf:relativize-uri(tokenize(@href,'#')[1],base-uri(.))"/>
    </xsl:template>

</xsl:stylesheet>
