<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:pf="http://www.daisy.org/ns/pipeline/functions"
                xmlns:html="http://www.w3.org/1999/xhtml"
                xmlns:epub="http://www.idpf.org/2007/ops"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns="http://www.w3.org/1999/xhtml"
                xpath-default-namespace="http://www.w3.org/1999/xhtml"
                exclude-result-prefixes="#all">

    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
                
    <xsl:template match="html:details">
        <xsl:element name="div" namespace="http://www.w3.org/1999/xhtml">
            <xsl:attribute name="class" select="string-join(('details', tokenize(@class, '\s+')))"/>
            <xsl:apply-templates select="@* except @class | node()" exclude-result-prefixes="#all"/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="html:summary">
        <xsl:element name="p" namespace="http://www.w3.org/1999/xhtml">
            <xsl:attribute name="class" select="string-join(('summary', tokenize(@class, '\s+')))"/>
            <xsl:apply-templates select="@* except @class | node()" exclude-result-prefixes="#all"/>
        </xsl:element>
    </xsl:template>

</xsl:stylesheet>
