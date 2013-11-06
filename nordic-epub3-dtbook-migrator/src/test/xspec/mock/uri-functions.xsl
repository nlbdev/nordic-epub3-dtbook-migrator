<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:pf="http://www.daisy.org/ns/pipeline/functions" exclude-result-prefixes="#all"
    version="2.0">

    <xsl:function name="pf:relativize-uri" as="xs:string">
        <xsl:param name="uri" as="xs:string?"/>
        <xsl:param name="base" as="xs:string?"/>
        <xsl:variable name="base-dir" select="replace($base,'^(.+?/?)([^/]*)?$','$1')"/>
        <xsl:value-of select="if (starts-with($uri,$base-dir)) then substring($uri,string-length($base-dir)+1) else $uri"/>
    </xsl:function>

</xsl:stylesheet>
