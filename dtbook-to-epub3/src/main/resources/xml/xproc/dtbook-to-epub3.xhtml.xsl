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

    <xsl:template match="dtbook:sent">
        <span xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </span>
    </xsl:template>

    <xsl:template match="dtbook:p">
        <p xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </p>
    </xsl:template>
    
    <xsl:template match="dtbook:linegroup">
        <TODO xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </TODO>
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
        <li xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </li>
    </xsl:template>
    
    <xsl:template match="dtbook:meta">
        <meta xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </meta>
    </xsl:template>
    
    <xsl:template match="dtbook:noteref">
        <TODO xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </TODO>
    </xsl:template>
    
    <xsl:template match="dtbook:pagenum">
        <TODO xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </TODO>
    </xsl:template>
    
    <xsl:template match="dtbook:poem">
        <TODO xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </TODO>
    </xsl:template>
    
    <xsl:template match="dtbook:prodnote">
        <TODO xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </TODO>
    </xsl:template>
    
    <xsl:template match="dtbook:rearmatter">
        <div xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:attribute name="epub:type" select="'rearmatter'"/>
            <xsl:apply-templates select="node()"/>
        </div>
    </xsl:template>
    
    <xsl:template match="dtbook:sidebar">
        <TODO xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </TODO>
    </xsl:template>
    
    <xsl:template match="dtbook:level1 | dtbook:level2 | dtbook:level3 | dtbook:level4 | dtbook:level5 | dtbook:level6">
        <section xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </section>
    </xsl:template>
    
    <xsl:template match="dtbook:h1 | dtbook:h2 | dtbook:h3 | dtbook:h4 | dtbook:h5 | dtbook:h6">
        <xsl:element name="{local-name()}" namespace="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="dtbook:sub">
        <TODO xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </TODO>
    </xsl:template>
    
    <xsl:template match="dtbook:sup">
        <TODO xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </TODO>
    </xsl:template>
    
    <xsl:template match="dtbook:table">
        <table xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </table>
    </xsl:template>
    
    <xsl:template match="dtbook:td">
        <td xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </td>
    </xsl:template>
    
    <xsl:template match="dtbook:tr">
        <tr xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="class" select="string-join((concat('dtbook-',local-name()),@class),' ')"/>
            <xsl:apply-templates select="node()"/>
        </tr>
    </xsl:template>

</xsl:stylesheet>
