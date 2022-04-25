<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:rng="http://relaxng.org/ns/structure/1.0"
                xmlns:a="http://relaxng.org/ns/compatibility/annotations/1.0"
                xmlns:f="#"
                xmlns="http://www.w3.org/1999/xhtml"
                xpath-default-namespace="http://relaxng.org/ns/structure/1.0"
                exclude-result-prefixes="#all"
                version="2.0">
    
    <xsl:template match="@* | node()" mode="#all" exclude-result-prefixes="#all">
        <xsl:copy exclude-result-prefixes="#all">
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="text()[. = ' ' and preceding-sibling::node()[1][self::ref] and following-sibling::node()[1][self::comment()]]">
        <!-- remove preceding spaces from existing ref comments -->
    </xsl:template>
    
    <xsl:template match="comment()[preceding-sibling::node()[1][self::text()][. = ' '] and preceding-sibling::node()[2] intersect preceding-sibling::ref]">
        <!-- remove existing ref comments -->
    </xsl:template>
    
    <xsl:template match="ref">
        <xsl:next-match/>
        
        <xsl:variable name="ref-comment" select="string-join(((for $a in f:referenced-attributes(/*, @name) return concat('@', $a)), f:referenced-elements(/*, @name)), ', ')"/>
        <xsl:if test="$ref-comment">
            <xsl:text> </xsl:text>
            <xsl:comment select="concat(' ', $ref-comment, ' ')"/>
        </xsl:if>
    </xsl:template>
    
    <xsl:function name="f:referenced-elements">
        <xsl:param name="grammar" as="element()"/>
        <xsl:param name="reference" as="xs:string"/>
        
        <xsl:if test="$reference = 'math'">
            <xsl:sequence select="'math'"/>  <!-- we don't check to MathML schema so we have to add this element explicitly here -->
        </xsl:if>
        
        <xsl:variable name="results" as="xs:string*">
            <xsl:sequence select="$grammar/define[@name=$reference]//element[not(ancestor::element)]/@name"/>
            <xsl:for-each select="$grammar/define[@name=$reference]//ref[not(ancestor::element)]/@name">
                <xsl:sequence select="f:referenced-elements($grammar, string(.))"/>
            </xsl:for-each>
        </xsl:variable>
        <xsl:sequence select="distinct-values($results)"/>
    </xsl:function>
    
    <xsl:function name="f:referenced-attributes">
        <xsl:param name="grammar" as="element()"/>
        <xsl:param name="reference" as="xs:string"/>
        
        <xsl:variable name="results" as="xs:string*">
            <xsl:sequence select="$grammar/define[@name=$reference]//attribute[not(ancestor::element)]/@name"/>
            <xsl:for-each select="$grammar/define[@name=$reference]//ref[not(ancestor::element)]/@name">
                <xsl:sequence select="f:referenced-attributes($grammar, string(.))"/>
            </xsl:for-each>
        </xsl:variable>
        <xsl:sequence select="distinct-values($results)"/>
    </xsl:function>
    
</xsl:stylesheet>
