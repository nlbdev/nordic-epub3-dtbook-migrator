<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" xmlns:px="http://www.daisy.org/ns/pipeline/xproc" xmlns:d="http://www.daisy.org/ns/pipeline/data"
    type="px:nordic-dtbook-to-html.step" name="main" version="1.0" xmlns:epub="http://www.idpf.org/2007/ops" xmlns:dtbook="http://www.daisy.org/z3986/2005/dtbook/"
    xmlns:html="http://www.w3.org/1999/xhtml" xmlns:cx="http://xmlcalabash.com/ns/extensions" xmlns:pxi="http://www.daisy.org/ns/pipeline/xproc/internal/nordic-epub3-dtbook-migrator">

    <p:input port="fileset.in" primary="true">
        <p:empty/>
    </p:input>
    <p:input port="in-memory.in" sequence="true">
        <p:empty/>
    </p:input>
    <p:input port="report.in" sequence="true">
        <p:empty/>
    </p:input>
    <p:input port="status.in">
        <p:inline>
            <d:validation-status result="ok"/>
        </p:inline>
    </p:input>

    <p:output port="fileset.out" primary="true">
        <p:pipe port="fileset.out" step="choose"/>
    </p:output>
    <p:output port="in-memory.out" sequence="true">
        <p:pipe port="in-memory.out" step="choose"/>
    </p:output>

    <p:output port="report.out" sequence="true">
        <p:pipe port="report.in" step="main"/>
        <p:pipe port="report.out" step="choose"/>
    </p:output>
    <p:output port="status.out">
        <p:pipe port="result" step="status"/>
    </p:output>

    <p:option name="fail-on-error" select="'true'"/>
    <p:option name="temp-dir" required="true"/>

    <p:import href="validation-status.xpl"/>
    <p:import href="../upstream/fileset-utils/fileset-load.xpl"/>
    <p:import href="../upstream/fileset-utils/fileset-add-entry.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/fileset-utils/library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/file-utils/library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/common-utils/library.xpl"/>

    <px:assert message="'fail-on-error' whould be either 'true' or 'false'. was: '$1'. will default to 'true'.">
        <p:with-option name="param1" select="$fail-on-error"/>
        <p:with-option name="test" select="$fail-on-error = ('true','false')"/>
    </px:assert>

    <p:choose name="choose">
        <p:xpath-context>
            <p:pipe port="status.in" step="main"/>
        </p:xpath-context>
        <p:when test="/*/@result='ok' or $fail-on-error = 'false'">
            <p:output port="fileset.out" primary="true">
                <p:pipe port="result" step="result.fileset"/>
            </p:output>
            <p:output port="in-memory.out" sequence="true">
                <p:pipe port="result" step="result.in-memory"/>
            </p:output>
            <p:output port="report.out" sequence="true">
                <p:empty/>
            </p:output>










            <p:variable name="href" select="resolve-uri((//d:file[@media-type='application/x-dtbook+xml'])[1]/@href,base-uri(/))"/>
            <p:variable name="doc-base" select="base-uri(/)">
                <p:inline>
                    <irrelevant/>
                </p:inline>
            </p:variable>

            <pxi:fileset-load media-types="application/x-dtbook+xml">
                <p:input port="in-memory">
                    <p:pipe port="in-memory.in" step="main"/>
                </p:input>
            </pxi:fileset-load>
            <px:assert test-count-max="1" message="There are multiple DTBooks in the fileset; only the first one will be converted."/>
            <px:assert test-count-min="1" message="There must be a DTBook file in the fileset." error-code="NORDICDTBOOKEPUB004"/>
            <p:split-sequence initial-only="true" test="position()=1"/>
            <p:identity name="dtbook"/>

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
                    <p:inline exclude-inline-prefixes="#all">
                        <link xmlns="http://www.w3.org/1999/xhtml" rel="stylesheet" type="text/css" href="css/accessibility.css"/>
                    </p:inline>
                </p:input>
            </p:insert>
            <!-- TODO: add ASCIIMathML.js if there are asciimath elements -->

            <p:add-attribute match="/*" attribute-name="xml:base">
                <p:with-option name="attribute-value" select="concat($temp-dir,(//dtbook:meta[@name='dtb:uid']/@content,'missing-uid')[1],'.xhtml')">
                    <p:pipe port="result" step="dtbook"/>
                </p:with-option>
            </p:add-attribute>
            <p:identity name="result.in-memory"/>

            <px:mkdir name="mkdir">
                <p:with-option name="href" select="concat($temp-dir,'css/fonts/opendyslexic/')"/>
            </px:mkdir>
            <px:copy-resource name="store1" cx:depends-on="mkdir">
                <p:with-option name="href" select="resolve-uri('../../../css/accessibility.css',$doc-base)"/>
                <p:with-option name="target" select="concat($temp-dir,'css/accessibility.css')"/>
            </px:copy-resource>
            <px:copy-resource name="store2" cx:depends-on="mkdir">
                <p:with-option name="href" select="resolve-uri('../../../css/fonts/opendyslexic/OpenDyslexic-Regular.otf',$doc-base)"/>
                <p:with-option name="target" select="concat($temp-dir,'css/fonts/opendyslexic/OpenDyslexic-Regular.otf')"/>
            </px:copy-resource>
            <px:copy-resource name="store3" cx:depends-on="mkdir">
                <p:with-option name="href" select="resolve-uri('../../../css/fonts/opendyslexic/OpenDyslexic-Italic.otf',$doc-base)"/>
                <p:with-option name="target" select="concat($temp-dir,'css/fonts/opendyslexic/OpenDyslexic-Italic.otf')"/>
            </px:copy-resource>
            <px:copy-resource name="store4" cx:depends-on="mkdir">
                <p:with-option name="href" select="resolve-uri('../../../css/fonts/opendyslexic/OpenDyslexic-Bold.otf',$doc-base)"/>
                <p:with-option name="target" select="concat($temp-dir,'css/fonts/opendyslexic/OpenDyslexic-Bold.otf')"/>
            </px:copy-resource>
            <px:copy-resource name="store5" cx:depends-on="mkdir">
                <p:with-option name="href" select="resolve-uri('../../../css/fonts/opendyslexic/OpenDyslexic-BoldItalic.otf',$doc-base)"/>
                <p:with-option name="target" select="concat($temp-dir,'css/fonts/opendyslexic/OpenDyslexic-BoldItalic.otf')"/>
            </px:copy-resource>
            <px:copy-resource name="store6" cx:depends-on="mkdir">
                <p:with-option name="href" select="resolve-uri('../../../css/fonts/opendyslexic/OpenDyslexicMono-Regular.otf',$doc-base)"/>
                <p:with-option name="target" select="concat($temp-dir,'css/fonts/opendyslexic/OpenDyslexicMono-Regular.otf')"/>
            </px:copy-resource>
            <px:copy-resource name="store7" cx:depends-on="mkdir">
                <p:with-option name="href" select="resolve-uri('../../../css/fonts/opendyslexic/LICENSE.txt',$doc-base)"/>
                <p:with-option name="target" select="concat($temp-dir,'css/fonts/opendyslexic/LICENSE.txt')"/>
            </px:copy-resource>
            <!-- TODO: add ASCIIMathML.js if there are asciimath elements -->
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
            <p:sink/>

            <px:fileset-filter not-media-types="application/x-dtbook+xml text/css">
                <p:input port="source">
                    <p:pipe port="fileset.in" step="main"/>
                </p:input>
            </px:fileset-filter>
            <px:fileset-move>
                <p:with-option name="new-base" select="$temp-dir"/>
            </px:fileset-move>
            <p:viewport match="/*/*[starts-with(@media-type,'image/')]">
                <p:add-attribute match="/*" attribute-name="href">
                    <p:with-option name="attribute-value" select="concat('images/',/*/@href)"/>
                </p:add-attribute>
            </p:viewport>
            <p:identity name="fileset.existing-resources"/>

            <px:fileset-create>
                <p:with-option name="base" select="$temp-dir"/>
            </px:fileset-create>
            <pxi:fileset-add-entry media-type="text/css" href="css/accessibility.css"/>
            <pxi:fileset-add-entry media-type="application/x-font-opentype" href="css/fonts/opendyslexic/OpenDyslexic-Regular.otf"/>
            <pxi:fileset-add-entry media-type="application/x-font-opentype" href="css/fonts/opendyslexic/OpenDyslexic-Italic.otf"/>
            <pxi:fileset-add-entry media-type="application/x-font-opentype" href="css/fonts/opendyslexic/OpenDyslexic-Bold.otf"/>
            <pxi:fileset-add-entry media-type="application/x-font-opentype" href="css/fonts/opendyslexic/OpenDyslexic-BoldItalic.otf"/>
            <pxi:fileset-add-entry media-type="application/x-font-opentype" href="css/fonts/opendyslexic/OpenDyslexicMono-Regular.otf"/>
            <pxi:fileset-add-entry media-type="text/plain" href="css/fonts/opendyslexic/LICENSE.txt"/>
            <p:viewport match="/*/*">
                <p:add-attribute match="/*" attribute-name="original-href">
                    <p:with-option name="attribute-value" select="resolve-uri(/*/@href,base-uri(/*))"/>
                </p:add-attribute>
            </p:viewport>
            <pxi:fileset-add-entry media-type="application/xhtml+xml">
                <p:with-option name="href" select="base-uri(/*)">
                    <p:pipe port="result" step="result.in-memory"/>
                </p:with-option>
            </pxi:fileset-add-entry>
            <p:add-attribute match="//d:file[@media-type='application/xhtml+xml']" attribute-name="omit-xml-declaration" attribute-value="false"/>
            <p:add-attribute match="//d:file[@media-type='application/xhtml+xml']" attribute-name="version" attribute-value="1.0"/>
            <p:add-attribute match="//d:file[@media-type='application/xhtml+xml']" attribute-name="encoding" attribute-value="utf-8"/>
            <p:identity name="fileset.new-resources"/>
            <px:fileset-join>
                <p:input port="source">
                    <p:pipe port="result" step="fileset.existing-resources"/>
                    <p:pipe port="result" step="fileset.new-resources"/>
                </p:input>
            </px:fileset-join>
            <p:identity name="result.fileset" cx:depends-on="store-dependency"/>










        </p:when>
        <p:otherwise>
            <p:output port="fileset.out" primary="true"/>
            <p:output port="in-memory.out" sequence="true">
                <p:pipe port="fileset.in" step="main"/>
            </p:output>
            <p:output port="report.out" sequence="true">
                <p:empty/>
            </p:output>

            <p:identity/>
        </p:otherwise>
    </p:choose>

    <p:choose>
        <p:xpath-context>
            <p:pipe port="status.in" step="main"/>
        </p:xpath-context>
        <p:when test="/*/@result='ok'">
            <px:nordic-validation-status>
                <p:input port="source">
                    <p:pipe port="report.out" step="choose"/>
                </p:input>
            </px:nordic-validation-status>
        </p:when>
        <p:otherwise>
            <p:identity>
                <p:input port="source">
                    <p:pipe port="status.in" step="main"/>
                </p:input>
            </p:identity>
        </p:otherwise>
    </p:choose>
    <p:identity name="status"/>

</p:declare-step>
