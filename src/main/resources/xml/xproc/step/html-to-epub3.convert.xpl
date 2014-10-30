<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" xmlns:px="http://www.daisy.org/ns/pipeline/xproc" xmlns:d="http://www.daisy.org/ns/pipeline/data"
    type="px:nordic-html-to-epub3-convert" name="main" version="1.0" xmlns:epub="http://www.idpf.org/2007/ops" xmlns:dtbook="http://www.daisy.org/z3986/2005/dtbook/"
    xmlns:html="http://www.w3.org/1999/xhtml" xmlns:opf="http://www.idpf.org/2007/opf" xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmlns:pxi="http://www.daisy.org/ns/pipeline/xproc/internal/nordic-epub3-dtbook-migrator">


    <p:input port="fileset.in" primary="true"/>
    <p:input port="in-memory.in" sequence="true"/>

    <p:output port="fileset.out" primary="true">
        <p:pipe port="result" step="result.fileset"/>
    </p:output>
    <p:output port="in-memory.out" sequence="true">
        <p:pipe port="result" step="result.in-memory"/>
    </p:output>

    <p:option name="temp-dir" required="true"/>
    <p:option name="compatibility-mode" select="'true'"/>

    <p:import href="html-split.split.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/html-utils/library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/epub3-nav-utils/library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/epub3-pub-utils/library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/epub3-ocf-utils/library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/fileset-utils/library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/common-utils/library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/mediatype-utils/library.xpl"/>

    <p:variable name="epub-dir" select="concat($temp-dir,'epub/')"/>
    <p:variable name="publication-dir" select="concat($epub-dir,'EPUB/')"/>

    <px:nordic-html-split-perform name="html-split">
        <p:input port="in-memory.in">
            <p:pipe port="in-memory.in" step="main"/>
        </p:input>
    </px:nordic-html-split-perform>
    <px:fileset-move name="html-split.moved">
        <p:input port="in-memory.in">
            <p:pipe port="in-memory.out" step="html-split"/>
        </p:input>
        <p:with-option name="new-base" select="$publication-dir"/>
    </px:fileset-move>

    <!-- Create spine -->
    <px:fileset-filter media-types="application/xhtml+xml"/>
    <p:identity name="spine"/>

    <px:fileset-load name="spine-html">
        <p:input port="in-memory">
            <p:pipe port="in-memory.out" step="html-split.moved"/>
        </p:input>
    </px:fileset-load>

    <px:fileset-load media-types="application/xhtml+xml">
        <p:input port="fileset">
            <p:pipe port="fileset.in" step="main"/>
        </p:input>
        <p:input port="in-memory">
            <p:pipe port="in-memory.in" step="main"/>
        </p:input>
    </px:fileset-load>
    <px:assert test-count-min="1" test-count-max="1" message="There must be exactly one HTML file in the single-page HTML fileset." error-code="NORDICDTBOOKEPUB007"/>
    <p:identity name="single-html"/>

    <!-- Create OPF metadata -->
    <p:xslt name="opf-metadata">
        <p:input port="parameters">
            <p:empty/>
        </p:input>
        <p:input port="stylesheet">
            <p:document href="../../xslt/html-to-opf-metadata.xsl"/>
        </p:input>
    </p:xslt>
    <p:sink/>

    <!-- Create Navigation Document -->
    <p:group name="nav">
        <p:output port="html">
            <p:pipe port="result" step="nav.html"/>
        </p:output>
        <p:output port="ncx">
            <p:pipe port="result" step="nav.ncx"/>
        </p:output>

        <p:group name="nav.toc">
            <p:output port="result"/>
            <p:identity>
                <p:input port="source">
                    <p:pipe port="result" step="single-html"/>
                </p:input>
            </p:identity>
            <p:xslt>
                <p:input port="parameters">
                    <p:empty/>
                </p:input>
                <p:input port="stylesheet">
                    <p:document href="../../xslt/generate-missing-headlines.xsl"/>
                </p:input>
            </p:xslt>
            <px:epub3-nav-create-toc>
                <p:with-option name="base-dir" select="replace(base-uri(/*),'[^/]+$','')">
                    <p:pipe port="result" step="single-html"/>
                </p:with-option>
            </px:epub3-nav-create-toc>
            <p:add-attribute match="/*" attribute-name="xml:base">
                <p:with-option name="attribute-value" select="base-uri(/*)">
                    <p:pipe port="result" step="single-html"/>
                </p:with-option>
            </p:add-attribute>
            <p:delete match="/*/@xml:base"/>
            <p:delete match="/html:nav/html:ol/html:li/html:a"/>
            <p:unwrap match="/html:nav/html:ol/html:li"/>
            <p:unwrap match="/html:nav/html:ol"/>
            <p:identity name="nav.toc.single-html-hrefs"/>
            <p:xslt>
                <p:input port="source">
                    <p:pipe port="result" step="nav.toc.single-html-hrefs"/>
                    <p:pipe port="in-memory.out" step="html-split"/>
                </p:input>
                <p:input port="parameters">
                    <p:empty/>
                </p:input>
                <p:input port="stylesheet">
                    <p:document href="../../xslt/replace-single-html-hrefs-with-multi-html-hrefs.xsl"/>
                </p:input>
            </p:xslt>
        </p:group>
        <p:sink/>

        <px:epub3-nav-create-page-list name="nav.page-list">
            <p:with-option name="base-dir" select="replace(base-uri(/*),'[^/]+$','')">
                <p:pipe port="result" step="single-html"/>
            </p:with-option>
            <p:input port="source">
                <p:pipe port="in-memory.out" step="html-split"/>
            </p:input>
        </px:epub3-nav-create-page-list>
        <p:sink/>

        <px:epub3-nav-aggregate>
            <p:input port="source">
                <p:pipe step="nav.toc" port="result"/>
                <p:pipe step="nav.page-list" port="result"/>
            </p:input>
            <p:with-option name="language" select="/*/(@xml:lang,@lang)[1]">
                <p:pipe port="result" step="single-html"/>
            </p:with-option>
        </px:epub3-nav-aggregate>
        <p:add-attribute match="/*" attribute-name="xml:base">
            <p:with-option name="attribute-value" select="concat($publication-dir,'nav.xhtml')"/>
        </p:add-attribute>
        <p:xslt>
            <p:with-param name="identifier" select="/*/html:head/html:meta[@name='dc:identifier']/@content">
                <p:pipe port="result" step="single-html"/>
            </p:with-param>
            <p:with-param name="title" select="/*/html:head/html:title/text()">
                <p:pipe port="result" step="single-html"/>
            </p:with-param>
            <p:with-param name="supplier" select="/*/html:head/html:meta[@name='nordic:supplier']/@content">
                <p:pipe port="result" step="single-html"/>
            </p:with-param>
            <p:with-param name="publisher" select="/*/html:head/html:meta[@name='dc:publisher']/@content">
                <p:pipe port="result" step="single-html"/>
            </p:with-param>
            <p:input port="stylesheet">
                <p:document href="../../xslt/navdoc-nordic-normalization.xsl"/>
            </p:input>
        </p:xslt>
        <p:identity name="nav.html"/>

        <p:xslt>
            <p:input port="parameters">
                <p:empty/>
            </p:input>
            <p:input port="stylesheet">
                <p:document href="http://www.daisy.org/pipeline/modules/epub3-nav-utils/nav-to-ncx.xsl"/>
            </p:input>
        </p:xslt>
        <p:add-attribute match="/*" attribute-name="xml:base">
            <p:with-option name="attribute-value" select="concat($publication-dir,'nav.ncx')"/>
        </p:add-attribute>
        <p:identity name="nav.ncx"/>
    </p:group>

    <px:fileset-create>
        <p:with-option name="base" select="replace(base-uri(/*),'[^/]+$','')">
            <p:pipe port="ncx" step="nav"/>
        </p:with-option>
    </px:fileset-create>
    <px:message message="ncx base: $1">
        <p:with-option name="param1" select="replace(base-uri(/*),'[^/]+$','')">
            <p:pipe port="ncx" step="nav"/>
        </p:with-option>
    </px:message>
    <px:fileset-add-entry media-type="application/x-dtbncx+xml">
        <p:with-option name="href" select="'nav.ncx'"/>
    </px:fileset-add-entry>
    <p:identity name="ncx-fileset"/>
    <px:fileset-join>
        <p:input port="source">
            <p:pipe port="result" step="ncx-fileset"/>
            <p:pipe port="result" step="non-linear-content"/>
        </p:input>
    </px:fileset-join>
    <px:mediatype-detect name="resource-fileset"/>
    <p:sink/>

    <px:epub3-pub-create-package-doc>
        <p:with-option name="result-uri" select="concat($publication-dir,'package.opf')"/>
        <p:with-option name="compatibility-mode" select="$compatibility-mode"/>
        <p:with-option name="detect-properties" select="'false'"/>
        <p:input port="spine-filesets">
            <p:pipe port="result" step="spine"/>
        </p:input>
        <p:input port="metadata">
            <p:pipe port="result" step="opf-metadata"/>
        </p:input>
        <p:input port="content-docs">
            <p:pipe port="html" step="nav"/>
            <p:pipe port="result" step="spine-html"/>
        </p:input>
        <p:input port="publication-resources">
            <p:pipe port="result" step="resource-fileset"/>
        </p:input>
    </px:epub3-pub-create-package-doc>
    <p:add-attribute match="/*" attribute-name="unique-identifier" attribute-value="pub-identifier"/>
    <p:add-attribute match="//dc:identifier[not(preceding::dc:identifier)]" attribute-name="id" attribute-value="pub-identifier"/>
    <p:add-attribute match="/*" attribute-name="prefix" attribute-value="nordic: http://www.mtm.se/epub/"/>
    <p:delete match="/*//*/@prefix"/>
    <p:xslt>
        <p:input port="parameters">
            <p:empty/>
        </p:input>
        <p:input port="stylesheet">
            <p:inline>
                <xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
                    <xsl:template match="/*">
                        <xsl:copy>
                            <xsl:namespace name="dc" select="'http://purl.org/dc/elements/1.1/'"/>
                            <xsl:copy-of select="@*|node()"/>
                        </xsl:copy>
                    </xsl:template>
                </xsl:stylesheet>
            </p:inline>
        </p:input>
    </p:xslt>
    <p:add-attribute match="/*" attribute-name="xml:base">
        <p:with-option name="attribute-value" select="concat($publication-dir,'package.opf')"/>
    </p:add-attribute>
    <p:identity name="package"/>

    <p:identity name="result.in-memory-without-ocf-files">
        <p:input port="source">
            <p:pipe port="html" step="nav"/>
            <p:pipe port="ncx" step="nav"/>
            <p:pipe port="result" step="spine-html"/>
            <p:pipe port="result" step="package"/>
        </p:input>
    </p:identity>
    <p:sink/>

    <p:identity>
        <p:input port="source">
            <p:pipe port="result" step="resource-fileset"/>
        </p:input>
    </p:identity>
    <px:fileset-add-entry media-type="application/oebps-package+xml">
        <p:with-option name="href" select="base-uri(/*)">
            <p:pipe port="result" step="package"/>
        </p:with-option>
    </px:fileset-add-entry>
    <px:fileset-add-entry media-type="application/xhtml+xml">
        <p:with-option name="href" select="concat($publication-dir,'nav.xhtml')"/>
    </px:fileset-add-entry>
    <px:mediatype-detect>
        <p:input port="in-memory">
            <p:pipe port="result" step="result.in-memory-without-ocf-files"/>
        </p:input>
    </px:mediatype-detect>
    <px:message message="epub-dir: $1">
        <p:with-option name="param1" select="$epub-dir"/>
    </px:message>
    <px:fileset-rebase>
        <p:with-option name="new-base" select="$epub-dir"/>
    </px:fileset-rebase>
    <p:identity name="result.fileset-without-ocf-files"/>
    <p:sink/>

    <px:epub3-ocf-finalize name="finalize">
        <p:with-option name="epub-dir" select="$epub-dir"/>
        <p:input port="source">
            <p:pipe port="result" step="result.fileset-without-ocf-files"/>
        </p:input>
    </px:epub3-ocf-finalize>
    <px:fileset-join>
        <p:input port="source">
            <p:pipe port="result" step="finalize"/>
            <p:pipe port="result" step="spine"/>
            <p:pipe port="result" step="result.fileset-without-ocf-files"/>
        </p:input>
    </px:fileset-join>
    <p:add-attribute match="//d:file[@href='META-INF/container.xml']" attribute-name="media-type" attribute-value="application/xml"/>
    <p:add-attribute match="//d:file[matches(@media-type,'[/+]xml$')]" attribute-name="omit-xml-declaration" attribute-value="false"/>
    <p:add-attribute match="//d:file[matches(@media-type,'[/+]xml$')]" attribute-name="indent" attribute-value="true"/>
    <p:add-attribute match="//d:file[matches(@media-type,'[/+]xml$') and not(@media-type='application/xhtml+xml')]" attribute-name="method" attribute-value="xml"/>
    <p:add-attribute match="//d:file[@media-type='application/xhtml+xml']" attribute-name="method" attribute-value="xhtml"/>
    <p:add-attribute match="//d:file[@media-type='application/xhtml+xml']" attribute-name="doctype" attribute-value="&lt;!DOCTYPE html&gt;"/>
    <p:identity name="result.fileset"/>
    <p:sink/>

    <p:identity name="result.in-memory">
        <p:input port="source">
            <p:pipe port="result" step="result.in-memory-without-ocf-files"/>
            <p:pipe port="in-memory.out" step="finalize"/>
        </p:input>
    </p:identity>
    <p:sink/>

    <!-- List auxiliary resources (i.e. all non-content files: images, CSS, NCX, etc. as well as content files that are non-primary) -->
    <px:fileset-filter>
        <p:input port="source">
            <p:pipe port="fileset.out" step="html-split.moved"/>
        </p:input>
    </px:fileset-filter>
    <p:delete match="//d:file[@media-type='application/xhtml+xml' and not(ends-with(@href,'-cover.xhtml'))]"/>
    <p:identity name="non-linear-content"/>

</p:declare-step>
