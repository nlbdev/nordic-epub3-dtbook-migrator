<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
                xmlns:pf="http://www.daisy.org/ns/pipeline/functions"
                xmlns:d="http://www.daisy.org/ns/pipeline/data"
                xmlns:html="http://www.w3.org/1999/xhtml"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                exclude-result-prefixes="#all">
	
	<!--
	    Update links to images
	-->
	
	<xsl:import href="http://www.daisy.org/pipeline/modules/file-utils/library.xsl"/>
	
	<xsl:variable name="file-mapping" as="element()">
		<xsl:apply-templates mode="absolute-hrefs" select="collection()[2]"/>
	</xsl:variable>
	
	<xsl:template match="html:img/@src|
	                     math:math/@altimg">
		<xsl:variable name="base" select="base-uri(..)"/>
		<xsl:variable name="src" select="resolve-uri(.,$base)"/>
		<xsl:variable name="file" as="element(d:file)?" select="$file-mapping//d:file[@original-href=$src]"/>
		<xsl:attribute name="{name()}" select="if (exists($file)) then pf:relativize-uri($file/@href,$base) else ."/>
	</xsl:template>
	
	<xsl:template mode="absolute-hrefs"
	              match="d:file/@href|
	                     d:file/@original-href">
		<xsl:attribute name="{name()}" select="resolve-uri(.,base-uri(..))"/>
	</xsl:template>
	
	<xsl:template mode="#default absolute-hrefs" match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates mode="#current" select="@*|node()"/>
		</xsl:copy>
	</xsl:template>
	
</xsl:stylesheet>
