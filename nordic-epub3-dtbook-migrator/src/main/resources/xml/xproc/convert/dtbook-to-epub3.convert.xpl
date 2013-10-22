<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" xmlns:px="http://www.daisy.org/ns/pipeline/xproc" xmlns:d="http://www.daisy.org/ns/pipeline/data"
    type="px:nordic-dtbook-to-epub3" name="main" version="1.0" xmlns:epub="http://www.idpf.org/2007/ops" xmlns:dtbook="http://www.daisy.org/z3986/2005/dtbook/"
    xmlns:html="http://www.w3.org/1999/xhtml">
    
    <p:input port="fileset.in" primary="true"/>
    <p:input port="in-memory.in" sequence="true"/>

    <p:output port="fileset.out" primary="true">
        <p:pipe port="fileset.out" step="convert"/>
    </p:output>
    <p:output port="in-memory.out" sequence="true">
        <p:pipe port="in-memory.out" step="convert"/>
    </p:output>

    <p:option name="temp-dir" required="true"/>
    <p:option name="output-dir" required="true"/>

    <p:import href="../library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/html-utils/html-library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/epub3-nav-utils/epub3-nav-library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/epub3-pub-utils/xproc/epub3-pub-library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/epub3-ocf-utils/xproc/epub3-ocf-library.xpl"/>
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

    <p:group name="convert">
        <p:output port="fileset.out">
            <p:pipe port="result" step="result.fileset"/>
        </p:output>
        <p:output port="in-memory.out">
            <p:pipe port="result" step="result.in-memory"/>
        </p:output>
        
        <p:variable name="dtbook-dir" select="replace(base-uri(/*),'/[^/]*$','/')"/>
        
        <!-- Convert from a single DTBook file to multiple HTML files -->
        <px:nordic-dtbook-to-html-convert name="single-html">
            <p:with-option name="temp-dir" select="concat($temp-dir,'dtbook-to-html/')"/>
            <p:with-option name="result-uri" select="concat($content-dir,'content.xhtml')"/>
        </px:nordic-dtbook-to-html-convert>
        <px:nordic-html-split-perform name="html">
            <p:input port="in-memory.in">
                <p:pipe port="in-memory.out" step="single-html"/>
            </p:input>
        </px:nordic-html-split-perform>
        
        <!-- Create spine -->
        <p:for-each>
            <p:variable name="base" select="base-uri(/*)"/>
            <px:fileset-create>
                <p:with-option name="base" select="replace($base,'[^/]*$','')"/>
            </px:fileset-create>
            <px:fileset-add-entry media-type="application/xhtml+xml">
                <p:with-option name="href" select="replace($base,'^.*([^/]*)$','$1')"/>
            </px:fileset-add-entry>
        </p:for-each>
        <p:identity name="spine"/>

        <!-- Create OPF metadata -->
        <p:xslt name="opf-metadata">
            <p:input port="parameters">
                <p:empty/>
            </p:input>
            <p:input port="source">
                <p:pipe port="result" step="single-html"/>
            </p:input>
            <p:input port="stylesheet">
                <p:document href="../../xslt/html-to-opf-metadata.xsl"/>
            </p:input>
        </p:xslt>

        <!-- Create Navigation Document -->
        <p:group name="nav">
            <p:output port="html">
                <p:pipe port="result" step="nav.html"/>
            </p:output>
            <p:output port="ncx">
                <p:pipe port="result" step="nav.ncx"/>
            </p:output>

            <px:epub3-nav-create-toc name="nav.toc">
                <p:with-option name="base-dir" select="$publication-dir"/>
                <p:input port="source">
                    <p:pipe port="result" step="html"/>
                </p:input>
            </px:epub3-nav-create-toc>

            <px:epub3-nav-create-page-list name="nav.page-list">
                <p:with-option name="base-dir" select="$publication-dir"/>
                <p:input port="source">
                    <p:pipe port="result" step="html"/>
                </p:input>
            </px:epub3-nav-create-page-list>

            <px:epub3-nav-aggregate name="nav.html">
                <p:input port="source">
                    <p:pipe step="nav.toc" port="result"/>
                    <p:pipe step="nav.page-list" port="result"/>
                </p:input>
                <p:with-option name="language" select="/*/(@xml:lang,@lang)[1]">
                    <p:pipe port="result" step="single-html"/>
                </p:with-option>
            </px:epub3-nav-aggregate>
            <p:add-attribute match="/*" attribute-name="xml:base">
                <p:with-option name="attribute-value" select="concat($publication-dir,'navigation.xhtml')"/>
            </p:add-attribute>
            
            <p:xslt name="nav.ncx">
                <p:input port="parameters">
                    <p:empty/>
                </p:input>
                <p:input port="stylesheet">
                    <p:document href="http://www.daisy.org/pipeline/modules/epub3-nav-utils/nav-to-ncx.xsl"/>
                </p:input>
            </p:xslt>
            <p:add-attribute match="/*" attribute-name="xml:base">
                <p:with-option name="attribute-value" select="concat($publication-dir,'ncx.xml')"/>
            </p:add-attribute>
        </p:group>
        
        <!-- List auxiliary resources (i.e. all non-content files: images, CSS, NCX, etc.) -->
        <p:for-each>
            <p:iteration-source>
                <p:pipe port="html" step="nav"/>
                <p:pipe port="result" step="html"/>
            </p:iteration-source>
            <px:html-to-fileset/>
        </p:for-each>
        <p:identity name="html-filesets"/>
        <px:fileset-create>
            <p:with-option name="base" select="replace(base-uri(/*),'[^/]*$','')">
                <p:pipe port="ncx" step="nav"/>
            </p:with-option>
        </px:fileset-create>
        <px:fileset-add-entry media-type="application/x-dtbncx+xml">
            <p:with-option name="href" select="'ncx.xml'"/>
        </px:fileset-add-entry>
        <p:identity name="ncx-fileset"/>
        <px:fileset-join name="resource-fileset">
            <p:input port="source">
                <p:pipe port="result" step="ncx-fileset"/>
                <p:pipe port="result" step="html-filesets"/>
            </p:input>
        </px:fileset-join>

        <px:epub3-pub-create-package-doc name="package">
            <p:with-option name="result-uri" select="$result-uri"/>
            <p:with-option name="compatibility-mode" select="$compatibility-mode"/>
            <p:with-option name="detect-properties" select="'false'"/>
            <p:input port="spine-filesets">
                <p:pipe port="result" step="spine"/>
            </p:input>
            <p:input port="metadata">
                <p:pipe port="result" step="opf-metadata"/>
            </p:input>
            <p:input port="content-docs">
                <p:pipe port="result" step="nav"/>
                <p:pipe port="result" step="html"/>
            </p:input>
            <p:input port="publication-resources">
                <p:pipe port="result" step="resource-fileset"/>
            </p:input>
        </px:epub3-pub-create-package-doc>
        
        <p:for-each name="result.for-each">
            <p:output port="in-memory">
                <p:pipe port="result" step="result.for-each.in-memory"/>
            </p:output>
            <p:output port="fileset">
                <p:pipe port="result" step="result.for-each.fileset"/>
            </p:output>
            <p:iteration-source>
                <p:pipe port="html" step="nav"/>
                <p:pipe port="ncx" step="nav"/>
                <p:pipe port="result" step="html"/>
                <p:pipe port="opf-package" step="package"/>
            </p:iteration-source>
            <p:delete match="/*/@original-href | /*/@xml:base"/>
            <p:identity name="result.for-each.in-memory"/>
            <p:add-attribute match="/*" attribute-name="href">
                <p:with-option name="attribute-value" select="base-uri(/*)">
                    <p:pipe port="current" step="result.for-each"/>
                </p:with-option>
                <p:input port="source">
                    <p:inline exclude-inline-prefixes="#all">
                        <d:file/>
                    </p:inline>
                </p:input>
            </p:add-attribute>
            <p:choose>
                <p:when test="/*/@original-href">
                    <p:xpath-context>
                        <p:pipe port="current" step="result.for-each"/>
                    </p:xpath-context>
                    <p:add-attribute match="/*" attribute-name="original-href">
                        <p:with-option name="attribute-value" select="/*/@original-href">
                            <p:pipe port="current" step="result.for-each"/>
                        </p:with-option>
                    </p:add-attribute>
                </p:when>
                <p:otherwise>
                    <p:identity/>
                </p:otherwise>
            </p:choose>
            
            <p:wrap-sequence wrapper="d:fileset"/>
            <p:add-attribute match="/*" attribute-name="xml:base">
                <p:with-option name="attribute-value" select="$epub-dir"/>
            </p:add-attribute>
            <p:identity name="result.for-each.fileset"/>
        </p:for-each>
        
        <px:fileset-join>
            <p:input port="source">
                <p:pipe port="fileset" step="result.for-each"/>
                <p:pipe port="fileset" step="resources"/>
            </p:input>
        </px:fileset-join>
        <px:mediatype-detect>
            <p:input port="in-memory">
                <p:pipe port="in-memory" step="result.for-each"/>
            </p:input>
        </px:mediatype-detect>
        <p:identity name="result.fileset-without-ocf-files"/>
        <p:sink/>
        
        <px:epub3-ocf-finalize name="finalize">
            <p:input port="source">
                <p:pipe port="result" step="result.fileset-without-ocf-files"/>
            </p:input>
        </px:epub3-ocf-finalize>
        <px:fileset-join>
            <p:input port="source">
                <p:pipe port="result" step="finalize"/>
                <p:pipe port="result" step="result.fileset-without-ocf-files"/>
            </p:input>
        </px:fileset-join>
        <p:identity name="result.fileset"/>
        <p:sink/>
        
        <p:identity name="result.in-memory">
            <p:input port="source">
                <p:pipe port="in-memory" step="result.for-each"/>
                <p:pipe port="in-memory.out" step="finalize"/>
            </p:input>
        </p:identity>
        <p:sink/>

    </p:group>

</p:declare-step>
