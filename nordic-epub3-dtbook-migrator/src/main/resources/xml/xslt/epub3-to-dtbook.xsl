<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:f="http://www.daisy.org/ns/pipeline/internal-functions" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0" xmlns="http://www.daisy.org/z3986/2005/dtbook/"
    xpath-default-namespace="http://www.daisy.org/z3986/2005/dtbook/" exclude-result-prefixes="#all" xmlns:epub="http://www.idpf.org/2007/ops" xmlns:html="http://www.w3.org/1999/xhtml"
    xmlns:xs="http://www.w3.org/2001/XMLSchema">

    <xsl:output indent="yes" exclude-result-prefixes="#all"/>

    <xsl:variable name="all-ids" select="//@id"/>

    <xsl:template match="text()|comment()">
        <xsl:copy-of select="."/>
    </xsl:template>

    <xsl:template match="*">
        <xsl:comment select="concat('No template for element: ',name())"/>
    </xsl:template>

    <xsl:template match="html:style"/>
    <xsl:template name="coreattrs">
        <xsl:param name="except" tunnel="yes"/>

        <xsl:copy-of select="(@id|@title|@xml:space)[not(name()=$except)]"/>
        <xsl:call-template name="classes-and-types"/>
    </xsl:template>

    <xsl:template name="i18n">
        <xsl:param name="except" tunnel="yes"/>

        <xsl:copy-of select="(@dir)[not(name()=$except)]"/>
        <xsl:if test="(@xml:lang|@lang) and not(('xml:lang','lang')=$except)">
            <xsl:attribute name="xml:lang" select="(@xml:lang|@lang)[1]"/>
        </xsl:if>
    </xsl:template>

    <xsl:template name="classes-and-types">
        <xsl:param name="classes" select="()" tunnel="yes"/>
        <xsl:param name="except" tunnel="yes" select="()"/>
        <xsl:param name="except-classes" tunnel="yes" select="()"/>

        <xsl:variable name="old-classes" select="f:classes(.)"/>

        <xsl:variable name="showin" select="replace($old-classes[matches(.,'^showin-...$')][1],'showin-','')"/>
        <xsl:if test="$showin and not('_showin'=$except)">
            <xsl:attribute name="showin" select="$showin"/>
        </xsl:if>

        <xsl:if test="not('_class'=$except)">
            <xsl:variable name="epub-type-classes">
                <xsl:for-each select="f:types(.)[not(matches(.,'(^|:)(front|body|back)matter'))]">
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

            <xsl:variable name="class-string"
                select="string-join(distinct-values(($classes, $old-classes[not(matches(.,concat('showin-',$showin)))], $epub-type-classes)[not(.='') and not(.=$except-classes)]),' ')"/>
            <xsl:if test="not($class-string='')">
                <xsl:attribute name="class" select="$class-string"/>
            </xsl:if>
        </xsl:if>
    </xsl:template>

    <xsl:template name="attrs">
        <xsl:call-template name="coreattrs"/>
        <xsl:call-template name="i18n"/>
    </xsl:template>

    <xsl:template name="attrsrqd">
        <xsl:param name="except" tunnel="yes"/>

        <xsl:copy-of select="(@id|@title|@xml:space)[not(name()=$except)]"/>
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
            <!-- TODO: maybe add some default CSS styles here? -->
        </head>
    </xsl:template>

    <xsl:template match="html:title">
        <xsl:if test="not(parent::*/html:meta[lower-case(@name)='dc:title'])">
            <meta name="dc:title" content="{normalize-space(.)}">
                <xsl:call-template name="i18n"/>
            </meta>
        </xsl:if>
    </xsl:template>

    <xsl:template name="attlist.head">
        <xsl:call-template name="i18n"/>
        <xsl:if test="html:link[@rel='profile' and @href]">
            <xsl:attribute name="profile" select="(html:link[@rel='profile'][1])/@href"/>
        </xsl:if>
    </xsl:template>

    <xsl:template match="html:link">
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
            <xsl:if test="(html:section | html:article)[f:types(.)=('cover','frontmatter')] or *[not(self::html:section)]">
                <xsl:call-template name="frontmatter"/>
            </xsl:if>
            <xsl:if test="(html:section | html:article)[f:types(.)=('bodymatter') or not(f:types(.)=('cover','frontmatter','bodymatter','backmatter'))]">
                <xsl:call-template name="bodymatter"/>
            </xsl:if>
            <xsl:if test="(html:section | html:article)[f:types(.)=('backmatter')]">
                <xsl:call-template name="rearmatter"/>
            </xsl:if>
            <xsl:apply-templates select="*[last()]/following-sibling::node()"/>
        </book>
    </xsl:template>

    <xsl:template name="frontmatter">
        <xsl:call-template name="copy-preceding-comments"/>
        <frontmatter>
            <xsl:for-each select="html:header">
                <xsl:call-template name="copy-preceding-comments"/>
                <xsl:apply-templates select="node()"/>
            </xsl:for-each>
            <xsl:apply-templates select="(html:section | html:article)[f:types(.)=('cover','frontmatter')]"/>
        </frontmatter>
    </xsl:template>

    <xsl:template name="bodymatter">
        <bodymatter>
            <xsl:apply-templates select="(html:section | html:article)[not(f:types(.)=('cover','frontmatter','backmatter'))]"/>
        </bodymatter>
    </xsl:template>

    <xsl:template name="rearmatter">
        <rearmatter>
            <xsl:apply-templates select="(html:section | html:article)[f:types(.)=('backmatter')]"/>
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
        <xsl:call-template name="attrs">
            <xsl:with-param name="except-classes" select="'line'" tunnel="yes"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="html:span[f:classes(.)='linenum']">
        <linenum>
            <xsl:call-template name="attlist.linenum"/>
            <xsl:apply-templates select="node()"/>
        </linenum>
    </xsl:template>

    <xsl:template name="attlist.linenum">
        <xsl:call-template name="attrs">
            <xsl:with-param name="except-classes" select="'linenum'" tunnel="yes"/>
        </xsl:call-template>
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
        <xsl:call-template name="attrs">
            <xsl:with-param name="except-classes" select="'title'" tunnel="yes"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="html:*[f:types(.)='z3998:author' and not(f:classes(.)='docauthor')]">
        <author>
            <xsl:call-template name="attlist.author"/>
            <xsl:apply-templates select="node()"/>
        </author>
    </xsl:template>

    <xsl:template name="attlist.author">
        <xsl:call-template name="attrs">
            <xsl:with-param name="except-classes" select="'author'" tunnel="yes"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="html:aside[f:types(.)='z3998:production']">
        <prodnote>
            <xsl:call-template name="attlist.prodnote"/>
            <xsl:apply-templates select="node()"/>
        </prodnote>
    </xsl:template>

    <xsl:template name="attlist.prodnote">
        <xsl:call-template name="attrs">
            <xsl:with-param name="except-classes" select="('production','render-required','render-optional')" tunnel="yes"/>
        </xsl:call-template>
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
                <xsl:attribute name="imgref" select="string-join($img/((@id,f:generate-pretty-id(.))[1]),' ')"/>
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
        <xsl:call-template name="attrs">
            <xsl:with-param name="except-classes" select="('sidebar','render-required','render-optional')" tunnel="yes"/>
        </xsl:call-template>
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
        <xsl:call-template name="attrsrqd">
            <xsl:with-param name="except-classes" select="'note'" tunnel="yes"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="html:aside[f:types(.)='annotation']">
        <annotation>
            <xsl:call-template name="attlist.annotation"/>
            <xsl:apply-templates select="node()"/>
        </annotation>
    </xsl:template>

    <xsl:template name="attlist.annotation">
        <xsl:call-template name="attrsrqd">
            <xsl:with-param name="except-classes" select="'annotation'" tunnel="yes"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="html:aside[f:types(.)='epigraph']">
        <epigraph>
            <xsl:call-template name="attlist.epigraph"/>
            <xsl:apply-templates select="node()"/>
        </epigraph>
    </xsl:template>

    <xsl:template name="attlist.epigraph">
        <xsl:call-template name="attrs">
            <xsl:with-param name="except-classes" select="'epigraph'" tunnel="yes"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="html:span[f:classes(.)='byline']">
        <byline>
            <xsl:call-template name="attlist.byline"/>
            <xsl:apply-templates select="node()"/>
        </byline>
    </xsl:template>

    <xsl:template name="attlist.byline">
        <xsl:call-template name="attrs">
            <xsl:with-param name="except-classes" select="'byline'" tunnel="yes"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="html:span[f:classes(.)='dateline']">
        <dateline>
            <xsl:call-template name="attlist.dateline"/>
            <xsl:apply-templates select="node()"/>
        </dateline>
    </xsl:template>

    <xsl:template name="attlist.dateline">
        <xsl:call-template name="attrs">
            <xsl:with-param name="except-classes" select="'dateline'" tunnel="yes"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="html:*[f:classes(.)='linegroup']">
        <linegroup>
            <xsl:call-template name="attlist.linegroup"/>
            <xsl:apply-templates select="node()"/>
        </linegroup>
    </xsl:template>

    <xsl:template name="attlist.linegroup">
        <xsl:call-template name="attrs">
            <xsl:with-param name="except-classes" select="'linegroup'" tunnel="yes"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="html:*[f:types(.)='z3998:poem']">
        <poem>
            <xsl:call-template name="attlist.poem"/>
            <xsl:apply-templates select="node()"/>
        </poem>
    </xsl:template>

    <xsl:template name="attlist.poem">
        <xsl:call-template name="attrs">
            <xsl:with-param name="except-classes" select="'poem'" tunnel="yes"/>
        </xsl:call-template>
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
            <xsl:with-param name="except-classes" select="('external-true','external-false',for $rev in (f:classes(.)[matches(.,'^rev-')]) return $rev )" tunnel="yes"/>
        </xsl:call-template>
        <xsl:copy-of select="@type|@href|@hreflang|@rel|@accesskey|@tabindex"/>
        <!-- @download and @media is dropped - they don't have a good equivalent in DTBook -->

        <xsl:choose>
            <xsl:when test="f:classes(.)[matches(.,'^external-(true|false)')]">
                <xsl:attribute name="external" select="replace((f:classes(.)[matches(.,'^external-(true|false)')])[1],'^external-','')"/>
            </xsl:when>
            <xsl:when test="@target='_blank' or matches(@href,'^(\w+:|/)')">
                <xsl:attribute name="external" select="'true'"/>
            </xsl:when>
        </xsl:choose>

        <xsl:if test="f:classes(.)[matches(.,'^rev-')]">
            <xsl:attribute name="rev" select="replace((f:classes(.)[matches(.,'^rev-')])[1],'^rev-','')"/>
        </xsl:if>
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

    <xsl:template match="html:cite">
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

    <xsl:template match="html:abbr[f:types(.)='acronym']">
        <acronym>
            <xsl:call-template name="attlist.acronym"/>
            <xsl:apply-templates select="node()"/>
        </acronym>
    </xsl:template>

    <xsl:template name="attlist.acronym">
        <xsl:call-template name="attrs">
            <xsl:with-param name="except-classes" select="'acronym'" tunnel="yes"/>
        </xsl:call-template>
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
        <xsl:call-template name="attrs">
            <xsl:with-param name="except-classes" select="'sentence'" tunnel="yes"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="html:span[f:types(.)='z3998:word']">
        <w>
            <xsl:call-template name="attlist.w"/>
            <xsl:apply-templates select="node()"/>
        </w>
    </xsl:template>

    <xsl:template name="attlist.w">
        <xsl:call-template name="attrs">
            <xsl:with-param name="except-classes" select="'word'" tunnel="yes"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="html:*[self::html:span or self::html:div][f:types(.)='pagebreak']">
        <pagenum>
            <xsl:call-template name="attlist.pagenum"/>
            <xsl:value-of select="@title"/>
        </pagenum>
    </xsl:template>

    <xsl:template name="attlist.pagenum">
        <xsl:call-template name="attrsrqd">
            <xsl:with-param name="except" select="'title'" tunnel="yes"/>
            <xsl:with-param name="except-classes" select="('page-front','page-normal','page-special','pagebreak')" tunnel="yes"/>
        </xsl:call-template>
        <xsl:attribute name="page" select="replace((f:classes(.)[starts-with(.,'page-')],'page-normal')[1], '^page-', '')"/>
    </xsl:template>

    <xsl:template match="html:a[f:types(.)='noteref']">
        <noteref>
            <xsl:call-template name="attlist.noteref"/>
            <xsl:apply-templates select="node()"/>
        </noteref>
    </xsl:template>

    <xsl:template name="attlist.noteref">
        <xsl:call-template name="attrs">
            <xsl:with-param name="except-classes" select="'noteref'" tunnel="yes"/>
        </xsl:call-template>
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
        <xsl:call-template name="attrs">
            <xsl:with-param name="except-classes" select="'annoref'" tunnel="yes"/>
        </xsl:call-template>
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
            <xsl:attribute name="id" select="f:generate-pretty-id(.)"/>
        </xsl:if>
    </xsl:template>

    <xsl:template match="html:figure">
        <imggroup>
            <xsl:call-template name="attlist.imggroup"/>
            <xsl:choose>
                <xsl:when test="not(html:figcaption) or html:figcaption/*[not(self::html:div[f:classes(.)='img-caption'])]">
                    <!-- no figcaption present or figcaption does not follow the convention that lets it be matched against individual images -->
                    <xsl:apply-templates select="node()"/>
                </xsl:when>

                <xsl:otherwise>
                    <xsl:variable name="precede" select="if (html:img[1]/preceding-sibling::html:figcaption) then true() else false()"/>
                    <xsl:for-each select="node()[not(self::html:figcaption)]">
                        <xsl:choose>
                            <xsl:when test="self::html:img">
                                <xsl:variable name="position" select="count(preceding-sibling::html:img)+1"/>
                                <xsl:choose>
                                    <xsl:when test="$precede">
                                        <xsl:for-each select="parent::html:figure/html:figcaption/html:div[$position]/*">
                                            <caption>
                                                <xsl:call-template name="attlist.caption"/>
                                                <xsl:apply-templates select="node()"/>
                                            </caption>
                                        </xsl:for-each>
                                        <xsl:apply-templates select="."/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:apply-templates select="."/>
                                        <xsl:for-each select="parent::html:figure/html:figcaption/html:div[$position]/*">
                                            <caption>
                                                <xsl:call-template name="attlist.caption"/>
                                                <xsl:apply-templates select="node()"/>
                                            </caption>
                                        </xsl:for-each>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:apply-templates select="."/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:for-each>
                </xsl:otherwise>
            </xsl:choose>
        </imggroup>
    </xsl:template>

    <xsl:template name="attlist.imggroup">
        <xsl:call-template name="attrs"/>
    </xsl:template>

    <xsl:template match="html:p">
        <xsl:variable name="precedingemptyline" select="preceding-sibling::*[1] intersect preceding-sibling::html:hr[1]"/>
        <p>
            <xsl:call-template name="attlist.p">
                <xsl:with-param name="classes" select="if ($precedingemptyline) then 'precedingemptyline' else ()" tunnel="yes"/>
            </xsl:call-template>
            <xsl:apply-templates select="node()"/>
        </p>
    </xsl:template>

    <xsl:template name="attlist.p">
        <xsl:call-template name="attrs"/>
    </xsl:template>

    <xsl:template match="html:hr"/>

    <xsl:template match="html:*[f:types(.)='fulltitle']">
        <doctitle>
            <xsl:call-template name="attlist.doctitle"/>
            <xsl:apply-templates select="node()"/>
        </doctitle>
    </xsl:template>

    <xsl:template name="attlist.doctitle">
        <xsl:call-template name="attrs">
            <xsl:with-param name="except-classes" select="'fulltitle'" tunnel="yes"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="html:*[f:types(.)='z3998:author' and f:classes(.)='docauthor']">
        <docauthor>
            <xsl:call-template name="attlist.docauthor"/>
            <xsl:apply-templates select="node()"/>
        </docauthor>
    </xsl:template>

    <xsl:template name="attlist.docauthor">
        <xsl:call-template name="attrs">
            <xsl:with-param name="except-classes" select="('author','docauthor')" tunnel="yes"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="html:*[f:types(.)='z3998:covertitle']">
        <covertitle>
            <xsl:call-template name="attlist.covertitle"/>
            <xsl:apply-templates select="node()"/>
        </covertitle>
    </xsl:template>

    <xsl:template name="attlist.covertitle">
        <xsl:call-template name="attrs">
            <xsl:with-param name="except-classes" select="'covertitle'" tunnel="yes"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6">
        <xsl:element name="h{f:level(.)}">
            <xsl:call-template name="attlist.h"/>
            <xsl:apply-templates select="node()"/>
        </xsl:element>
    </xsl:template>

    <xsl:template name="attlist.h">
        <xsl:call-template name="attrs"/>
    </xsl:template>

    <xsl:template match="html:p[f:types(.)='bridgehead']">
        <bridgehead>
            <xsl:call-template name="attlist.bridgehead"/>
            <xsl:apply-templates select="node()"/>
        </bridgehead>
    </xsl:template>

    <xsl:template name="attlist.bridgehead">
        <xsl:call-template name="attrs"/>
    </xsl:template>

    <xsl:template match="html:blockquote">
        <blockquote>
            <xsl:call-template name="attlist.blockquote"/>
            <xsl:apply-templates select="node()"/>
        </blockquote>
    </xsl:template>

    <xsl:template name="attlist.blockquote">
        <xsl:call-template name="attrs"/>
        <xsl:copy-of select="@cite"/>
    </xsl:template>

    <xsl:template match="html:dl">
        <dl>
            <xsl:call-template name="attlist.dl"/>
            <xsl:apply-templates select="node()"/>
        </dl>
    </xsl:template>

    <xsl:template name="attlist.dl">
        <xsl:call-template name="attrs"/>
    </xsl:template>

    <xsl:template match="html:dt">
        <dt>
            <xsl:call-template name="attlist.dt"/>
            <xsl:apply-templates select="node()"/>
        </dt>
    </xsl:template>

    <xsl:template name="attlist.dt">
        <xsl:call-template name="attrs"/>
    </xsl:template>

    <xsl:template match="html:dd">
        <dd>
            <xsl:call-template name="attlist.dd"/>
            <xsl:apply-templates select="node()"/>
        </dd>
    </xsl:template>

    <xsl:template name="attlist.dd">
        <xsl:call-template name="attrs"/>
    </xsl:template>

    <xsl:template match="html:ol | html:ul">
        <list>
            <xsl:call-template name="attlist.list"/>
            <xsl:apply-templates select="node()"/>
        </list>
    </xsl:template>

    <xsl:template name="attlist.list">
        <xsl:attribute name="type" select="if (self::html:ul) then 'ul' else if (f:classes(.)='list-preformatted') then 'pl' else 'ol'"/>
        <xsl:call-template name="attrs"/>
        <xsl:copy-of select="@start"/>
        <xsl:if test="@type">
            <xsl:attribute name="enum" select="@type"/>
        </xsl:if>
        <xsl:attribute name="depth" select="count(ancestor::html:li)+1"/>
    </xsl:template>

    <xsl:template match="html:li">
        <li>
            <xsl:call-template name="attlist.li"/>
            <xsl:apply-templates select="node()"/>
        </li>
    </xsl:template>

    <xsl:template name="attlist.li">
        <xsl:call-template name="attrs"/>
    </xsl:template>

    <xsl:template match="html:span[f:classes(.)='lic']">
        <lic>
            <xsl:call-template name="attlist.lic"/>
            <xsl:apply-templates select="node()"/>
        </lic>
    </xsl:template>

    <xsl:template name="attlist.lic">
        <xsl:call-template name="attrs"/>
    </xsl:template>

    <xsl:template name="cellhvalign">
        <!--
            the @cellhalign and @cellvalign attributes could potentially be inferred from the CSS here,
            but it's probably not worth it so they are ignored for now.
        -->
    </xsl:template>

    <xsl:template match="html:table">
        <table>
            <xsl:call-template name="attlist.table"/>
            <xsl:for-each select="html:caption">
                <xsl:call-template name="caption.table"/>
            </xsl:for-each>
            <xsl:apply-templates select="html:colgroup"/>
            <xsl:apply-templates select="html:thead"/>
            <xsl:apply-templates select="html:tfoot"/>
            <xsl:apply-templates select="html:tbody | html:tr"/>
        </table>
    </xsl:template>

    <xsl:template name="attlist.table">
        <xsl:call-template name="attrs"/>
        <xsl:if test="html:caption/html:p[f:classes(.)='table-summary']">
            <xsl:attribute name="summary" select="normalize-space(string-join(html:caption/html:p[f:classes(.)='table-summary']//text(),' '))"/>
        </xsl:if>
        <xsl:if test="f:classes(.)[matches(.,'^table-rules-')]">
            <xsl:attribute name="rules" select="replace(f:classes(.)[matches(.,'^table-rules-')][1],'^table-rules-','')"/>
        </xsl:if>
        <xsl:if test="f:classes(.)[matches(.,'^table-frame-')]">
            <xsl:attribute name="frame" select="replace(f:classes(.)[matches(.,'^table-frame-')][1],'^table-frame-','')"/>
        </xsl:if>
        <!--
            @cellspacing, @cellpadding and @width could potentially be inferred from the CSS,
            but it's probably not worth it so they are ignored for now
        -->
    </xsl:template>

    <xsl:template name="caption.table">
        <xsl:variable name="content" select="node()[not(self::html:p[f:classes(.)='table-summary'])]"/>
        <xsl:if test="$content">
            <caption>
                <xsl:call-template name="attlist.caption"/>
                <xsl:apply-templates select="$content"/>
            </caption>
        </xsl:if>
    </xsl:template>

    <xsl:template match="html:figcaption">
        <xsl:variable name="content" select="node()[not(self::div[f:classes(.)='img-caption'])]"/>
        <xsl:if test="$content">
            <caption>
                <xsl:call-template name="attlist.caption"/>
                <xsl:apply-templates select="$content"/>
            </caption>
        </xsl:if>
    </xsl:template>

    <!--<xsl:template match="html:div[f:classes(.)='img-caption']">
        <caption>
            <xsl:call-template name="attlist.caption"/>
            <xsl:apply-templates select="node()"/>
        </caption>
    </xsl:template>-->

    <xsl:template name="attlist.caption">
        <xsl:call-template name="attrs"/>
    </xsl:template>

    <xsl:template match="html:thead">
        <thead>
            <xsl:call-template name="attlist.thead"/>
            <xsl:apply-templates select="node()"/>
        </thead>
    </xsl:template>

    <xsl:template name="attlist.thead">
        <xsl:call-template name="attrs"/>
        <xsl:call-template name="cellhvalign"/>
    </xsl:template>

    <xsl:template match="html:tfoot">
        <tfoot>
            <xsl:call-template name="attlist.tfoot"/>
            <xsl:apply-templates select="node()"/>
        </tfoot>
    </xsl:template>

    <xsl:template name="attlist.tfoot">
        <xsl:call-template name="attrs"/>
        <xsl:call-template name="cellhvalign"/>
    </xsl:template>

    <xsl:template match="html:tbody">
        <tbody>
            <xsl:call-template name="attlist.tbody"/>
            <xsl:apply-templates select="node()"/>
        </tbody>
    </xsl:template>

    <xsl:template name="attlist.tbody">
        <xsl:call-template name="attrs"/>
        <xsl:call-template name="cellhvalign"/>
    </xsl:template>

    <xsl:template match="html:colgroup">
        <colgroup>
            <xsl:call-template name="attlist.colgroup"/>
            <xsl:apply-templates select="node()"/>
        </colgroup>
    </xsl:template>

    <xsl:template name="attlist.colgroup">
        <xsl:call-template name="attrs"/>
        <xsl:copy-of select="@span"/>
        <xsl:call-template name="cellhvalign"/>
        <!--
            @width could potentially be inferred from the CSS,
            but it's probably not worth it so they are ignored for now
        -->
    </xsl:template>

    <xsl:template match="html:col">
        <col>
            <xsl:call-template name="attlist.col"/>
            <xsl:apply-templates select="node()"/>
        </col>
    </xsl:template>

    <xsl:template name="attlist.col">
        <xsl:call-template name="attrs"/>
        <xsl:copy-of select="@span"/>
        <xsl:call-template name="cellhvalign"/>
        <!--
            @width could potentially be inferred from the CSS,
            but it's probably not worth it so they are ignored for now
        -->
    </xsl:template>

    <xsl:template match="html:tr">
        <tr>
            <xsl:call-template name="attlist.tr"/>
            <xsl:apply-templates select="node()"/>
        </tr>
    </xsl:template>

    <xsl:template name="attlist.tr">
        <xsl:call-template name="attrs"/>
        <xsl:call-template name="cellhvalign"/>
        <!--
            @width could potentially be inferred from the CSS,
            but it's probably not worth it so they are ignored for now
        -->
    </xsl:template>

    <xsl:template match="html:th">
        <th>
            <xsl:call-template name="attlist.th"/>
            <xsl:apply-templates select="node()"/>
        </th>
    </xsl:template>

    <xsl:template name="attlist.th">
        <xsl:call-template name="attrs"/>
        <xsl:copy-of select="@headers|@scope|@rowspan|@colspan"/>
        <xsl:call-template name="cellhvalign"/>
    </xsl:template>

    <xsl:template match="html:td">
        <td>
            <xsl:call-template name="attlist.td"/>
            <xsl:apply-templates select="node()"/>
        </td>
    </xsl:template>

    <xsl:template name="attlist.td">
        <xsl:call-template name="attrs"/>
        <xsl:copy-of select="@headers|@scope|@rowspan|@colspan"/>
        <xsl:call-template name="cellhvalign"/>
    </xsl:template>

    <xsl:template name="copy-preceding-comments">
        <xsl:variable name="this" select="."/>
        <xsl:apply-templates select="preceding-sibling::comment()[not($this/preceding-sibling::*) or preceding-sibling::*[1] is $this/preceding-sibling::*[1]]"/>
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
        <xsl:variable name="h" select="$element/descendant-or-self::*[self::html:h1 or self::html:h2 or self::html:h3 or self::html:h4 or self::html:h5 or self::html:h6][1]"/>
        <xsl:variable name="sections" select="$h/ancestor::*[self::html:section or self::html:article or self::html:aside or self::html:nav]"/>
        <xsl:variable name="explicit-level" select="count($sections)-1"/>
        <xsl:variable name="h-in-section"
            select="($h, ($h/preceding::* intersect $sections[last()]//*)[self::html:h1 or self::html:h2 or self::html:h3 or self::html:h4 or self::html:h5 or self::html:h6])"/>
        <xsl:variable name="h-in-section-levels" select="reverse($h-in-section/xs:integer(number(replace(local-name(),'^h',''))))"/>
        <xsl:variable name="implicit-level" select="if ($h-in-section-levels[1] = 6) then 6 else ()"/>
        <xsl:variable name="h-in-section-levels" select="$h-in-section-levels[not(.=6)]"/>
        <xsl:variable name="implicit-level" select="($implicit-level, if ($h-in-section-levels[1] = 5) then 5 else ())"/>
        <xsl:variable name="h-in-section-levels" select="$h-in-section-levels[not(.=5)]"/>
        <xsl:variable name="implicit-level" select="($implicit-level, if ($h-in-section-levels[1] = 4) then 4 else ())"/>
        <xsl:variable name="h-in-section-levels" select="$h-in-section-levels[not(.=4)]"/>
        <xsl:variable name="implicit-level" select="($implicit-level, if ($h-in-section-levels[1] = 3) then 3 else ())"/>
        <xsl:variable name="h-in-section-levels" select="$h-in-section-levels[not(.=3)]"/>
        <xsl:variable name="implicit-level" select="($implicit-level, if ($h-in-section-levels[1] = 2) then 2 else ())"/>
        <xsl:variable name="implicit-level" select="($implicit-level, if ($h-in-section-levels = 1) then 1 else ())"/>
        <xsl:variable name="implicit-level" select="count($implicit-level)"/>

        <xsl:variable name="level" select="$explicit-level + $implicit-level"/>
        <xsl:sequence select="max((1,min(($level, 6))))"/>
        <!--
            NOTE: DTBook only supports 6 levels when using the explicit level1-level6 / h1-h6 elements,
            so min(($level, 6)) is used to flatten deeper structures.
            The implicit level / hd elements could be used in cases where the structures are deeper.
            However, our tools would have to support those elements.
        -->
    </xsl:function>

    <xsl:function name="f:generate-pretty-id" as="xs:string">
        <xsl:param name="element" as="element()"/>
        <xsl:variable name="id">
            <xsl:choose>
                <xsl:when test="$element[self::html:blockquote or self::html:q]">
                    <xsl:sequence select="concat('quote_',count($element/preceding::*[self::html:blockquote or self::html:q])+1)"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:variable name="element-name" select="local-name($element)"/>
                    <xsl:sequence select="concat($element-name,'_',count($element/preceding::*[local-name()=$element-name])+1)"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:sequence select="if ($all-ids=$id) then generate-id($element) else $id"/>
    </xsl:function>

</xsl:stylesheet>
