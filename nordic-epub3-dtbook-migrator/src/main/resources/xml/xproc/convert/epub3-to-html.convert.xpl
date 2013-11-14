<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" xmlns:px="http://www.daisy.org/ns/pipeline/xproc" xmlns:d="http://www.daisy.org/ns/pipeline/data"
    type="px:nordic-epub3-to-html-convert" name="main" version="1.0" xmlns:epub="http://www.idpf.org/2007/ops" xmlns:html="http://www.w3.org/1999/xhtml" xmlns:opf="http://www.idpf.org/2007/opf"
    xmlns:pxi="http://www.daisy.org/ns/pipeline/xproc/internal/nordic-epub3-dtbook-migrator">

    <p:input port="fileset.in" primary="true"/>
    <p:input port="in-memory.in" sequence="true"/>

    <p:output port="fileset.out" primary="true">
        <p:pipe port="result" step="fileset"/>
    </p:output>
    <p:output port="in-memory.out" sequence="true">
        <p:pipe port="result" step="in-memory"/>
    </p:output>

    <p:import href="http://www.daisy.org/pipeline/modules/html-utils/html-library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/fileset-utils/xproc/fileset-library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/common-utils/logging-library.xpl"/>
    <!--    <p:import href="http://www.daisy.org/pipeline/modules/mediatype-utils/mediatype.xpl"/>-->

    <p:declare-step type="pxi:replace-sections-with-documents" name="replace-sections-with-documents">
        <p:input port="section" primary="true"/>
        <p:input port="fileset"/>
        <p:input port="in-memory" sequence="true"/>
        <p:output port="result"/>
        <p:viewport match="/*//html:section">
            <p:choose>
                <p:when test="/*/@xml:base">
                    <p:variable name="base-uri" select="resolve-uri(/*/@xml:base,base-uri(/*))"/>
                    <p:identity name="section"/>
                    <p:rename match="/*" new-name="d:section-wrapper" name="section-wrapped"/>
                    <px:fileset-load name="content">
                        <p:with-option name="href" select="$base-uri"/>
                        <p:input port="fileset">
                            <p:pipe port="fileset" step="replace-sections-with-documents"/>
                        </p:input>
                        <p:input port="in-memory">
                            <p:pipe port="in-memory" step="replace-sections-with-documents"/>
                        </p:input>
                    </px:fileset-load>
                    <px:assert test-count-min="1" test-count-max="1" message="The document referenced from the Navigation Document must exist: $1" error-code="NORDICDTBOOKEPUB012">
                        <p:with-option name="param1" select="$base-uri">
                            <p:empty/>
                        </p:with-option>
                    </px:assert>
                    <p:filter select="//html:body">
                        <p:input port="source">
                            <p:pipe port="result" step="content"/>
                        </p:input>
                    </p:filter>
                    <p:add-attribute match="/*" attribute-name="xml:base">
                        <p:with-option name="attribute-value" select="$base-uri"/>
                    </p:add-attribute>
                    <p:rename match="/*" new-namespace="http://www.w3.org/1999/xhtml">
                        <p:with-option name="new-name" select="if (matches(/*/@epub:type,'(^|\s)article(\s|$)')) then 'article' else 'section'"/>
                    </p:rename>
                    <p:insert match="/*" position="last-child">
                        <p:input port="insertion">
                            <p:pipe port="result" step="section-wrapped"/>
                        </p:input>
                    </p:insert>
                    <p:unwrap match="/*/d:section-wrapper"/>
                </p:when>
                <p:otherwise>
                    <p:identity/>
                </p:otherwise>
            </p:choose>
            <pxi:replace-sections-with-documents>
                <p:input port="fileset">
                    <p:pipe port="fileset" step="replace-sections-with-documents"/>
                </p:input>
                <p:input port="in-memory">
                    <p:pipe port="in-memory" step="replace-sections-with-documents"/>
                </p:input>
            </pxi:replace-sections-with-documents>
        </p:viewport>
    </p:declare-step>

    <px:fileset-load media-types="application/oebps-package+xml">
        <p:input port="in-memory">
            <p:pipe port="in-memory.in" step="main"/>
        </p:input>
    </px:fileset-load>
    <px:assert test-count-min="1" test-count-max="1" message="There must be exactly one Package Document in the EPUB." error-code="NORDICDTBOOKEPUB011"/>
    <p:identity name="package-doc"/>

    <p:filter select="/*/opf:manifest/opf:item[matches(@properties,'(^|\s)nav(\s|$)')]"/>
    <px:fileset-load>
        <p:input port="fileset">
            <p:pipe port="fileset.in" step="main"/>
        </p:input>
        <p:input port="in-memory">
            <p:pipe port="in-memory.in" step="main"/>
        </p:input>
        <p:with-option name="href" select="resolve-uri(/*/@href,base-uri(/*))"/>
    </px:fileset-load>
    <p:xslt>
        <p:input port="parameters">
            <p:empty/>
        </p:input>
        <p:input port="stylesheet">
            <p:document href="../../xslt/navdoc-to-outline.xsl"/>
        </p:input>
    </p:xslt>
    <p:delete match="//html:section[@xml:base=(preceding::html:section|ancestor::html:section)/@xml:base]"/>
    <pxi:replace-sections-with-documents>
        <p:input port="fileset">
            <p:pipe port="fileset.in" step="main"/>
        </p:input>
        <p:input port="in-memory">
            <p:pipe port="in-memory.in" step="main"/>
        </p:input>
    </pxi:replace-sections-with-documents>
    <p:xslt>
        <p:input port="parameters">
            <p:empty/>
        </p:input>
        <p:input port="stylesheet">
            <p:document href="../../xslt/make-uris-relative-to-document.xsl"/>
        </p:input>
    </p:xslt>
    <p:identity name="single-html.body"/>

    <p:xslt>
        <p:input port="parameters">
            <p:empty/>
        </p:input>
        <p:input port="source">
            <p:pipe step="package-doc" port="result"/>
        </p:input>
        <p:input port="stylesheet">
            <p:document href="../../xslt/opf-to-html-metadata.xsl"/>
        </p:input>
    </p:xslt>
    <p:identity name="single-html.metadata"/>

    <p:replace match="//html:head">
        <p:input port="source">
            <p:pipe port="result" step="single-html.body"/>
        </p:input>
        <p:input port="replacement" select="//html:head">
            <p:pipe port="result" step="single-html.metadata"/>
        </p:input>
    </p:replace>
    <p:identity name="in-memory"/>

    <px:html-to-fileset>
        <p:input port="fileset.in">
            <p:pipe port="fileset.in" step="main"/>
        </p:input>
    </px:html-to-fileset>
    <px:fileset-add-entry>
        <p:with-option name="href" select="base-uri(/*)">
            <p:pipe port="result" step="in-memory"/>
        </p:with-option>
    </px:fileset-add-entry>
    <!--<p:add-attribute attribute-name="xml:base" match="//*">
        <p:input port="source">
            <p:inline>
                <d:fileset>
                    <d:file media-type="application/xhtml+xml"/>
                </d:fileset>
            </p:inline>
        </p:input>
        <p:with-option name="attribute-value" select="base-uri(/*)"/>
    </p:add-attribute>
    <p:add-attribute match="/*" attribute-name="xml:base">
        <p:with-option name="attribute-value" select="replace(/*/@xml:base,'[^/]+$','')"/>
    </p:add-attribute>
    <p:add-attribute match="/*/*" attribute-name="href">
        <p:with-option name="attribute-value" select="replace(/*/@xml:base,'.*/([^/]*)$','$1')"/>
    </p:add-attribute>-->
    <p:identity name="fileset"/>

    <!--<p:group name="convert">
        <p:output port="fileset.out" primary="true">
            <p:pipe port="result" step="result.fileset"/>
        </p:output>
        <p:output port="in-memory.out" sequence="true">
            <p:pipe port="result" step="result.in-memory"/>
        </p:output>

        <p:variable name="dtbook-dir" select="replace(base-uri(/*),'/[^/]*$','/')"/>

        <!-\- Convert from a single DTBook file to multiple HTML files -\->
        <px:nordic-dtbook-to-html-convert name="single-html">
            <p:input port="fileset.in">
                <p:pipe port="fileset.in" step="main"/>
            </p:input>
            <p:input port="in-memory.in">
                <p:pipe port="in-memory.in" step="main"/>
            </p:input>
            <p:with-option name="temp-dir" select="concat($temp-dir,'dtbook-to-html/')"/>
            <p:with-option name="output-dir" select="$publication-dir"/>
        </px:nordic-dtbook-to-html-convert>
        <px:nordic-html-split-perform name="html">
            <p:input port="in-memory.in">
                <p:pipe port="in-memory.out" step="single-html"/>
            </p:input>
            <p:with-option name="output-dir" select="$publication-dir"/>
        </px:nordic-html-split-perform>

        <!-\- Create spine -\->
        <px:fileset-filter media-types="application/xhtml+xml" name="spine"/>

        <px:fileset-load name="spine-html">
            <p:input port="in-memory">
                <p:pipe port="in-memory.out" step="html"/>
            </p:input>
        </px:fileset-load>

        <px:fileset-load media-types="application/xhtml+xml">
            <p:input port="fileset">
                <p:pipe port="fileset.out" step="single-html"/>
            </p:input>
            <p:input port="in-memory">
                <p:pipe port="in-memory.out" step="single-html"/>
            </p:input>
        </px:fileset-load>
        <px:assert test-count-min="1" test-count-max="1" message="There must be exactly one HTML file in the single-page HTML fileset." error-code="NORDICDTBOOKEPUB007"/>
        <p:identity name="single-html.html"/>

        <!-\- Create OPF metadata -\->
        <p:xslt name="opf-metadata">
            <p:input port="parameters">
                <p:empty/>
            </p:input>
            <p:input port="stylesheet">
                <p:document href="../../xslt/html-to-opf-metadata.xsl"/>
            </p:input>
        </p:xslt>
        <p:sink/>

        <!-\- Create Navigation Document -\->
        <p:group name="nav">
            <p:output port="html">
                <p:pipe port="result" step="nav.html"/>
            </p:output>
            <p:output port="ncx">
                <p:pipe port="result" step="nav.ncx"/>
            </p:output>

            <px:epub3-nav-create-toc name="nav.toc">
                <p:with-option name="base-dir" select="$publication-dir">
                    <p:empty/>
                </p:with-option>
                <p:input port="source">
                    <p:pipe port="result" step="spine-html"/>
                </p:input>
            </px:epub3-nav-create-toc>

            <px:epub3-nav-create-page-list name="nav.page-list">
                <p:with-option name="base-dir" select="$publication-dir">
                    <p:empty/>
                </p:with-option>
                <p:input port="source">
                    <p:pipe port="result" step="spine-html"/>
                </p:input>
            </px:epub3-nav-create-page-list>

            <px:epub3-nav-aggregate>
                <p:input port="source">
                    <p:pipe step="nav.toc" port="result"/>
                    <p:pipe step="nav.page-list" port="result"/>
                </p:input>
                <p:with-option name="language" select="/*/(@xml:lang,@lang)[1]">
                    <p:pipe port="result" step="single-html.html"/>
                </p:with-option>
            </px:epub3-nav-aggregate>
            <p:add-attribute match="/*" attribute-name="xml:base">
                <p:with-option name="attribute-value" select="concat($publication-dir,'nav.xhtml')"/>
            </p:add-attribute>
            <p:add-attribute match="/*" attribute-name="epub:prefix" xmlns:epub="http://www.idpf.org/2007/ops">
                <p:with-option name="attribute-value" select="'z3998: http://www.daisy.org/z3998/2012/vocab/structure/#'"/>
            </p:add-attribute>
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
                <p:with-option name="attribute-value" select="concat($publication-dir,'ncx.xml')"/>
            </p:add-attribute>
            <p:identity name="nav.ncx"/>
        </p:group>

        <!-\- List auxiliary resources (i.e. all non-content files: images, CSS, NCX, etc.) -\->
        <p:for-each>
            <p:iteration-source>
                <p:pipe port="html" step="nav"/>
                <p:pipe port="result" step="spine-html"/>
            </p:iteration-source>
            <px:html-to-fileset>
                <p:input port="fileset.in">
                    <p:pipe port="fileset.out" step="html"/>
                </p:input>
            </px:html-to-fileset>
        </p:for-each>
        <p:identity name="html-filesets"/>
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
            <p:with-option name="href" select="'ncx.xml'"/>
        </px:fileset-add-entry>
        <p:identity name="ncx-fileset"/>
        <px:fileset-join>
            <p:input port="source">
                <p:pipe port="result" step="ncx-fileset"/>
                <p:pipe port="result" step="html-filesets"/>
            </p:input>
        </px:fileset-join>
        <px:mediatype-detect name="resource-fileset"/>
        <p:sink/>

        <px:epub3-pub-create-package-doc name="package">
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
                <p:pipe port="result" step="spine-html"/>
                <p:pipe port="result" step="package"/>
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
                <p:pipe port="result" step="resource-fileset"/>
            </p:input>
        </px:fileset-join>
        <px:mediatype-detect>
            <p:input port="in-memory">
                <p:pipe port="in-memory" step="result.for-each"/>
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

    </p:group>-->

</p:declare-step>
