<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0" xmlns:d="http://www.daisy.org/ns/pipeline/data">

    <xsl:template match="/*">
        <xsl:copy>
            <xsl:for-each select="*">
                <xsl:if test="(parent::*/* except .)/@id = @id">
                    <d:error>
                        <d:desc>
                            <xsl:value-of
                                select="concat('Duplicate id: ',@xml:base,'#',@id,' ...already exists in... ',string-join(for $e in ((parent::*/* except .)[@id=current()/@id]) return concat($e/@xml:base,'#',$e/@id),' and '))"
                            />
                        </d:desc>
                        <d:file>
                            <xsl:value-of select="@xml:base"/>
                        </d:file>
                        <d:was>
                            <xsl:value-of select="@id"/>
                        </d:was>
                    </d:error>
                </xsl:if>
            </xsl:for-each>
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>
