<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0" xmlns:d="http://www.daisy.org/ns/pipeline/data"
	xmlns:epub="http://www.idpf.org/2007/ops" xmlns:html="http://www.w3.org/1999/xhtml" xmlns="http://www.idpf.org/2007/opf" xpath-default-namespace="http://www.idpf.org/2007/opf"
	xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:f="http://www.daisy.org/ns/pipeline/internal-function">
	
	<!-- TODO: This XSLT should probably be converted to Schematron -->
	
	<xsl:output indent="yes" exclude-result-prefixes="#all"/>

	<xsl:template match="/*">
		<d:document-validation-report>
			<xsl:text>
    </xsl:text>
			<d:document-info>
				<xsl:text>
        </xsl:text>
				<d:document-name>
					<xsl:value-of select="base-uri(/*)"/>
				</d:document-name>
				<xsl:text>
        </xsl:text>
				<d:document-type>Nordic EPUB3 Package Document</d:document-type>
				<xsl:text>
        </xsl:text>
				<d:document-path>
					<xsl:value-of select="base-uri(/*)"/>
				</d:document-path>
				<xsl:text>
        </xsl:text>
				<d:error-count>Number of errors as an integer</d:error-count>
				<xsl:text>
    </xsl:text>
			</d:document-info>
			<xsl:text>
    </xsl:text>
			<d:reports>
				<xsl:text>
        </xsl:text>
				<d:report>
					<xsl:text>
