<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:f="http://www.daisy.org/ns/pipeline/internal-functions" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0" xmlns="http://www.daisy.org/z3986/2005/dtbook/"
    xpath-default-namespace="http://www.daisy.org/z3986/2005/dtbook/" exclude-result-prefixes="#all" xmlns:epub="http://www.idpf.org/2007/ops" xmlns:html="http://www.w3.org/1999/xhtml"
    xmlns:xs="http://www.w3.org/2001/XMLSchema">

    <xsl:template match="text()|comment()">
        <xsl:copy-of select="."/>
    </xsl:template>

    <xsl:template name="coreattrs">
        <xsl:copy-of select="@id|@title|@xml:space"/>
        <xsl:call-template name="classes-and-types"/>
    </xsl:template>

    <xsl:template name="i18n">
        <xsl:copy-of select="@xml:lang|@dir"/>
    </xsl:template>

    <xsl:template name="classes-and-types">
        <xsl:param name="classes" select="()" tunnel="yes"/>
        <xsl:variable name="old-classes" select="f:classes(.)"/>

        <xsl:variable name="showin" select="($old-classes[matches(.,'^showin-...$')])[1]/replace(.,'showin-','')"/>
        <xsl:if test="$showin">
            <xsl:attribute name="showin" select="$showin"/>
        </xsl:if>

        <xsl:variable name="epub-type-classes">
            <xsl:for-each select="f:types(.)">
                <xsl:choose>
                    <xsl:when test=".='toc'">
                        <!-- TODO: add epub:types that maps to different class strings here like this -->
                        <xsl:sequence select="'toc'"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:sequence select="tokenize(.,':')[last()]"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:for-each>
        </xsl:variable>

        <xsl:attribute name="class" select="string-join(distinct-values(($classes, $old-classes[not(matches(.,concat('showin-',$showin)))], $epub-type-classes)),' ')"/>
    </xsl:template>

    <xsl:template name="attrs">
        <xsl:call-template name="coreattrs"/>
        <xsl:call-template name="i18n"/>
    </xsl:template>

    <xsl:template name="attrsrqd">
        <xsl:copy-of select="@id|@title|@xml:space"/>
        <xsl:call-template name="classes-and-types"/>
        <xsl:call-template name="i18n"/>
    </xsl:template>

    <xsl:template match="html:html">
        <dtbook version="2005-3">
            <xsl:call-template name="attlist.dtbook"/>
            <xsl:apply-templates select="node()"/>
        </dtbook>
    </xsl:template>

    <xsl:template name="attlist.dtbook">
        <xsl:call-template name="i18n"/>
    </xsl:template>

    <xsl:template match="html:head">
        <head>
            <xsl:call-template name="attlist.head"/>
            <xsl:apply-templates select="node()"/>
            <!-- TODO: maybe add a default CSS here? -->
        </head>
    </xsl:template>

    <xsl:template name="attlist.head">
        <xsl:call-template name="i18n"/>
    </xsl:template>

    <xsl:template match="link">
        <link>
            <xsl:call-template name="attlist.link"/>
        </link>
    </xsl:template>

    <xsl:template name="attlist.link">
        <xsl:call-template name="attrs"/>
        <xsl:copy-of select="@href|@hreflang|@type|@rel|@media"/>
        <!-- @sizes are dropped -->
    </xsl:template>

    <xsl:template match="html:meta">
        <meta>
            <xsl:call-template name="attlist.meta"/>
        </meta>
    </xsl:template>

    <xsl:template name="attlist.meta">
        <xsl:call-template name="i18n"/>
        <xsl:copy-of select="@content|@http-equiv|@name"/>
        <!-- @charset is dropped -->
    </xsl:template>

    <xsl:template match="html:body">
        <book>
            <xsl:if test="*[f:types(.)=('cover','frontmatter')]">
                <xsl:call-template name="frontmatter"/>
            </xsl:if>
            <xsl:if test="*[f:types(.)=('bodymatter')]">
                <xsl:call-template name="bodymatter"/>
            </xsl:if>
            <xsl:if test="*[f:types(.)=('backmatter')]">
                <xsl:call-template name="rearmatter"/>
            </xsl:if>
            <xsl:apply-templates select="*[last()]/following-sibling::node()"/>
        </book>
    </xsl:template>

    <xsl:template name="frontmatter">
        <frontmatter>
            <xsl:for-each select="*[f:types(.)='titlepage']//html:h1[f:types(.)='fulltitle']">
                <xsl:call-template name="doctitle"/>
            </xsl:for-each>
            <xsl:for-each select="*[f:types(.)='cover']//html:h1[f:types(.)='covertitle']">
                <xsl:call-template name="covertitle"/>
            </xsl:for-each>
            <xsl:for-each select="*[f:types(.)='titlepage']//*[f:types(.)='z3998:author']">
                <xsl:call-template name="docauthor"/>
            </xsl:for-each>
            <xsl:apply-templates select="*[f:types(.)=('cover','frontmatter')]"/>
        </frontmatter>
    </xsl:template>

    <xsl:template match="html:h1[f:types(.)='fulltitle' and ancestor::*[f:types(.)='titlepage']]"/>
    <xsl:template match="html:h1[f:types(.)='covertitle' and ancestor::*[f:types(.)='cover']]"/>
    <xsl:template match="*[f:types(.)='z3998:author'][ancestor::*[f:types(.)='titlepage']]"/>

    <xsl:template name="bodymatter">
        <bodymatter>
            <xsl:apply-templates select="node()"/>
        </bodymatter>
    </xsl:template>

    <xsl:template name="rearmatter">
        <rearmatter>
            <xsl:apply-templates select="node()"/>
        </rearmatter>
    </xsl:template>

    <xsl:template match="html:section | html:article">
        <xsl:call-template name="copy-preceding-comments"/>
        <xsl:element name="level{f:level(.)}">
            <xsl:call-template name="attlist.level">
                <xsl:with-param name="classes" select="if (self::html:article) then 'z3998:article' else ()" tunnel="yes"/>
            </xsl:call-template>
            <xsl:apply-templates select="node()"/>
        </xsl:element>
    </xsl:template>

    <xsl:template name="attlist.level">
        <xsl:call-template name="attrs"/>
    </xsl:template>

    <xsl:template match="html:br">
        <br>
            <xsl:call-template name="attlist.br"/>
        </br>
    </xsl:template>

    <xsl:template name="attlist.br">
        <xsl:call-template name="coreattrs"/>
    </xsl:template>

    <xsl:template match="html:p[f:classes(.)='line']">
        <line>
            <xsl:call-template name="attlist.line"/>
            <xsl:apply-templates select="node()"/>
        </line>
    </xsl:template>

    <xsl:template name="attlist.line">
        <xsl:call-template name="attrs"/>
    </xsl:template>

    <xsl:template match="html:span[f:classes(.)='linenum']">
        <linenum>
            <xsl:call-template name="attlist.linenum"/>
            <xsl:apply-templates select="node()"/>
        </linenum>
    </xsl:template>

    <xsl:template name="attlist.linenum">
        <xsl:call-template name="attrs"/>
    </xsl:template>

    <xsl:template match="html:address">
        <address>
            <xsl:call-template name="attlist.address"/>
            <xsl:apply-templates select="node()"/>
        </address>
    </xsl:template>

    <xsl:template name="attlist.address">
        <xsl:call-template name="attrs"/>
    </xsl:template>

    <xsl:template match="html:div">
        <div>
            <xsl:call-template name="attlist.div"/>
            <xsl:apply-templates select="node()"/>
        </div>
    </xsl:template>

    <xsl:template name="attlist.div">
        <xsl:call-template name="attrs"/>
    </xsl:template>

    <xsl:template match="html:*[f:classes(.)='title']">
        <title>
            <xsl:call-template name="attlist.title"/>
            <xsl:apply-templates select="node()"/>
        </title>
    </xsl:template>

    <xsl:template name="attlist.title">
        <xsl:call-template name="attrs"/>
    </xsl:template>

    <xsl:template match="*[f:types(.)='z3998:author']">
        <author>
            <xsl:call-template name="attlist.author"/>
            <xsl:apply-templates select="node()"/>
        </author>
    </xsl:template>

    <xsl:template name="attlist.author">
        <xsl:call-template name="attrs"/>
    </xsl:template>

    <xsl:template match="html:aside[f:types(.)='z3998:production']">
        <prodnote>
            <xsl:call-template name="attlist.prodnote"/>
            <xsl:apply-templates select="node()"/>
        </prodnote>
    </xsl:template>

    <xsl:template name="attlist.prodnote">
        <xsl:call-template name="attrs"/>
        <xsl:choose>
            <xsl:when test="f:classes(.)='render-required'">
                <xsl:attribute name="render" select="'required'"/>
            </xsl:when>
            <xsl:when test="f:classes(.)='render-optional'">
                <xsl:attribute name="render" select="'optional'"/>
            </xsl:when>
        </xsl:choose>
        <xsl:if test="@id">
            <xsl:variable name="id" select="@id"/>
            <xsl:variable name="img" select="//html:img[replace(@longdesc,'^#','')=$id]"/>
            <xsl:if test="$img">
                <xsl:attribute name="imgref" select="string-join($img/((@id,generate-id(.))[1]),' ')"/>
            </xsl:if>
        </xsl:if>
    </xsl:template>

    <xsl:template match="html:aside[f:types(.)='sidebar']">
        <sidebar>
            <xsl:call-template name="attlist.sidebar"/>
            <xsl:apply-templates select="node()"/>
        </sidebar>
    </xsl:template>

    <xsl:template name="attlist.sidebar">
        <xsl:call-template name="attrs"/>
        <xsl:choose>
            <xsl:when test="f:classes(.)='render-required'">
                <xsl:attribute name="render" select="'required'"/>
            </xsl:when>
            <xsl:when test="f:classes(.)='render-optional'">
                <xsl:attribute name="render" select="'optional'"/>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="html:aside[f:types(.)='note']">
        <note>
            <xsl:call-template name="attlist.note"/>
            <xsl:apply-templates select="node()"/>
        </note>
    </xsl:template>

    <xsl:template name="attlist.note">
        <xsl:call-template name="attrsrqd"/>
    </xsl:template>

    <xsl:template match="html:aside[f:types(.)='annotation']">
        <annotation>
            <xsl:call-template name="attlist.note"/>
            <xsl:apply-templates select="node()"/>
        </annotation>
    </xsl:template>

    <xsl:template name="attlist.annotation">
        <xsl:call-template name="attrsrqd"/>
    </xsl:template>

    <xsl:template match="html:aside[f:types(.)='epigraph']">
        <epigraph>
            <xsl:call-template name="attlist.epigraph"/>
            <xsl:apply-templates select="node()"/>
        </epigraph>
    </xsl:template>

    <xsl:template name="attlist.epigraph">
        <xsl:call-template name="attrs"/>
    </xsl:template>

    <xsl:template match="html:span[f:classes(.)='byline']">
        <byline>
            <xsl:call-template name="attlist.byline"/>
            <xsl:apply-templates select="node()"/>
        </byline>
    </xsl:template>

    <xsl:template name="attlist.byline">
        <xsl:call-template name="attrs"/>
    </xsl:template>

    <xsl:template match="html:span[f:classes(.)='dateline']">
        <dateline>
            <xsl:call-template name="attlist.dateline"/>
            <xsl:apply-templates select="node()"/>
        </dateline>
    </xsl:template>

    <xsl:template name="attlist.dateline">
        <xsl:call-template name="attrs"/>
    </xsl:template>

    <xsl:template match="html:div[f:classes(.)='linegroup']">
        <linegroup>
            <xsl:call-template name="attlist.linegroup"/>
            <xsl:apply-templates select="node()"/>
        </linegroup>
    </xsl:template>

    <xsl:template name="attlist.linegroup">
        <xsl:call-template name="attrs"/>
    </xsl:template>

    <xsl:template match="html:div[f:types(.)='z3998:poem']">
        <poem>
            <xsl:call-template name="attlist.poem"/>
            <xsl:apply-templates select="node()"/>
        </poem>
    </xsl:template>

    <xsl:template name="attlist.poem">
        <xsl:call-template name="attrs"/>
    </xsl:template>

    <xsl:template match="html:a">
        <a>
            <xsl:call-template name="attlist.a"/>
            <xsl:apply-templates select="node()"/>
        </a>
    </xsl:template>

    <xsl:template name="attlist.a">
        <xsl:call-template name="attrs">
            <!-- Preserve @target as class attribute. Assumes that only characters that are valid for class names are used. -->
            <xsl:with-param name="classes" select="if (@target) then concat('target-',replace(@target,'_','-')) else ()" tunnel="yes"/>
        </xsl:call-template>
        <xsl:copy-of select="@type|@href|@hreflang|@rel|@accesskey|@tabindex"/>
        <!-- @download, @media, @type is dropped - they don't have a good equivalent in DTBook -->

        <xsl:choose>
            <xsl:when test="f:classes(.)[matches(.,'^external-(true|false)')]">
                <xsl:attribute name="external" select="replace((f:classes(.)[matches(.,'^external-(true|false)')])[1],'^external-','')"/>
            </xsl:when>
            <xsl:when test="@target='_blank' or matches(@href,'^(\w+:|/)')">
                <xsl:attribute name="external" select="'true'"/>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="html:em">
        <em>
            <xsl:call-template name="attlist.em"/>
            <xsl:apply-templates select="node()"/>
        </em>
    </xsl:template>

    <xsl:template name="attlist.em">
        <xsl:call-template name="attrs"/>
    </xsl:template>

    <xsl:template match="html:strong">
        <strong>
            <xsl:call-template name="attlist.strong"/>
            <xsl:apply-templates select="node()"/>
        </strong>
    </xsl:template>

    <xsl:template name="attlist.strong">
        <xsl:call-template name="attrs"/>
    </xsl:template>

    <xsl:template match="html:dfn">
        <dfn>
            <xsl:call-template name="attlist.dfn"/>
            <xsl:apply-templates select="node()"/>
        </dfn>
    </xsl:template>

    <xsl:template name="attlist.dfn">
        <xsl:call-template name="attrs"/>
    </xsl:template>

    <xsl:template match="html:kbd">
        <kbd>
            <xsl:call-template name="attlist.kbd"/>
            <xsl:apply-templates select="node()"/>
        </kbd>
    </xsl:template>

    <xsl:template name="attlist.kbd">
        <xsl:call-template name="attrs"/>
    </xsl:template>

    <xsl:template match="html:code">
        <code>
            <xsl:call-template name="attlist.code"/>
            <xsl:apply-templates select="node()"/>
        </code>
    </xsl:template>

    <xsl:template name="attlist.code">
        <xsl:call-template name="attrs"/>
        <xsl:call-template name="i18n"/>
    </xsl:template>

    <xsl:template match="html:samp">
        <samp>
            <xsl:call-template name="attlist.samp"/>
            <xsl:apply-templates select="node()"/>
        </samp>
    </xsl:template>

    <xsl:template name="attlist.samp">
        <xsl:call-template name="attrs"/>
        <xsl:call-template name="i18n"/>
    </xsl:template>

    <xsl:template match="html:span[f:types(.)='z3998:nonresolving-citation']">
        <cite>
            <xsl:call-template name="attlist.cite"/>
            <xsl:apply-templates select="node()"/>
        </cite>
    </xsl:template>

    <xsl:template name="attlist.cite">
        <xsl:call-template name="attrs"/>
    </xsl:template>

    <xsl:template match="html:abbr">
        <abbr>
            <xsl:call-template name="attlist.abbr"/>
            <xsl:apply-templates select="node()"/>
        </abbr>
    </xsl:template>

    <xsl:template name="attlist.abbr">
        <xsl:call-template name="attrs"/>
    </xsl:template>

    <xsl:template match="html:abbr[f:classes(.)='acronym']">
        <acronym>
            <xsl:call-template name="attlist.acronym"/>
            <xsl:apply-templates select="node()"/>
        </acronym>
    </xsl:template>

    <xsl:template name="attlist.acronym">
        <xsl:call-template name="attrs"/>
        <xsl:if test="f:classes(.)='spell-out' or matches(@style,'-epub-speak-as:\s*spell-out')">
            <xsl:attribute name="pronounce" select="'no'"/>
        </xsl:if>
    </xsl:template>

    <xsl:template match="html:sub">
        <sub>
            <xsl:call-template name="attlist.sub"/>
            <xsl:apply-templates select="node()"/>
        </sub>
    </xsl:template>

    <xsl:template name="attlist.sub">
        <xsl:call-template name="attrs"/>
    </xsl:template>

    <xsl:template match="html:sup">
        <sup>
            <xsl:call-template name="attlist.sup"/>
            <xsl:apply-templates select="node()"/>
        </sup>
    </xsl:template>

    <xsl:template name="attlist.sup">
        <xsl:call-template name="attrs"/>
    </xsl:template>

    <xsl:template match="html:span">
        <span>
            <xsl:call-template name="attlist.span"/>
            <xsl:apply-templates select="node()"/>
        </span>
    </xsl:template>

    <xsl:template name="attlist.span">
        <xsl:call-template name="attrs"/>
    </xsl:template>

    <xsl:template match="html:bdo">
        <bdo>
            <xsl:call-template name="attlist.bdo"/>
            <xsl:apply-templates select="node()"/>
        </bdo>
    </xsl:template>

    <xsl:template name="attlist.bdo">
        <xsl:call-template name="coreattrs"/>
        <xsl:call-template name="i18n"/>
    </xsl:template>

    <xsl:template match="html:span[f:types(.)='z3998:sentence']">
        <sent>
            <xsl:call-template name="attlist.sent"/>
            <xsl:apply-templates select="node()"/>
        </sent>
    </xsl:template>

    <xsl:template name="attlist.sent">
        <xsl:call-template name="attrs"/>
    </xsl:template>

    <xsl:template match="html:span[f:types(.)='z3998:word']">
        <w>
            <xsl:call-template name="attlist.w"/>
            <xsl:apply-templates select="node()"/>
        </w>
    </xsl:template>

    <xsl:template name="attlist.w">
        <xsl:call-template name="attrs"/>
    </xsl:template>

    <xsl:template match="html:span[f:types(.)='pagebreak']">
        <pagenum>
            <xsl:call-template name="attlist.pagenum"/>
            <xsl:value-of select="@title"/>
        </pagenum>
    </xsl:template>

    <xsl:template name="attlist.pagenum">
        <xsl:variable name="attributes-including-title">
            <xsl:call-template name="attrsrqd"/>
        </xsl:variable>
        <xsl:copy-of select="$attributes-including-title[not(name()='title')]"/>
    </xsl:template>

    <xsl:template match="html:a[f:types(.)='noteref']">
        <noteref>
            <xsl:call-template name="attlist.noteref"/>
            <xsl:apply-templates select="node()"/>
        </noteref>
    </xsl:template>

    <xsl:template name="attlist.noteref">
        <xsl:call-template name="attrs"/>
        <xsl:attribute name="idref" select="@href"/>
        <xsl:copy-of select="@type"/>
    </xsl:template>

    <xsl:template match="html:a[f:types(.)='annoref']">
        <annoref>
            <xsl:call-template name="attlist.annoref"/>
            <xsl:apply-templates select="node()"/>
        </annoref>
    </xsl:template>

    <xsl:template name="attlist.annoref">
        <xsl:call-template name="attrs"/>
        <xsl:attribute name="idref" select="@href"/>
        <xsl:copy-of select="@type"/>
    </xsl:template>

    <xsl:template match="html:q">
        <q>
            <xsl:call-template name="attlist.q"/>
            <xsl:apply-templates select="node()"/>
        </q>
    </xsl:template>

    <xsl:template name="attlist.q">
        <xsl:call-template name="attrs"/>
        <xsl:copy-of select="@cite"/>
    </xsl:template>

    <xsl:template match="html:img">
        <img>
            <xsl:call-template name="attlist.img"/>
            <xsl:apply-templates select="node()"/>
        </img>
    </xsl:template>

    <xsl:template name="attlist.img">
        <xsl:call-template name="attrs"/>
        <xsl:copy-of select="@src|@alt|@longdesc|@height|@width"/>
        <xsl:if test="not(@id)">
            <xsl:attribute name="id" select="generate-id(.)"/>
        </xsl:if>
    </xsl:template>

    <xsl:template name="imggroup">
        <imggroup>
            <xsl:call-template name="attlist.imggroup"/>
            <xsl:variable name="caption-first" select="*[1]=html:figcaption"/>
            <xsl:variable name="imggroup-captions" select="boolean(html:figcaption/html:div[f:classes(.)='imggroup-caption'])"/>
            <xsl:choose>
                <!-- multiple image captions - one for each image -->
                <xsl:when test="$imggroup-captions">
                    <xsl:variable name="images" select="count(html:img)"/>
                    <xsl:variable name="captions" select="count($imggroup-captions)"/>
                    <xsl:for-each select="node()">
                        <xsl:choose>
                            <xsl:when test="html:img">
                                <xsl:variable name="position" select="count(preceding-sibling::html:img)+1"/>
                                <xsl:if test="$caption-first">
                                    <xsl:if test="$position=1">
                                        <xsl:apply-templates select="$imggroup-captions[position()&lt;=($captions - $images)]"/>
                                    </xsl:if>
                                    <xsl:apply-templates select="$imggroup-captions[$position + max((0,$captions - $images))]"/>
                                </xsl:if>
                                
                                <xsl:apply-templates select="."/>
                                
                                <xsl:if test="not($caption-first)">
                                    <xsl:if test="$position=$images">
                                        <xsl:apply-templates select="$imggroup-captions[position()&gt;=$position]"/>
                                    </xsl:if>
                                    <xsl:apply-templates select="$imggroup-captions[$position]"/>
                                </xsl:if>
                            </xsl:when>
                            
                            <xsl:otherwise>
                                <xsl:apply-templates select="node()"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:for-each>
                </xsl:when>
                <!-- a single image caption for all images -->
                <xsl:otherwise>
                    <xsl:apply-templates select="node()"/>
                </xsl:otherwise>
            </xsl:choose>
        </imggroup>
    </xsl:template>

    <xsl:template name="attlist.imggroup">
        <xsl:call-template name="attrs"/>
    </xsl:template>

    <!--<xsl:template name="p">
        <p>
            <xsl:call-template name="attlist.p"/>
            <zeroOrMore>
                <choice>
                    <xsl:call-template name="inline"/>
                </choice>
            </zeroOrMore>
        </element>

        <zeroOrMore>
            <choice>
                <xsl:call-template name="list"/>
                <xsl:call-template name="dl"/>
            </choice>
        </zeroOrMore>
    </xsl:template>-->
    <!--<xsl:template name="attlist.p">
        <xsl:call-template name="attrs"/>
    </xsl:template>-->

    <xsl:template name="doctitle">
        <doctitle>
            <xsl:call-template name="attlist.doctitle"/>
            <xsl:apply-templates select="node()"/>
        </doctitle>
    </xsl:template>

    <xsl:template name="attlist.doctitle">
        <xsl:call-template name="attrs"/>
    </xsl:template>

    <xsl:template name="docauthor">
        <docauthor>
            <xsl:call-template name="attlist.docauthor"/>
            <xsl:apply-templates select="node()"/>
        </docauthor>
    </xsl:template>

    <xsl:template name="attlist.docauthor">
        <xsl:call-template name="attrs"/>
    </xsl:template>

    <xsl:template name="covertitle">
        <covertitle>
            <xsl:call-template name="attlist.covertitle"/>
            <xsl:apply-templates select="node()"/>
        </covertitle>
    </xsl:template>

    <xsl:template name="attlist.covertitle">
        <xsl:call-template name="attrs"/>
    </xsl:template>

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
        <p>
            <sch:rule context=".">
                <sch:assert test="tokenize(@epub:type,' ')='bridgehead'">The bridgehead must have an epub:type of 'bridgehead'</sch:assert>
            </sch:rule>
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
        <h1>
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

        <optional>
            <xsl:call-template name="pagenum"/>
        </xsl:if>
        <dl>
            <xsl:call-template name="attlist.dl"/>
            <zeroOrMore>
                <group>
                    <oneOrMore>
                        <xsl:call-template name="dt"/>
                    </oneOrMore>
                    <oneOrMore>
                        <xsl:call-template name="dd"/>
                    </oneOrMore>
                </group>
            </zeroOrMore>
        </element>
    </xsl:template>-->
    <!--<xsl:template name="attlist.dl">
        <xsl:call-template name="attrs"/>
    </xsl:template>-->

    <!--<xsl:template name="dt">
        <dt>
            <xsl:call-template name="attlist.dt"/>
            <zeroOrMore>
                <choice>
                    <xsl:call-template name="inline"/>
                </choice>
            </zeroOrMore>
            <optional>
                <xsl:call-template name="pagenum"/>
            </xsl:if>
        </element>
    </xsl:template>-->
    <!--<xsl:template name="attlist.dt">
        <xsl:call-template name="attrs"/>
    </xsl:template>-->

    <!--<xsl:template name="dd">
        <dd>
            <xsl:call-template name="attlist.dd"/>
            <zeroOrMore>
                <choice>
                    <xsl:call-template name="flow"/>
                </choice>
            </zeroOrMore>
            <optional>
                <xsl:call-template name="pagenum"/>
            </xsl:if>
        </element>
    </xsl:template>-->
    <!--<xsl:template name="attlist.dd">
        <xsl:call-template name="attrs"/>
    </xsl:template>-->

    <!--<xsl:template name="list">

        <choice>
            <ol>
                <choice>
                    <xsl:call-template name="attlist.list.ordered"/>
                    <xsl:call-template name="attlist.list.preformatted"/>
                </choice>
                <oneOrMore>

                    <xsl:call-template name="li"/>
                </oneOrMore>
            </element>
            <ul>
                <xsl:call-template name="attlist.list.unordered"/>
                <oneOrMore>

                    <xsl:call-template name="li"/>
                </oneOrMore>
            </element>
        </choice>
    </xsl:template>-->

    <!--<xsl:template name="attlist.list.ordered">
        <xsl:call-template name="attrs"/>

        <xsl:if test="@type">
            <attribute name="type">
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
            <attribute name="start"/>
        </xsl:if>

    </xsl:template>-->

    <!--<xsl:template name="attlist.list.preformatted">
        <xsl:call-template name="attrs"/>
        <attribute name="style">
            <value>list-style-type: none;</value>
        </attribute>

    </xsl:template>-->

    <!--<xsl:template name="attlist.list.unordered">
        <xsl:call-template name="attrs"/>

    </xsl:template>-->

    <!--<xsl:template name="li">
        <li>
            <choice>
                <group>
                    <xsl:call-template name="attlist.li"/>
                    <zeroOrMore>
                        <choice>
                            <xsl:call-template name="flow"/>
                            <xsl:call-template name="lic"/>
                        </choice>
                    </zeroOrMore>
                    <optional>
                        <xsl:call-template name="pagenum"/>
                    </xsl:if>
                </group>
                <xsl:call-template name="hd"/>
                <xsl:call-template name="prodnote"/>
            </choice>
        </element>
    </xsl:template>-->
    <!--<xsl:template name="attlist.li">
        <xsl:call-template name="attrs"/>
    </xsl:template>-->

    <!--<xsl:template name="lic">
        <span>
            <xsl:call-template name="attlist.lic"/>
            <sch:rule context=".">
                <sch:assert test="tokenize(@class,' ')='lic'">List item components must have a 'lic' class.</sch:assert>
            </sch:rule>
            <zeroOrMore>
                <xsl:call-template name="inline"/>
            </zeroOrMore>
        </element>
    </xsl:template>-->

    <!--<xsl:template name="attlist.lic">
        <xsl:call-template name="attrs"/>
    </xsl:template>-->

    <!--<xsl:template name="cellhvalign">

        <xsl:if test="@style">
            <attribute name="style">
                <data type="string">
                    <param name="pattern">^vertical-align: (top|middle|bottom|baseline); (text-align: (left|center|right|justify);|text-align: right; padding-right: \d+ch;)(| width: \w+;)$</param>

                </data>
            </attribute>
        </xsl:if>

    </xsl:template>-->

    <!--<xsl:template name="table">
        <optional>
            <xsl:call-template name="pagenum"/>
        </xsl:if>
        <table>
            <xsl:call-template name="attlist.table"/>
            <optional>
                <xsl:call-template name="caption.table"/>
            </xsl:if>

            <zeroOrMore>
                <xsl:call-template name="colgroup"/>
            </zeroOrMore>
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
                    <xsl:call-template name="tr"/>

                </oneOrMore>
            </choice>
        </element>
    </xsl:template>-->

    <!--<xsl:template name="attlist.table">
        <xsl:call-template name="attrs"/>

        <attribute name="style"/>
    </xsl:template>-->

    <!--<xsl:template name="caption.table">
        <caption>
            <xsl:call-template name="attlist.caption"/>
            <optional>
                <p>

                    <attribute name="class"/>
                    <sch:rule context=".">
                        <sch:assert test="matches(@class,'(^|.* )table-summary( .*|$)')">Table summaries must have a 'table-summary' class.</sch:assert>
                    </sch:rule>
                    <xsl:call-template name="Text"/>
                </element>
            </xsl:if>
            <zeroOrMore>
                <xsl:call-template name="flownotable"/>
            </zeroOrMore>
        </element>
    </xsl:template>-->
    
    <xsl:template match="html:figcaption">
        <xsl:variable name="content" select="node()[not(self::div[f:classes(.)='imggroup-caption'])]"/>
        <xsl:if test="$content">
            <caption>
                <xsl:call-template name="attlist.caption"/>
                <xsl:apply-templates select="$content"/>
            </caption>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="html:div[f:classes(.)='imggroup-caption']">
        <caption>
            <xsl:call-template name="attlist.caption"/>
            <xsl:apply-templates select="node()"/>
        </caption>
    </xsl:template>

    <xsl:template name="attlist.caption">
        <xsl:call-template name="attrs"/>
    </xsl:template>

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
        <xsl:call-template name="cellhvalign"/>
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
        <xsl:call-template name="cellhvalign"/>
    </xsl:template>-->

    <!--<xsl:template name="tbody">
        <tbody>
            <xsl:call-template name="attlist.tbody"/>
            <oneOrMore>
                <choice>
                    <xsl:call-template name="tr"/>

                </choice>
            </oneOrMore>
        </element>
    </xsl:template>-->
    <!--<xsl:template name="attlist.tbody">
        <xsl:call-template name="attrs"/>
        <xsl:call-template name="cellhvalign"/>
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
            <xsl:attribute name="span" select="@span"/> <!-\- NMTOKEN, a:defaultValue="1" -\->
        </xsl:if>
        <xsl:call-template name="cellhvalign"/>
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
            <xsl:attribute name="span" select="@span"/> <!-\- NMTOKEN, a:defaultValue="1" -\->
        </xsl:if>
        <xsl:call-template name="cellhvalign"/>
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
        <xsl:call-template name="cellhvalign"/>
    </xsl:template>-->

    <!--<xsl:template name="th">
        <th>
            <xsl:call-template name="attlist.th"/>
            <zeroOrMore>
                <xsl:call-template name="flownopagenum"/>
            </zeroOrMore>
            <optional>
                <xsl:call-template name="pagenum"/>
            </xsl:if>
        </element>
    </xsl:template>-->

    <!--<xsl:template name="attlist.th">
        <xsl:call-template name="attrs"/>

        <xsl:if test="@headers">
            <xsl:attribute name="headers" select="@headers"/> <!-\- IDREFS -\->
        </xsl:if>
        <xsl:if test="@scope">
            <xsl:attribute name="scope" select="@scope"/> <!-\- Scope -\->
        </xsl:if>
        <xsl:if test="@rowspan">
            <xsl:attribute name="rowspan" select="@rowspan"/> <!-\- NMTOKEN, a:defaultValue="1" -\->
        </xsl:if>
        <xsl:if test="@colspan">
            <xsl:attribute name="colspan" select="@colspan"/> <!-\- NMTOKEN, a:defaultValue="1" -\->
        </xsl:if>
        <xsl:call-template name="cellhvalign"/>
    </xsl:template>-->

    <!--<xsl:template name="td">
        <td>
            <xsl:call-template name="attlist.td"/>
            <zeroOrMore>
                <xsl:call-template name="flownopagenum"/>
            </zeroOrMore>
            <optional>
                <xsl:call-template name="pagenum"/>
            </xsl:if>
        </element>
    </xsl:template>-->

    <!--<xsl:template name="attlist.td">
        <xsl:call-template name="attrs"/>

        <xsl:if test="@headers">
            <xsl:attribute name="headers" select="@headers"/> <!-\- IDREFS -\->
        </xsl:if>
        <xsl:if test="@scope">
            <xsl:attribute name="scope" select="@scope"/> <!-\- Scope -\->
        </xsl:if>
        <xsl:if test="@rowspan">
            <xsl:attribute name="rowspan" select="@rowspan"/> <!-\- NMTOKEN, a:defaultValue="1" -\->
        </xsl:if>
        <xsl:if test="@colspan">
            <xsl:attribute name="colspan" select="@colspan"/> <!-\- NMTOKEN, a:defaultValue="1" -\->
        </xsl:if>
        <xsl:call-template name="cellhvalign"/>
    </xsl:template>-->

    <xsl:template name="copy-preceding-comments">
        <xsl:variable name="this" select="."/>
        <xsl:apply-templates select="preceding-sibling::comment()[not(preceding-sibling::*) or preceding-sibling::*[1] = $this/preceding-sibling::*[1]]"/>
    </xsl:template>

    <xsl:function name="f:types" as="xs:string*">
        <xsl:param name="element" as="element()"/>
        <xsl:sequence select="tokenize($element/@epub:type,'\s+')"/>
    </xsl:function>

    <xsl:function name="f:classes" as="xs:string*">
        <xsl:param name="element" as="element()"/>
        <xsl:sequence select="tokenize($element/@class,'\s+')"/>
    </xsl:function>

    <xsl:function name="f:level" as="xs:integer">
        <xsl:param name="element" as="element()"/>
        <xsl:variable name="h" select="($element/descendant-or-self::*[self::html:h1 or self::html:h2 or self::html:h3 or self::html:h4 or self::html:h5 or self::html:h6])[1]"/>
        <xsl:variable name="sections" select="$h/ancestor::*[self::html:section or self::html:article or self::html:aside or self::html:nav or self::html:body]"/>
        <xsl:variable name="explicit-level" select="count($sections)-1"/>
        <xsl:variable name="h-in-section" select="($h, $h/preceding::*[./preceding::*=$sections[1]])"/>
        <xsl:variable name="h-in-section-levels" select="$h-in-section/number(replace(local-name(),'^h',''))"/>
        <xsl:variable name="implicit-level"
            select="count(distinct-values((for $i in (1 to count($h-in-section-levels)-1) return (if (not($h-in-section-levels[$i] > $h-in-section-levels[position()>$i])) then $h-in-section-levels[$i] else ()), $h-in-section-levels[last()])))"/>
        <xsl:variable name="level" select="$explicit-level + $implicit-level"/>
        <xsl:sequence select="min(($level, 6))"/>
        <!--
            NOTE: DTBook only supports 6 levels when using the explicit level1-level6 / h1-h6 elements,
            so min(($level, 6)) is used to flatten deeper structures.
            The implicit level / hd elements could be used in cases where the structures are deeper.
            However, our tools would have to support those elements.
        -->
    </xsl:function>

</xsl:stylesheet>
