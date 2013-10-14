<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0" xmlns="http://www.daisy.org/z3986/2005/dtbook/" xpath-default-namespace="http://www.daisy.org/z3986/2005/dtbook/"
    exclude-result-prefixes="#all" xmlns:epub="http://www.idpf.org/2007/ops" xmlns:html="http://www.w3.org/1999/xhtml">

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

    <xsl:template name="blocknoimggroupnotable">
        <xsl:apply-templates select="*"/>
        <!-- p, list, dl, div, blockquote, poem, linegroup, byline, dateline, epigraph, address, line, "dtbookblocknoimggroup" -->
    </xsl:template>

    <xsl:template name="docblockorinline">
        <xsl:apply-templates select="*"/>
        <!-- doctitle, docauthor, bridgehead, "block", "inlineblock" -->
    </xsl:template>

    <xsl:template name="coreattrs">
        <xsl:if test="@id">
            <xsl:attribute name="id" select="@id"/>
            <!-- ID -->
        </xsl:if>
        <xsl:if test="@class">
            <xsl:variable name="classes" select="tokenize(@class,'\s+')"/>
            <xsl:variable name="epub-type-classes">
                <xsl:for-each select="tokenize(@epub:type,'\s+')">
                    <xsl:choose>
                        <xsl:when test=".='toc'">
                            <xsl:sequence select="'toc'"/>
                        </xsl:when>
                        <!-- TODO: other epub:type mappings to classes -->
                    </xsl:choose>
                </xsl:for-each>> </xsl:variable>
            <xsl:value-of select="string-join(distinct-values(($classes,$epub-type-classes)),' ')"/>
        </xsl:if>
        <xsl:if test="@title">
            <xsl:attribute name="title" select="@title"/>
            <!-- Text -->
        </xsl:if>
        <xsl:if test="@xml:space">
            <xsl:attribute name="xml:space" select="@xml:space"/>
            <!-- "default" or "preserve" -->
        </xsl:if>
    </xsl:template>

    <xsl:template name="i18n">
        <xsl:if test="@xml:lang">
            <xsl:attribute name="xml:lang" select="@xml:lang"/>
            <!-- LanguageCode -->
        </xsl:if>
        <xsl:if test="@dir">
            <xsl:attribute name="dir" select="@dir"/>
        </xsl:if>
    </xsl:template>

    <!--<xsl:template name="attrs">
        <xsl:call-template name="coreattrs"/>
        <xsl:call-template name="i18n"/>

    </xsl:template>-->

    <!--<xsl:template name="attrsrqd">
        <xsl:attribute name="id" select="@id"/> <!-\- ID -\->
        <xsl:if test="@class">
            <attribute name="class"/>
        </xsl:if>
        <xsl:if test="@title">
            <xsl:attribute name="title" select="@title"/> <!-\- Text -\->
        </xsl:if>
        <xsl:if test="@xml:space">
            <attribute name="xml:space">
                <choice>
                    <value>default</value>
                    <value>preserve</value>
                </choice>
            </attribute>
        </xsl:if>
        <xsl:call-template name="i18n"/>

        
    </xsl:template>-->

    <xsl:template name="dtbookcontent">
        <xsl:apply-templates select="*"/>
        <!-- head, book -->
    </xsl:template>

    <xsl:template match="html:html">
        <dtbook version="2005-3">
            <xsl:call-template name="attlist.dtbook"/>
            <xsl:call-template name="dtbookcontent"/>
        </dtbook>
    </xsl:template>

    <xsl:template name="attlist.dtbook">
        <xsl:call-template name="i18n"/>
    </xsl:template>

    <xsl:template name="headmisc">
        <xsl:apply-templates select="*"/>
        <!-- html:title, meta, link -->
        <!--<xsl:choose>
            <xsl:when test="self::html:title">
                <meta name="dc:title" content="{.}"/>
            </xsl:when>
            <xsl:when test="self::html:meta">
                <meta name="{@name}" content="{@content}"/>
            </xsl:when>
            <xsl:when test="self::html:link">
                <!-\- TODO -\->
            </xsl:when>
        </xsl:choose>-->
    </xsl:template>

    <xsl:template match="html:head">
        <head>
            <!--<xsl:call-template name="attlist.head"/>-->
            <xsl:for-each select="*">
                <xsl:call-template name="headmisc"/>
            </xsl:for-each>
            <!-- TODO: maybe add a default CSS here? -->
        </head>
    </xsl:template>

    <!--<xsl:template name="attlist.head">
        <xsl:call-template name="i18n"/>

    </xsl:template>-->

    <!--<xsl:template name="link">
        <link>
            <xsl:call-template name="attlist.link"/>
            <empty/>
        </element>
    </xsl:template>-->

    <!--<xsl:template name="attlist.link">
        <xsl:call-template name="attrs"/>
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
        <attribute name="content"/>
        <xsl:if test="@scheme">
            <attribute name="scheme"/>
        </xsl:if>
    </xsl:template>-->

    <xsl:template match="html:body">
        <book>
            <xsl:apply-templates select="*"/>
            <!-- section/article (cover, frontmatter, bodymatter, rearmatter) -->
        </book>
    </xsl:template>

    <!--<xsl:template name="cover">
        <sch:rule context=".">
            <sch:assert test="tokenize(@epub:type,' ')='cover'">The cover must have an epub:type of 'cover'</sch:assert>
        </sch:rule>
        <xsl:call-template name="covertitle"/>
        <oneOrMore>
            <choice>
                <xsl:call-template name="docblockorinline"/>
                <xsl:call-template name="level"/>
                <xsl:call-template name="level2"/>
            </choice>
        </oneOrMore>
    </xsl:template>-->

    <!--<xsl:template name="frontmatter">
        <sch:rule context=".">
            <sch:assert test="tokenize(@epub:type,' ')='frontmatter'">The frontmatter must have an epub:type of 'frontmatter'</sch:assert>
        </sch:rule>
        <choice>
            <xsl:call-template name="frontmatter.titlepage"/>
            <xsl:call-template name="frontmatter.colophon"/>
            <xsl:call-template name="frontmatter.toc"/>
            <xsl:call-template name="frontmatter.foreword"/>
            <xsl:call-template name="frontmatter.introduction"/>
            <xsl:call-template name="frontmatter.other"/>
        </choice>
    </xsl:template>-->
    <!--<xsl:template name="frontmatter.titlepage">
        <sch:rule context=".">
            <sch:assert test="tokenize(@epub:type,' ')='titlepage'">The titlepage must have an epub:type of 'titlepage'</sch:assert>
        </sch:rule>
        <zeroOrMore>
            <xsl:call-template name="docauthor"/>
        </zeroOrMore>
        <xsl:call-template name="doctitle"/>
        <oneOrMore>
            <choice>
                <xsl:call-template name="docblockorinline"/>
                <xsl:call-template name="level"/>
                <xsl:call-template name="level2"/>
            </choice>
        </oneOrMore>
    </xsl:template>-->
    <!--<xsl:template name="frontmatter.colophon">
        <xsl:call-template name="frontmatter.generic"/>
        <sch:rule context=".">
            <sch:assert test="tokenize(@epub:type,' ')='colophon'">The titlepage must have an epub:type of 'colophon'</sch:assert>
        </sch:rule>
    </xsl:template>-->
    <!--<xsl:template name="frontmatter.toc">
        <xsl:call-template name="frontmatter.generic"/>
        <sch:rule context=".">
            <sch:assert test="tokenize(@epub:type,' ')='toc'">The toc must have an epub:type of 'toc'</sch:assert>
        </sch:rule>
    </xsl:template>-->
    <!--<xsl:template name="frontmatter.foreword">
        <xsl:call-template name="frontmatter.generic"/>
        <sch:rule context=".">
            <sch:assert test="tokenize(@epub:type,' ')='foreword'">The foreword must have an epub:type of 'foreword'</sch:assert>
        </sch:rule>
    </xsl:template>-->
    <!--<xsl:template name="frontmatter.introduction">
        <xsl:call-template name="frontmatter.generic"/>
        <sch:rule context=".">
            <sch:assert test="tokenize(@epub:type,' ')='introduction'">The introduction must have an epub:type of 'introduction'</sch:assert>
        </sch:rule>
    </xsl:template>-->
    <!--<xsl:template name="frontmatter.other">
        <xsl:call-template name="frontmatter.generic"/>
    </xsl:template>-->
    <!--<xsl:template name="frontmatter.generic">
        <choice>
            <xsl:call-template name="level.content"/>
            <xsl:call-template name="level1.content"/>
        </choice>
    </xsl:template>-->

    <!--<xsl:template name="bodymatter">
        <sch:rule context=".">
            <sch:assert test="tokenize(@epub:type,' ')='bodymatter'">The bodymatter must have an epub:type of 'bodymatter'</sch:assert>
        </sch:rule>
        <choice>
            <xsl:call-template name="bodymatter.prologue"/>
            <xsl:call-template name="bodymatter.preface"/>
            <xsl:call-template name="bodymatter.part"/>
            <xsl:call-template name="bodymatter.chapter"/>
            <xsl:call-template name="bodymatter.conclusion"/>
            <xsl:call-template name="bodymatter.epilogue"/>
        </choice>
    </xsl:template>-->
    <!--<xsl:template name="bodymatter.prologue">
        <xsl:call-template name="bodymatter.generic"/>
        <sch:rule context=".">
            <sch:assert test="tokenize(@epub:type,' ')='prologue'">The titlepage must have an epub:type of 'prologue'</sch:assert>
        </sch:rule>
    </xsl:template>-->
    <!--<xsl:template name="bodymatter.preface">
        <xsl:call-template name="bodymatter.generic"/>
        <sch:rule context=".">
            <sch:assert test="tokenize(@epub:type,' ')='preface'">The titlepage must have an epub:type of 'preface'</sch:assert>
        </sch:rule>
    </xsl:template>-->
    <!--<xsl:template name="bodymatter.part">
        <xsl:call-template name="bodymatter.generic"/>
        <sch:rule context=".">
            <sch:assert test="tokenize(@epub:type,' ')='part'">The part must have an epub:type of 'part'</sch:assert>
            <sch:assert test="(section,article)/@epub:type='chapter'">The subsections of a part must have an epub:type of 'chapter'.</sch:assert>
        </sch:rule>
    </xsl:template>-->
    <!--<xsl:template name="bodymatter.chapter">
        <xsl:call-template name="bodymatter.generic"/>
        <sch:rule context=".">
            <sch:assert test="tokenize(@epub:type,' ')='chapter'">The chapter must have an epub:type of 'chapter'</sch:assert>
        </sch:rule>
    </xsl:template>-->
    <!--<xsl:template name="bodymatter.conclusion">
        <xsl:call-template name="bodymatter.generic"/>
        <sch:rule context=".">
            <sch:assert test="tokenize(@epub:type,' ')='conclusion'">The conclusion must have an epub:type of 'conclusion'</sch:assert>
        </sch:rule>
    </xsl:template>-->
    <!--<xsl:template name="bodymatter.epilogue">
        <xsl:call-template name="bodymatter.generic"/>
        <sch:rule context=".">
            <sch:assert test="tokenize(@epub:type,' ')='epilogue'">The titlepage must have an epub:type of 'epilogue'</sch:assert>
        </sch:rule>
    </xsl:template>-->
    <!--<xsl:template name="bodymatter.generic">
        <choice>
            <xsl:call-template name="level.content"/>
            <xsl:call-template name="level1.content"/>
        </choice>
    </xsl:template>-->

    <!--<xsl:template name="rearmatter">
        <sch:rule context=".">
            <sch:assert test="tokenize(@epub:type,' ')='backmatter'">The backmatter must have an epub:type of 'backmatter'</sch:assert>
        </sch:rule>
        <choice>
            <xsl:call-template name="rearmatter.afterword"/>
            <xsl:call-template name="rearmatter.toc"/>
            <xsl:call-template name="rearmatter.index"/>
            <xsl:call-template name="rearmatter.appendix"/>
            <xsl:call-template name="rearmatter.glossary"/>
            <xsl:call-template name="rearmatter.footnotes"/>
            <xsl:call-template name="rearmatter.rearnotes"/>
            <xsl:call-template name="rearmatter.other"/>
        </choice>
    </xsl:template>-->
    <!--<xsl:template name="rearmatter.afterword">
        <xsl:call-template name="rearmatter.generic"/>
        <sch:rule context=".">
            <sch:assert test="tokenize(@epub:type,' ')='afterword'">The afterword must have an epub:type of 'afterword'</sch:assert>
        </sch:rule>
    </xsl:template>-->
    <!--<xsl:template name="rearmatter.toc">
        <xsl:call-template name="rearmatter.generic"/>
        <sch:rule context=".">
            <sch:assert test="tokenize(@epub:type,' ')='toc'">The toc must have an epub:type of 'toc'</sch:assert>
        </sch:rule>
    </xsl:template>-->
    <!--<xsl:template name="rearmatter.index">
        <xsl:call-template name="rearmatter.generic"/>
        <sch:rule context=".">
            <sch:assert test="tokenize(@epub:type,' ')='index'">The index must have an epub:type of 'index'</sch:assert>
        </sch:rule>
    </xsl:template>-->
    <!--<xsl:template name="rearmatter.appendix">
        <xsl:call-template name="rearmatter.generic"/>
        <sch:rule context=".">
            <sch:assert test="tokenize(@epub:type,' ')='appendix'">The appendix must have an epub:type of 'appendix'</sch:assert>
        </sch:rule>
    </xsl:template>-->
    <!--<xsl:template name="rearmatter.glossary">
        <xsl:call-template name="rearmatter.generic"/>
        <sch:rule context=".">
            <sch:assert test="tokenize(@epub:type,' ')='glossary'">The glossary must have an epub:type of 'glossary'</sch:assert>
        </sch:rule>
    </xsl:template>-->
    <!--<xsl:template name="rearmatter.footnotes">
        <xsl:call-template name="rearmatter.generic"/>
        <sch:rule context=".">
            <sch:assert test="tokenize(@epub:type,' ')='footnotes'">The footnotes must have an epub:type of 'footnotes'</sch:assert>
        </sch:rule>
    </xsl:template>-->
    <!--<xsl:template name="rearmatter.rearnotes">
        <xsl:call-template name="rearmatter.generic"/>
        <sch:rule context=".">
            <sch:assert test="tokenize(@epub:type,' ')='rearnotes'">The rearnotes must have an epub:type of 'rearnotes'</sch:assert>
        </sch:rule>
    </xsl:template>-->
    <!--<xsl:template name="rearmatter.other">
        <xsl:call-template name="rearmatter.generic"/>
    </xsl:template>-->
    <!--<xsl:template name="rearmatter.generic">
        <choice>
            <xsl:call-template name="level.content"/>
            <xsl:call-template name="level1.content"/>
        </choice>
    </xsl:template>-->

    <!--<xsl:template name="level">
        <choice>
            <section>
                <xsl:call-template name="level.content"/>
            </element>
            <article>

                <xsl:call-template name="level.content"/>
            </element>
        </choice>
    </xsl:template>-->
    <!--<xsl:template name="level.content">

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
    </xsl:template>-->

    <!--<xsl:template name="attlist.level">
        <xsl:call-template name="attrs"/>

    </xsl:template>-->

    <!--<xsl:template name="level1">
        <choice>
            <section>
                <xsl:call-template name="level1.content"/>
            </element>
            <article>

                <xsl:call-template name="level1.content"/>
            </element>
        </choice>
    </xsl:template>-->
    <!--<xsl:template name="level1.content">
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
    </xsl:template>-->
    <!--<xsl:template name="attlist.level1">
        <xsl:call-template name="attrs"/>
    </xsl:template>-->

    <!--<xsl:template name="level2">
        <choice>
            <section>
                <xsl:call-template name="level2.content"/>
            </element>
            <article>

                <xsl:call-template name="level2.content"/>
            </element>
        </choice>
    </xsl:template>-->
    <!--<xsl:template name="level2.content">
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
    </xsl:template>-->
    <!--<xsl:template name="attlist.level2">
        <xsl:call-template name="attrs"/>
    </xsl:template>-->

    <!--<xsl:template name="level3">
        <choice>
            <section>
                <xsl:call-template name="level3.content"/>
            </element>
            <article>

                <xsl:call-template name="level3.content"/>
            </element>
        </choice>
    </xsl:template>-->
    <!--<xsl:template name="level3.content">
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
    </xsl:template>-->
    <!--<xsl:template name="attlist.level3">
        <xsl:call-template name="attrs"/>
    </xsl:template>-->

    <!--<xsl:template name="level4">
        <choice>
            <section>
                <xsl:call-template name="level4.content"/>
            </element>
            <article>

                <xsl:call-template name="level4.content"/>
            </element>
        </choice>
    </xsl:template>-->
    <!--<xsl:template name="level4.content">
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
    </xsl:template>-->
    <!--<xsl:template name="attlist.level4">
        <xsl:call-template name="attrs"/>
    </xsl:template>-->

    <!--<xsl:template name="level5">
        <choice>
            <section>
                <xsl:call-template name="level5.content"/>
            </element>
            <article>

                <xsl:call-template name="level5.content"/>
            </element>
        </choice>
    </xsl:template>-->
    <!--<xsl:template name="level5.content">
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
    </xsl:template>-->
    <!--<xsl:template name="attlist.level5">
        <xsl:call-template name="attrs"/>
    </xsl:template>-->

    <!--<xsl:template name="level6">
        <choice>
            <section>
                <xsl:call-template name="level6.content"/>
            </element>
            <article>

                <xsl:call-template name="level6.content"/>
            </element>
        </choice>
    </xsl:template>-->
    <!--<xsl:template name="level6.content">
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
    <!--<xsl:template name="phrasenodfn">
        <choice>
            <xsl:call-template name="em"/>
            <xsl:call-template name="strong"/>
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
            <xsl:call-template name="dtbookinlinenoa"/>
            <xsl:call-template name="annoref"/>
            <xsl:call-template name="noteref"/>
        </choice>
    </xsl:template>-->
    <!--<xsl:template name="dtbookinlinenoa">
        <choice>
            <xsl:call-template name="sent"/>
            <xsl:call-template name="w"/>
            <xsl:call-template name="pagenum"/>

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
            <xsl:call-template name="dtbookinlinenoa"/>
        </choice>
    </xsl:template>-->
    <!--<xsl:template name="inlinenodfn">
        <choice>
            <text/>
            <xsl:call-template name="phrasenodfn"/>
            <xsl:call-template name="special"/>
            <xsl:call-template name="dtbookinlinenoa"/>
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
    <!--<xsl:template name="flownotable">
        <choice>
            <xsl:call-template name="inlinenoprodnote"/>
            <xsl:call-template name="blocknoimggroupnotable"/>
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
        <p>

            <xsl:call-template name="attlist.line"/>
            <sch:rule context=".">
                <sch:assert test="tokenize(@class,' ')='line'">Lines must have a 'line' class.</sch:assert>
            </sch:rule>
            <optional>
                <xsl:call-template name="linenum"/>
            </xsl:if>
            <zeroOrMore>
                <xsl:call-template name="inline"/>
            </zeroOrMore>
        </element>
    </xsl:template>-->
    <!--<xsl:template name="attlist.line">
        <xsl:call-template name="attrs"/>
    </xsl:template>-->

    <!--<xsl:template name="linenum">
        <span>
            <xsl:call-template name="attrs"/>
            <sch:rule context=".">
                <sch:assert test="tokenize(@class,' ')='linenum'">Line numbers must have a 'linenum' class.</sch:assert>
            </sch:rule>
            <text/>
        </element>
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

    <!--<xsl:template name="inlinetitle">
        <span>
            <xsl:call-template name="title.content"/>
        </element>
    </xsl:template>-->
    <!--<xsl:template name="title">
        <h1>

            <xsl:call-template name="title.content"/>
        </element>
    </xsl:template>-->
    <!--<xsl:template name="title.content">
        <xsl:call-template name="attlist.title"/>
        <sch:rule context=".">
            <sch:assert test="tokenize(@class,' ')='title'">Titles must have a 'title' class.</sch:assert>
        </sch:rule>
        <zeroOrMore>
            <xsl:call-template name="inline"/>
        </zeroOrMore>
    </xsl:template>-->
    <!--<xsl:template name="attlist.title">
        <xsl:call-template name="attrs"/>
    </xsl:template>-->

    <!--<xsl:template name="author">
        <span>

            <sch:rule context=".">
                <sch:assert test="tokenize(@epub:type,' ')='z3998:author'">The name of the author must have an epub:type of 'z3998:author'</sch:assert>
            </sch:rule>
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
        <aside>

            <sch:rule context=".">
                <sch:assert test="tokenize(@epub:type,' ')='z3998:production'">The production note must have an epub:type of 'z3998:production'</sch:assert>
            </sch:rule>
            <xsl:call-template name="attlist.prodnote"/>
            <zeroOrMore>
                <xsl:call-template name="flow"/>
            </zeroOrMore>
        </element>
    </xsl:template>-->

    <!--<xsl:template name="attlist.prodnote">
        <xsl:call-template name="attrs"/>

        <sch:rule context=".">
            <sch:assert test="matches(@class,'(^|.* )(render-required|render-optional)( .*|$)')">Production notes must have either a 'required' or 'optional' class. If optional, some user preference
                may allow skipping over the content.</sch:assert>
        </sch:rule>
    </xsl:template>-->

    <!--<xsl:template name="sidebar">
        <section>

            <sch:rule context=".">
                <sch:assert test="tokenize(@epub:type,' ')='sidebar'">The sidebar must have an epub:type of 'sidebar'</sch:assert>
            </sch:rule>
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
        <sch:rule context=".">
            <sch:assert test="matches(@class,'(^|.* )(render-required|render-optional)( .*|$)')">Sidebars must have either a 'required' or 'optional' class. If optional, some user preference may allow
                skipping over the content.</sch:assert>
        </sch:rule>
    </xsl:template>-->

    <!--<xsl:template name="note">
        <aside>

            <sch:rule context=".">
                <sch:assert test="tokenize(@epub:type,' ')='note'">The note must have an epub:type of 'note'</sch:assert>
            </sch:rule>
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
        <aside>

            <sch:rule context=".">
                <sch:assert test="tokenize(@epub:type,' ')='annotation'">The annotation must have an epub:type of 'annotation'</sch:assert>
            </sch:rule>
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
        <p>

            <sch:rule context=".">
                <sch:assert test="tokenize(@epub:type,' ')='epigraph'">The epigraph must have an epub:type of 'epigraph'</sch:assert>
            </sch:rule>
            <xsl:call-template name="attlist.epigraph"/>
            <zeroOrMore>
                <xsl:call-template name="inline"/>
            </zeroOrMore>
        </element>
    </xsl:template>-->
    <!--<xsl:template name="attlist.epigraph">
        <xsl:call-template name="attrs"/>
    </xsl:template>-->

    <!--<xsl:template name="byline">
        <span>

            <xsl:call-template name="attlist.byline"/>
            <sch:rule context=".">
                <sch:assert test="tokenize(@class,' ')='byline'">Bylines must have a 'byline' class.</sch:assert>
            </sch:rule>
            <zeroOrMore>
                <xsl:call-template name="inline"/>
            </zeroOrMore>
        </element>
    </xsl:template>-->
    <!--<xsl:template name="attlist.byline">
        <xsl:call-template name="attrs"/>
    </xsl:template>-->

    <!--<xsl:template name="dateline">
        <span>

            <xsl:call-template name="attlist.dateline"/>
            <sch:rule context=".">
                <sch:assert test="tokenize(@class,' ')='dateline'">Datelines must have a 'dateline' class.</sch:assert>
            </sch:rule>
            <zeroOrMore>
                <xsl:call-template name="inline"/>
            </zeroOrMore>
        </element>
    </xsl:template>-->
    <!--<xsl:template name="attlist.dateline">
        <xsl:call-template name="attrs"/>
    </xsl:template>-->

    <!--<xsl:template name="linegroup">
        <section>

            <xsl:call-template name="attlist.linegroup"/>
            <sch:rule context=".">
                <sch:assert test="tokenize(@class,' ')='linegroup'">Linegroups must have a 'linegroup' class.</sch:assert>
            </sch:rule>
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
        <section>

            <sch:rule context=".">
                <sch:assert test="tokenize(@epub:type,' ')='z3998:poem'">The poem must have an epub:type of 'z3998:poem'</sch:assert>
            </sch:rule>
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
        <xsl:if test="@accesskey">
            <xsl:attribute name="accesskey" select="@accesskey"/> <!-\- Character -\->
        </xsl:if>
        <xsl:if test="@tabindex">
            <xsl:attribute name="tabindex" select="@tabindex"/> <!-\- Number -\->
        </xsl:if>
        <xsl:if test="@target">
            <attribute name="target">
                <value>_blank</value>
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
                <xsl:call-template name="inlinenodfn"/>

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
            <attribute name="class"/>
        </xsl:if>
        <xsl:if test="@title">
            <xsl:attribute name="title" select="@title"/> <!-\- Text -\->
        </xsl:if>
        <xsl:if test="@xml:space">
            <attribute name="xml:space" a:defaultValue="preserve">
                <choice>
                    <value>default</value>
                    <value>preserve</value>
                </choice>
            </attribute>
        </xsl:if>
        
        <xsl:call-template name="i18n"/>

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
            <attribute name="class"/>
        </xsl:if>
        <xsl:if test="@title">
            <xsl:attribute name="title" select="@title"/> <!-\- Text -\->
        </xsl:if>
        <xsl:if test="@xml:space">
            <attribute name="xml:space" a:defaultValue="preserve">
                <choice>
                    <value>default</value>
                    <value>preserve</value>
                </choice>
            </attribute>
        </xsl:if>
        
        <xsl:call-template name="i18n"/>

    </xsl:template>-->

    <!--<xsl:template name="cite">
        <span>
            <xsl:call-template name="attlist.cite"/>
            <sch:rule context=".">
                <sch:assert test="tokenize(@epub:type,' ')='z3998:nonresolving-citation'">The citation must have an epub:type of 'z3998:nonresolving-citation'</sch:assert>
            </sch:rule>
            <zeroOrMore>
                <choice>
                    <xsl:call-template name="inline"/>
                    <xsl:call-template name="inlinetitle"/>
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
        <abbr>
            <xsl:call-template name="attlist.acronym"/>
            <sch:rule context=".">
                <sch:assert test="tokenize(@class,' ')='acronym'">Acronyms must have a 'acronym' class.</sch:assert>
            </sch:rule>
            <zeroOrMore>
                <xsl:call-template name="inline"/>
            </zeroOrMore>
        </element>
    </xsl:template>-->

    <!--<xsl:template name="attlist.acronym">
        <xsl:call-template name="attrs"/>
        <xsl:if test="@style">
            <attribute name="style">
                <value>-epub-speak-as: spell-out;</value>
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
        <attribute name="dir">
            <choice>
                <value>ltr</value>
                <value>rtl</value>
            </choice>
        </attribute>

    </xsl:template>-->

    <!--<xsl:template name="sent">
        <span>
            <sch:rule context=".">
                <sch:assert test="tokenize(@epub:type,' ')='z3998:sentence'">The sentence must have an epub:type of 'z3998:sentence'</sch:assert>
            </sch:rule>
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
        <span>
            <sch:rule context=".">
                <sch:assert test="tokenize(@epub:type,' ')='z3998:word'">The word must have an epub:type of 'z3998:word'</sch:assert>
            </sch:rule>
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
        <span>
            <sch:rule context=".">
                <sch:assert test="tokenize(@epub:type,' ')='pagebreak'">The pagebreak must have an epub:type of 'pagebreak'</sch:assert>
            </sch:rule>
            <xsl:call-template name="attlist.pagenum"/>
            <sch:rule context=".">
                <sch:assert test="matches(@class,'(^|.* )(page-front|page-normal|page-special)( .*|$)')">Page breaks must have either a 'page-front', a 'page-normal' or a 'page-special'
                    class.</sch:assert>
                <sch:assert test="matches(@title,'.+')">The title attribute must be used to describe the page number.</sch:assert>
            </sch:rule>
        </element>
    </xsl:template>-->

    <!--<xsl:template name="attlist.pagenum">
        <xsl:call-template name="attrsrqd"/>
    </xsl:template>-->

    <!--<xsl:template name="noteref">
        <a>
            <sch:rule context=".">
                <sch:assert test="tokenize(@epub:type,' ')='noteref'">The note reference must have an epub:type of 'noteref'</sch:assert>
            </sch:rule>
            <xsl:call-template name="attlist.noteref"/>
            <text/>
        </element>
    </xsl:template>-->

    <!--<xsl:template name="attlist.noteref">
        <xsl:call-template name="attrs"/>
        <xsl:attribute name="href" select="@href"/> <!-\- URI -\->
        <xsl:if test="@type">
            <xsl:attribute name="type" select="@type"/> <!-\- ContentType -\->
        </xsl:if>
    </xsl:template>-->

    <!--<xsl:template name="annoref">
        <a>
            <sch:rule context=".">
                <sch:assert test="tokenize(@epub:type,' ')='annoref'">The annotation reference must have an epub:type of 'annoref'</sch:assert>
            </sch:rule>
            <xsl:call-template name="attlist.annoref"/>
            <text/>
        </element>
    </xsl:template>-->

    <!--<xsl:template name="attlist.annoref">
        <xsl:call-template name="attrs"/>
        <xsl:attribute name="href" select="@href"/> <!-\- URI -\->
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
        <data type="string" datatypeLibrary=""/>
    </xsl:template>-->

    <!--<xsl:template name="MultiLength">
        <data type="string" datatypeLibrary=""/>
    </xsl:template>-->

    <!--<xsl:template name="Pixels">
        <data type="string" datatypeLibrary=""/>
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
        <figure>

            <xsl:call-template name="attlist.imggroup"/>
            <choice>
                <group>
                    <optional>
                        <xsl:call-template name="caption.figure"/>
                    </xsl:if>
                    <oneOrMore>
                        <choice>
                            <xsl:call-template name="prodnote"/>
                            <xsl:call-template name="img"/>
                            <xsl:call-template name="pagenum"/>
                        </choice>
                    </oneOrMore>
                </group>
                <group>
                    <oneOrMore>
                        <choice>
                            <xsl:call-template name="prodnote"/>
                            <xsl:call-template name="img"/>
                            <xsl:call-template name="pagenum"/>
                        </choice>
                    </oneOrMore>
                    <xsl:call-template name="caption.figure"/>
                </group>
            </choice>
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

    <!--<xsl:template name="doctitle">
        <h1>
            <sch:rule context=".">
                <sch:assert test="tokenize(@epub:type,' ')='fulltitle'">The full title must have an epub:type of 'fulltitle'</sch:assert>
            </sch:rule>
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
        <p>
            <sch:rule context=".">
                <sch:assert test="tokenize(@epub:type,' ')='z3998:author'">The document author must have an epub:type of 'z3998:author'</sch:assert>
            </sch:rule>
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
        <h1>
            <sch:rule context=".">
                <sch:assert test="tokenize(@epub:type,' ')='covertitle'">The cover title must have an epub:type of 'covertitle'</sch:assert>
            </sch:rule>
            <xsl:call-template name="attlist.covertitle"/>
            <text/>
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
    <!--<xsl:template name="caption.figure">
        <figcaption>

            <choice>
                <group>
                    <xsl:call-template name="attlist.caption"/>
                    <sch:rule context=".">
                        <sch:assert test="tokenize(@class,' ')='caption'">Figure captions must have a 'caption' class.</sch:assert>
                    </sch:rule>
                    <zeroOrMore>
                        <xsl:call-template name="flow"/>
                    </zeroOrMore>
                </group>
                <group>
                    <oneOrMore>
                        <div>
                            <xsl:call-template name="attlist.caption"/>
                            <sch:rule context=".">
                                <sch:assert test="tokenize(@class,' ')='caption'">Figure captions must have a 'caption' class.</sch:assert>
                            </sch:rule>
                            <zeroOrMore>
                                <xsl:call-template name="flow"/>
                            </zeroOrMore>
                        </element>
                    </oneOrMore>
                </group>
            </choice>
        </element>
    </xsl:template>-->

    <!--<xsl:template name="attlist.caption">
        <xsl:call-template name="attrs"/>

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

</xsl:stylesheet>
