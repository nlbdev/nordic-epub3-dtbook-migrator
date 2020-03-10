<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
                xmlns="http://www.w3.org/1999/xhtml"
                xpath-default-namespace="http://www.w3.org/1999/xhtml"
                exclude-result-prefixes="#all">

	<xsl:import href="http://www.daisy.org/pipeline/modules/epub-utils/library.xsl"/>

	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="head">
		<head xmlns:dc="http://purl.org/dc/elements/1.1/"
		      xmlns:dcterms="http://purl.org/dc/terms/"
		      xmlns:nordic="http://www.mtm.se/epub/"
		      xmlns:epub="http://www.idpf.org/2007/ops">
			<xsl:copy-of select="namespace::*[not(.=('http://www.w3.org/1999/xhtml',
			                                         'http://www.idpf.org/2007/opf'))]"/>
			<xsl:apply-templates select="@*|node()"/>
			<xsl:if test="not(meta[@name='dc:identifier'])">
				<xsl:call-template name="viewport"/>
			</xsl:if>
		</head>
	</xsl:template>

	<xsl:template match="head/meta[@name='dc:identifier']">
		<xsl:next-match/>
		<xsl:call-template name="viewport"/>
		<xsl:sequence select="parent::*/meta[@name='nordic:guidelines']/preceding-sibling::node()[1][self::text()]"/>
		<xsl:sequence select="parent::*/meta[@name='nordic:guidelines']"/>
		<xsl:sequence select="parent::*/meta[@name='nordic:supplier']/preceding-sibling::node()[1][self::text()]"/>
		<xsl:sequence select="parent::*/meta[@name='nordic:supplier']"/>
	</xsl:template>

	<xsl:template match="head/meta[@name=('nordic:guidelines',
	                                      'nordic:supplier')]|
	                     text()[following-sibling::node()[1][self::meta[@name=('nordic:guidelines',
	                                                                           'nordic:supplier')]]]"/>

	<xsl:template name="viewport">
		<xsl:text>&#xa;    </xsl:text>
		<meta name="viewport" content="width=device-width"/>
	</xsl:template>

</xsl:stylesheet>