</xsl:text>

					<!-- ########## Document assertions ########## -->

					<xsl:if test="not(ends-with(base-uri(/*),'.opf'))">
						<xsl:call-template name="error">
							<xsl:with-param name="desc" select="'the OPF file must have the extension .opf'"/>
							<xsl:with-param name="context" select="/*"/>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="not(matches(base-uri(/*),'.*/package.opf'))">
						<xsl:call-template name="error">
							<xsl:with-param name="desc" select="'the filename of the OPF must be package.opf'"/>
							<xsl:with-param name="context" select="/*"/>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="not(matches(base-uri(/*),'EPUB/package.opf'))">
						<xsl:call-template name="error">
							<xsl:with-param name="desc" select="'the OPF must be contained in a folder named EPUB'"/>
							<xsl:with-param name="context" select="/*"/>
						</xsl:call-template>
					</xsl:if>
					<!-- TODO: the package document must have the xml declaration `<?xml version="1.0" encoding="UTF-8"?>` -->


					<!-- ########## Metadata assertions ########## -->

					<xsl:call-template name="assert-equals">
						<xsl:with-param name="expect" select="'pub-identifier'"/>
						<xsl:with-param name="actual" select="/*/@unique-identifier"/>
						<xsl:with-param name="context" select="/*"/>
						<xsl:with-param name="desc" select="'the unique-identifier attribute'"/>
					</xsl:call-template>

					<xsl:choose>
						<xsl:when test="/*/metadata/dc:identifier">
							<xsl:call-template name="assert-equals">
								<xsl:with-param name="expect" select="'pub-identifier'"/>
								<xsl:with-param name="actual" select="/*/metadata/dc:identifier/@id"/>
								<xsl:with-param name="context" select="/*/metadata/dc:identifier"/>
								<xsl:with-param name="desc" select="'the id attribute'"/>
							</xsl:call-template>
							<!-- TODO: dc:identifier value must be the same as the filename of the EPUB (excluding the file extension) -->
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="error">
								<xsl:with-param name="desc" select="'a &quot;dc:identifier&quot; element must be present in the metadata'"/>
								<xsl:with-param name="context" select="/*/metadata"/>
							</xsl:call-template>
						</xsl:otherwise>
					</xsl:choose>

					<xsl:choose>
						<xsl:when test="/*/metadata/dc:title">
							<xsl:call-template name="assert-equals">
								<xsl:with-param name="expect" select="'pub-title'"/>
								<xsl:with-param name="actual" select="/*/metadata/dc:title/@id"/>
								<xsl:with-param name="context" select="/*/metadata/dc:title"/>
								<xsl:with-param name="desc" select="'the id attribute'"/>
							</xsl:call-template>
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="error">
								<xsl:with-param name="desc" select="'a &quot;dc:title&quot; element must be present in the metadata'"/>
								<xsl:with-param name="context" select="/*/metadata"/>
							</xsl:call-template>
						</xsl:otherwise>
					</xsl:choose>

					<xsl:choose>
						<xsl:when test="/*/metadata/dc:language">
							<xsl:call-template name="assert-equals">
								<!-- only one dc:language needs to have the id. this template succeds if at least one of the matched ids has the correct id -->
								<xsl:with-param name="expect" select="'pub-language'"/>
								<xsl:with-param name="actual" select="/*/metadata/dc:language/@id"/>
								<xsl:with-param name="context" select="/*/metadata/dc:language"/>
								<xsl:with-param name="desc" select="'the id attribute'"/>
							</xsl:call-template>
							<xsl:for-each select="/*/metadata/dc:language">
								<xsl:if test="not(matches(text(),'^[a-z]{2,3}(-[A-Z]{2})?$'))">
									<xsl:call-template name="error">
										<xsl:with-param name="desc"
											select="'the language codes in the &quot;dc:language&quot; elements must start with a two or three-letter language code (lowercase), and then optionally end with a dash (-) and a two-letter country code (uppercase).'"/>
										<xsl:with-param name="context" select="."/>
									</xsl:call-template>
								</xsl:if>
							</xsl:for-each>
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="error">
								<xsl:with-param name="desc" select="'a &quot;dc:language&quot; element must be present in the metadata'"/>
								<xsl:with-param name="context" select="/*/metadata"/>
							</xsl:call-template>
						</xsl:otherwise>
					</xsl:choose>

					<xsl:choose>
						<xsl:when test="/*/metadata/dc:date">
							<xsl:if test="not(matches(/*/metadata/dc:date/text(), '\d\d\d\d-[01]\d-[0123]\d'))">
								<xsl:call-template name="error">
									<xsl:with-param name="desc" select="'the &quot;dc:date&quot; metadata element must contain a date which matches the scheme &quot;YYYY-MM-DD&quot;'"/>
									<xsl:with-param name="context" select="/*/metadata/dc:date"/>
								</xsl:call-template>
							</xsl:if>
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="error">
								<xsl:with-param name="desc" select="'a &quot;dc:date&quot; element must be present in the metadata'"/>
								<xsl:with-param name="context" select="/*/metadata"/>
							</xsl:call-template>
						</xsl:otherwise>
					</xsl:choose>

					<xsl:if test="not(/*/metadata/meta[@property='dcterms:modified'])">
						<xsl:call-template name="error">
							<xsl:with-param name="desc" select="'a &quot;meta&quot; element with the property name &quot;dcterms:modified&quot; must be present'"/>
							<xsl:with-param name="context" select="/*/metadata"/>
						</xsl:call-template>
					</xsl:if>

					<xsl:choose>
						<xsl:when test="/*/metadata/dc:publisher">
							<!-- no assertions -->
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="error">
								<xsl:with-param name="desc" select="'a &quot;dc:publisher&quot; element must be present in the metadata'"/>
								<xsl:with-param name="context" select="/*/metadata"/>
							</xsl:call-template>
						</xsl:otherwise>
					</xsl:choose>

					<xsl:choose>
						<xsl:when test="/*/metadata/dc:creator">
							<xsl:call-template name="assert-equals">
								<xsl:with-param name="expect" select="'pub-creator'"/>
								<xsl:with-param name="actual" select="/*/metadata/dc:creator/@id"/>
								<xsl:with-param name="context" select="/*/metadata/dc:creator"/>
								<xsl:with-param name="desc" select="'the id attribute'"/>
							</xsl:call-template>
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="error">
								<xsl:with-param name="desc" select="'a &quot;dc:creator&quot; element must be present in the metadata'"/>
								<xsl:with-param name="context" select="/*/metadata"/>
							</xsl:call-template>
						</xsl:otherwise>
					</xsl:choose>

					<xsl:choose>
						<xsl:when test="/*/metadata/dc:source">
							<xsl:call-template name="assert-equals">
								<xsl:with-param name="expect" select="'source-id'"/>
								<xsl:with-param name="actual" select="/*/metadata/dc:source/@id"/>
								<xsl:with-param name="context" select="/*/metadata/dc:source"/>
								<xsl:with-param name="desc" select="'the id attribute'"/>
							</xsl:call-template>
							<xsl:if test="not(matches(/*/metadata/dc:source/text(),'^urn:isbn:\d[\d\- ]*\d$'))">
								<xsl:call-template name="error">
									<xsl:with-param name="desc"
										select="'the value of the &quot;dc:source&quot; element must start with &quot;urn:isbn:&quot; and end with an ISBN. The first number in the ISBN must follow directly after &quot;urn:isbn:&quot;, and the ISBN must only contain numbers (0-9), spaces ( ) and dashes (-). There must be no spaces at the beginning or the end of the string.'"/>
									<xsl:with-param name="context" select="/*/metadata/dc:source"/>
								</xsl:call-template>
							</xsl:if>
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="error">
								<xsl:with-param name="desc" select="'a &quot;dc:source&quot; element must be present in the metadata'"/>
								<xsl:with-param name="context" select="/*/metadata"/>
							</xsl:call-template>
						</xsl:otherwise>
					</xsl:choose>


					<!-- ########## Manifest assertions ########## -->

					<xsl:choose>
						<xsl:when test="/*/manifest/item[@media-type='application/x-dtbncx+xml']">
							<xsl:call-template name="assert-equals">
								<xsl:with-param name="expect" select="'nav.ncx'"/>
								<xsl:with-param name="actual" select="/*/manifest/item[@media-type='application/x-dtbncx+xml']/@href"/>
								<xsl:with-param name="context" select="/*/manifest/item[@media-type='application/x-dtbncx+xml']"/>
								<xsl:with-param name="desc" select="'the href attribute for the NCX document'"/>
							</xsl:call-template>
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="error">
								<xsl:with-param name="desc" select="'there must be a NCX item present in the manifest (media-type: application/x-dtbncx+xml)'"/>
								<xsl:with-param name="context" select="/*/manifest"/>
							</xsl:call-template>
						</xsl:otherwise>
					</xsl:choose>

					<xsl:for-each select="/*/manifest/item[starts-with(@media-type,'image/')]">
						<xsl:if test="not(matches(@href,'^images/[^/]+$'))">
							<xsl:call-template name="error">
								<xsl:with-param name="desc"
									select="concat('all images must be stored in the directory &quot;EPUB/images/&quot;, but the href attribute for the image (which is relative to the package document) is &quot;',@href,'&quot;')"/>
								<xsl:with-param name="context" select="."/>
							</xsl:call-template>
						</xsl:if>
					</xsl:for-each>

					<xsl:text>
        </xsl:text>
				</d:report>
				<xsl:text>
    </xsl:text>
			</d:reports>
			<xsl:text>
