<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" xmlns:px="http://www.daisy.org/ns/pipeline/xproc" xmlns:d="http://www.daisy.org/ns/pipeline/data"
    type="px:nordic-dtbook-to-html" name="main" version="1.0" xmlns:epub="http://www.idpf.org/2007/ops" xmlns:dtbook="http://www.daisy.org/z3986/2005/dtbook/" xmlns:html="http://www.w3.org/1999/xhtml"
    xmlns:cx="http://xmlcalabash.com/ns/extensions">

    <p:input port="fileset.in" primary="true"/>
    <p:input port="in-memory.in" sequence="true"/>

    <p:output port="fileset.out" primary="true">
        <p:pipe port="fileset.out" step="convert"/>
    </p:output>
    <p:output port="in-memory.out" sequence="true">
        <p:pipe port="in-memory.out" step="convert"/>
    </p:output>

    <p:option name="temp-dir" required="true"/>
    <p:option name="result-uri"/>

    <p:import href="../library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/fileset-utils/xproc/fileset-library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/common-utils/logging-library.xpl"/>

    <p:variable name="href" select="resolve-uri((//d:file[@media-type='application/x-dtbook+xml'])[1]/@href,base-uri(/))"/>
    <p:variable name="new-href" select="if (p:value-available('result-uri')) then $result-uri else if (ends-with($href,'.xml')) then replace($href,'\.xml$','.xhtml') else concat($href,'.xhtml')"/>

    <px:fileset-load media-type="application/x-dtbook+xml"/>
    <px:assert test-count-max="1" message="There are multiple DTBooks in the fileset; only the first one will be converted." severity="WARN"/>
    <px:assert test-count-min="1" message="There must be a DTBook file in the fileset." error-code="NORDICDTBOOKEPUB004"/>
    <p:split-sequence initial-only="true" test="position()=1"/>

    <!-- TODO: validate input DTBook -->

    <p:xslt>
        <p:input port="parameters">
            <p:empty/>
        </p:input>
        <p:input port="stylesheet">
            <p:document href="../../xslt/dtbook-to-epub3.xsl"/>
        </p:input>
    </p:xslt>
    
    <p:insert match="/html:html/html:head" position="last-child">
        <p:input port="insertion">
            <p:inline>
                <link xmlns="http://www.w3.org/1999/xhtml" rel="stylesheet" type="text/css" href="css/accessibility.css"/>
            </p:inline>
        </p:input>
    </p:insert>

    <p:add-attribute match="/*" attribute-name="xml:base">
        <p:with-option name="attribute-value" select="$new-href"/>
    </p:add-attribute>
    <p:delete match="/*/@xml:base"/>
    <p:identity name="result.in-memory"/>

    <!-- TODO: validate output HTML -->

    <px:mkdir name="mkdir">
        <p:with-option name="href" select="$temp-dir"/>
    </px:mkdir>
    <p:store name="store1" media-type="text/css" method="text" cx:depends-on="mkdir">
        <p:input port="source">
            <p:data href="../../css/accessibility.css" content-type="text/css"/>
        </p:input>
        <p:with-option name="href" select="concat($temp-dir,'style.css')"/>
    </p:store>
    <p:store name="store2" media-type="application/x-font-opentype" method="binary" cx:depends-on="mkdir">
        <p:input port="source">
            <p:data href="../../css/fonts/opendyslexic/OpenDyslexic-Regular.otf" content-type="application/x-font-opentype"/>
        </p:input>
        <p:with-option name="href" select="concat($temp-dir,'OpenDyslexic-Regular.otf')"/>
    </p:store>
    <p:store name="store3" media-type="application/x-font-opentype" method="binary" cx:depends-on="mkdir">
        <p:input port="source">
            <p:data href="../../css/fonts/opendyslexic/OpenDyslexic-Italic.otf" content-type="application/x-font-opentype"/>
        </p:input>
        <p:with-option name="href" select="concat($temp-dir,'OpenDyslexic-Italic.otf')"/>
    </p:store>
    <p:store name="store4" media-type="application/x-font-opentype" method="binary" cx:depends-on="mkdir">
        <p:input port="source">
            <p:data href="../../css/fonts/opendyslexic/OpenDyslexic-Bold.otf" content-type="application/x-font-opentype"/>
        </p:input>
        <p:with-option name="href" select="concat($temp-dir,'OpenDyslexic-Bold.otf')"/>
    </p:store>
    <p:store name="store5" media-type="application/x-font-opentype" method="binary" cx:depends-on="mkdir">
        <p:input port="source">
            <p:data href="../../css/fonts/opendyslexic/OpenDyslexic-BoldItalic.otf" content-type="application/x-font-opentype"/>
        </p:input>
        <p:with-option name="href" select="concat($temp-dir,'OpenDyslexic-BoldItalic.otf')"/>
    </p:store>
    <p:store name="store6" media-type="application/x-font-opentype" method="binary" cx:depends-on="mkdir">
        <p:input port="source">
            <p:data href="../../css/fonts/opendyslexic/OpenDyslexicMono-Regular.otf" content-type="application/x-font-opentype"/>
        </p:input>
        <p:with-option name="href" select="concat($temp-dir,'OpenDyslexicMono-Regular.otf')"/>
    </p:store>
    <p:store name="store7" media-type="text/plain" method="text" cx:depends-on="mkdir">
        <p:input port="source">
            <p:data href="../../css/fonts/opendyslexic/LICENSE.txt" content-type="text/plain"/>
        </p:input>
        <p:with-option name="href" select="concat($temp-dir,'LICENSE.txt')"/>
    </p:store>
    <p:identity name="store-dependency">
        <p:input port="source">
            <p:pipe port="result" step="store1"/>
            <p:pipe port="result" step="store2"/>
            <p:pipe port="result" step="store3"/>
            <p:pipe port="result" step="store4"/>
            <p:pipe port="result" step="store5"/>
            <p:pipe port="result" step="store6"/>
            <p:pipe port="result" step="store7"/>
        </p:input>
    </p:identity>

    <px:fileset-create>
        <p:with-option name="base" select="replace($new-base,'[^/]*$','')"/>
    </px:fileset-create>
    <px:fileset-add-entry media-type="application/xhtml+xml">
        <p:with-option name="href" select="replace($new-base,'^.*/([^/]*)$','$1')"/>
    </px:fileset-add-entry>
    <px:fileset-add-entry media-type="text/css">
        <p:with-option name="href" select="'accessibility.css'"/>
        <p:with-option name="original-href" select="concat($temp-dir,'accessibility.css')"/>
    </px:fileset-add-entry>
    <px:fileset-add-entry media-type="application/x-font-opentype">
        <p:with-option name="href" select="'css/fonts/opendyslexic/OpenDyslexic-Regular.otf'"/>
        <p:with-option name="original-href" select="concat($temp-dir,'OpenDyslexic-Regular.otf')"/>
    </px:fileset-add-entry>
    <px:fileset-add-entry media-type="application/x-font-opentype">
        <p:with-option name="href" select="'css/fonts/opendyslexic/OpenDyslexic-Italic.otf'"/>
        <p:with-option name="original-href" select="concat($temp-dir,'OpenDyslexic-Italic.otf')"/>
    </px:fileset-add-entry>
    <px:fileset-add-entry media-type="application/x-font-opentype">
        <p:with-option name="href" select="'css/fonts/opendyslexic/OpenDyslexic-Bold.otf'"/>
        <p:with-option name="original-href" select="concat($temp-dir,'OpenDyslexic-Bold.otf')"/>
    </px:fileset-add-entry>
    <px:fileset-add-entry media-type="application/x-font-opentype">
        <p:with-option name="href" select="'css/fonts/opendyslexic/OpenDyslexic-BoldItalic.otf'"/>
        <p:with-option name="original-href" select="concat($temp-dir,'OpenDyslexic-BoldItalic.otf')"/>
    </px:fileset-add-entry>
    <px:fileset-add-entry media-type="application/x-font-opentype">
        <p:with-option name="href" select="'css/fonts/opendyslexic/OpenDyslexicMono-Regular.otf'"/>
        <p:with-option name="original-href" select="concat($temp-dir,'OpenDyslexicMono-Regular.otf')"/>
    </px:fileset-add-entry>
    <p:identity name="result.fileset" cx:depends-on="store-dependency"/>

</p:declare-step>
