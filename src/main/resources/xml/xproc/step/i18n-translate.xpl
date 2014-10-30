<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step type="pxi:i18n-translate" xmlns:pxi="http://www.daisy.org/ns/pipeline/xproc/internal/nordic-epub3-dtbook-migrator" xmlns:p="http://www.w3.org/ns/xproc"
    xmlns:c="http://www.w3.org/ns/xproc-step" xmlns:px="http://www.daisy.org/ns/pipeline/xproc" version="1.0" xmlns:d="http://www.daisy.org/ns/pipeline/data" name="main"
    xmlns:pf="http://www.daisy.org/ns/pipeline/functions">
    
    <!--
        TODO: this is here until these are merged and released:
        https://github.com/daisy-consortium/pipeline-modules-common/pull/55
    -->

    <p:documentation xmlns="http://www.w3.org/1999/xhtml">
        <p>This step invokes the <code>pf:i18n-translate</code> function (implemented in i18n-translate.xsl) with its options as arguments and returns the result as a <code>c:result</code>
            document.</p>
    </p:documentation>

    <p:option name="id" required="true">
        <p:documentation xmlns="http://www.w3.org/1999/xhtml">
            <p>The id of the translation.</p>
        </p:documentation>
    </p:option>

    <p:option name="language" required="true">
        <p:documentation xmlns="http://www.w3.org/1999/xhtml">
            <p>The preferred language (RFC5646). For instance "en" or "en-US".</p>
        </p:documentation>
    </p:option>

    <p:input port="maps" sequence="true">
        <p:documentation xmlns="http://www.w3.org/1999/xhtml">
            <p>The i18n XML documents.</p>
        </p:documentation>
    </p:input>

    <p:output port="result">
        <p:documentation xmlns="http://www.w3.org/1999/xhtml">
            <p>A <code>c:result</code> document whose content is the translation. Will be empty if no translation was found.</p>
        </p:documentation>
    </p:output>

    <p:wrap-sequence wrapper="d:maps"/>

    <p:xslt>
        <p:with-param name="id" select="$id"/>
        <p:with-param name="language" select="$language"/>
        <p:input port="stylesheet">
            <p:inline>
                <xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" version="2.0" exclude-result-prefixes="#all"
                    xmlns:d="http://www.daisy.org/ns/pipeline/data" xmlns:pf="http://www.daisy.org/ns/pipeline/functions">
                    <xsl:import href="../../xslt/i18n.xsl"/>
                    <xsl:param name="id" as="xs:string"/>
                    <xsl:param name="language" as="xs:string"/>
                    <xsl:template match="/*">
                        <c:result>
                            <xsl:value-of select="pf:i18n-translate($id, $language, /*/*)"/>
                        </c:result>
                    </xsl:template>
                </xsl:stylesheet>
            </p:inline>
        </p:input>
    </p:xslt>

</p:declare-step>
