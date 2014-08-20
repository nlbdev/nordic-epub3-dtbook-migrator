<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step type="pxi:epub3-nav-aggregate" xmlns:pxi="http://www.daisy.org/ns/pipeline/xproc/internal/nordic-epub3-dtbook-migrator" name="main" xmlns:p="http://www.w3.org/ns/xproc"
    xmlns:px="http://www.daisy.org/ns/pipeline/xproc" xmlns:d="http://www.daisy.org/ns/pipeline/data" xmlns:html="http://www.w3.org/1999/xhtml" version="1.0">

    <!--
        TODO: this is here until these are merged and released:
        https://github.com/daisy-consortium/pipeline-modules-common/pull/55
        https://github.com/daisy-consortium/pipeline-scripts-utils/pull/36
        https://github.com/daisy-consortium/pipeline-scripts-utils/pull/37
    -->

    <p:input port="source" sequence="true"/>
    <p:output port="result"/>

    <p:option name="title" select="''"/>
    <p:option name="language" select="''"/>
    <p:option name="css" select="''"/>

    <p:import href="http://www.daisy.org/pipeline/modules/common-utils/library.xpl"/>
    <p:import href="../../i18n-translate.xpl"/>

    <p:wrap-sequence wrapper="wrapper">
        <p:input port="source">
            <p:pipe port="source" step="main"/>
        </p:input>
    </p:wrap-sequence>
    <pxi:i18n-translate name="toc-string" id="Table of contents">
        <p:with-option name="language" select="( //html:head/html:meta[@name='dc:language']/@content , //html:html/@xml:lang , //*/@xml:lang , 'en' )[1]"/>
        <p:input port="maps">
            <p:document href="../i18n.xml"/>
        </p:input>
    </pxi:i18n-translate>
    <p:sink/>

    <p:identity>
        <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
                <html xmlns="http://www.w3.org/1999/xhtml" xmlns:epub="http://www.idpf.org/2007/ops">
                    <head>
                        <meta charset="UTF-8"/>
                        <title>Table of contents</title>
                        <link rel="stylesheet" type="text/css"/>
                    </head>
                    <body/>
                </html>
            </p:inline>
        </p:input>
    </p:identity>

    <!-- Translate "Table of contents" -->
    <p:replace match="//html:title/text()">
        <p:input port="replacement">
            <p:pipe port="result" step="toc-string"/>
        </p:input>
    </p:replace>
    <p:unwrap match="//html:title/*"/>
    <p:choose>
        <p:when test="$title=''">
            <p:identity/>
        </p:when>
        <p:otherwise>
            <p:string-replace match="//html:title/text()">
                <p:with-option name="replace" select="concat('&quot;',$title,'&quot;')"/>
            </p:string-replace>
        </p:otherwise>
    </p:choose>

    <!-- add xml:lang and lang attributes -->
    <p:add-attribute match="/*" attribute-name="xml:lang">
        <p:with-option name="attribute-value" select="if ($language) then $language else /*/@xml:lang">
            <p:pipe port="result" step="toc-string"/>
        </p:with-option>
    </p:add-attribute>
    <p:add-attribute match="/*" attribute-name="lang">
        <p:with-option name="attribute-value" select="if ($language) then $language else /*/@xml:lang">
            <p:pipe port="result" step="toc-string"/>
        </p:with-option>
    </p:add-attribute>

    <!-- add CSS -->
    <p:add-attribute match="//html:link" attribute-name="href">
        <p:with-option name="attribute-value" select="$css"/>
    </p:add-attribute>
    <p:delete match="//html:link[@href='']"/>

    <!-- insert navs into document -->
    <p:insert match="/*/html:body" position="last-child">
        <p:input port="insertion">
            <p:pipe step="main" port="source"/>
        </p:input>
    </p:insert>

</p:declare-step>
