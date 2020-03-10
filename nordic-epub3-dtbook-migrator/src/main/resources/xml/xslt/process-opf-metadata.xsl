<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
                xmlns:pf="http://www.daisy.org/ns/pipeline/functions"
                xmlns="http://www.idpf.org/2007/opf"
                xpath-default-namespace="http://www.idpf.org/2007/opf"
                exclude-result-prefixes="#all">

	<xsl:import href="http://www.daisy.org/pipeline/modules/epub-utils/library.xsl"/>

	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="metadata">
		<xsl:copy>
			<xsl:attribute name="prefix" select="pf:epub3-vocab-add-prefix(@prefix,'nordic','http://www.mtm.se/epub/')"/>
			<xsl:apply-templates select="@* except @prefix"/>
			<xsl:apply-templates/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="meta[@name='track:Guidelines']">
		<meta property="nordic:guidelines">2015-1</meta>
	</xsl:template>

	<xsl:template match="meta[@name='track:Supplier']">
		<meta property="nordic:supplier">
			<xsl:sequence select="node()"/>
		</meta>
	</xsl:template>

</xsl:stylesheet>