</xsl:text>
		</d:document-validation-report>
	</xsl:template>

	<xsl:template name="error">
		<xsl:param name="desc" as="xs:string" required="yes"/>
		<xsl:param name="context" required="yes"/>
		<xsl:param name="include-xpath" select="true()" required="no"/>
		<xsl:text>            </xsl:text>
		<d:error>
			<xsl:text>
                </xsl:text>
			<d:desc>
				<xsl:value-of select="$desc"/>
				<xsl:if test="$include-xpath"> (at <xsl:value-of select="f:xpath($context)"/>)</xsl:if>
			</d:desc>
			<!--<d:file>
				<xsl:value-of select="base-uri(/*)"/>
			</d:file>-->
			<xsl:text>
            </xsl:text>
		</d:error>
		<xsl:text>
</xsl:text>
	</xsl:template>

	<xsl:function name="f:xpath">
		<xsl:param name="context"/>
		<xsl:sequence
			select="concat('/',string-join(for $node in ($context/(ancestor::*|self::node())) return if ($node/self::*) then concat($node/name(),'[',1+count($node/preceding-sibling::*[name()=$node/name()]),']') else if ($node/self::text()) then concat('text()[',1+count($node/preceding-sibling::text()),']') else if ($node/self::comment()) then concat('comment()[',1+count($node/preceding-sibling::comment()),']') else if (f:is-attribute($node)) then concat('@',$node/name()) else concat('node()[',1+count($node/preceding-sibling::node()),']'),'/'))"
		/>
	</xsl:function>

	<xsl:function name="f:is-attribute">
		<xsl:param name="context"/>
		<xsl:sequence select="$context/(parent::*/@* intersect .)"/>
	</xsl:function>

	<xsl:template name="assert-equals">
		<xsl:param name="expect" as="xs:string"/>
		<xsl:param name="actual"/>
		<xsl:param name="context"/>
		<xsl:param name="desc"/>
		<xsl:if test="not($actual = $expect)">
			<xsl:call-template name="error">
				<xsl:with-param name="desc"
					select="concat('The value of ',$desc,' must be &quot;',$expect,'&quot;, but it was ',if ($actual) then concat('&quot;',$actual,'&quot;') else 'not defined', '.')"/>
				<xsl:with-param name="context" select="$context"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

</xsl:stylesheet>
