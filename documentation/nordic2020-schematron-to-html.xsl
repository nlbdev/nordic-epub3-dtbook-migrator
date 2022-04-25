<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:sch="http://purl.oclc.org/dsdl/schematron" exclude-result-prefixes="#all" version="2.0">
    <xsl:template match="/">
        <html lang="en" xml:lang="en">
            <head>
                <title>Schematron rules for Nordic EPUB 2020-1</title>
                <style>
                    body{
                        font-family: Arial, Helvetica, sans-serif;
                        font-size: 12px;
                        max-width: 95%;
                        margin: auto;
                    }
                    h1{
                        text-align: center;
                        font-size: 1.5rem;
                        margin-top: 1rem;
                        margin-bottom: 2rem;
                    }
                    table,
                    th,
                    td{
                        border: 0.1rem solid #ddd;
                        border-collapse: collapse;
                        padding: 0.5rem;
                    }
                    table{
                        margin-bottom: 2rem
                    }
                    tr:nth-child(even){
                        background-color: #f2f2f2;
                    }
                    tbody tr:hover{
                        background-color: #ddd;
                    }
                    thead{
                        background-color: #1D393C;
                        color: white;
                    }
                    td:first-child{
                        white-space: nowrap;
                    }
                    footer{
                        margin-top: 1rem;
                        margin-bottom: 1rem;
                        text-align: center;
                        font-size: 0.8rem;
                    }</style>
            </head>
            <body>
                <h1>Schematron rules for Nordic EPUB 2020-1</h1>
                <table>
                    <thead>
                        <tr>
                            <th>Rule</th>
                            <th>Global description</th>
                            <th>Detailed description</th>
                        </tr>
                    </thead>
                    <tbody>
                        <xsl:for-each select="//sch:pattern">
                            <tr>
                                <td>
                                    <xsl:value-of select="substring(sch:title, 6)"/>
                                </td>
                                <td>
                                    <xsl:value-of select="sch:p"/>
                                </td>
                                <td>
                                    <xsl:for-each select="sch:rule/sch:report | sch:rule/sch:assert">
                                        <xsl:choose>
                                            <xsl:when test="not(following-sibling::sch:report or following-sibling::sch:assert)">
                                                <xsl:value-of select="."/>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:value-of select="."/>
                                                <br/>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:for-each>
                                    <br/>
                                </td>
                            </tr>
                        </xsl:for-each>
                    </tbody>
                </table>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
