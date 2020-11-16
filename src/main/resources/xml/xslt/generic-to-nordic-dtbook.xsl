<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:f="generic-to-nordic-dtbook.xsl"
                xmlns:dtb="http://www.daisy.org/z3986/2005/dtbook/"
                xmlns="http://www.daisy.org/z3986/2005/dtbook/"
                xpath-default-namespace="http://www.daisy.org/z3986/2005/dtbook/"
                exclude-result-prefixes="#all">

	<xsl:import href="http://www.daisy.org/pipeline/modules/html-to-dtbook/format-list.xsl"/>

	<xsl:param name="allow-links" select="false()"/>

	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:function name="f:class" as="xs:string*">
		<xsl:param name="elem" as="element()"/>
		<xsl:sequence select="tokenize($elem/@class,'\s+')[not(.='')]"></xsl:sequence>
	</xsl:function>

	<xsl:template name="f:class">
		<xsl:param name="classes" as="xs:string*" select="()"/>
		<xsl:variable name="classes" as="xs:string*" select="(f:class(.),$classes)"/>
		<xsl:if test="exists($classes)">
			<xsl:attribute name="class" select="string-join(distinct-values($classes),' ')"/>
		</xsl:if>
	</xsl:template>

	<xsl:function name="f:is-inline" as="xs:boolean">
		<xsl:param name="node" as="element()"/>
		<xsl:choose>
			<xsl:when test="$node/parent::*">
				<xsl:variable name="sibling-implies-inline"
				              select="('em','strong','dfn','code','samp','kbd','cite','abbr','acronym',
				                       'a','img','br','q','sub','sup','span','bdo','sent','w','annoref',
				                       'noteref','lic')"/>
				<xsl:variable name="parent-implies-inline"
				              select="($sibling-implies-inline,
				                       'imggroup','pagenum','prodnote','line','linenum','address','title',
				                       'author','byline','dateline','p','doctitle','docauthor','covertitle',
				                       'h1','h2','h3','h4','h5','h6','bridgehead','dt')"/>
				<xsl:sequence select="exists($node/parent::*/(
				                        self::dtb:*[local-name()=$parent-implies-inline]|
				                        text()[normalize-space()]|
				                        dtb:*[local-name()=$sibling-implies-inline]))"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:sequence select="false()"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:function>

	<!-- ================================================ -->

	<!-- a is disallowed in Nordic DTBook, using span instead -->
	<xsl:template match="a">
		<xsl:choose>
			<xsl:when test="$allow-links">
				<xsl:next-match/>
			</xsl:when>
			<xsl:when test="not(@* except (@external|@type|@href|@hreflang|@rel|@accesskey|@tabindex))
			                and parent::lic[count(*)=1 and not(text()[normalize-space()])]">
				<xsl:message select="'&lt;a&gt; is not allowed in nordic DTBook. Replacing it with its content.'"/>
				<xsl:apply-templates/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:message select="'&lt;a&gt; is not allowed in nordic DTBook. Using span instead.'"/>
				<span>
					<xsl:apply-templates select="@* except (@class|@external|@type|@href|@hreflang|@rel|@accesskey|@tabindex)"/>
					<xsl:call-template name="f:class">
						<!-- <xsl:with-param name="classes" select="'a'"/> -->
						<xsl:with-param name="classes" select="if (@external='true') then 'external-true' else ()"/>
					</xsl:call-template>
					<xsl:apply-templates/>
				</span>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- abbr is disallowed in Nordic DTBook, using span instead -->
	<xsl:template match="abbr">
		<xsl:message select="'&lt;abbr&gt; is not allowed in nordic DTBook. Using span instead with a &quot;truncation&quot; class.'"/>
		<span>
			<xsl:apply-templates select="@* except @class"/>
			<xsl:call-template name="f:class">
				<xsl:with-param name="classes" select="'truncation'"/>
			</xsl:call-template>
			<xsl:apply-templates/>
		</span>
	</xsl:template>

	<!-- acronym is disallowed in Nordic DTBook, using span instead -->
	<xsl:template match="acronym">
		<xsl:message select="concat(
		                       '&lt;acronym&gt; is not allowed in nordic DTBook. Using span instead with a &quot;',
		                       if (@pronounce='no') then 'initialism' else 'acronym',
		                       '&quot; class.')"/>
		<span>
			<xsl:apply-templates select="@* except (@class|@pronounce)"/>
			<xsl:call-template name="f:class">
				<xsl:with-param name="classes" select="if (@pronounce='no') then 'initialism' else 'acronym'"/>
			</xsl:call-template>
			<xsl:apply-templates/>
		</span>
	</xsl:template>

	<!-- address is not allowed in nordic DTBook, using p instead -->
	<xsl:template match="address">
		<xsl:message select="'&lt;address&gt; is not allowed in nordic DTBook. Using p instead with a &quot;address&quot; class.'"/>
		<p>
			<xsl:apply-templates select="@* except @class"/>
			<xsl:call-template name="f:class">
				<xsl:with-param name="classes" select="'address'"/>
			</xsl:call-template>
			<xsl:apply-templates/>
		</p>
	</xsl:template>

	<!-- annoref is not allowed in nordic DTBook, using span instead -->
	<xsl:template match="annoref">
		<xsl:message select="'&lt;annoref&gt; is not allowed in nordic DTBook. Using span instead with a &quot;annoref&quot; class.'"/>
		<span>
			<xsl:apply-templates select="@* except (@class|@idref|@type)"/>
			<xsl:call-template name="f:class">
				<xsl:with-param name="classes" select="'annoref'"/>
			</xsl:call-template>
			<xsl:apply-templates/>
		</span>
	</xsl:template>

	<!-- annotation is not allowed in nordic DTBook, using p instead -->
	<xsl:template match="annotation">
		<xsl:message select="'&lt;annotation&gt; is not allowed in nordic DTBook. Using p instead with a &quot;annotation&quot; class.'"/>
		<p>
			<xsl:apply-templates select="@* except @class"/>
			<xsl:call-template name="f:class">
				<xsl:with-param name="classes" select="'annotation'"/>
			</xsl:call-template>
			<xsl:apply-templates/>
		</p>
	</xsl:template>

	<!-- bdo is not allowed in nordic DTBook, using span instead -->
	<xsl:template match="bdo">
		<xsl:message select="concat(
		                       '&lt;bdo&gt; is not allowed in nordic DTBook. Using span instead with a &quot;bdo&quot; ',
		                       if (@dir[not(.='')]) then concat('and a &quot;bdo-dir-',@dir,'&quot; ') else '',
		                       'class.')"/>
		<span>
			<xsl:apply-templates select="@* except (@class|@dir)"/>
			<xsl:call-template name="f:class">
				<xsl:with-param name="classes" select="('bdo',if (@dir[not(.='')]) then concat('bdo-dir-',@dir) else ())"/>
			</xsl:call-template>
			<xsl:apply-templates/>
		</span>
	</xsl:template>

	<!-- bridgehead is not allowed in nordic DTBook, using p instead -->
	<xsl:template match="bridgehead">
		<xsl:message select="'&lt;bridgehead&gt; is not allowed in nordic DTBook. Using p instead with a &quot;bridgehead&quot; class.'"/>
		<p>
			<xsl:apply-templates select="@* except @class"/>
			<xsl:call-template name="f:class">
				<xsl:with-param name="classes" select="'bridgehead'"/>
			</xsl:call-template>
			<xsl:apply-templates/>
		</p>
	</xsl:template>

	<!-- byline is not allowed in nordic DTBook, using span instead -->
	<xsl:template match="byline">
		<xsl:message select="'&lt;byline&gt; is not allowed in nordic DTBook. Using span instead with a &quot;byline&quot; class.'"/>
		<span>
			<xsl:apply-templates select="@* except @class"/>
			<xsl:call-template name="f:class">
				<xsl:with-param name="classes" select="'byline'"/>
			</xsl:call-template>
			<xsl:apply-templates/>
		</span>
	</xsl:template>

	<!-- cite is not allowed in nordic DTBook, using span instead -->
	<xsl:template match="cite">
		<xsl:message select="'&lt;cite&gt; is not allowed in nordic DTBook. Using span instead with a &quot;cite&quot; class.'"/>
		<span>
			<xsl:apply-templates select="@* except @class"/>
			<xsl:call-template name="f:class">
				<xsl:with-param name="classes" select="'cite'"/>
			</xsl:call-template>
			<xsl:apply-templates/>
		</span>
	</xsl:template>

	<!-- add xml:space="preserve" on code -->
	<xsl:template match="code">
		<xsl:copy>
			<xsl:if test="not(@xml:space)">
				<xsl:attribute name="xml:space" select="'preserve'"/>
			</xsl:if>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>

	<!-- col is disallowed in Nordic DTBook -->
	<xsl:template match="col">
		<xsl:message select="'&lt;col&gt; is not allowed in nordic DTBook. Dropping it.'"/>
	</xsl:template>

	<!-- colgroup is disallowed in Nordic DTBook -->
	<xsl:template match="colgroup">
		<xsl:message select="'&lt;colgroup&gt; is not allowed in nordic DTBook. Dropping it.'"/>
	</xsl:template>

	<!-- covertitle is disallowed in Nordic DTBook -->
	<xsl:template match="covertitle">
		<xsl:message select="'&lt;covertitle&gt; is not allowed in nordic DTBook. Dropping it.'"/>
		<!--<p>
			<xsl:apply-templates select="@* except @class"/>
			<xsl:call-template name="f:class">
				<xsl:with-param name="classes" select="'covertitle'"/>
			</xsl:call-template>
			<xsl:apply-templates/>
		</p>-->
	</xsl:template>

	<!-- dateline is not allowed in nordic DTBook, using span instead -->
	<xsl:template match="dateline">
		<xsl:message select="'&lt;dateline&gt; is not allowed in nordic DTBook. Using span instead with a &quot;dateline&quot; class.'"/>
		<span>
			<xsl:apply-templates select="@* except @class"/>
			<xsl:call-template name="f:class">
				<xsl:with-param name="classes" select="'dateline'"/>
			</xsl:call-template>
			<xsl:apply-templates/>
		</span>
	</xsl:template>

	<!-- dfn is not allowed in nordic DTBook, using span instead -->
	<xsl:template match="dfn">
		<xsl:message select="'&lt;dfn&gt; is not allowed in nordic DTBook. Using span instead with a &quot;definition&quot; class.'"/>
		<span>
			<xsl:apply-templates select="@* except @class"/>
			<xsl:call-template name="f:class">
				<xsl:with-param name="classes" select="'definition'"/>
			</xsl:call-template>
			<xsl:apply-templates/>
		</span>
	</xsl:template>

	<!-- epigraph is not allowed in nordic DTBook, using p instead -->
	<xsl:template match="epigraph">
		<xsl:choose>
			<xsl:when test="exists(*[not(f:is-inline(.))])">
				<xsl:copy>
					<xsl:apply-templates select="@* except @class"/>
					<xsl:call-template name="f:class">
						<xsl:with-param name="classes" select="'epigraph'"/>
					</xsl:call-template>
					<xsl:apply-templates/>
				</xsl:copy>
			</xsl:when>
			<xsl:otherwise>
				<xsl:message select="'&lt;epigraph&gt; is not allowed in nordic DTBook. Using p instead with a &quot;epigraph&quot; class.'"/>
				<p>
					<xsl:apply-templates select="@* except @class"/>
					<xsl:call-template name="f:class">
						<xsl:with-param name="classes" select="'epigraph'"/>
					</xsl:call-template>
					<xsl:apply-templates/>
				</p>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- kbd is not allowed in nordic DTBook, using code instead -->
	<xsl:template match="kbd">
		<xsl:message select="'&lt;kbd&gt; is not allowed in Nordic DTBook. Using code instead with &quot;keyboard&quot; class.'"/>
		<code>
			<xsl:if test="not(@xml:space)">
				<xsl:attribute name="xml:space" select="'preserve'"/>
			</xsl:if>
			<xsl:apply-templates select="@* except @class"/>
			<xsl:call-template name="f:class">
				<xsl:with-param name="classes" select="'keyboard'"/>
			</xsl:call-template>
			<xsl:apply-templates/>
		</code>
	</xsl:template>

	<!-- link is disallowed in Nordic DTBook -->
	<xsl:template match="link">
		<xsl:message select="'&lt;link&gt; is not allowed in nordic DTBook. Dropping it.'"/>
	</xsl:template>

	<!-- only type 'pl' is allowed in nordic DTBook, markers will be inlined -->
	<xsl:template match="list[@type=('ol','ul') and not(ancestor-or-self::list[f:class(.)='toc'])]">
		<xsl:variable name="formatted-list" as="element()">
			<xsl:apply-templates mode="format-list" select="."/>
		</xsl:variable>
		<xsl:apply-templates select="$formatted-list"/>
	</xsl:template>

	<xsl:template match="list/@type">
		<xsl:attribute name="type" select="'pl'"/>
	</xsl:template>

	<xsl:template match="li">
		<xsl:copy>
			<xsl:apply-templates select="@*"/>
			<xsl:choose>
				<!-- if li contains block content wrap inline content in p -->
				<xsl:when test="*[not(self::list or f:is-inline(.))]">
					<xsl:choose>
						<xsl:when test="text()[normalize-space()]|*[f:is-inline(.)]">
							<xsl:for-each-group select="node()" group-adjacent="boolean(*[not(f:is-inline(.))])">
								<xsl:choose>
									<xsl:when test="current-grouping-key()">
										<xsl:apply-templates select="current-group()"/>
									</xsl:when>
									<xsl:when test="current-group()[self::*|self::text()[normalize-space()]]">
										<p>
											<xsl:apply-templates select="current-group()"/>
										</p>
									</xsl:when>
									<xsl:otherwise>
										<xsl:apply-templates select="current-group()"/>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:for-each-group>
						</xsl:when>
						<xsl:otherwise>
							<xsl:apply-templates/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<!-- if li contains nested lists wrap everything that is not a list in lic  -->
				<xsl:when test="list and text()[normalize-space()]|*[not(self::list|self::lic|self::pagenum)]">
					<xsl:for-each-group select="node()" group-adjacent="boolean(self::list|self::lic|self::pagenum)">
						<xsl:choose>
							<xsl:when test="current-grouping-key()">
								<xsl:apply-templates select="current-group()"/>
							</xsl:when>
							<xsl:when test="current-group()[self::*|self::text()[normalize-space()]]">
								<lic>
									<xsl:apply-templates select="current-group()"/>
								</lic>
							</xsl:when>
							<xsl:otherwise>
								<xsl:apply-templates select="current-group()"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:for-each-group>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:copy>
	</xsl:template>

	<!-- q is not allowed in nordic DTBook, using span instead -->
	<xsl:template match="q">
		<xsl:message select="'&lt;q&gt; is not allowed in Nordic DTBook. Using span instead with &quot;quote&quot; class.'"/>
		<span>
			<xsl:apply-templates select="@* except (@class|@cite)"/>
			<xsl:call-template name="f:class">
				<xsl:with-param name="classes" select="'quote'"/>
			</xsl:call-template>
			<xsl:apply-templates/>
		</span>
	</xsl:template>

	<!-- samp is not allowed in nordic DTBook, using code instead -->
	<xsl:template match="samp">
		<xsl:message select="'&lt;samp&gt; is not allowed in Nordic DTBook. Using code instead with &quot;example&quot; class.'"/>
		<code>
			<xsl:if test="not(@xml:space)">
				<xsl:attribute name="xml:space" select="'preserve'"/>
			</xsl:if>
			<xsl:apply-templates select="@* except @class"/>
			<xsl:call-template name="f:class">
				<xsl:with-param name="classes" select="'example'"/>
			</xsl:call-template>
			<xsl:apply-templates/>
		</code>
	</xsl:template>

	<!-- sent is not allowed in nordic DTBook, using span instead -->
	<xsl:template match="sent">
		<xsl:message select="'&lt;sent&gt; is not allowed in Nordic DTBook. Using span instead with &quot;sentence&quot; class.'"/>
		<span>
			<xsl:apply-templates select="@* except @class"/>
			<xsl:call-template name="f:class">
				<xsl:with-param name="classes" select="'sentence'"/>
			</xsl:call-template>
			<xsl:apply-templates/>
		</span>
	</xsl:template>

	<!-- unwrap thead, tbody and tfoot -->
	<xsl:template match="table">
		<xsl:copy>
			<xsl:apply-templates select="@*"/>
			<xsl:apply-templates select="node() except (thead|tfoot|tbody|tr|pagenum)"/>
			<xsl:apply-templates select="thead/node()"/>
			<xsl:apply-templates select="tbody/node()|tr|pagenum"/>
			<xsl:apply-templates select="tfoot/node()"/>
		</xsl:copy>
	</xsl:template>

	<!-- w is not allowed in nordic DTBook, using span instead -->
	<xsl:template match="w">
		<xsl:message select="'&lt;w&gt; is not allowed in Nordic DTBook. Using span instead with &quot;word&quot; class.'"/>
		<span>
			<xsl:apply-templates select="@* except @class"/>
			<xsl:call-template name="f:class">
				<xsl:with-param name="classes" select="'word'"/>
			</xsl:call-template>
			<xsl:apply-templates/>
		</span>
	</xsl:template>

</xsl:stylesheet>
