<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0" xmlns:dtbook="http://www.daisy.org/z3986/2005/dtbook/" xmlns:epub="http://www.idpf.org/2007/ops"
    xmlns="http://www.w3.org/1999/xhtml" xpath-default-namespace="http://www.w3.org/1999/xhtml" exclude-result-prefixes="#all">

    <xsl:template name="dtbookblocknoimggroup">
        <xsl:apply-templates select="*"/>
        <!-- author, prodnote, sidebar, note, annotation, "externalblock" -->
    </xsl:template>

    <xsl:template name="inlineinblock">
        <xsl:apply-templates select="*"/>
        <!-- a, cite, samp, kbd, pagenum -->
    </xsl:template>

    <xsl:template name="block">
        <xsl:apply-templates select="*"/>
        <!-- p, list, dl, div, blockquote, img, imggroup, poem, linegroup, byline, dateline, epigraph, table, address, line, "dtbookblocknoimggroup", "externalFlow" -->
    </xsl:template>

    <xsl:template name="blocknoimggroup">
        <xsl:apply-templates select="*"/>
        <!-- p, list, dl, div, blockquote, poem, linegroup, byline, dateline, epigraph, table, address, line, "dtbookblocknoimggroup" -->
    </xsl:template>

    <xsl:template name="docblockorinline">
        <xsl:apply-templates select="*"/>
        <!-- doctitle, docauthor, covertitle, bridgehead, "block", "inlineblock" -->
    </xsl:template>

    <xsl:template name="coreattrs">
        <xsl:if test="@id">
            <xsl:attribute name="id" select="@id"/> <!-- ID -->
        </xsl:if>
        <xsl:if test="@class">
            <xsl:attribute name="class" select="@class"/>
        </xsl:if>
        <xsl:if test="@title">
            <xsl:attribute name="title" select="@title"/> <!-- Text -->
        </xsl:if>
        <xsl:if test="@xml:space">
            <xsl:attribute name="xml:space" select="@xml:space"/> <!-- "default" or "preserve" -->
        </xsl:if>
    </xsl:template>

    <xsl:template name="i18n">
        <xsl:if test="@xml:lang">
            <xsl:attribute name="xml:lang" select="@xml:lang"/>
        </xsl:if>
        <xsl:if test="@dir">
            <xsl:attribute name="dir" select="@dir"/>
        </xsl:if>
    </xsl:template>

    <!--<xsl:template name="showin">
        <xsl:if test="@showin">
            <xsl:attribute name="showin">
                <choice>
                    <value>xxx</value>
                    <value>xxp</value>
                    <value>xlx</value>
                    <value>xlp</value>
                    <value>bxx</value>
                    <value>bxp</value>
                    <value>blx</value>
                    <value>blp</value>
                </choice>
            </attribute>
        </xsl:if>
    </xsl:template>-->

    <!--<xsl:template name="attrs">
        <xsl:call-template name="coreattrs"/>
        <xsl:call-template name="i18n"/>
        <xsl:if test="@smilref">
            <xsl:attribute name="smilref" select="@smilref"/>
        </xsl:if>
        <xsl:call-template name="showin"/>
    </xsl:template>-->

    <!--<xsl:template name="attrsrqd">
        <xsl:attribute name="id" select="@id"/> <!-\- ID -\->
        <xsl:if test="@class">
            <xsl:attribute name="class" select="@class"/>
        </xsl:if>
        <xsl:if test="@title">
            <xsl:attribute name="title" select="@title"/> <!-\- Text -\->
        </xsl:if>
        <xsl:if test="@xml:space">
            <xsl:attribute name="xml:space">
                <choice>
                    <value>default</value>
                    <value>preserve</value>
                </choice>
            </attribute>
        </xsl:if>
        <xsl:if test="@smilref">
            <xsl:attribute name="smilref" select="@smilref"/>
        </xsl:if>
        <xsl:call-template name="i18n"/>
        <xsl:call-template name="showin"/>
        
    </xsl:template>-->

    <xsl:template name="dtbookcontent">
        <xsl:apply-templates select="*"/>
        <!-- head, book -->
    </xsl:template>

    <xsl:template match="dtbook:dtbook">
        <html>
            <xsl:attribute name="epub:prefix" select="'z3998: http://www.daisy.org/z3998/2012/vocab/structure/#'"/>
            <xsl:call-template name="attlist.dtbook"/>
            <xsl:call-template name="dtbookcontent"/>
        </html>
    </xsl:template>

    <xsl:template name="attlist.dtbook">
        <!-- ignore @version -->
        <xsl:call-template name="i18n"/>
    </xsl:template>

    <xsl:template name="headmisc">
        <xsl:apply-templates select="*"/>
        <!-- meta, link -->
    </xsl:template>

    <xsl:template match="dtbook:head">
        <head>
            <!--<xsl:call-template name="attlist.head"/>-->
            <xsl:call-template name="headmisc"/>
        </head>
    </xsl:template>

    <!--<xsl:template name="attlist.head">
        <xsl:call-template name="i18n"/>
        <xsl:if test="@profile">
            <xsl:attribute name="profile" select="@profile"/> <!-\- URI -\->
        </xsl:if>
    </xsl:template>-->

    <!--<xsl:template name="link">
        <link>
            <xsl:call-template name="attlist.link"/>
            <empty/>
        </element>
    </xsl:template>-->

    <!--<xsl:template name="attlist.link">
        <xsl:call-template name="attrs"/>
        <xsl:if test="@charset">
            <xsl:attribute name="charset" select="@charset"/> <!-\- Charset -\->
        </xsl:if>
        <xsl:if test="@href">
            <xsl:attribute name="href" select="@charset" select="@charset"/> <!-\- Charset -\->
        </xsl:if>
        <xsl:if test="@href">
            <xsl:attribute name="href" select="@href"/> <!-\- URI -\->
        </xsl:if>
        <xsl:if test="@hreflang">
            <xsl:attribute name="hreflang" select="@hreflang"/> <!-\- LanguageCode -\->
        </xsl:if>
        <xsl:if test="@type">
            <xsl:attribute name="type" select="@type"/> <!-\- ContentType -\->
        </xsl:if>
        <xsl:if test="@rel">
            <xsl:attribute name="rel" select="@rel"/> <!-\- LinkTypes -\->
        </xsl:if>
        <xsl:if test="@rev">
            <xsl:attribute name="rev" select="@rev"/> <!-\- LinkTypes -\->
        </xsl:if>
        <xsl:if test="@media">
            <xsl:attribute name="media" select="@media"/> <!-\- MediaDesc -\->
        </xsl:if>
    </xsl:template>-->

    <!--<xsl:template name="meta">
        <meta>
            <xsl:call-template name="attlist.meta"/>
            <empty/>
        </element>
    </xsl:template>-->

    <!--<xsl:template name="attlist.meta">
        <xsl:call-template name="i18n"/>
        <xsl:if test="@http-equiv">
            <xsl:attribute name="http-equiv" select="@http-equiv"/> <!-\- NMTOKEN -\->
        </xsl:if>
        <xsl:if test="@name">
            <xsl:attribute name="name" select="@name"/> <!-\- NMTOKEN -\->
        </xsl:if>
        <xsl:attribute name="content" select="@content"/>
        <xsl:if test="@scheme">
            <xsl:attribute name="scheme" select="@scheme"/>
        </xsl:if>
    </xsl:template>-->

    <xsl:template match="dtbook:book">
        <body>
            <!--<xsl:call-template name="attlist.book"/>-->
            <xsl:apply-templates select="*"/>
            <!-- frontmatter, bodymatter, rearmatter -->
        </body>
    </xsl:template>
    <!--<xsl:template name="attlist.book">
        <xsl:call-template name="attrs"/>
    </xsl:template>-->

    <!--<xsl:template name="frontmatter">
        <frontmatter>
            <xsl:call-template name="attlist.frontmatter"/>
            <xsl:call-template name="doctitle"/>
            <optional>
                <xsl:call-template name="covertitle"/>
            </xsl:if>
            <zeroOrMore>
                <xsl:call-template name="docauthor"/>
            </zeroOrMore>
            <zeroOrMore>
                <choice>
                    <xsl:call-template name="level"/>
                    <xsl:call-template name="level1"/>
                </choice>
            </zeroOrMore>
        </element>
    </xsl:template>-->
    <!--<xsl:template name="attlist.frontmatter">
        <xsl:call-template name="attrs"/>
    </xsl:template>-->

    <!--<xsl:template name="bodymatter">
        <bodymatter>
            <xsl:call-template name="attlist.bodymatter"/>
            <oneOrMore>
                <choice>
                    <xsl:call-template name="level"/>
                    <xsl:call-template name="level1"/>
                </choice>
            </oneOrMore>
        </element>
    </xsl:template>-->
    <!--<xsl:template name="attlist.bodymatter">
        <xsl:call-template name="attrs"/>
    </xsl:template>-->

    <!--<xsl:template name="rearmatter">
        <rearmatter>
            <xsl:call-template name="attlist.rearmatter"/>
            <oneOrMore>
                <choice>
                    <xsl:call-template name="level"/>
                    <xsl:call-template name="level1"/>
                </choice>
            </oneOrMore>
        </element>
    </xsl:template>-->
    <!--<xsl:template name="attlist.rearmatter">
        <xsl:call-template name="attrs"/>
    </xsl:template>-->

    <!--<xsl:template name="level">
        <level>
            <xsl:call-template name="attlist.level"/>
            <choice>
                <group>
                    <xsl:call-template name="hd"/>
                    <oneOrMore>
                        <choice>
                            <xsl:call-template name="docblockorinline"/>
                            <xsl:call-template name="level"/>
                        </choice>
                    </oneOrMore>
                </group>
                <group>
                    <oneOrMore>
                        <choice>
                            <xsl:call-template name="docblockorinline"/>
                            <xsl:call-template name="level"/>
                        </choice>
                    </oneOrMore>
                    <optional>
                        <xsl:call-template name="hd"/>
                        <oneOrMore>
                            <choice>
                                <xsl:call-template name="docblockorinline"/>
                                <xsl:call-template name="level"/>
                            </choice>
                        </oneOrMore>
                    </xsl:if>
                </group>
            </choice>
        </element>
    </xsl:template>-->

    <!--<xsl:template name="attlist.level">
        <xsl:call-template name="attrs"/>
        <xsl:if test="@depth">
            <xsl:attribute name="depth" select="@depth"/>
        </xsl:if>
    </xsl:template>-->

    <!--<xsl:template name="level1">
        <level1>
            <xsl:call-template name="attlist.level1"/>
            <choice>
                <group>
                    <xsl:call-template name="h1"/>
                    <oneOrMore>
                        <choice>
                            <xsl:call-template name="docblockorinline"/>
                            <xsl:call-template name="level2"/>
                        </choice>
                    </oneOrMore>
                </group>
                <group>
                    <oneOrMore>
                        <choice>
                            <xsl:call-template name="docblockorinline"/>
                            <xsl:call-template name="level2"/>
                        </choice>
                    </oneOrMore>
                    <optional>
                        <xsl:call-template name="h1"/>
                        <oneOrMore>
                            <choice>
                                <xsl:call-template name="docblockorinline"/>
                                <xsl:call-template name="level2"/>
                            </choice>
                        </oneOrMore>
                    </xsl:if>
                </group>
            </choice>
        </element>
    </xsl:template>-->
    <!--<xsl:template name="attlist.level1">
        <xsl:call-template name="attrs"/>
    </xsl:template>-->

    <!--<xsl:template name="level2">
        <level2>
            <xsl:call-template name="attlist.level2"/>
            <choice>
                <group>
                    <xsl:call-template name="h2"/>
                    <oneOrMore>
                        <choice>
                            <xsl:call-template name="docblockorinline"/>
                            <xsl:call-template name="level3"/>
                        </choice>
                    </oneOrMore>
                </group>
                <group>
                    <oneOrMore>
                        <choice>
                            <xsl:call-template name="docblockorinline"/>
                            <xsl:call-template name="level3"/>
                        </choice>
                    </oneOrMore>
                    <optional>
                        <xsl:call-template name="h2"/>
                        <oneOrMore>
                            <choice>
                                <xsl:call-template name="docblockorinline"/>
                                <xsl:call-template name="level3"/>
                            </choice>
                        </oneOrMore>
                    </xsl:if>
                </group>
            </choice>
        </element>
    </xsl:template>-->
    <!--<xsl:template name="attlist.level2">
        <xsl:call-template name="attrs"/>
    </xsl:template>-->

    <!--<xsl:template name="level3">
        <level3>
            <xsl:call-template name="attlist.level3"/>
            <choice>
                <group>
                    <xsl:call-template name="h3"/>
                    <oneOrMore>
                        <choice>
                            <xsl:call-template name="docblockorinline"/>
                            <xsl:call-template name="level4"/>
                        </choice>
                    </oneOrMore>
                </group>
                <group>
                    <oneOrMore>
                        <choice>
                            <xsl:call-template name="docblockorinline"/>
                            <xsl:call-template name="level4"/>
                        </choice>
                    </oneOrMore>
                    <optional>
                        <xsl:call-template name="h3"/>
                        <oneOrMore>
                            <choice>
                                <xsl:call-template name="docblockorinline"/>
                                <xsl:call-template name="level4"/>
                            </choice>
                        </oneOrMore>
                    </xsl:if>
                </group>
            </choice>
        </element>
    </xsl:template>-->
    <!--<xsl:template name="attlist.level3">
        <xsl:call-template name="attrs"/>
    </xsl:template>-->

    <!--<xsl:template name="level4">
        <level4>
            <xsl:call-template name="attlist.level4"/>
            <choice>
                <group>
                    <xsl:call-template name="h4"/>
                    <oneOrMore>
                        <choice>
                            <xsl:call-template name="docblockorinline"/>
                            <xsl:call-template name="level5"/>
                        </choice>
                    </oneOrMore>
                </group>
                <group>
                    <oneOrMore>
                        <choice>
                            <xsl:call-template name="docblockorinline"/>
                            <xsl:call-template name="level5"/>
                        </choice>
                    </oneOrMore>
                    <optional>
                        <xsl:call-template name="h4"/>
                        <oneOrMore>
                            <choice>
                                <xsl:call-template name="docblockorinline"/>
                                <xsl:call-template name="level5"/>
                            </choice>
                        </oneOrMore>
                    </xsl:if>
                </group>
            </choice>
        </element>
    </xsl:template>-->
    <!--<xsl:template name="attlist.level4">
        <xsl:call-template name="attrs"/>
    </xsl:template>-->

    <!--<xsl:template name="level5">
        <level5>
            <xsl:call-template name="attlist.level5"/>
            <choice>
                <group>
                    <xsl:call-template name="h5"/>
                    <oneOrMore>
                        <choice>
                            <xsl:call-template name="docblockorinline"/>
                            <xsl:call-template name="level6"/>
                        </choice>
                    </oneOrMore>
                </group>
                <group>
                    <oneOrMore>
                        <choice>
                            <xsl:call-template name="docblockorinline"/>
                            <xsl:call-template name="level6"/>
                        </choice>
                    </oneOrMore>
                    <optional>
                        <xsl:call-template name="h5"/>
                        <oneOrMore>
                            <choice>
                                <xsl:call-template name="docblockorinline"/>
                                <xsl:call-template name="level6"/>
                            </choice>
                        </oneOrMore>
                    </xsl:if>
                </group>
            </choice>
        </element>
    </xsl:template>-->
    <!--<xsl:template name="attlist.level5">
        <xsl:call-template name="attrs"/>
    </xsl:template>-->

    <!--<xsl:template name="level6">
        <level6>
            <xsl:call-template name="attlist.level6"/>
            <choice>
                <group>
                    <xsl:call-template name="h6"/>
                    <oneOrMore>
                        <xsl:call-template name="docblockorinline"/>
                    </oneOrMore>
                </group>
                <group>
                    <oneOrMore>
                        <xsl:call-template name="docblockorinline"/>
                    </oneOrMore>
                    <optional>
                        <xsl:call-template name="h6"/>
                        <oneOrMore>
                            <xsl:call-template name="docblockorinline"/>
                        </oneOrMore>
                    </xsl:if>
                </group>
            </choice>
        </element>
    </xsl:template>-->
    <!--<xsl:template name="attlist.level6">
        <xsl:call-template name="attrs"/>
    </xsl:template>-->

    <!--<xsl:template name="phrase">
        <choice>
            <xsl:call-template name="em"/>
            <xsl:call-template name="strong"/>
            <xsl:call-template name="dfn"/>
            <xsl:call-template name="code"/>
            <xsl:call-template name="samp"/>
            <xsl:call-template name="kbd"/>
            <xsl:call-template name="cite"/>
            <xsl:call-template name="abbr"/>
            <xsl:call-template name="acronym"/>
        </choice>
    </xsl:template>-->

    <!--<xsl:template name="special">
        <choice>
            <xsl:call-template name="a"/>
            <xsl:call-template name="img"/>
            <xsl:call-template name="imggroup"/>
            <xsl:call-template name="br"/>
            <xsl:call-template name="q"/>
            <xsl:call-template name="sub"/>
            <xsl:call-template name="sup"/>
            <xsl:call-template name="span"/>
            <xsl:call-template name="bdo"/>
        </choice>
    </xsl:template>-->

    <!--<xsl:template name="specialnoa">
        <choice>
            <xsl:call-template name="img"/>
            <xsl:call-template name="imggroup"/>
            <xsl:call-template name="br"/>
            <xsl:call-template name="q"/>
            <xsl:call-template name="sub"/>
            <xsl:call-template name="sup"/>
            <xsl:call-template name="span"/>
            <xsl:call-template name="bdo"/>
        </choice>
    </xsl:template>-->

    <!--<xsl:template name="dtbookinline">
        <choice>
            <xsl:call-template name="sent"/>
            <xsl:call-template name="w"/>
            <xsl:call-template name="pagenum"/>
            <xsl:call-template name="prodnote"/>
            <xsl:call-template name="annoref"/>
            <xsl:call-template name="noteref"/>
            <xsl:call-template name="externalinline"/>
            <xsl:call-template name="externalFlow"/>
        </choice>
    </xsl:template>-->

    <!--<xsl:template name="inline">
        <choice>
            <text/>
            <xsl:call-template name="phrase"/>
            <xsl:call-template name="special"/>
            <xsl:call-template name="dtbookinline"/>
        </choice>
    </xsl:template>-->

    <!--<xsl:template name="inlinenoa">
        <choice>
            <text/>
            <xsl:call-template name="phrase"/>
            <xsl:call-template name="specialnoa"/>
            <xsl:call-template name="dtbookinline"/>
        </choice>
    </xsl:template>-->

    <!--<xsl:template name="inlines">
        <choice>
            <text/>
            <xsl:call-template name="phrase"/>
            <xsl:call-template name="special"/>
            <xsl:call-template name="pagenum"/>
            <xsl:call-template name="w"/>
            <xsl:call-template name="prodnote"/>
            <xsl:call-template name="annoref"/>
            <xsl:call-template name="noteref"/>
            <xsl:call-template name="externalinline"/>
            <xsl:call-template name="externalFlow"/>
        </choice>
    </xsl:template>-->

    <!--<xsl:template name="inlinew">
        <choice>
            <text/>
            <xsl:call-template name="phrase"/>
            <xsl:call-template name="special"/>
            <xsl:call-template name="externalinline"/>
            <xsl:call-template name="externalFlow"/>
        </choice>
    </xsl:template>-->

    <!--<xsl:template name="inlinenopagenum">
        <choice>
            <text/>
            <xsl:call-template name="phrase"/>
            <xsl:call-template name="special"/>
            <xsl:call-template name="sent"/>
            <xsl:call-template name="w"/>
            <xsl:call-template name="annoref"/>
            <xsl:call-template name="noteref"/>
            <xsl:call-template name="externalinline"/>
        </choice>
    </xsl:template>-->

    <!--<xsl:template name="inlinenoprodnote">
        <choice>
            <text/>
            <xsl:call-template name="phrase"/>
            <xsl:call-template name="special"/>
            <xsl:call-template name="sent"/>
            <xsl:call-template name="w"/>
            <xsl:call-template name="pagenum"/>
            <xsl:call-template name="annoref"/>
            <xsl:call-template name="noteref"/>
            <xsl:call-template name="externalinline"/>
        </choice>
    </xsl:template>-->

    <!--<xsl:template name="flow">
        <choice>
            <xsl:call-template name="inlinenoprodnote"/>
            <xsl:call-template name="blocknoimggroup"/>
            <xsl:call-template name="externalFlow"/>
        </choice>
    </xsl:template>-->

    <!--<xsl:template name="flownopagenum">
        <choice>
            <xsl:call-template name="inlinenopagenum"/>
            <xsl:call-template name="blocknoimggroup"/>
            <xsl:call-template name="externalFlow"/>
        </choice>
    </xsl:template>-->

    <!--<xsl:template name="br">
        <br>
            <xsl:call-template name="attlist.br"/>
            <empty/>
        </element>
    </xsl:template>-->

    <!--<xsl:template name="attlist.br">
        <xsl:call-template name="coreattrs"/>
    </xsl:template>-->

    <!--<xsl:template name="line">
        <line>
            <xsl:call-template name="attlist.line"/>
            <zeroOrMore>
                <choice>
                    <xsl:call-template name="inline"/>
                    <xsl:call-template name="linenum"/>
                </choice>
            </zeroOrMore>
        </element>
    </xsl:template>-->
    <!--<xsl:template name="attlist.line">
        <xsl:call-template name="attrs"/>
    </xsl:template>-->

    <!--<xsl:template name="linenum">
        <linenum>
            <xsl:call-template name="attlist.linenum"/>
            <text/>
        </element>
    </xsl:template>-->
    <!--<xsl:template name="attlist.linenum">
        <xsl:call-template name="attrs"/>
    </xsl:template>-->

    <!--<xsl:template name="address">
        <address>
            <xsl:call-template name="attlist.address"/>
            <zeroOrMore>
                <choice>
                    <xsl:call-template name="inline"/>
                    <xsl:call-template name="line"/>
                </choice>
            </zeroOrMore>
        </element>
    </xsl:template>-->
    <!--<xsl:template name="attlist.address">
        <xsl:call-template name="attrs"/>
    </xsl:template>-->

    <!--<xsl:template name="div">
        <div>
            <xsl:call-template name="attlist.div"/>
            <oneOrMore>
                <xsl:call-template name="docblockorinline"/>
            </oneOrMore>
        </element>
    </xsl:template>-->

    <!--<xsl:template name="attlist.div">
        <xsl:call-template name="attrs"/>
    </xsl:template>-->

    <!--<xsl:template name="title">
        <title>
            <xsl:call-template name="attlist.title"/>
            <zeroOrMore>
                <xsl:call-template name="inline"/>
            </zeroOrMore>
        </element>
    </xsl:template>-->
    <!--<xsl:template name="attlist.title">
        <xsl:call-template name="attrs"/>
    </xsl:template>-->

    <!--<xsl:template name="author">
        <author>
            <xsl:call-template name="attlist.author"/>
            <zeroOrMore>
                <xsl:call-template name="inline"/>
            </zeroOrMore>
        </element>
    </xsl:template>-->
    <!--<xsl:template name="attlist.author">
        <xsl:call-template name="attrs"/>
    </xsl:template>-->

    <!--<xsl:template name="prodnote">
        <prodnote>
            <xsl:call-template name="attlist.prodnote"/>
            <zeroOrMore>
                <xsl:call-template name="flow"/>
            </zeroOrMore>
        </element>
    </xsl:template>-->

    <!--<xsl:template name="attlist.prodnote">
        <xsl:call-template name="attrs"/>
        <xsl:if test="@imgref">
            <xsl:attribute name="imgref" select="@imgref"/> <!-\- IDREFS -\->
        </xsl:if>
        <xsl:attribute name="render">
            <choice>
                <value>required</value>
                <value>optional</value>
            </choice>
        </attribute>
    </xsl:template>-->

    <!--<xsl:template name="sidebar">
        <sidebar>
            <xsl:call-template name="attlist.sidebar"/>
            <zeroOrMore>
                <choice>
                    <xsl:call-template name="flow"/>
                    <xsl:call-template name="hd"/>
                </choice>
            </zeroOrMore>
        </element>
    </xsl:template>-->

    <!--<xsl:template name="attlist.sidebar">
        <xsl:call-template name="attrs"/>
        <xsl:attribute name="render">
            <choice>
                <value>required</value>
                <value>optional</value>
            </choice>
        </attribute>
    </xsl:template>-->

    <!--<xsl:template name="note">
        <note>
            <xsl:call-template name="attlist.note"/>
            <oneOrMore>
                <choice>
                    <xsl:call-template name="block"/>
                    <xsl:call-template name="inlineinblock"/>
                </choice>
            </oneOrMore>
        </element>
    </xsl:template>-->
    <!--<xsl:template name="attlist.note">
        <xsl:call-template name="attrsrqd"/>
    </xsl:template>-->

    <!--<xsl:template name="annotation">
        <annotation>
            <xsl:call-template name="attlist.annotation"/>
            <oneOrMore>
                <choice>
                    <xsl:call-template name="block"/>
                    <xsl:call-template name="inlineinblock"/>
                </choice>
            </oneOrMore>
        </element>
    </xsl:template>-->
    <!--<xsl:template name="attlist.annotation">
        <xsl:call-template name="attrsrqd"/>
    </xsl:template>-->

    <!--<xsl:template name="epigraph">
        <epigraph>
            <xsl:call-template name="attlist.epigraph"/>
            <zeroOrMore>
                <xsl:call-template name="flow"/>
            </zeroOrMore>
        </element>
    </xsl:template>-->
    <!--<xsl:template name="attlist.epigraph">
        <xsl:call-template name="attrs"/>
    </xsl:template>-->

    <!--<xsl:template name="byline">
        <byline>
            <xsl:call-template name="attlist.byline"/>
            <zeroOrMore>
                <xsl:call-template name="inline"/>
            </zeroOrMore>
        </element>
    </xsl:template>-->
    <!--<xsl:template name="attlist.byline">
        <xsl:call-template name="attrs"/>
    </xsl:template>-->

    <!--<xsl:template name="dateline">
        <dateline>
            <xsl:call-template name="attlist.dateline"/>
            <zeroOrMore>
                <xsl:call-template name="inline"/>
            </zeroOrMore>
        </element>
    </xsl:template>-->
    <!--<xsl:template name="attlist.dateline">
        <xsl:call-template name="attrs"/>
    </xsl:template>-->

    <!--<xsl:template name="linegroup">
        <linegroup>
            <xsl:call-template name="attlist.linegroup"/>
            <zeroOrMore>
                <choice>
                    <xsl:call-template name="hd"/>
                    <xsl:call-template name="dateline"/>
                    <xsl:call-template name="epigraph"/>
                    <xsl:call-template name="byline"/>
                    <xsl:call-template name="linegroup"/>
                    <xsl:call-template name="line"/>
                    <xsl:call-template name="pagenum"/>
                    <xsl:call-template name="prodnote"/>
                    <xsl:call-template name="noteref"/>
                    <xsl:call-template name="annoref"/>
                    <xsl:call-template name="note"/>
                    <xsl:call-template name="annotation"/>
                    <xsl:call-template name="p"/>
                    <xsl:call-template name="blockquote"/>
                    <xsl:call-template name="img"/>
                    <xsl:call-template name="imggroup"/>
                </choice>
            </zeroOrMore>
        </element>
    </xsl:template>-->

    <!--<xsl:template name="attlist.linegroup">
        <xsl:call-template name="attrs"/>
    </xsl:template>-->

    <!--<xsl:template name="poem">
        <poem>
            <xsl:call-template name="attlist.poem"/>
            <zeroOrMore>
                <choice>
                    <xsl:call-template name="title"/>
                    <xsl:call-template name="author"/>
                    <xsl:call-template name="hd"/>
                    <xsl:call-template name="dateline"/>
                    <xsl:call-template name="epigraph"/>
                    <xsl:call-template name="byline"/>
                    <xsl:call-template name="linegroup"/>
                    <xsl:call-template name="line"/>
                    <xsl:call-template name="pagenum"/>
                    <xsl:call-template name="img"/>
                    <xsl:call-template name="imggroup"/>
                    <xsl:call-template name="sidebar"/>
                </choice>
            </zeroOrMore>
        </element>
    </xsl:template>-->
    <!--<xsl:template name="attlist.poem">
        <xsl:call-template name="attrs"/>
    </xsl:template>-->

    <!--<xsl:template name="a">
        <a>
            <xsl:call-template name="attlist.a"/>
            <zeroOrMore>
                <xsl:call-template name="inlinenoa"/>
            </zeroOrMore>
        </element>
    </xsl:template>-->

    <!--<xsl:template name="attlist.a">
        <xsl:call-template name="attrs"/>
        <xsl:if test="@type">
            <xsl:attribute name="type" select="@type"/> <!-\- ContentType -\->
        </xsl:if>
        <xsl:if test="@href">
            <xsl:attribute name="href" select="@href"/> <!-\- URI -\->
        </xsl:if>
        <xsl:if test="@hreflang">
            <xsl:attribute name="hreflang" select="@hreflang"/> <!-\- LanguageCode -\->
        </xsl:if>
        <xsl:if test="@rel">
            <xsl:attribute name="rel" select="@rel"/> <!-\- LinkTypes -\->
        </xsl:if>
        <xsl:if test="@rev">
            <xsl:attribute name="rev" select="@rev"/> <!-\- LinkTypes -\->
        </xsl:if>
        <xsl:if test="@accesskey">
            <xsl:attribute name="accesskey" select="@accesskey"/> <!-\- Character -\->
        </xsl:if>
        <xsl:if test="@tabindex">
            <xsl:attribute name="tabindex" select="@tabindex"/> <!-\- Number -\->
        </xsl:if>
        <xsl:if test="@external">
            <xsl:attribute name="external"> <!-\-  a:defaultValue="false" -\->
                <choice>
                    <value>true</value>
                    <value>false</value>
                </choice>
            </attribute>
        </xsl:if>
    </xsl:template>-->

    <!--<xsl:template name="em">
        <em>
            <xsl:call-template name="attlist.em"/>
            <zeroOrMore>
                <xsl:call-template name="inline"/>
            </zeroOrMore>
        </element>
    </xsl:template>-->
    <!--<xsl:template name="attlist.em">
        <xsl:call-template name="attrs"/>
    </xsl:template>-->

    <!--<xsl:template name="strong">
        <strong>
            <xsl:call-template name="attlist.strong"/>
            <zeroOrMore>
                <xsl:call-template name="inline"/>
            </zeroOrMore>
        </element>
    </xsl:template>-->
    <!--<xsl:template name="attlist.strong">
        <xsl:call-template name="attrs"/>
    </xsl:template>-->

    <!--<xsl:template name="dfn">
        <dfn>
            <xsl:call-template name="attlist.dfn"/>
            <zeroOrMore>
                <xsl:call-template name="inline"/>
            </zeroOrMore>
        </element>
    </xsl:template>-->
    <!--<xsl:template name="attlist.dfn">
        <xsl:call-template name="attrs"/>
    </xsl:template>-->

    <!--<xsl:template name="kbd">
        <kbd>
            <xsl:call-template name="attlist.kbd"/>
            <zeroOrMore>
                <xsl:call-template name="inline"/>
            </zeroOrMore>
        </element>
    </xsl:template>-->
    <!--<xsl:template name="attlist.kbd">
        <xsl:call-template name="attrs"/>
    </xsl:template>-->

    <!--<xsl:template name="code">
        <code>
            <xsl:call-template name="attlist.code"/>
            <zeroOrMore>
                <xsl:call-template name="inline"/>
            </zeroOrMore>
        </element>
    </xsl:template>-->

    <!--<xsl:template name="attlist.code">
        <xsl:if test="@id">
            <xsl:attribute name="id" select="@id"/> <!-\- ID -\->
        </xsl:if>
        <xsl:if test="@class">
            <xsl:attribute name="class" select="@class"/>
        </xsl:if>
        <xsl:if test="@title">
            <xsl:attribute name="title" select="@title"/> <!-\- Text -\->
        </xsl:if>
        <xsl:if test="@xml:space">
            <xsl:attribute name="xml:space"> <!-\-  a:defaultValue="preserve" -\->
                <choice>
                    <value>default</value>
                    <value>preserve</value>
                </choice>
            </attribute>
        </xsl:if>
        
        <xsl:call-template name="i18n"/>
        <xsl:if test="@smilref">
            <xsl:attribute name="smilref" select="@smilref"/>
        </xsl:if>
        <xsl:call-template name="showin"/>
    </xsl:template>-->

    <!--<xsl:template name="samp">
        <samp>
            <xsl:call-template name="attlist.samp"/>
            <zeroOrMore>
                <xsl:call-template name="inline"/>
            </zeroOrMore>
        </element>
    </xsl:template>-->

    <!--<xsl:template name="attlist.samp">
        <xsl:if test="@id">
            <xsl:attribute name="id" select="@id"/> <!-\- ID -\->
        </xsl:if>
        <xsl:if test="@class">
            <xsl:attribute name="class" select="@class"/>
        </xsl:if>
        <xsl:if test="@title">
            <xsl:attribute name="title" select="@title"/> <!-\- Text -\->
        </xsl:if>
        <xsl:if test="@xml:space">
            <xsl:attribute name="xml:space"> <!-\-  a:defaultValue="preserve" -\->
                <choice>
                    <value>default</value>
                    <value>preserve</value>
                </choice>
            </attribute>
        </xsl:if>
        
        <xsl:call-template name="i18n"/>
        <xsl:if test="@smilref">
            <xsl:attribute name="smilref" select="@smilref"/>
        </xsl:if>
        <xsl:call-template name="showin"/>
    </xsl:template>-->

    <!--<xsl:template name="cite">
        <cite>
            <xsl:call-template name="attlist.cite"/>
            <zeroOrMore>
                <choice>
                    <xsl:call-template name="inline"/>
                    <xsl:call-template name="title"/>
                    <xsl:call-template name="author"/>
                </choice>
            </zeroOrMore>
        </element>
    </xsl:template>-->
    <!--<xsl:template name="attlist.cite">
        <xsl:call-template name="attrs"/>
    </xsl:template>-->

    <!--<xsl:template name="abbr">
        <abbr>
            <xsl:call-template name="attlist.abbr"/>
            <zeroOrMore>
                <xsl:call-template name="inline"/>
            </zeroOrMore>
        </element>
    </xsl:template>-->

    <!--<xsl:template name="attlist.abbr">
        <xsl:call-template name="attrs"/>
    </xsl:template>-->

    <!--<xsl:template name="acronym">
        <acronym>
            <xsl:call-template name="attlist.acronym"/>
            <zeroOrMore>
                <xsl:call-template name="inline"/>
            </zeroOrMore>
        </element>
    </xsl:template>-->

    <!--<xsl:template name="attlist.acronym">
        <xsl:call-template name="attrs"/>
        <xsl:if test="@pronounce">
            <xsl:attribute name="pronounce">
                <choice>
                    <value>yes</value>
                    <value>no</value>
                </choice>
            </attribute>
        </xsl:if>
    </xsl:template>-->

    <!--<xsl:template name="sub">
        <sub>
            <xsl:call-template name="attlist.sub"/>
            <zeroOrMore>
                <xsl:call-template name="inline"/>
            </zeroOrMore>
        </element>
    </xsl:template>-->
    <!--<xsl:template name="attlist.sub">
        <xsl:call-template name="attrs"/>
    </xsl:template>-->

    <!--<xsl:template name="sup">
        <sup>
            <xsl:call-template name="attlist.sup"/>
            <zeroOrMore>
                <xsl:call-template name="inline"/>
            </zeroOrMore>
        </element>
    </xsl:template>-->
    <!--<xsl:template name="attlist.sup">
        <xsl:call-template name="attrs"/>
    </xsl:template>-->

    <!--<xsl:template name="span">
        <span>
            <xsl:call-template name="attlist.span"/>
            <zeroOrMore>
                <xsl:call-template name="inline"/>
            </zeroOrMore>
        </element>
    </xsl:template>-->
    <!--<xsl:template name="attlist.span">
        <xsl:call-template name="attrs"/>
    </xsl:template>-->

    <!--<xsl:template name="bdo">
        <bdo>
            <xsl:call-template name="attlist.bdo"/>
            <zeroOrMore>
                <xsl:call-template name="inline"/>
            </zeroOrMore>
        </element>
    </xsl:template>-->

    <!--<xsl:template name="attlist.bdo">
        <xsl:call-template name="coreattrs"/>
        <xsl:if test="@xml:lang">
            <xsl:attribute name="xml:lang" select="@xml:lang"/> <!-\- LanguageCode -\->
        </xsl:if>
        <xsl:attribute name="dir">
            <choice>
                <value>ltr</value>
                <value>rtl</value>
            </choice>
        </attribute>
        <xsl:if test="@smilref">
            <xsl:attribute name="smilref" select="@smilref"/>
        </xsl:if>
        <xsl:call-template name="showin"/>
    </xsl:template>-->

    <!--<xsl:template name="sent">
        <sent>
            <xsl:call-template name="attlist.sent"/>
            <zeroOrMore>
                <xsl:call-template name="inlines"/>
            </zeroOrMore>
        </element>
    </xsl:template>-->
    <!--<xsl:template name="attlist.sent">
        <xsl:call-template name="attrs"/>
    </xsl:template>-->

    <!--<xsl:template name="w">
        <w>
            <xsl:call-template name="attlist.w"/>
            <zeroOrMore>
                <xsl:call-template name="inlinew"/>
            </zeroOrMore>
        </element>
    </xsl:template>-->
    <!--<xsl:template name="attlist.w">
        <xsl:call-template name="attrs"/>
    </xsl:template>-->

    <!--<xsl:template name="pagenum">
        <pagenum>
            <xsl:call-template name="attlist.pagenum"/>
            <text/>
        </element>
    </xsl:template>-->

    <!--<xsl:template name="attlist.pagenum">
        <xsl:call-template name="attrsrqd"/>
        <xsl:if test="@page">
            <xsl:attribute name="page"> <!-\-  a:defaultValue="normal" -\->
                <choice>
                    <value>front</value>
                    <value>normal</value>
                    <value>special</value>
                </choice>
            </attribute>
        </xsl:if>
    </xsl:template>-->

    <!--<xsl:template name="noteref">
        <noteref>
            <xsl:call-template name="attlist.noteref"/>
            <text/>
        </element>
    </xsl:template>-->

    <!--<xsl:template name="attlist.noteref">
        <xsl:call-template name="attrs"/>
        <xsl:attribute name="idref" select="@idref"/> <!-\- URI -\->
        <xsl:if test="@type">
            <xsl:attribute name="type" select="@type"/> <!-\- ContentType -\->
        </xsl:if>
    </xsl:template>-->

    <!--<xsl:template name="annoref">
        <annoref>
            <xsl:call-template name="attlist.annoref"/>
            <text/>
        </element>
    </xsl:template>-->

    <!--<xsl:template name="attlist.annoref">
        <xsl:call-template name="attrs"/>
        <xsl:attribute name="idref" select="@idref"/> <!-\- URI -\->
        <xsl:if test="@type">
            <xsl:attribute name="type" select="@type"/> <!-\- ContentType -\->
        </xsl:if>
    </xsl:template>-->

    <!--<xsl:template name="q">
        <q>
            <xsl:call-template name="attlist.q"/>
            <zeroOrMore>
                <xsl:call-template name="inline"/>
            </zeroOrMore>
        </element>
    </xsl:template>-->

    <!--<xsl:template name="attlist.q">
        <xsl:call-template name="attrs"/>
        <xsl:if test="@cite">
            <xsl:attribute name="cite" select="@cite"/> <!-\- URI -\->
        </xsl:if>
    </xsl:template>-->

    <!--<xsl:template name="Length">
        <xsl:value-of select="."/> <!-\- string -\->
    </xsl:template>-->

    <!--<xsl:template name="MultiLength">
        <xsl:value-of select="."/> <!-\- string -\->
    </xsl:template>-->

    <!--<xsl:template name="Pixels">
        <xsl:value-of select="."/> <!-\- string -\->
    </xsl:template>-->

    <!--<xsl:template name="img">
        <img>
            <xsl:call-template name="attlist.img"/>
            <empty/>
        </element>
    </xsl:template>-->

    <!--<xsl:template name="attlist.img">
        <xsl:call-template name="attrs"/>
        <xsl:attribute name="src" select="@src"/> <!-\- URI -\->
        <xsl:attribute name="alt" select="@alt"/> <!-\- Text -\->
        <xsl:if test="@longdesc">
            <xsl:attribute name="longdesc" select="@longdesc"/> <!-\- URI -\->
        </xsl:if>
        <xsl:if test="@height">
            <xsl:attribute name="height" select="@height"/> <!-\- Length -\->
        </xsl:if>
        <xsl:if test="@width">
            <xsl:attribute name="width" select="@width"/> <!-\- Length -\->
        </xsl:if>
    </xsl:template>-->

    <!--<xsl:template name="imggroup">
        <imggroup>
            <xsl:call-template name="attlist.imggroup"/>
            <oneOrMore>
                <choice>
                    <xsl:call-template name="prodnote"/>
                    <xsl:call-template name="img"/>
                    <xsl:call-template name="caption"/>
                    <xsl:call-template name="pagenum"/>
                </choice>
            </oneOrMore>
        </element>
    </xsl:template>-->
    <!--<xsl:template name="attlist.imggroup">
        <xsl:call-template name="attrs"/>
    </xsl:template>-->

    <!--<xsl:template name="p">
        <p>
            <xsl:call-template name="attlist.p"/>
            <zeroOrMore>
                <choice>
                    <xsl:call-template name="inline"/>
                    <xsl:call-template name="list"/>
                    <xsl:call-template name="dl"/>
                </choice>
            </zeroOrMore>
        </element>
    </xsl:template>-->
    <!--<xsl:template name="attlist.p">
        <xsl:call-template name="attrs"/>
    </xsl:template>-->

    <!--<xsl:template name="doctitle">
        <doctitle>
            <xsl:call-template name="attlist.doctitle"/>
            <zeroOrMore>
                <xsl:call-template name="inline"/>
            </zeroOrMore>
        </element>
    </xsl:template>-->
    <!--<xsl:template name="attlist.doctitle">
        <xsl:call-template name="attrs"/>
    </xsl:template>-->

    <!--<xsl:template name="docauthor">
        <docauthor>
            <xsl:call-template name="attlist.docauthor"/>
            <zeroOrMore>
                <xsl:call-template name="inline"/>
            </zeroOrMore>
        </element>
    </xsl:template>-->
    <!--<xsl:template name="attlist.docauthor">
        <xsl:call-template name="attrs"/>
    </xsl:template>-->

    <!--<xsl:template name="covertitle">
        <covertitle>
            <xsl:call-template name="attlist.covertitle"/>
            <zeroOrMore>
                <xsl:call-template name="inline"/>
            </zeroOrMore>
        </element>
    </xsl:template>-->
    <!--<xsl:template name="attlist.covertitle">
        <xsl:call-template name="attrs"/>
    </xsl:template>-->

    <!--<xsl:template name="h1">
        <h1>
            <xsl:call-template name="attlist.h1"/>
            <zeroOrMore>
                <xsl:call-template name="inline"/>
            </zeroOrMore>
        </element>
    </xsl:template>-->
    <!--<xsl:template name="attlist.h1">
        <xsl:call-template name="attrs"/>
    </xsl:template>-->

    <!--<xsl:template name="h2">
        <h2>
            <xsl:call-template name="attlist.h2"/>
            <zeroOrMore>
                <xsl:call-template name="inline"/>
            </zeroOrMore>
        </element>
    </xsl:template>-->
    <!--<xsl:template name="attlist.h2">
        <xsl:call-template name="attrs"/>
    </xsl:template>-->

    <!--<xsl:template name="h3">
        <h3>
            <xsl:call-template name="attlist.h3"/>
            <zeroOrMore>
                <xsl:call-template name="inline"/>
            </zeroOrMore>
        </element>
    </xsl:template>-->
    <!--<xsl:template name="attlist.h3">
        <xsl:call-template name="attrs"/>
    </xsl:template>-->

    <!--<xsl:template name="h4">
        <h4>
            <xsl:call-template name="attlist.h4"/>
            <zeroOrMore>
                <xsl:call-template name="inline"/>
            </zeroOrMore>
        </element>
    </xsl:template>-->
    <!--<xsl:template name="attlist.h4">
        <xsl:call-template name="attrs"/>
    </xsl:template>-->

    <!--<xsl:template name="h5">
        <h5>
            <xsl:call-template name="attlist.h5"/>
            <zeroOrMore>
                <xsl:call-template name="inline"/>
            </zeroOrMore>
        </element>
    </xsl:template>-->
    <!--<xsl:template name="attlist.h5">
        <xsl:call-template name="attrs"/>
    </xsl:template>-->

    <!--<xsl:template name="h6">
        <h6>
            <xsl:call-template name="attlist.h6"/>
            <zeroOrMore>
                <xsl:call-template name="inline"/>
            </zeroOrMore>
        </element>
    </xsl:template>-->
    <!--<xsl:template name="attlist.h6">
        <xsl:call-template name="attrs"/>
    </xsl:template>-->

    <!--<xsl:template name="bridgehead">
        <bridgehead>
            <xsl:call-template name="attlist.bridgehead"/>
            <zeroOrMore>
                <xsl:call-template name="inline"/>
            </zeroOrMore>
        </element>
    </xsl:template>-->
    <!--<xsl:template name="attlist.bridgehead">
        <xsl:call-template name="attrs"/>
    </xsl:template>-->

    <!--<xsl:template name="hd">
        <hd>
            <xsl:call-template name="attlist.hd"/>
            <zeroOrMore>
                <xsl:call-template name="inline"/>
            </zeroOrMore>
        </element>
    </xsl:template>-->
    <!--<xsl:template name="attlist.hd">
        <xsl:call-template name="attrs"/>
    </xsl:template>-->

    <!--<xsl:template name="blockquote">
        <blockquote>
            <xsl:call-template name="attlist.blockquote"/>
            <zeroOrMore>
                <choice>
                    <xsl:call-template name="pagenum"/>
                    <xsl:call-template name="block"/>
                </choice>
            </zeroOrMore>
        </element>
    </xsl:template>-->

    <!--<xsl:template name="attlist.blockquote">
        <xsl:call-template name="attrs"/>
        <xsl:if test="@cite">
            <xsl:attribute name="cite" select="@cite"/> <!-\- URI -\->
        </xsl:if>
    </xsl:template>-->

    <!--<xsl:template name="dl">
        <dl>
            <xsl:call-template name="attlist.dl"/>
            <oneOrMore>
                <choice>
                    <xsl:call-template name="dt"/>
                    <xsl:call-template name="dd"/>
                    <xsl:call-template name="pagenum"/>
                </choice>
            </oneOrMore>
        </element>
    </xsl:template>-->
    <!--<xsl:template name="attlist.dl">
        <xsl:call-template name="attrs"/>
    </xsl:template>-->

    <!--<xsl:template name="dt">
        <dt>
            <xsl:call-template name="attlist.dt"/>
            <zeroOrMore>
                <xsl:call-template name="inline"/>
            </zeroOrMore>
        </element>
    </xsl:template>-->
    <!--<xsl:template name="attlist.dt">
        <xsl:call-template name="attrs"/>
    </xsl:template>-->

    <!--<xsl:template name="dd">
        <dd>
            <xsl:call-template name="attlist.dd"/>
            <zeroOrMore>
                <xsl:call-template name="flow"/>
            </zeroOrMore>
        </element>
    </xsl:template>-->
    <!--<xsl:template name="attlist.dd">
        <xsl:call-template name="attrs"/>
    </xsl:template>-->

    <!--<xsl:template name="list">
        <list>
            <xsl:call-template name="attlist.list"/>
            <oneOrMore>
                <choice>
                    <xsl:call-template name="hd"/>
                    <xsl:call-template name="prodnote"/>
                    <xsl:call-template name="li"/>
                    <xsl:call-template name="pagenum"/>
                </choice>
            </oneOrMore>
        </element>
    </xsl:template>-->

    <!--<xsl:template name="attlist.list">
        <xsl:call-template name="attrs"/>
        <xsl:attribute name="type">
            <choice>
                <value>ol</value>
                <value>ul</value>
                <value>pl</value>
            </choice>
        </attribute>
        <xsl:if test="@depth">
            <xsl:attribute name="depth" select="@depth"/>
        </xsl:if>
        <xsl:if test="@enum">
            <xsl:attribute name="enum">
                <choice>
                    <value>1</value>
                    <value>a</value>
                    <value>A</value>
                    <value>i</value>
                    <value>I</value>
                </choice>
            </attribute>
        </xsl:if>
        <xsl:if test="@start">
            <xsl:attribute name="start" select="@start"/>
        </xsl:if>
    </xsl:template>-->

    <!--<xsl:template name="li">
        <li>
            <xsl:call-template name="attlist.li"/>
            <zeroOrMore>
                <choice>
                    <xsl:call-template name="flow"/>
                    <xsl:call-template name="lic"/>
                </choice>
            </zeroOrMore>
        </element>
    </xsl:template>-->
    <!--<xsl:template name="attlist.li">
        <xsl:call-template name="attrs"/>
    </xsl:template>-->

    <!--<xsl:template name="lic">
        <lic>
            <xsl:call-template name="attlist.lic"/>
            <zeroOrMore>
                <xsl:call-template name="inline"/>
            </zeroOrMore>
        </element>
    </xsl:template>-->

    <!--<xsl:template name="attlist.lic">
        <xsl:call-template name="attrs"/>
    </xsl:template>-->

    <!--<xsl:template name="Scope">
        <choice>
            <value>row</value>
            <value>col</value>
            <value>rowgroup</value>
            <value>colgroup</value>
        </choice>
    </xsl:template>-->

    <!--<xsl:template name="TFrame">
        <choice>
            <value>void</value>
            <value>above</value>
            <value>below</value>
            <value>hsides</value>
            <value>lhs</value>
            <value>rhs</value>
            <value>vsides</value>
            <value>box</value>
            <value>border</value>
        </choice>
    </xsl:template>-->

    <!--<xsl:template name="TRules">
        <choice>
            <value>none</value>
            <value>groups</value>
            <value>rows</value>
            <value>cols</value>
            <value>all</value>
        </choice>
    </xsl:template>-->

    <!--<xsl:template name="cellhalign">
        <xsl:if test="@align">
            <xsl:attribute name="align">
                <choice>
                    <value>left</value>
                    <value>center</value>
                    <value>right</value>
                    <value>justify</value>
                    <value>char</value>
                </choice>
            </attribute>
        </xsl:if>
        <xsl:if test="@char">
            <xsl:attribute name="char" select="@char"/> <!-\- Character -\->
        </xsl:if>
        <xsl:if test="@charoff">
            <xsl:attribute name="charoff" select="@charoff"/> <!-\- Length -\->
        </xsl:if>
    </xsl:template>-->

    <!--<xsl:template name="cellvalign">
        <xsl:if test="@valign">
            <xsl:attribute name="valign">
                <choice>
                    <value>top</value>
                    <value>middle</value>
                    <value>bottom</value>
                    <value>baseline</value>
                </choice>
            </attribute>
        </xsl:if>
    </xsl:template>-->

    <!--<xsl:template name="table">
        <table>
            <xsl:call-template name="attlist.table"/>
            <optional>
                <xsl:call-template name="caption"/>
            </xsl:if>
            <choice>
                <zeroOrMore>
                    <xsl:call-template name="col"/>
                </zeroOrMore>
                <zeroOrMore>
                    <xsl:call-template name="colgroup"/>
                </zeroOrMore>
            </choice>
            <optional>
                <xsl:call-template name="thead"/>
            </xsl:if>
            <optional>
                <xsl:call-template name="tfoot"/>
            </xsl:if>
            <choice>
                <oneOrMore>
                    <xsl:call-template name="tbody"/>
                </oneOrMore>
                <oneOrMore>
                    <choice>
                        <xsl:call-template name="tr"/>
                        <xsl:call-template name="pagenum"/>
                    </choice>
                </oneOrMore>
            </choice>
        </element>
    </xsl:template>-->

    <!--<xsl:template name="attlist.table">
        <xsl:call-template name="attrs"/>
        <xsl:if test="@summary">
            <xsl:attribute name="summary" select="@summary"/> <!-\- Text -\->
        </xsl:if>
        <xsl:if test="@width">
            <xsl:attribute name="width" select="@width"/> <!-\- Length -\->
        </xsl:if>
        <xsl:if test="@border">
            <xsl:attribute name="border" select="@border"/> <!-\- Pixels -\->
        </xsl:if>
        <xsl:if test="@frame">
            <xsl:attribute name="frame" select="@frame"/> <!-\- TFrame -\->
        </xsl:if>
        <xsl:if test="@rules">
            <xsl:attribute name="rules" select="@rules"/> <!-\- TRules -\->
        </xsl:if>
        <xsl:if test="@cellspacing">
            <xsl:attribute name="cellspacing" select="@cellspacing"/> <!-\- Length -\->
        </xsl:if>
        <xsl:if test="@cellpadding">
            <xsl:attribute name="cellpadding" select="@cellpadding"/> <!-\- Length -\->
        </xsl:if>
    </xsl:template>-->

    <!--<xsl:template name="caption">
        <caption>
            <xsl:call-template name="attlist.caption"/>
            <zeroOrMore>
                <xsl:call-template name="flow"/>
            </zeroOrMore>
        </element>
    </xsl:template>-->

    <!--<xsl:template name="attlist.caption">
        <xsl:call-template name="attrs"/>
        <xsl:if test="@imgref">
            <xsl:attribute name="imgref" select="@imgref"/> <!-\- IDREFS -\->
        </xsl:if>
    </xsl:template>-->

    <!--<xsl:template name="thead">
        <thead>
            <xsl:call-template name="attlist.thead"/>
            <oneOrMore>
                <xsl:call-template name="tr"/>
            </oneOrMore>
        </element>
    </xsl:template>-->
    <!--<xsl:template name="attlist.thead">
        <xsl:call-template name="attrs"/>
        <xsl:call-template name="cellhalign"/>
        <xsl:call-template name="cellvalign"/>
    </xsl:template>-->

    <!--<xsl:template name="tfoot">
        <tfoot>
            <xsl:call-template name="attlist.tfoot"/>
            <oneOrMore>
                <xsl:call-template name="tr"/>
            </oneOrMore>
        </element>
    </xsl:template>-->
    <!--<xsl:template name="attlist.tfoot">
        <xsl:call-template name="attrs"/>
        <xsl:call-template name="cellhalign"/>
        <xsl:call-template name="cellvalign"/>
    </xsl:template>-->

    <!--<xsl:template name="tbody">
        <tbody>
            <xsl:call-template name="attlist.tbody"/>
            <oneOrMore>
                <choice>
                    <xsl:call-template name="tr"/>
                    <xsl:call-template name="pagenum"/>
                </choice>
            </oneOrMore>
        </element>
    </xsl:template>-->
    <!--<xsl:template name="attlist.tbody">
        <xsl:call-template name="attrs"/>
        <xsl:call-template name="cellhalign"/>
        <xsl:call-template name="cellvalign"/>
    </xsl:template>-->

    <!--<xsl:template name="colgroup">
        <colgroup>
            <xsl:call-template name="attlist.colgroup"/>
            <zeroOrMore>
                <xsl:call-template name="col"/>
            </zeroOrMore>
        </element>
    </xsl:template>-->

    <!--<xsl:template name="attlist.colgroup">
        <xsl:call-template name="attrs"/>
        <xsl:if test="@span">
            <xsl:attribute name="span"> <!-\-  a:defaultValue="1" -\->
                <xsl:value-of select="."/> <!-\- NMTOKEN -\->
            </attribute>
        </xsl:if>
        <xsl:if test="@width">
            <xsl:attribute name="width" select="@width"/> <!-\- MultiLength -\->
        </xsl:if>
        <xsl:call-template name="cellhalign"/>
        <xsl:call-template name="cellvalign"/>
    </xsl:template>-->

    <!--<xsl:template name="col">
        <col>
            <xsl:call-template name="attlist.col"/>
            <empty/>
        </element>
    </xsl:template>-->

    <!--<xsl:template name="attlist.col">
        <xsl:call-template name="attrs"/>
        <xsl:if test="@span">
            <xsl:attribute name="span"> <!-\-  a:defaultValue="1" -\->
                <xsl:value-of select="."/> <!-\- NMTOKEN -\->
            </attribute>
        </xsl:if>
        <xsl:if test="@width">
            <xsl:attribute name="width" select="@width"/> <!-\- MultiLength -\->
        </xsl:if>
        <xsl:call-template name="cellhalign"/>
        <xsl:call-template name="cellvalign"/>
    </xsl:template>-->

    <!--<xsl:template name="tr">
        <tr>
            <xsl:call-template name="attlist.tr"/>
            <oneOrMore>
                <choice>
                    <xsl:call-template name="th"/>
                    <xsl:call-template name="td"/>
                </choice>
            </oneOrMore>
        </element>
    </xsl:template>-->

    <!--<xsl:template name="attlist.tr">
        <xsl:call-template name="attrs"/>
        <xsl:call-template name="cellhalign"/>
        <xsl:call-template name="cellvalign"/>
    </xsl:template>-->

    <!--<xsl:template name="th">
        <th>
            <xsl:call-template name="attlist.th"/>
            <zeroOrMore>
                <xsl:call-template name="flownopagenum"/>
            </zeroOrMore>
        </element>
    </xsl:template>-->

    <!--<xsl:template name="attlist.th">
        <xsl:call-template name="attrs"/>
        <xsl:if test="@abbr">
            <xsl:attribute name="abbr" select="@abbr"/> <!-\- Text -\->
        </xsl:if>
        <xsl:if test="@axis">
            <xsl:attribute name="axis" select="@axis"/>
        </xsl:if>
        <xsl:if test="@headers">
            <xsl:attribute name="headers" select="@headers"/> <!-\- IDREFS -\->
        </xsl:if>
        <xsl:if test="@scope">
            <xsl:attribute name="scope" select="@scope"/> <!-\- Scope -\->
        </xsl:if>
        <xsl:if test="@rowspan">
            <xsl:attribute name="rowspan"> <!-\-  a:defaultValue="1" -\->
                <xsl:value-of select="."/> <!-\- NMTOKEN -\->
            </attribute>
        </xsl:if>
        <xsl:if test="@colspan">
            <xsl:attribute name="colspan"> <!-\-  a:defaultValue="1" -\->
                <xsl:value-of select="."/> <!-\- NMTOKEN -\->
            </attribute>
        </xsl:if>
        <xsl:call-template name="cellhalign"/>
        <xsl:call-template name="cellvalign"/>
    </xsl:template>-->

    <!--<xsl:template name="td">
        <td>
            <xsl:call-template name="attlist.td"/>
            <zeroOrMore>
                <xsl:call-template name="flownopagenum"/>
            </zeroOrMore>
        </element>
    </xsl:template>-->

    <!--<xsl:template name="attlist.td">
        <xsl:call-template name="attrs"/>
        <xsl:if test="@abbr">
            <xsl:attribute name="abbr" select="@abbr"/> <!-\- Text -\->
        </xsl:if>
        <xsl:if test="@axis">
            <xsl:attribute name="axis" select="@axis"/>
        </xsl:if>
        <xsl:if test="@headers">
            <xsl:attribute name="headers" select="@headers"/> <!-\- IDREFS -\->
        </xsl:if>
        <xsl:if test="@scope">
            <xsl:attribute name="scope" select="@scope"/> <!-\- Scope -\->
        </xsl:if>
        <xsl:if test="@rowspan">
            <xsl:attribute name="rowspan"> <!-\-  a:defaultValue="1" -\->
                <xsl:value-of select="."/> <!-\- NMTOKEN -\->
            </attribute>
        </xsl:if>
        <xsl:if test="@colspan">
            <xsl:attribute name="colspan"> <!-\-  a:defaultValue="1" -\->
                <xsl:value-of select="."/> <!-\- NMTOKEN -\->
            </attribute>
        </xsl:if>
        <xsl:call-template name="cellhalign"/>
        <xsl:call-template name="cellvalign"/>
    </xsl:template>-->

</xsl:stylesheet>
