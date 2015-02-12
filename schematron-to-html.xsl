<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.w3.org/1999/xhtml" xmlns:html="http://www.w3.org/1999/xhtml"
    xmlns:sch="http://purl.oclc.org/dsdl/schematron" exclude-result-prefixes="#all" version="2.0">

    <xsl:template match="text()"/>

    <xsl:template match="sch:schema">
        <html>
            <head>
                <meta charset="utf-8"/>
                <title>
                    <xsl:value-of select="replace(string-join(sch:title//text(),''),' ?\([^\)]*\)','')"/>
                </title>
                <link href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css" rel="stylesheet"/>
            </head>
            <body>
                <div class="container">
                    <h1>
                        <xsl:value-of select="replace(string-join(sch:title//text(),''),' ?\([^\)]*\)','')"/>
                        <xsl:for-each select="tokenize(string-join(sch:title//text(),''),' ?\(')">
                            <xsl:if test="position() &gt; 1">
                                <br/>
                                <small>
                                    <xsl:value-of select="replace(.,'^(.*)\)[^\)]*$','$1')"/>
                                </small>
                            </xsl:if>
                        </xsl:for-each>
                    </h1>
                    <!--<xsl:if test="sch:ns">
                        <section>
                            <h2>Namespaces used</h2>
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>Prefix</th>
                                        <th>URI</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <xsl:apply-templates select="sch:ns"/>
                                </tbody>
                            </table>
                        </section>
                    </xsl:if>
                    <h2>Validation rules</h2>-->
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Rule ID</th>
                                <th>Rule description</th>
                            </tr>
                        </thead>
                        <tbody>
                            <xsl:apply-templates select="* except (sch:title | sch:ns)"/>
                        </tbody>
                    </table>
                    <br/>
                    <footer>
                        <em>Last updated: <xsl:value-of select="replace(replace(string(current-dateTime()),'(T|Z)',' '),'(\..*|\+.*)','')"/></em>
                    </footer>
                    <br/>
                    <br/>
                    <br/>
                </div>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="sch:title">
        <xsl:value-of select="text()"/>
    </xsl:template>

    <xsl:template match="sch:ns">
        <tr>
            <td>
                <xsl:value-of select="@prefix"/>
            </td>
            <td>
                <xsl:value-of select="@uri"/>
            </td>
        </tr>
    </xsl:template>

    <xsl:template match="sch:pattern">
        <xsl:apply-templates select="sch:rule"/>
    </xsl:template>

    <xsl:template match="sch:rule">
        <xsl:apply-templates select="sch:assert | sch:report"/>
    </xsl:template>

    <xsl:template match="sch:assert | sch:report">
        <tr>
            <td>
                <xsl:choose>
                    <xsl:when test="matches(text()[1],'^\[[^\]]*\]')">
                        <code>
                            <xsl:value-of select="replace(text()[1],'^\[([^\]]*)\].*$','$1','s')"/>
                        </code>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>Missing rule ID</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </td>
            <td>
                <xsl:for-each select="node()">
                    <xsl:choose>
                        <xsl:when test="self::*">
                            <xsl:text>...</xsl:text>
                        </xsl:when>
                        <xsl:when test="self::text()[not(preceding-sibling::text())]">
                            <xsl:value-of select="replace(.,'^\[[^\]]*\](.*)$','$1','s')"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:copy-of select="."/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:for-each>
            </td>
        </tr>
    </xsl:template>

</xsl:stylesheet>
