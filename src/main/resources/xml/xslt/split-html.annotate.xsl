<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:f="http://www.daisy.org/ns/pipeline/internal-functions" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0" xmlns:epub="http://www.idpf.org/2007/ops"
    xmlns="http://www.w3.org/1999/xhtml" xpath-default-namespace="http://www.w3.org/1999/xhtml" exclude-result-prefixes="#all" xmlns:xs="http://www.w3.org/2001/XMLSchema">

    <xsl:param name="output-dir" required="yes"/>

    <xsl:template match="/*">

        <xsl:variable name="partition-types" select="('cover','frontmatter','bodymatter','backmatter')"/>
        <xsl:variable name="division-types"
            select="('acknowledgments','afterword','appendix','assessment','bibliography','z3998:biographical-note','chapter','colophon','conclusion','contributors','copyright-page','dedication','z3998:discography','division','z3998:editorial-note','epigraph','epilogue','errata','z3998:filmography','footnotes','foreword','glossary','z3998:grant-acknowledgment','halftitlepage','imprimatur','imprint','index','index-group','index-headnotes','index-legend','introduction','landmarks','loa','loi','lot','lov','notice','other-credits','page-list','part','practices','preamble','preface','prologue','z3998:promotional-copy','z3998:published-works','z3998:publisher-address','qna','rearnotes','revision-history','z3998:section','standard','subchapter','z3998:subsection','titlepage','toc','z3998:translator-note','volume','warning')"/>
        <xsl:variable name="identifier" select="(//html/head/meta[@name='dc:identifier']/string(@content))[1]"/>
        <xsl:variable name="padding-size" select="string-length(string(count(/*/body/(section|article|section[tokenize(@epub:type,'\s+')='part']/(section|article)))))"/>

        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:attribute name="xml:base" select="base-uri(/*)"/>
            <xsl:copy-of select="head"/>
            <xsl:for-each select="body">
                <xsl:copy>
                    <xsl:copy-of select="@*"/>
                    <xsl:for-each select="section | article | section[tokenize(@epub:type,'\s+')='part']/(section|article)">
                        <xsl:copy>
                            <xsl:variable name="types" select="f:types(.)"/>
                            <xsl:variable name="partition" select="(f:types(.)[.=$partition-types], 'bodymatter')[1]"/>
                            <xsl:variable name="division" select="if (count($types[.=$division-types])) then ($types[.=$division-types])[1] else if ($partition='bodymatter') then 'chapter' else ()"/>
                            <xsl:variable name="filename"
                                select="concat($identifier,'-',f:zero-pad(string(position()),$padding-size),'-',if ($division) then tokenize($division,':')[last()] else $partition)"/>

                            <xsl:copy-of select="@*"/>
                            <xsl:attribute name="xml:base" select="concat($output-dir,$filename,'.xhtml')"/>
                            <xsl:attribute name="epub:type" select="string-join(($partition, $division, $types[not(.=($partition-types,$division-types))]),' ')"/>

                            <xsl:choose>
                                <xsl:when test="$division='part'">
                                    <xsl:copy-of select="node()[not(self::section) and not(self::article)]"/>

                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:copy-of select="node()"/>

                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:copy>
                    </xsl:for-each>
                </xsl:copy>
            </xsl:for-each>

        </xsl:copy>
    </xsl:template>

    <xsl:function name="f:types" as="xs:string*">
        <xsl:param name="element" as="element()"/>
        <xsl:sequence select="tokenize($element/@epub:type,'\s+')"/>
    </xsl:function>

    <xsl:function name="f:zero-pad" as="xs:string">
        <xsl:param name="text" as="xs:string"/>
        <xsl:param name="desired-length" as="xs:integer"/>
        <xsl:sequence select="concat(string-join(for $i in (string-length($text)+1 to $desired-length) return '0',''),$text)"/>
    </xsl:function>

</xsl:stylesheet>
