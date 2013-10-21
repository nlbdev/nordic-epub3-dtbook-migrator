<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" xmlns:px="http://www.daisy.org/ns/pipeline/xproc" xmlns:d="http://www.daisy.org/ns/pipeline/data"
    type="px:nordic-dtbook-to-epub3" name="main" version="1.0" xmlns:epub="http://www.idpf.org/2007/ops" xmlns:dtbook="http://www.daisy.org/z3986/2005/dtbook/"
    xmlns:html="http://www.w3.org/1999/xhtml">

    <p:input port="fileset.in" primary="true"/>
    <p:input port="in-memory.in" sequence="true"/>

    <p:output port="fileset.out" primary="true"/>
    <p:output port="in-memory.out" sequence="true"/>

    <p:option name="temp-dir" required="true"/>
    <p:option name="output-dir" required="true"/>

    <p:import href="library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/html-utils/html-library.xpl"/>
    <!--    <p:import href="http://www.daisy.org/pipeline/modules/epub3-nav-utils/epub3-nav-library.xpl"/>-->
    <!--    <p:import href="http://www.daisy.org/pipeline/modules/epub3-ocf-utils/xproc/epub3-ocf-library.xpl"/>-->
    <!--    <p:import href="http://www.daisy.org/pipeline/modules/epub3-pub-utils/xproc/epub3-pub-library.xpl"/>-->
    <p:import href="http://www.daisy.org/pipeline/modules/fileset-utils/xproc/fileset-library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/common-utils/logging-library.xpl"/>

    <p:variable name="epub-dir" select="concat($temp-dir,'epub/')"/>
    <p:variable name="publication-dir" select="concat($epub-dir,'EPUB/')"/>
    <p:variable name="content-dir" select="concat($publication-dir,'Content/')"/>

    <px:fileset-load media-type="application/x-dtbook+xml">
        <p:input port="in-memory">
            <p:pipe port="in-memory.in" step="main"/>
        </p:input>
    </px:fileset-load>
    <px:assert test-count-min="1" test-count-max="1" message="There must be exactly one DTBook file in the fileset." error-code="NORDICDTBOOKEPUB001"/>
    <p:identity name="dtbook"/>

    <p:group>
        <p:variable name="dtbook-dir" select="replace(base-uri(/*),'/[^/]*$','/')"/>
        <p:variable name="epub-file-uri"
            select="concat(resolve((replace(replace(/dtbook:dtbook/dtbook:head/dtbook:meta[lower-case(@name)=('dc:title','dct:title','title')][1]/normalize-space(@content),'\s+',' '),'[^\w ]',''), replace(base-uri(/*),'^.*/([^/]*)\.?[^\.]*$','$1'))[not(.='')][1], $output-dir),'.epub')"/>
        
        <px:nordic-dtbook-to-html name="single-html"/>
        <px:nordic-html-split name="html"/>
        
        <!-- List auxiliary resources (i.e. images and stylesheets) -->
        <p:for-each>
            <px:html-to-fileset/>
        </p:for-each>
        <px:fileset-join name="resource-fileset"/>

        <!-- Create Navigation Document -->
        <p:group name="nav">
            <p:output port="result"/>

            <px:epub3-nav-create-toc name="nav.toc">
                <p:input port="source">
                    <p:pipe port="result" step="html"/>
                </p:input>
            </px:epub3-nav-create-toc>

            <px:epub3-nav-create-page-list name="nav.page-list">
                <p:input port="source">
                    <p:pipe port="result" step="html"/>
                </p:input>
            </px:epub3-nav-create-page-list>

            <px:epub3-nav-aggregate>
                <p:input port="source">
                    <p:pipe step="nav.toc" port="result"/>
                    <p:pipe step="nav.page-list" port="result"/>
                </p:input>
                <p:with-option name="language" select="/*/(@xml:lang,@lang)[1]">
                    <p:pipe port="result" step="single-html"/>
                </p:with-option>
            </px:epub3-nav-aggregate>
        </p:group>
        
        <!-- Create OPF metadata -->
        <p:xslt name="opf-metadata">
            <p:input port="parameters">
                <p:empty/>
            </p:input>
            <p:input port="source">
                <p:pipe port="result" step="single-html"/>
            </p:input>
            <p:input port="stylesheet">
                <p:document href="html-to-opf-metadata.xsl"/>
            </p:input>
        </p:xslt>

        <px:epub3-pub-create-package-doc>
            <p:with-option name="result-uri" select="$result-uri"/>
            <p:with-option name="compatibility-mode" select="$compatibility-mode"/>
            <p:with-option name="detect-properties" select="'false'"/>
            <p:input port="spine-filesets">
                <p:pipe port="result" step="html"/>
            </p:input>
            <p:input port="publication-resources">
                <p:pipe port="result" step="manifest"/>
            </p:input>
            <p:input port="metadata">
                <p:pipe port="result" step="opf-metadata"/>
            </p:input>
            <p:input port="content-docs">
                <p:pipe port="result" step="nav"/>
                <p:pipe port="result" step="html"/>
            </p:input>
            <p:input port="mediaoverlays">
                <p:empty/>
            </p:input>
        </px:epub3-pub-create-package-doc>

        <!--EPUB3:
     * html content documents
     * html nav doc
     * package doc
     * default CSS stylesheet-->

        <!--<p:xslt name="output-dir-uri">
        <p:with-param name="href" select="concat($output-dir,'/')"/>
        <p:input port="source">
            <p:inline>
                <d:file/>
            </p:inline>
        </p:input>
        <p:input port="stylesheet">
            <p:inline>
                <xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:pf="http://www.daisy.org/ns/pipeline/functions" version="2.0">
                    <xsl:import href="http://www.daisy.org/pipeline/modules/file-utils/xslt/uri-functions.xsl"/>
                    <xsl:param name="href" required="yes"/>
                    <xsl:template match="/*">
                        <xsl:copy>
                            <xsl:attribute name="href" select="pf:normalize-uri($href)"/>
                        </xsl:copy>
                    </xsl:template>
                </xsl:stylesheet>
            </p:inline>
        </p:input>
    </p:xslt>
    <p:sink/>-->

        <!--<p:group>
        <p:variable name="output-dir-uri" select="/*/@href">
            <p:pipe port="result" step="output-dir-uri"/>
        </p:variable>
        <p:variable name="epub-file-uri" select="concat($output-dir-uri,replace($input-uri,'^.*/([^/]*)\.[^/\.]*$','$1'),'.epub')"/>
        
        <p:xslt>
            <p:input port="parameters">
                <p:empty/>
            </p:input>
            <p:input port="stylesheet">
                <p:document href="dtbook-to-epub3.xhtml.xsl"/>
            </p:input>
        </p:xslt>
        
        <!-\- TODO: potentially split into one file per chapter -\->
        
        <p:store>
            <p:with-option name="href" select="concat($epub-file-uri,'.TODO.xml')"/>
        </p:store>
        <!-\-<px:epub3-store>
            <p:with-option name="href" select="$epub-file-uri"/>
            <p:input port="in-memory.in">
                <p:pipe port="in-memory.out" step="convert"/>
            </p:input>
        </px:epub3-store>-\->
    </p:group>-->

    </p:group>

</p:declare-step>
