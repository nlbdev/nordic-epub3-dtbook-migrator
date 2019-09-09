<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" version="1.0"
                xmlns:px="http://www.daisy.org/ns/pipeline/xproc"
                xmlns:d="http://www.daisy.org/ns/pipeline/data"
                xmlns:dc="http://purl.org/dc/elements/1.1/"
                xmlns:epub="http://www.idpf.org/2007/ops"
                xmlns:html="http://www.w3.org/1999/xhtml"
                xmlns:opf="http://www.idpf.org/2007/opf"
                type="px:nordic-html-to-epub3.step" name="main">

    <p:input port="fileset.in" primary="true"/>
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

    <p:option name="fail-on-error" required="true"/>
    <p:option name="temp-dir" required="true"/>
    <p:option name="compatibility-mode" select="'true'"/>

    <p:import href="html-split.xpl">
        <p:documentation>
            px:nordic-html-split-perform
        </p:documentation>
    </p:import>
    <p:import href="validation-status.xpl">
        <p:documentation>
            px:nordic-validation-status
        </p:documentation>
    </p:import>
    <p:import href="http://www.daisy.org/pipeline/modules/epub3-utils/library.xpl">
        <p:documentation>
            px:epub3-nav-create-toc
            px:epub3-nav-create-page-list
            px:epub3-nav-aggregate
            px:epub3-nav-to-ncx
            px:epub3-pub-create-package-doc
            px:epub3-ocf-finalize
        </p:documentation>
    </p:import>
    <p:import href="http://www.daisy.org/pipeline/modules/fileset-utils/library.xpl">
        <p:documentation>
            px:fileset-load
            px:fileset-copy
            px:fileset-filter
            px:fileset-create
            px:fileset-add-entry
            px:fileset-join
            px:fileset-rebase
            px:fileset-update
        </p:documentation>
    </p:import>
    <p:import href="http://www.daisy.org/pipeline/modules/common-utils/library.xpl">
        <p:documentation>
            px:assert
            px:message
        </p:documentation>
    </p:import>
    <p:import href="http://www.daisy.org/pipeline/modules/mediatype-utils/library.xpl">
        <p:documentation>
            px:mediatype-detect
        </p:documentation>
    </p:import>
    <p:import href="http://www.daisy.org/pipeline/modules/html-to-epub3/library.xpl">
        <p:documentation>
            px:html-to-opf-metadata
        </p:documentation>
    </p:import>
    <p:import href="http://www.daisy.org/pipeline/modules/file-utils/library.xpl">
        <p:documentation>
            px:set-base-uri
        </p:documentation>
    </p:import>

    <px:assert message="'fail-on-error' should be either 'true' or 'false'. was: '$1'. will default to 'true'.">
        <p:with-option name="param1" select="$fail-on-error"/>
        <p:with-option name="test" select="$fail-on-error = ('true','false')"/>
    </px:assert>

    <p:choose name="choose">
        <p:xpath-context>
            <p:pipe port="status.in" step="main"/>
        </p:xpath-context>
        <p:when test="/*/@result='ok' or $fail-on-error = 'false'">
            <p:output port="fileset.out" primary="true"/>
            <p:output port="in-memory.out" sequence="true">
                <p:pipe step="html-to-epub3.step.post-process-package-doc" port="in-memory"/>
            </p:output>
            <p:output port="report.out" sequence="true">
                <p:empty/>
            </p:output>

            <p:variable name="epub-dir" select="concat($temp-dir,'epub/')"/>
            <p:variable name="publication-dir" select="concat($epub-dir,'EPUB/')"/>

            <!--
                Move to EPUB/ directory
            -->
            <px:fileset-copy name="html-to-epub3.step.move">
                <p:input port="source.fileset">
                    <p:pipe step="main" port="fileset.in"/>
                </p:input>
                <p:input port="source.in-memory">
                    <p:pipe step="main" port="in-memory.in"/>
                </p:input>
                <p:with-option name="target" select="$publication-dir"/>
            </px:fileset-copy>

            <!--
                Chunk the HTML
            -->
            <px:nordic-html-split-perform name="html-to-epub3.step.html-split">
                <p:input port="in-memory.in">
                    <p:pipe step="html-to-epub3.step.move" port="result.in-memory"/>
                </p:input>
            </px:nordic-html-split-perform>

            <!--
                Create spine from all the HTML documents
            -->
            <px:fileset-filter media-types="application/xhtml+xml" name="html-to-epub3.step.filter-html-split-fileset-xhtml">
                <p:input port="source.in-memory">
                    <p:pipe step="html-to-epub3.step.html-split" port="in-memory.out"/>
                </p:input>
            </px:fileset-filter>
            <p:identity name="html-to-epub3.step.spine"/>

            <!--
                Load spine items and pretty-print HTML
            -->
            <p:group name="html-to-epub3.step.pretty-print-html">
                <p:output port="fileset" primary="true">
                    <p:pipe step="html-to-epub3.step.html-split" port="fileset.out"/>
                </p:output>
                <p:output port="in-memory" sequence="true">
                    <p:pipe step="in-memory" port="result"/>
                </p:output>

                <px:fileset-load name="html-to-epub3.step.load-spine">
                    <p:input port="in-memory">
                        <p:pipe step="html-to-epub3.step.filter-html-split-fileset-xhtml" port="result.in-memory"/>
                    </p:input>
                </px:fileset-load>
                <p:for-each name="html-to-epub3.step.iterate-spine">
                    <p:viewport match="/html:html/html:head" name="html-to-epub3.step.iterate-spine.viewport-html-head">
                        <p:xslt name="html-to-epub3.step.iterate-spine.viewport-html-head.pretty-print">
                            <!-- TODO: remove as many pretty printing steps as possible to improve performance -->
                            <p:with-param name="preserve-empty-whitespace" select="'false'"/>
                            <p:input port="stylesheet">
                                <p:document href="../../xslt/pretty-print.xsl"/>
                            </p:input>
                        </p:xslt>
                    </p:viewport>
                </p:for-each>
                <p:identity name="html-to-epub3.step.spine-html"/>
                <p:identity name="in-memory">
                    <p:input port="source">
                        <p:pipe step="html-to-epub3.step.filter-html-split-fileset-xhtml" port="not-matched.in-memory"/>
                        <p:pipe step="html-to-epub3.step.spine-html" port="result"/>
                    </p:input>
                </p:identity>
                <p:sink/>
            </p:group>

            <!--
                Load the single HTML
            -->
            <px:fileset-load media-types="application/xhtml+xml">
                <p:input port="fileset">
                    <p:pipe step="html-to-epub3.step.move" port="result.fileset"/>
                </p:input>
                <p:input port="in-memory">
                    <p:pipe step="html-to-epub3.step.move" port="result.in-memory"/>
                </p:input>
            </px:fileset-load>
            <px:assert test-count-min="1" test-count-max="1"
                       message="There must be exactly one HTML file in the single-page HTML fileset." error-code="NORDICDTBOOKEPUB007"/>
            <p:identity name="html-to-epub3.step.single-html"/>

            <!--
                Create OPF metadata
            -->
            <p:group name="html-to-epub3.step.opf-metadata">
                <p:output port="result"/>
                <px:html-to-opf-metadata>
                </px:html-to-opf-metadata>
                <!-- post-process -->
                <p:xslt>
                    <p:input port="stylesheet">
                        <p:document href="../../xslt/process-opf-metadata.xsl"/>
                    </p:input>
                    <p:input port="parameters">
                        <p:empty/>
                    </p:input>
                </p:xslt>
            </p:group>
            <p:sink/>

            <!--
                Create and add navigation document and NCX
            -->
            <p:group name="html-to-epub3.step.add-nav">
                <p:output port="fileset" primary="true"/>
                <p:output port="in-memory" sequence="true">
                    <p:pipe step="html-to-epub3.step.add-nav-entry" port="result.in-memory"/>
                </p:output>

                <p:group name="html-to-epub3.step.nav">
                    <p:output port="html">
                        <p:pipe port="result" step="html-to-epub3.step.nav.html"/>
                    </p:output>
                    <p:output port="ncx">
                        <p:pipe port="result" step="html-to-epub3.step.nav.ncx"/>
                    </p:output>

                    <p:group name="html-to-epub3.step.nav.toc">
                        <p:output port="result"/>
                        <p:identity>
                            <p:input port="source">
                                <p:pipe port="result" step="html-to-epub3.step.single-html"/>
                            </p:input>
                        </p:identity>
                        <!--
                            Generate missing headings in section and body elements:
                            - Cover
                            - Front Cover
                            - Rear Cover
                            - Left Flap
                            - Right Flap
                            - Untitled Part
                            - Untitled Chapter
                            - Untitled Section
                        -->
                        <p:xslt name="html-to-epub3.step.nav.toc.generate-missing-headlines">
                            <p:input port="parameters">
                                <p:empty/>
                            </p:input>
                            <p:input port="stylesheet">
                                <p:document href="../../xslt/generate-missing-headlines.xsl"/>
                            </p:input>
                        </p:xslt>
                        <p:delete match="html:a[tokenize(@epub:type,'\s+')='noteref']" name="html-to-epub3.step.nav.toc.delete-noterefs"/>

                        <px:epub3-nav-create-toc name="html-to-epub3.step.nav.toc.nav-create-toc">
                            <p:with-option name="output-base-uri" select="concat($publication-dir,'nav.xhtml')"/>
                        </px:epub3-nav-create-toc>
                        <!--
                            Process the TOC: the hrefs need to be fixed because TOC is generated
                            from the single HTML but the links should point to the split HTML.
                        -->
                        <p:group>
                            <p:delete match="/html:nav/html:ol/html:li/html:a" name="html-to-epub3.step.nav.toc.delete-nav-ol-li-a"/>
                            <p:unwrap match="/html:nav/html:ol/html:li" name="html-to-epub3.step.nav.toc.unwrap-nav-ol-li"/>
                            <p:unwrap match="/html:nav/html:ol" name="html-to-epub3.step.nav.toc.unwrap-nav-ol"/>
                            <p:identity name="html-to-epub3.step.nav.toc.single-html-hrefs"/>
                            <p:xslt name="html-to-epub3.step.nav.toc.replace-single-html-hrefs-with-multi-html-hrefs">
                                <p:input port="source">
                                    <p:pipe port="result" step="html-to-epub3.step.nav.toc.single-html-hrefs"/>
                                    <p:pipe port="in-memory.out" step="html-to-epub3.step.html-split"/>
                                </p:input>
                                <p:input port="parameters">
                                    <p:empty/>
                                </p:input>
                                <p:input port="stylesheet">
                                    <p:document href="../../xslt/replace-single-html-hrefs-with-multi-html-hrefs.xsl"/>
                                </p:input>
                            </p:xslt>
                        </p:group>
                    </p:group>
                    <p:sink/>

                    <px:epub3-nav-create-page-list name="html-to-epub3.step.nav.page-list">
                        <p:with-option name="output-base-uri" select="concat($publication-dir,'nav.xhtml')"/>
                        <p:input port="source">
                            <p:pipe step="html-to-epub3.step.html-split" port="in-memory.out"/>
                        </p:input>
                    </px:epub3-nav-create-page-list>
                    <p:sink/>

                    <px:epub3-nav-aggregate name="html-to-epub3.step.nav-aggregate">
                        <p:input port="source">
                            <p:pipe step="html-to-epub3.step.nav.toc" port="result"/>
                            <p:pipe step="html-to-epub3.step.nav.page-list" port="result"/>
                        </p:input>
                        <p:with-option name="language" select="/*/(@xml:lang,@lang)[1]">
                            <p:pipe port="result" step="html-to-epub3.step.single-html"/>
                        </p:with-option>
                        <p:with-option name="output-base-uri" select="concat($publication-dir,'nav.xhtml')"/>
                    </px:epub3-nav-aggregate>
                    <p:xslt name="html-to-epub3.step.navdoc-nordic-normalization">
                        <p:with-param name="identifier" select="/*/html:head/html:meta[@name='dc:identifier']/@content">
                            <p:pipe port="result" step="html-to-epub3.step.single-html"/>
                        </p:with-param>
                        <p:with-param name="title" select="/*/html:head/html:title/text()">
                            <p:pipe port="result" step="html-to-epub3.step.single-html"/>
                        </p:with-param>
                        <p:with-param name="supplier" select="/*/html:head/html:meta[@name='nordic:supplier']/@content">
                            <p:pipe port="result" step="html-to-epub3.step.single-html"/>
                        </p:with-param>
                        <p:with-param name="publisher" select="/*/html:head/html:meta[@name='dc:publisher']/@content">
                            <p:pipe port="result" step="html-to-epub3.step.single-html"/>
                        </p:with-param>
                        <p:input port="stylesheet">
                            <p:document href="../../xslt/navdoc-nordic-normalization.xsl"/>
                        </p:input>
                    </p:xslt>
                    <p:viewport match="/html:html/html:head" name="html-to-epub3.step.viewport-html-head">
                        <p:xslt name="html-to-epub3.step.viewport-html-head.pretty-print">
                            <!-- TODO: consider which pretty-print.xsl invocations can be removed to improve performance -->
                            <p:with-param name="preserve-empty-whitespace" select="'false'"/>
                            <p:input port="stylesheet">
                                <p:document href="../../xslt/pretty-print.xsl"/>
                            </p:input>
                        </p:xslt>
                    </p:viewport>
                    <p:identity name="html-to-epub3.step.nav.html"/>

                    <!--
                        Create ncx document
                    -->
                    <px:epub3-nav-to-ncx name="html-to-epub3.step.nav-to-ncx"/>
                    <p:xslt name="html-to-epub3.step.ncx-pretty-print">
                        <!-- TODO: remove pretty printing to improve performance -->
                        <p:with-param name="preserve-empty-whitespace" select="'false'"/>
                        <p:input port="stylesheet">
                            <p:document href="../../xslt/pretty-print.xsl"/>
                        </p:input>
                    </p:xslt>
                    <px:set-base-uri name="html-to-epub3.step.ncx-add-xml-base">
                        <p:with-option name="base-uri" select="concat($publication-dir,'nav.ncx')"/>
                    </px:set-base-uri>
                    <px:message message="ncx base: $1">
                        <p:with-option name="param1" select="replace(base-uri(/*),'[^/]+$','')"/>
                    </px:message>
                    <p:identity name="html-to-epub3.step.nav.ncx"/>
                </p:group>

                <!--
                    Add to fileset
                -->
                <px:fileset-add-entry media-type="application/x-dtbncx+xml" name="html-to-epub3.step.add-ncx-entry">
                    <p:input port="entry">
                        <p:pipe step="html-to-epub3.step.nav" port="ncx"/>
                    </p:input>
                    <p:input port="source">
                        <p:pipe step="html-to-epub3.step.pretty-print-html" port="fileset"/>
                    </p:input>
                    <p:input port="source.in-memory">
                        <p:pipe step="html-to-epub3.step.pretty-print-html" port="in-memory"/>
                    </p:input>
                </px:fileset-add-entry>
                <px:fileset-add-entry media-type="application/xhtml+xml" name="html-to-epub3.step.add-nav-entry">
                    <p:input port="entry">
                        <p:pipe step="html-to-epub3.step.nav" port="html"/>
                    </p:input>
                    <p:with-param port="file-attributes" name="nav" select="'true'"/>
                    <p:input port="source.in-memory">
                        <p:pipe step="html-to-epub3.step.add-ncx-entry" port="result.in-memory"/>
                    </p:input>
                </px:fileset-add-entry>
            </p:group>

            <!--
                Create and add package document
            -->
            <p:group name="html-to-epub3.step.add-package-doc">
                <p:output port="fileset" primary="true">
                    <p:pipe step="fileset" port="result"/>
                </p:output>
                <p:output port="in-memory" sequence="true">
                    <p:pipe step="in-memory" port="result"/>
                </p:output>

                <p:identity name="html-to-epub3.step.fileset-with-nav-attr"/>
                <px:epub3-pub-create-package-doc name="html-to-epub3.step.create-package-doc"
                                                 reserved-prefixes="dcterms: http://purl.org/dc/terms/">
                    <p:with-option name="output-base-uri" select="concat($publication-dir,'package.opf')"/>
                    <p:with-option name="compatibility-mode" select="$compatibility-mode"/>
                    <p:with-option name="detect-properties" select="'true'"/>
                    <p:input port="source.in-memory">
                        <p:pipe step="html-to-epub3.step.add-nav" port="in-memory"/>
                    </p:input>
                    <p:input port="spine">
                        <p:pipe step="html-to-epub3.step.spine" port="result"/>
                    </p:input>
                    <p:input port="metadata">
                        <p:pipe step="html-to-epub3.step.opf-metadata" port="result"/>
                    </p:input>
                </px:epub3-pub-create-package-doc>

                <!--
                    Add to fileset
                -->
                <p:identity name="html-to-epub3.step.package"/>
                <p:sink/>
                <p:identity>
                    <p:input port="source">
                        <p:pipe step="html-to-epub3.step.fileset-with-nav-attr" port="result"/>
                    </p:input>
                </p:identity>
                <p:delete match="d:file/@nav"/>
                <px:fileset-add-entry media-type="application/oebps-package+xml">
                    <p:input port="entry">
                        <p:pipe step="html-to-epub3.step.package" port="result"/>
                    </p:input>
                </px:fileset-add-entry>
                <p:identity name="fileset"/>
                <p:sink/>
                <p:identity name="in-memory">
                    <p:input port="source">
                        <p:pipe step="html-to-epub3.step.add-nav" port="in-memory"/>
                        <p:pipe step="html-to-epub3.step.package" port="result"/>
                    </p:input>
                </p:identity>
                <p:sink/>
            </p:group>

            <px:mediatype-detect name="html-to-epub3.step.mediatype-detect">
                <p:input port="source">
                    <p:pipe step="html-to-epub3.step.add-package-doc" port="fileset"/>
                </p:input>
                <p:input port="in-memory">
                    <p:pipe step="html-to-epub3.step.add-package-doc" port="in-memory"/>
                </p:input>
            </px:mediatype-detect>
            <!--
                Change fileset base from EPUB/ directory to top directory because this is what
                px:epub3-ocf-finalize expects.
            -->
            <px:fileset-rebase name="html-to-epub3.step.rebase-fileset-to-epub-dir" px:message="epub-dir: {$epub-dir}">
                <p:with-option name="new-base" select="$epub-dir"/>
            </px:fileset-rebase>

            <!--
                Add OCF files (container.xml, manifest.xml, metadata.xml, rights.xml, signature.xml)
            -->
            <px:epub3-ocf-finalize name="html-to-epub3.step.finalize">
                <p:with-option name="epub-dir" select="$epub-dir"/>
            </px:epub3-ocf-finalize>
            <px:fileset-join>
                <p:documentation>Normalize fileset</p:documentation>
            </px:fileset-join>

            <!--
                Omit XML declarations, indent XML, add DOCTYPE to xhtml files
            -->
            <p:add-attribute match="d:file[@href='META-INF/container.xml']" attribute-name="media-type" attribute-value="application/xml"
                             name="html-to-epub3.step.result-fileset.add-container-media-type"/>
            <p:add-attribute match="d:file[matches(@media-type,'[/+]xml$')]" attribute-name="omit-xml-declaration" attribute-value="false"
                             name="html-to-epub3.step.result-fileset.dont-omit-xml-declarations"/>
            <p:add-attribute match="d:file[matches(@media-type,'[/+]xml$')]" attribute-name="indent" attribute-value="true"
                             name="html-to-epub3.step.result-fileset.indent"/>
            <p:add-attribute match="d:file[matches(@media-type,'[/+]xml$') and not(@media-type='application/xhtml+xml')]"
                             attribute-name="method" attribute-value="xml"
                             name="html-to-epub3.step.result-fileset.method-xml"/>
            <p:add-attribute match="d:file[@media-type='application/xhtml+xml']" attribute-name="method" attribute-value="xhtml"
                             name="html-to-epub3.step.result-fileset.method-xhtml"/>
            <p:add-attribute match="d:file[@media-type='application/xhtml+xml']"
                             attribute-name="doctype" attribute-value="&lt;!DOCTYPE html&gt;"
                             name="html-to-epub3.step.result-fileset.doctype-html"/>
            <p:identity name="html-to-epub3.step.result.fileset"/>

            <!--
                Post-process package document
            -->
            <p:group name="html-to-epub3.step.post-process-package-doc">
                <p:output port="fileset" primary="true"/>
                <p:output port="in-memory" sequence="true">
                    <p:pipe step="update" port="result.in-memory"/>
                </p:output>

                <px:fileset-load media-types="application/oebps-package+xml" name="load">
                    <p:input port="in-memory">
                        <p:pipe step="html-to-epub3.step.add-package-doc" port="in-memory"/>
                    </p:input>
                </px:fileset-load>

                <p:add-attribute match="/*" attribute-name="unique-identifier" attribute-value="pub-identifier"
                                 name="html-to-epub3.step.add-opf-attribute.unique-identifier"/>
                <p:add-attribute match="//dc:identifier[not(preceding::dc:identifier)]" attribute-name="id" attribute-value="pub-identifier"
                                 name="html-to-epub3.step.add-opf-attribute.dc-identifier-id"/>
                <!--
                    Don't include "cover" and "rearnotes" in primary spine
                -->
                <p:add-attribute match="/*/opf:spine/opf:itemref[/*/opf:manifest/opf:item[matches(@href,'-(cover|rearnotes)(-\d+)?.xhtml')]/@id = @idref]"
                                 attribute-name="linear" attribute-value="no"/>
                <p:add-attribute match="opf:item[matches(@href,'(^|/)cover.jpg')]" attribute-name="properties" attribute-value="cover-image"/>
                <p:xslt name="html-to-epub3.step.add-dc-namespace">
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
                <!--
                    Pretty-print
                -->
                <p:xslt name="html-to-epub3.step.pretty-print-opf">
                    <!-- TODO: consider removing this XSLT invocation to improve performance -->
                    <p:with-param name="preserve-empty-whitespace" select="'false'"/>
                    <p:input port="stylesheet">
                        <p:document href="../../xslt/pretty-print.xsl"/>
                    </p:input>
                </p:xslt>
                <p:identity name="html-to-epub3.step.package-doc.processed"/>

                <px:fileset-update name="update">
                    <p:input port="source.fileset">
                        <p:pipe step="html-to-epub3.step.result.fileset" port="result"/>
                    </p:input>
                    <p:input port="source.in-memory">
                        <p:pipe step="html-to-epub3.step.add-package-doc" port="in-memory"/>
                        <p:pipe step="html-to-epub3.step.finalize" port="in-memory.out"/>
                    </p:input>
                    <p:input port="update.fileset">
                        <p:pipe step="load" port="result.fileset"/>
                    </p:input>
                    <p:input port="update.in-memory">
                        <p:pipe step="html-to-epub3.step.package-doc.processed" port="result"/>
                    </p:input>
                </px:fileset-update>
            </p:group>
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

    <p:choose name="status">
        <p:xpath-context>
            <p:pipe port="status.in" step="main"/>
        </p:xpath-context>
        <p:when test="/*/@result='ok' and $fail-on-error='true'">
            <p:output port="result"/>
            <px:nordic-validation-status>
                <p:input port="source">
                    <p:pipe port="report.out" step="choose"/>
                </p:input>
            </px:nordic-validation-status>
        </p:when>
        <p:otherwise>
            <p:output port="result"/>
            <p:identity>
                <p:input port="source">
                    <p:pipe port="status.in" step="main"/>
                </p:input>
            </p:identity>
        </p:otherwise>
    </p:choose>

</p:declare-step>
