<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0" xmlns:dtbook="http://www.daisy.org/z3986/2005/dtbook/" exclude-result-prefixes="#all" xmlns:epub="http://www.idpf.org/2007/ops">

    <xsl:output method="xml"/>

    <xsl:template match="@*|text()|comment()|*">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="dtbook:*">
        <div xmlns="http://www.w3.org/1999/xhtml" data-TODO="this element does not have a XSLT template yet">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </div>
    </xsl:template>

    <xsl:template match="dtbook:dtbook">
        <html xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </html>
    </xsl:template>

    <xsl:template match="dtbook:head">
        <head xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </head>
    </xsl:template>

    <xsl:template match="dtbook:link">
        <link xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </link>
    </xsl:template>

    <xsl:template match="dtbook:meta">
        <meta xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </meta>
    </xsl:template>

    <xsl:template match="dtbook:book">
        <body xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </body>
    </xsl:template>

    <xsl:template match="dtbook:frontmatter">
        <section xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:attribute name="epub:type" select="'frontmatter'"/>
            <xsl:apply-templates select="node()"/>
        </section>
    </xsl:template>

    <xsl:template match="dtbook:bodymatter">
        <section xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:attribute name="epub:type" select="'bodymatter'"/>
            <xsl:apply-templates select="node()"/>
        </section>
    </xsl:template>

    <xsl:template match="dtbook:rearmatter">
        <section xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:attribute name="epub:type" select="'rearmatter'"/>
            <xsl:apply-templates select="node()"/>
        </section>
    </xsl:template>

    <xsl:template match="dtbook:level | dtbook:level1 | dtbook:level2 | dtbook:level3 | dtbook:level4 | dtbook:level5 | dtbook:level6">
        <section xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </section>
    </xsl:template>

    <xsl:template match="dtbook:br">
        <br xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </br>
    </xsl:template>

    <xsl:template match="dtbook:line">
        <span xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </span>
        <br/>
    </xsl:template>

    <xsl:template match="dtbook:linegroup">
        <p xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </p>
    </xsl:template>
    
    <xsl:template match="dtbook:linenum">
        <TODO xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </TODO>
    </xsl:template>

    <xsl:template match="dtbook:address">
        <address xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </address>
    </xsl:template>
    
    <xsl:template match="dtbook:div">
        <div xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </div>
    </xsl:template>

    <xsl:template match="dtbook:title">
        <!-- used in poem and cite -->
        <span xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </span>
    </xsl:template>

    <xsl:template match="dtbook:author">
        <span xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </span>
    </xsl:template>

    <xsl:template match="dtbook:prodnote">
        <div xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </div>
    </xsl:template>

    <xsl:template match="dtbook:sidebar">
        <aside xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </aside>
    </xsl:template>

    <xsl:template match="dtbook:note">
        <div xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </div>
    </xsl:template>

    <xsl:template match="dtbook:annotation">
        <span xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </span>
    </xsl:template>
    
    <xsl:template match="dtbook:epigraph">
        <div xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </div>
    </xsl:template>
    
    <xsl:template match="dtbook:byline">
        <span xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </span>
    </xsl:template>
    
    <xsl:template match="dtbook:dateline">
        <span xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </span>
    </xsl:template>
    
    <xsl:template match="dtbook:linegroup">
        <p xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </p>
    </xsl:template>
    
    <xsl:template match="dtbook:poem">
        <p xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </p>
    </xsl:template>
    
    <xsl:template match="dtbook:a">
        <a xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </a>
    </xsl:template>
    
    <xsl:template match="dtbook:em">
        <em xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </em>
    </xsl:template>
    
    <xsl:template match="dtbook:strong">
        <strong xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </strong>
    </xsl:template>
    
    <xsl:template match="dtbook:dfn">
        <dfn xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </dfn>
    </xsl:template>
    
    <xsl:template match="dtbook:kbd">
        <kbd xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </kbd>
    </xsl:template>
    
    <xsl:template match="dtbook:code">
        <code xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </code>
    </xsl:template>
    
    <xsl:template match="dtbook:samp">
        <p xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </p>
    </xsl:template>
    
    <xsl:template match="dtbook:cite">
        <cite xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </cite>
    </xsl:template>

    <xsl:template match="dtbook:abbr">
        <abbr xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </abbr>
    </xsl:template>
    
    <xsl:template match="dtbook:acronym">
        <abbr xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </abbr>
    </xsl:template>

    <xsl:template match="dtbook:sub">
        <sub xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </sub>
    </xsl:template>
    
    <xsl:template match="dtbook:sup">
        <sup xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </sup>
    </xsl:template>
    
    <xsl:template match="dtbook:span">
        <span xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </span>
    </xsl:template>

    <xsl:template match="dtbook:bdo">
        <bdo xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </bdo>
    </xsl:template>
    
    <xsl:template match="dtbook:sent">
        <span xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </span>
    </xsl:template>
    
    <xsl:template match="dtbook:w">
        <span xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </span>
    </xsl:template>
    
    <xsl:template match="dtbook:pagenum">
        <span xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </span>
    </xsl:template>
    
    <xsl:template match="dtbook:noteref">
        <span xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </span>
    </xsl:template>
    
    <xsl:template match="dtbook:annoref">
        <span xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </span>
    </xsl:template>
    
    <xsl:template match="dtbook:q">
        <q xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </q>
    </xsl:template>
    
    <xsl:template match="dtbook:img">
        <img xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </img>
    </xsl:template>
    
    <xsl:template match="dtbook:imggroup">
        <figure xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </figure>
    </xsl:template>
    
    <xsl:template match="dtbook:p">
        <p xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </p>
    </xsl:template>
    
    <xsl:template match="dtbook:doctitle">
        <h1 xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:attribute name="epub:type" select="'fulltitle'"/>
            <xsl:apply-templates select="node()"/>
        </h1>
    </xsl:template>
    
    <xsl:template match="dtbook:docauthor">
        <p xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </p>
    </xsl:template>
    
    <xsl:template match="dtbook:covertitle">
        <p xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </p>
    </xsl:template>
    
    <xsl:template match="dtbook:h1 | dtbook:h2 | dtbook:h3 | dtbook:h4 | dtbook:h5 | dtbook:h6">
        <xsl:element name="{local-name()}" namespace="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="dtbook:bridgehead">
        <p xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </p>
    </xsl:template>
    
    <xsl:template match="dtbook:hd">
        <hd xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </hd>
    </xsl:template>
    
    <xsl:template match="dtbook:blockquote">
        <blockquote xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </blockquote>
    </xsl:template>
    
    <xsl:template match="dtbook:dl">
        <dl xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </dl>
    </xsl:template>

    <xsl:template match="dtbook:dt">
        <dt xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </dt>
    </xsl:template>

    <xsl:template match="dtbook:dd">
        <dd xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </dd>
    </xsl:template>

    <xsl:template match="dtbook:list">
        <ul xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </ul>
    </xsl:template>

    <xsl:template match="dtbook:li">
        <li xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </li>
    </xsl:template>

    <xsl:template match="dtbook:lic">
        <span xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </span>
    </xsl:template>
    
    <xsl:template match="dtbook:table">
        <table xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </table>
    </xsl:template>
    
    <xsl:template match="dtbook:caption">
        <figcaption xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </figcaption>
    </xsl:template>
    
    <xsl:template match="dtbook:thead">
        <thead xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </thead>
    </xsl:template>
    
    <xsl:template match="dtbook:tfoot">
        <tfoot xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </tfoot>
    </xsl:template>
    
    <xsl:template match="dtbook:tbody">
        <span xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </span>
    </xsl:template>
    
    <xsl:template match="dtbook:colgroup">
        <colgroup xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </colgroup>
    </xsl:template>
    
    <xsl:template match="dtbook:col">
        <col xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </col>
    </xsl:template>
    
    <xsl:template match="dtbook:tr">
        <tr xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </tr>
    </xsl:template>
    
    <xsl:template match="dtbook:th">
        <th xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </th>
    </xsl:template>
    
    <xsl:template match="dtbook:td">
        <td xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </td>
    </xsl:template>

</xsl:stylesheet>
