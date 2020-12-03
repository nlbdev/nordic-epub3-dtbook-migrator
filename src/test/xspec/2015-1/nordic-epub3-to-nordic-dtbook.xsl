<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:my="my"
                exclude-result-prefixes="#all">

	<!--
	    Test XSLT for epub3-to-dtbook.xspec that chains nordic-to-generic-epub3.xsl,
	    http://www.daisy.org/pipeline/modules/html-to-dtbook/epub3-to-dtbook.xsl and
	    generic-to-nordic-dtbook.xsl
	    
	    FIXME: use true modes instead of the xsl:apply-imports trick
	-->

	<xsl:import href="nordic-epub3-to-generic-dtbook.xsl"/>
	<xsl:include href="../../../main/resources/xml/xslt/generic-to-nordic-dtbook.xsl"/>

	<xsl:template match="@*|node()" priority="1000">
		<xsl:param name="my:mode" as="xs:string" tunnel="yes" select="'#default'"/>
		<xsl:choose>
			<xsl:when test="$my:mode=('nordic-to-generic-epub3','epub3-to-dtbook')">
				<xsl:apply-imports/>
			</xsl:when>
			<xsl:when test="$my:mode='generic-to-nordic-dtbook'">
				<xsl:next-match/>
			</xsl:when>
			<xsl:when test="$my:mode='#default'">
				<xsl:variable name="epub3">
					<xsl:apply-templates mode="nordic-to-generic-epub3" select="."/>
				</xsl:variable>
				<xsl:variable name="dtbook">
					<xsl:apply-templates mode="epub3-to-dtbook" select="$epub3"/>
				</xsl:variable>
				<_>
					<_ class="generic-epub3">
						<xsl:sequence select="$epub3"/>
					</_>
					<_ class="generic-dtbook">
						<xsl:sequence select="$dtbook"/>
					</_>
					<_ class="nordic-dtbook">
						<xsl:apply-templates mode="generic-to-nordic-dtbook" select="$dtbook"/>
					</_>
				</_>
			</xsl:when>
			<xsl:otherwise>
				<xsl:message terminate="yes" select="concat('Unexpected mode: ',$my:mode)"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template mode="nordic-to-generic-epub3" match="@*|node()">
		<xsl:apply-templates select=".">
			<xsl:with-param name="my:mode" tunnel="yes" select="'nordic-to-generic-epub3'"/>
		</xsl:apply-templates>
	</xsl:template>

	<xsl:template mode="epub3-to-dtbook" match="@*|node()">
		<xsl:apply-templates select=".">
			<xsl:with-param name="my:mode" tunnel="yes" select="'epub3-to-dtbook'"/>
		</xsl:apply-templates>
	</xsl:template>

	<xsl:template mode="generic-to-nordic-dtbook" match="@*|node()">
		<xsl:apply-templates select=".">
			<xsl:with-param name="my:mode" tunnel="yes" select="'generic-to-nordic-dtbook'"/>
		</xsl:apply-templates>
	</xsl:template>

</xsl:stylesheet>
