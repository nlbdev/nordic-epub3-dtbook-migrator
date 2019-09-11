<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:epub="http://www.idpf.org/2007/ops"
                xmlns:f="http://www.daisy.org/ns/pipeline/internal-functions"
                xmlns="http://www.w3.org/1999/xhtml"
                xpath-default-namespace="http://www.w3.org/1999/xhtml"
                exclude-result-prefixes="#all"
                version="2.0">
    
    <xsl:template match="@* | node()">
        <xsl:copy exclude-result-prefixes="#all">
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="/*">
        <xsl:copy exclude-result-prefixes="#all">
            <xsl:namespace name="epub" select="'http://www.idpf.org/2007/ops'"/>
            <xsl:copy-of select="@*" exclude-result-prefixes="#all"/>
            <xsl:attribute name="epub:prefix" select="string-join(f:prefixes(/*/head, /*/body, 'nordic'), ' ')"/>
            <xsl:apply-templates select="node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="/*/*//@epub:prefix"/>
    
    <xsl:function name="f:prefixes">
        <xsl:param name="head" as="element()?"/>
        <xsl:param name="body" as="element()?"/>
        <xsl:param name="other" as="xs:string*"/>
        <xsl:variable name="prefixes"
                      select="distinct-values(($other,
                                               if ($head) then f:head-prefixes($head) else (),
                                               if ($body) then f:body-prefixes($body) else ()))"/>
        <!--
            reserved prefixes can be omitted
        -->
        <xsl:variable name="prefixes" select="$prefixes[not(.=('dc','dcterms','marc','media','onix','xsd'))]"/>
        <!--
            get uri for each prefix
        -->
        <xsl:variable name="prefixes" select="for $prefix in ($prefixes) return
                                              concat($prefix, ': ', f:prefix-uri($prefix, ($head/parent::*, $head, $body)))"/>
        <!--
            drop invalid mappings
        -->
        <xsl:variable name="prefixes" select="for $prefix in ($prefixes) return
                                              if (matches($prefix, '^[^\s]+:\s*[^\s]+$')) then $prefix else ()"/>
        <xsl:sequence select="$prefixes"/>
    </xsl:function>
    
    <!--
        prefixes used in head (meta elements)
    -->
    <xsl:function name="f:head-prefixes" as="xs:string*">
        <xsl:param name="head" as="element()"/>
        <xsl:sequence select="distinct-values(for $name in ($head/*:meta/string(@name)) return
                                              if (contains($name, ':')) then substring-before($name, ':') else ())"/>
    </xsl:function>
    
    <!--
        prefixes used in body (epub:type attributes)
    -->
    <xsl:function name="f:body-prefixes" as="xs:string*">
        <xsl:param name="body" as="element()"/>
        <xsl:sequence select="distinct-values(for $type in ($body/descendant-or-self::*/tokenize(@epub:type, '\s+')) return
                                              if (contains($type, ':')) then substring-before($type, ':') else ())"/>
    </xsl:function>
    
    <xsl:variable name="known-prefixes" as="element()*">
        <vocab prefix="nordic" uri="http://www.mtm.se/epub/"/>
        <vocab prefix="z3998"  uri="http://www.daisy.org/z3998/2012/vocab/structure/#"/>
        <vocab prefix="a11y"   uri="http://www.idpf.org/epub/vocab/package/a11y/#"/>
        <vocab prefix="msv"    uri="http://www.idpf.org/epub/vocab/structure/magazine/#"/>
        <vocab prefix="prism"  uri="http://www.prismstandard.org/specifications/3.0/PRISM_CV_Spec_3.0.htm#"/>
        <vocab prefix="schema" uri="http://schema.org/"/>
    </xsl:variable>
    
    <xsl:function name="f:prefix-uri" as="xs:string">
        <xsl:param name="prefix" as="xs:string"/>
        <xsl:param name="contexts" as="element()*"/>
        <!--
            all prefixes declared in epub:prefix attributes of ancestor elements combined
        -->
        <xsl:variable name="existing-prefixes" as="xs:string"
                      select="string-join(($contexts/ancestor::*/descendant-or-self::*/@epub:prefix), ' ')" />
        <xsl:sequence select="if ($known-prefixes[@prefix=$prefix]) then $known-prefixes[@prefix=$prefix]/@uri
                              else if (concat($prefix,':') = tokenize($existing-prefixes, '\s+')[position() mod 2 = 1])
                                then replace($existing-prefixes, concat('(^|.*\s)', $prefix ,':\s*([^\s]+)(\s.*|$)'), '$2')
                              else string((for $context in ($contexts) return namespace-uri-for-prefix($prefix, $context))[1])"/>
    </xsl:function>
    
</xsl:stylesheet>
