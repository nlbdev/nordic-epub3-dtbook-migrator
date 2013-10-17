<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:f="http://www.daisy.org/ns/pipeline/internal-functions" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0" xmlns:dtbook="http://www.daisy.org/z3986/2005/dtbook/"
    xmlns:epub="http://www.idpf.org/2007/ops" xmlns="http://www.w3.org/1999/xhtml" xpath-default-namespace="http://www.w3.org/1999/xhtml" exclude-result-prefixes="#all"
    xmlns:xs="http://www.w3.org/2001/XMLSchema">

    <xsl:variable name="vocab-default"
        select="('acknowledgments','afterword','annoref','annotation','appendix','backmatter','biblioentry','bibliography','bodymatter','bridgehead','chapter','colophon','concluding-sentence','conclusion','contributors','copyright-page','cover','covertitle','dedication','division','epigraph','epilogue','errata','footnote','footnotes','foreword','frontmatter','fulltitle','glossary','glossdef','glossterm','halftitle','halftitlepage','help','imprimatur','imprint','index','introduction','keyword','landmarks','list','list-item','loi','lot','marginalia','note','noteref','notice','other-credits','pagebreak','page-list','part','practice','preamble','preface','prologue','rearnote','rearnotes','sidebar','subchapter','subtitle','table','table-cell','table-row','title','titlepage','toc','topic-sentence','volume','warning')"/>
    <xsl:variable name="vocab-z3998"
        select="('abbreviations','acknowledgments','acronym','actor','afterword','alteration','annoref','annotation','appendix','article','aside','attribution','author','award','backmatter','bcc','bibliography','biographical-note','bodymatter','cardinal','catalogue','cc','chapter','citation','clarification','collection','colophon','commentary','commentator','compound','concluding-sentence','conclusion','continuation','continuation-of','contributors','coordinate','correction','covertitle','currency','decimal','decorative','dedication','diary','diary-entry','discography','division','drama','dramatis-personae','editor','editorial-note','email','email-message','epigraph','epilogue','errata','essay','event','example','family-name','fiction','figure','filmography','footnote','footnotes','foreword','fraction','from','frontispiece','frontmatter','ftp','fulltitle','gallery','general-editor','geographic','given-name','glossary','grant-acknowledgment','grapheme','halftitle','halftitle-page','help','homograph','http','hymn','illustration','image-placeholder','imprimatur','imprint','index','initialism','introduction','introductory-note','ip','isbn','keyword','letter','loi','lot','lyrics','marginalia','measure','mixed','morpheme','name-title','nationality','non-fiction','nonresolving-citation','nonresolving-reference','note','noteref','notice','orderedlist','ordinal','organization','other-credits','pagebreak','page-footer','page-header','part','percentage','persona','personal-name','pgroup','phone','phoneme','photograph','phrase','place','plate','poem','portmanteau','postal','postal-code','postscript','practice','preamble','preface','prefix','presentation','primary','product','production','prologue','promotional-copy','published-works','publisher-address','publisher-logo','range','ratio','rearnote','rearnotes','recipient','recto','reference','republisher','resolving-reference','result','role-description','roman','root','salutation','scene','secondary','section','sender','sentence','sidebar','signature','song','speech','stage-direction','stem','structure','subchapter','subject','subsection','subtitle','suffix','surname','taxonomy','tertiary','text','textbook','t-form','timeline','title','title-page','to','toc','topic-sentence','translator','translator-note','truncation','unorderedlist','valediction','verse','verso','v-form','volume','warning','weight','word')"/>

    <xsl:template match="text()|comment()">
        <xsl:copy-of select="."/>
    </xsl:template>

    <xsl:template name="coreattrs">
        <xsl:if test="(self::dtbook:level or self::dtbook:level1) and (parent::dtbook:frontmatter or parent::dtbook:bodymatter or parent::dtbook:rearmatter)">
            <!--
                the frontmatter/bodymatter/rearmatter does not have corresponding elements in HTML and is removed;
                try preserving the attributes on the closest sectioning element(s) when possible
            -->
            <xsl:copy-of select="parent::*/(@title|@xml:space)"/>
            <xsl:if test="not(preceding-sibling::dtbook:level or preceding-sibling::dtbook:level1)">
                <xsl:copy-of select="parent::*/@id"/>
            </xsl:if>
        </xsl:if>
        <xsl:copy-of select="@id|@title|@xml:space"/>
        <xsl:call-template name="classes-and-types"/>
    </xsl:template>

    <xsl:template name="i18n">
        <xsl:if test="(self::dtbook:level or self::dtbook:level1) and (parent::dtbook:frontmatter or parent::dtbook:bodymatter or parent::dtbook:rearmatter)">
            <!--
                the frontmatter/bodymatter/rearmatter does not have corresponding elements in HTML and is removed;
                try preserving the attributes on the closest sectioning element(s) when possible
            -->
            <xsl:copy-of select="parent::*/(@xml:lang|@dir)"/>
        </xsl:if>
        <xsl:copy-of select="@xml:lang|@dir"/>
    </xsl:template>

    <xsl:template name="classes-and-types">
        <xsl:param name="classes" select="()" tunnel="yes"/>
        <xsl:param name="types" select="()" tunnel="yes"/>
        <xsl:variable name="showin" select="for $s in (@showin) return concat('showin-',$s)"/>
        <xsl:variable name="old-classes" select="tokenize(@class,'\s+')"/>

        <!-- assume that non-standard classes are fixed before running this XSLT (for instance, 'jacketcopy' => 'cover' and 'endnote' => 'rearnote') -->
        <xsl:variable name="epub-types">
            <xsl:for-each select="$old-classes">
                <xsl:sequence select="if (.=$vocab-default) then . else concat('z3998:',.)"/>
            </xsl:for-each>
            <xsl:value-of select="''"/>
        </xsl:variable>
        <xsl:variable name="epub-types" select="($types, $epub-types)"/>

        <xsl:variable name="classes" select="($classes, $old-classes[not(.=($vocab-default,$vocab-z3998))], $showin)"/>

        <xsl:if test="$classes">
            <xsl:attribute name="class" select="string-join(distinct-values($classes),' ')"/>
        </xsl:if>
        <xsl:if test="$epub-types">
            <xsl:attribute name="epub:type" select="string-join(distinct-values($epub-types),' ')"/>
        </xsl:if>
    </xsl:template>

    <xsl:template name="attrs">
        <xsl:call-template name="coreattrs"/>
        <xsl:call-template name="i18n"/>
        <!-- ignore @smilref -->
        <!-- @showin handled by coreattrs -->
    </xsl:template>

    <xsl:template name="attrsrqd">
        <xsl:if test="(self::dtbook:level or self::dtbook:level1) and (parent::dtbook:frontmatter or parent::dtbook:bodymatter or parent::dtbook:rearmatter)">
            <!--
                the frontmatter/bodymatter/rearmatter does not have corresponding elements in HTML and is removed;
                try preserving the attributes on the closest sectioning element(s) when possible
            -->
            <xsl:copy-of select="parent::*/(@title|@xml:space)"/>
            <xsl:if test="not(preceding-sibling::dtbook:level or preceding-sibling::dtbook:level1)">
                <xsl:copy-of select="parent::*/@id"/>
            </xsl:if>
        </xsl:if>
        <xsl:copy-of select="@id|@title|@xml:space"/>
        <xsl:call-template name="classes-and-types"/>
        <!-- ignore @smilref -->
        <xsl:call-template name="i18n"/>
        <!-- @showin handled by classes-and-types -->
    </xsl:template>

    <xsl:template match="dtbook:dtbook">
        <html>
            <xsl:attribute name="epub:prefix" select="'z3998: http://www.daisy.org/z3998/2012/vocab/structure/#'"/>
            <xsl:call-template name="attlist.dtbook"/>
            <xsl:apply-templates select="node()"/>
        </html>
    </xsl:template>

    <xsl:template name="attlist.dtbook">
        <!-- ignore @version -->
        <xsl:call-template name="i18n"/>
    </xsl:template>

    <xsl:template name="headmisc">
        <xsl:apply-templates select="node()"/>
    </xsl:template>

    <xsl:template match="dtbook:head">
        <head>
            <xsl:call-template name="attlist.head"/>
            <xsl:call-template name="headmisc"/>
            <style type="text/css">
                //<![CDATA[
                .spell-out{
                    -epub-speak-as:spell-out;
                }
                //]]></style>
        </head>
    </xsl:template>

    <xsl:template name="attlist.head">
        <xsl:call-template name="i18n"/>
        <xsl:if test="@profile">
            <link rel="profile" href="{@profile}"/>
        </xsl:if>
    </xsl:template>

    <xsl:template name="dtbook:link">
        <link>
            <xsl:call-template name="attlist.link"/>
        </link>
    </xsl:template>

    <xsl:template name="attlist.link">
        <xsl:call-template name="attrs"/>
        <xsl:copy-of select="@href|@hreflang|@type|@rel|@media"/>
        <!-- @charset and @rev are dropped -->
    </xsl:template>

    <xsl:template match="dtbook:meta">
        <meta>
            <xsl:call-template name="attlist.meta"/>
        </meta>
    </xsl:template>

    <xsl:template name="attlist.meta">
        <xsl:call-template name="i18n"/>
        <xsl:copy-of select="@content|@http-equiv|@name"/>
        <!-- @scheme is dropped -->
    </xsl:template>

    <xsl:template match="dtbook:book">
        <body>
            <xsl:call-template name="attlist.book"/>
            <xsl:apply-templates select="node()"/>
        </body>
    </xsl:template>

    <xsl:template name="attlist.book">
        <xsl:call-template name="attrs"/>
    </xsl:template>

    <xsl:template name="cover">
        <section>
            <xsl:call-template name="attlist.frontmatter">
                <xsl:with-param name="types" select="'cover'" tunnel="yes"/>
            </xsl:call-template>
            <xsl:for-each select="preceding-sibling::dtbook:covertitle">
                <xsl:call-template name="covertitle"/>
            </xsl:for-each>
            <xsl:apply-templates select="node()"/>
        </section>
    </xsl:template>

    <xsl:template match="dtbook:frontmatter">
        <!-- all attributes on frontmatter will be lost -->
        <xsl:choose>
            <xsl:when test="dtbook:covertitle">
                <xsl:apply-templates select="(*[f:classes(.)='cover'])[1]/preceding-sibling::node()"/>
                <xsl:for-each select="(*[f:classes(.)='cover'])[1]">
                    <xsl:call-template name="cover"/>
                </xsl:for-each>
                <xsl:apply-templates select="(*[f:classes(.)='cover'])[1]/following-sibling::node()"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates select="node()"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="attlist.frontmatter">
        <xsl:param name="types" tunnel="yes"/>
        <xsl:call-template name="attrs">
            <xsl:with-param name="types" select="('frontmatter',$types)" tunnel="yes"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="dtbook:bodymatter">
        <!-- all attributes on bodymatter will be lost -->
        <xsl:apply-templates select="node()"/>
    </xsl:template>

    <xsl:template name="attlist.bodymatter">
        <xsl:param name="types" tunnel="yes"/>
        <xsl:call-template name="attrs">
            <xsl:with-param name="types" select="('bodymatter',$types)" tunnel="yes"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="dtbook:rearmatter">
        <!-- all attributes on rearmatter will be lost -->
        <xsl:apply-templates select="node()"/>
    </xsl:template>

    <xsl:template name="attlist.rearmatter">
        <xsl:param name="types" tunnel="yes"/>
        <xsl:call-template name="attrs">
            <xsl:with-param name="types" select="('backmatter',$types)" tunnel="yes"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="dtbook:level | dtbook:level1 | dtbook:level2 | dtbook:level3 | dtbook:level4 | dtbook:level5 | dtbook:level6">
        <xsl:element name="{if (f:classes(.)='article') then 'article' else 'section'}">
            <xsl:call-template name="attlist.level"/>
            <xsl:apply-templates select="node()"/>
        </xsl:element>
    </xsl:template>

    <xsl:template name="attlist.level">
        <xsl:call-template name="attrs"/>
        <!-- @depth is removed, it is implicit anyway -->
    </xsl:template>

    <xsl:template match="dtbook:br">
        <br>
            <xsl:call-template name="attlist.br"/>
        </br>
    </xsl:template>

    <xsl:template name="attlist.br">
        <xsl:call-template name="coreattrs"/>
    </xsl:template>

    <xsl:template match="dtbook:line">
        <p>
            <xsl:call-template name="attlist.line"/>
            <xsl:apply-templates select="node()"/>
        </p>
    </xsl:template>

    <xsl:template name="attlist.line">
        <xsl:call-template name="attrs">
            <xsl:with-param name="classes" select="'line'" tunnel="yes"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="dtbook:linenum">
        <span>
            <xsl:call-template name="attlist.linenum"/>
            <xsl:apply-templates select="node()"/>
        </span>
    </xsl:template>

    <xsl:template name="attlist.linenum">
        <xsl:call-template name="attrs">
            <xsl:with-param name="classes" select="'linenum'" tunnel="yes"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="dtbook:address">
        <address>
            <xsl:call-template name="attlist.address"/>
            <xsl:apply-templates select="node()"/>
        </address>
    </xsl:template>

    <xsl:template name="attlist.address">
        <xsl:call-template name="attrs"/>
    </xsl:template>

    <xsl:template match="dtbook:div">
        <div>
            <xsl:call-template name="attlist.div"/>
            <xsl:apply-templates select="node()"/>
        </div>
    </xsl:template>

    <xsl:template name="attlist.div">
        <xsl:call-template name="attrs"/>
    </xsl:template>

    <xsl:template match="dtbook:title">
        <xsl:choose>
            <xsl:when test="parent::dtbook:poem">
                <xsl:element name="h{f:level(.)}">
                    <xsl:call-template name="attlist.title"/>
                    <xsl:apply-templates select="node()"/>
                </xsl:element>
            </xsl:when>
            <xsl:when test="parent::dtbook:cite">
                <span>
                    <xsl:call-template name="attlist.title"/>
                    <xsl:apply-templates select="node()"/>
                </span>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="attlist.title">
        <xsl:call-template name="attrs"/>
    </xsl:template>

    <xsl:template match="dtbook:author">
        <span>
            <xsl:call-template name="attlist.author"/>
            <xsl:apply-templates select="node()"/>
        </span>
    </xsl:template>

    <xsl:template name="attlist.author">
        <xsl:call-template name="attrs">
            <xsl:with-param name="types" select="'z3998:author'" tunnel="yes"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="dtbook:prodnote">
        <aside>
            <xsl:call-template name="attlist.prodnote"/>
            <xsl:apply-templates select="node()"/>
        </aside>
    </xsl:template>

    <xsl:template name="attlist.prodnote">
        <xsl:call-template name="attrs">
            <xsl:with-param name="types" select="'z3998:production'" tunnel="yes"/>
            <xsl:with-param name="classes" select="if (@render) then concat('render-',@render) else ()" tunnel="yes"/>
        </xsl:call-template>
        <!-- @imgref is dropped, the relationship is preserved in the corresponding img/@longdesc -->
        <xsl:if test="not(@id)">
            <xsl:attribute name="id" select="generate-id(.)"/>
        </xsl:if>
    </xsl:template>

    <xsl:template match="dtbook:sidebar">
        <aside>
            <xsl:call-template name="attlist.sidebar"/>
            <xsl:apply-templates select="node()"/>
        </aside>
    </xsl:template>

    <xsl:template name="attlist.sidebar">
        <xsl:call-template name="attrs">
            <xsl:with-param name="types" select="'sidebar'" tunnel="yes"/>
            <xsl:with-param name="classes" select="if (@render) then concat('render-',@render) else ()" tunnel="yes"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="dtbook:note">
        <aside>
            <xsl:call-template name="attlist.note"/>
            <xsl:apply-templates select="node()"/>
        </aside>
    </xsl:template>

    <xsl:template name="attlist.note">
        <xsl:call-template name="attrsrqd">
            <xsl:with-param name="types" select="'note'" tunnel="yes"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="dtbook:annotation">
        <aside>
            <xsl:call-template name="attlist.annotation"/>
            <xsl:apply-templates select="node()"/>
        </aside>
    </xsl:template>

    <xsl:template name="attlist.annotation">
        <xsl:call-template name="attrsrqd">
            <xsl:with-param name="types" select="'annotation'" tunnel="yes"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="dtbook:epigraph">
        <p>
            <xsl:call-template name="attlist.epigraph"/>
            <xsl:apply-templates select="node()"/>
        </p>
    </xsl:template>

    <xsl:template name="attlist.epigraph">
        <xsl:call-template name="attrs">
            <xsl:with-param name="types" select="'epigraph'" tunnel="yes"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="dtbook:byline">
        <span>
            <xsl:call-template name="attlist.byline"/>
            <xsl:apply-templates select="node()"/>
        </span>
    </xsl:template>

    <xsl:template name="attlist.byline">
        <xsl:call-template name="attrs">
            <xsl:with-param name="classes" select="'byline'" tunnel="yes"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="dtbook:dateline">
        <span>
            <xsl:call-template name="attlist.dateline"/>
            <xsl:apply-templates select="node()"/>
        </span>
    </xsl:template>

    <xsl:template name="attlist.dateline">
        <xsl:call-template name="attrs">
            <xsl:with-param name="classes" select="'dateline'" tunnel="yes"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="dtbook:linegroup">
        <div>
            <xsl:call-template name="attlist.linegroup"/>
            <xsl:apply-templates select="node()"/>
        </div>
    </xsl:template>

    <xsl:template name="attlist.linegroup">
        <xsl:call-template name="attrs">
            <xsl:with-param name="types" select="if (parent::dtbook:poem) then 'z3998:verse' else ()" tunnel="yes"/>
            <xsl:with-param name="classes" select="'linegroup'" tunnel="yes"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="dtbook:poem">
        <div>
            <xsl:call-template name="attlist.poem"/>
            <xsl:apply-templates select="node()"/>
        </div>
    </xsl:template>

    <xsl:template name="attlist.poem">
        <xsl:call-template name="attrs">
            <xsl:with-param name="types" select="'z3998:poem'" tunnel="yes"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="dtbook:a">
        <a>
            <xsl:call-template name="attlist.a"/>
            <xsl:apply-templates select="node()"/>
        </a>
    </xsl:template>

    <xsl:template name="attlist.a">
        <xsl:call-template name="attrs">
            <xsl:with-param name="classes" select="if (@external) then concat('external-',@external) else ()" tunnel="yes"/>
        </xsl:call-template>
        <xsl:copy-of select="@type|@href|@hreflang|@rel|@accesskey|@tabindex"/>
        <!-- @rev is dropped since it's not supported in HTML5 -->

        <xsl:choose>
            <xsl:when test="f:classes(.)[matches(.,'^target--')]">
                <xsl:attribute name="target" select="replace((f:classes(.)[matches(.,'^target--')])[1],'^target--','_')"/>
            </xsl:when>
            <xsl:when test="f:classes(.)[matches(.,'^target-')]">
                <xsl:attribute name="target" select="replace((f:classes(.)[matches(.,'^target-')])[1],'^target-','')"/>
            </xsl:when>
            <xsl:when test="@external='true'">
                <xsl:attribute name="target" select="'_blank'"/>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="dtbook:em">
        <em>
            <xsl:call-template name="attlist.em"/>
            <xsl:apply-templates select="node()"/>
        </em>
    </xsl:template>

    <xsl:template name="attlist.em">
        <xsl:call-template name="attrs"/>
    </xsl:template>

    <xsl:template match="dtbook:strong">
        <strong>
            <xsl:call-template name="attlist.strong"/>
            <xsl:apply-templates select="node()"/>
        </strong>
    </xsl:template>

    <xsl:template name="attlist.strong">
        <xsl:call-template name="attrs"/>
    </xsl:template>

    <xsl:template match="dtbook:dfn">
        <dfn>
            <xsl:call-template name="attlist.dfn"/>
            <xsl:apply-templates select="node()"/>
        </dfn>
    </xsl:template>

    <xsl:template name="attlist.dfn">
        <xsl:call-template name="attrs"/>
    </xsl:template>

    <xsl:template match="dtbook:kbd">
        <kbd>
            <xsl:call-template name="attlist.kbd"/>
            <xsl:apply-templates select="node()"/>
        </kbd>
    </xsl:template>

    <xsl:template name="attlist.kbd">
        <xsl:call-template name="attrs"/>
    </xsl:template>

    <xsl:template match="dtbook:code">
        <code>
            <xsl:call-template name="attlist.code"/>
            <xsl:apply-templates select="node()"/>
        </code>
    </xsl:template>

    <xsl:template name="attlist.code">
        <xsl:call-template name="attrs"/>
        <xsl:call-template name="i18n"/>
        <!-- ignore @smilref -->
        <!-- @showin handled by "attrs" -->
    </xsl:template>

    <xsl:template match="dtbook:samp">
        <samp>
            <xsl:call-template name="attlist.samp"/>
            <xsl:apply-templates select="node()"/>
        </samp>
    </xsl:template>

    <xsl:template name="attlist.samp">
        <xsl:call-template name="attrs"/>
        <xsl:call-template name="i18n"/>
        <!-- ignore @smilref -->
        <!-- @showin handled by "attrs" -->
    </xsl:template>

    <xsl:template match="dtbook:cite">
        <span>
            <xsl:call-template name="attlist.cite"/>
            <xsl:apply-templates select="node()"/>
        </span>
    </xsl:template>

    <xsl:template name="attlist.cite">
        <xsl:call-template name="attrs">
            <xsl:with-param name="types" select="'z3998:nonresolving-citation'" tunnel="yes"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="dtbook:abbr">
        <abbr>
            <xsl:call-template name="attlist.abbr"/>
            <xsl:apply-templates select="node()"/>
        </abbr>
    </xsl:template>

    <xsl:template name="attlist.abbr">
        <xsl:call-template name="attrs"/>
    </xsl:template>

    <xsl:template match="dtbook:acronym">
        <abbr>
            <xsl:call-template name="attlist.acronym"/>
            <xsl:apply-templates select="node()"/>
        </abbr>
    </xsl:template>

    <xsl:template name="attlist.acronym">
        <xsl:call-template name="attrs">
            <xsl:with-param name="classes" select="('acronym', if (@pronounce='no') then 'spell-out' else ())" tunnel="yes"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="dtbook:sub">
        <sub>
            <xsl:call-template name="attlist.sub"/>
            <xsl:apply-templates select="node()"/>
        </sub>
    </xsl:template>

    <xsl:template name="attlist.sub">
        <xsl:call-template name="attrs"/>
    </xsl:template>

    <xsl:template match="dtbook:sup">
        <sup>
            <xsl:call-template name="attlist.sup"/>
            <xsl:apply-templates select="node()"/>
        </sup>
    </xsl:template>

    <xsl:template name="attlist.sup">
        <xsl:call-template name="attrs"/>
    </xsl:template>

    <xsl:template match="dtbook:span">
        <span>
            <xsl:call-template name="attlist.span"/>
            <xsl:apply-templates select="node()"/>
        </span>
    </xsl:template>

    <xsl:template name="attlist.span">
        <xsl:call-template name="attrs"/>
    </xsl:template>

    <xsl:template match="dtbook:bdo">
        <bdo>
            <xsl:call-template name="attlist.bdo"/>
            <xsl:apply-templates select="node()"/>
        </bdo>
    </xsl:template>

    <xsl:template name="attlist.bdo">
        <xsl:call-template name="coreattrs"/>
        <xsl:call-template name="i18n"/>
        <!-- ignore @smilref -->
        <!-- @showin handled by "coreattrs" -->
    </xsl:template>

    <xsl:template match="dtbook:sent">
        <span>
            <xsl:call-template name="attlist.sent"/>
            <xsl:apply-templates select="node()"/>
        </span>
    </xsl:template>

    <xsl:template name="attlist.sent">
        <xsl:call-template name="attrs">
            <xsl:with-param name="types" select="'z3998:sentence'" tunnel="yes"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="dtbook:w">
        <span>
            <xsl:call-template name="attlist.w"/>
            <xsl:apply-templates select="node()"/>
        </span>
    </xsl:template>

    <xsl:template name="attlist.w">
        <xsl:call-template name="attrs">
            <xsl:with-param name="types" select="'z3998:word'" tunnel="yes"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="dtbook:pagenum">
        <span>
            <xsl:call-template name="attlist.pagenum"/>
            <xsl:attribute name="title" select="normalize-space(.)"/>
            <!--
                NOTE: the title attribute is overwritten with the contents of the pagenum,
                so any pre-existing @title content is lost.
            -->
        </span>
    </xsl:template>

    <xsl:template name="attlist.pagenum">
        <xsl:call-template name="attrsrqd">
            <xsl:with-param name="types" select="'pagebreak'" tunnel="yes"/>
            <xsl:with-param name="classes" select="concat('page-',('normal',@page)[1])" tunnel="yes"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="dtbook:noteref">
        <a>
            <xsl:call-template name="attlist.noteref"/>
            <xsl:apply-templates select="node()"/>
        </a>
    </xsl:template>

    <xsl:template name="attlist.noteref">
        <xsl:call-template name="attrs">
            <xsl:with-param name="types" select="'noteref'" tunnel="yes"/>
        </xsl:call-template>
        <xsl:attribute name="href" select="@idref"/>
        <xsl:copy-of select="@type"/>
    </xsl:template>

    <xsl:template match="dtbook:annoref">
        <span>
            <xsl:call-template name="attlist.annoref"/>
            <xsl:apply-templates select="node()"/>
        </span>
    </xsl:template>

    <xsl:template name="attlist.annoref">
        <xsl:call-template name="attrs">
            <xsl:with-param name="types" select="'annoref'" tunnel="yes"/>
        </xsl:call-template>
        <xsl:attribute name="href" select="@idref"/>
        <xsl:copy-of select="@type"/>
    </xsl:template>

    <xsl:template match="dtbook:q">
        <q>
            <xsl:call-template name="attlist.q"/>
            <xsl:apply-templates select="node()"/>
        </q>
    </xsl:template>

    <xsl:template name="attlist.q">
        <xsl:call-template name="attrs"/>
        <xsl:copy-of select="@cite"/>
    </xsl:template>

    <xsl:template name="img">
        <img>
            <xsl:call-template name="attlist.img"/>
            <xsl:apply-templates select="node()"/>
        </img>
    </xsl:template>

    <xsl:template name="attlist.img">
        <xsl:call-template name="attrs"/>
        <xsl:copy-of select="@src|@alt|@longdesc|@height|@width"/>
        <xsl:if test="not(@longdesc) and @id">
            <xsl:variable name="id" select="@id"/>
            <xsl:variable name="longdesc" select="(//dtbook:prodnote|//dtbook:caption)[tokenize(@imgref,'\s+')=$id]"/>
            <xsl:if test="$longdesc">
                <xsl:attribute name="longdesc" select="concat('#',$longdesc[1]/((@id,generate-id(.))[1]))"/>
                <!-- if the image has multiple prodnotes or captions, only the first one will be referenced. -->
            </xsl:if>
        </xsl:if>
    </xsl:template>

    <xsl:template name="imggroup">
        <figure>
            <xsl:call-template name="attlist.imggroup"/>
            <xsl:apply-templates select="dtbook:prodnote|dtbook:img|dtbook:pagenum"/>
            <xsl:if test="dtbook:caption">
                <figcaption>
                    <xsl:for-each select="dtbook:caption">
                        <xsl:apply-templates select="."/>
                    </xsl:for-each>
                </figcaption>
            </xsl:if>
            <!--<oneOrMore>
                <choice>
                    <xsl:call-template name="prodnote"/>
                    <xsl:call-template name="img"/>
                    <xsl:call-template name="caption"/>
                    <xsl:call-template name="pagenum"/>
                </choice>
            </oneOrMore>-->
        </figure>
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

    <xsl:template name="covertitle">
        <h1>
            <xsl:call-template name="attlist.covertitle"/>
            <xsl:apply-templates select="node()"/>
        </h1>
    </xsl:template>

    <xsl:template name="attlist.covertitle">
        <xsl:call-template name="attrs">
            <xsl:with-param name="types" select="'z3998:covertitle'" tunnel="yes"/>
        </xsl:call-template>
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

    <xsl:template name="hd">
        <!--Use: hd marks the text of a heading in <level>, <poem>, <list>, <linegroup>,
         or <sidebar>. -->
        <xsl:choose>
            <xsl:when test="parent::dtbook:level">
                <!-- TODO -->
                <xsl:call-template name="attlist.hd"/>
                <xsl:apply-templates select="node()"/>
            </xsl:when>
            <xsl:when test="parent::dtbook:poem">
                <!-- TODO -->
                <xsl:call-template name="attlist.hd"/>
                <xsl:apply-templates select="node()"/>
            </xsl:when>
            <xsl:when test="parent::dtbook:list">
                <!-- TODO -->
                <xsl:call-template name="attlist.hd"/>
                <xsl:apply-templates select="node()"/>
            </xsl:when>
            <xsl:when test="parent::dtbook:linegroup">
                <!-- TODO -->
                <xsl:call-template name="attlist.hd"/>
                <xsl:apply-templates select="node()"/>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="attlist.hd">
        <xsl:call-template name="attrs"/>
    </xsl:template>

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
    
    <xsl:template match="dtbook:caption[parent::dtbook:imggroup]">
        <div>
            <xsl:call-template name="attlist.caption">
                <xsl:with-param name="classes" select="'imggroup-caption'" tunnel="yes"/>
            </xsl:call-template>
            <xsl:apply-templates select="node()"/>
        </div>
    </xsl:template>
    
    <xsl:template name="attlist.caption">
        <xsl:call-template name="attrs"/>
        <!-- @imgref is dropped, the relationship is preserved in the corresponding img/@longdesc -->
        <xsl:if test="not(@id)">
            <xsl:attribute name="id" select="generate-id(.)"/>
        </xsl:if>
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

    <xsl:function name="f:classes" as="xs:string*">
        <xsl:param name="element" as="element()"/>
        <xsl:sequence select="tokenize($element/@class,'\s+')"/>
    </xsl:function>

    <xsl:function name="f:level" as="xs:integer">
        <xsl:param name="element" as="element()"/>
        <xsl:variable name="level"
            select="count($element/ancestor-or-self::*[self::dtbook:level or self::dtbook:level1 or self::dtbook:level2 or self::dtbook:level3 or self::dtbook:level4 or self::dtbook:level5 or self::dtbook:level6])"/>
        <xsl:sequence select="min(($level, 6))"/>
    </xsl:function>

</xsl:stylesheet>
