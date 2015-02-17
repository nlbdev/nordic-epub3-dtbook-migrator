<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" xmlns:px="http://www.daisy.org/ns/pipeline/xproc" xmlns:d="http://www.daisy.org/ns/pipeline/data"
    type="px:nordic-epub3-store.step" name="main" version="1.0" xmlns:epub="http://www.idpf.org/2007/ops" xmlns:l="http://xproc.org/library" xmlns:dtbook="http://www.daisy.org/z3986/2005/dtbook/"
    xmlns:html="http://www.w3.org/1999/xhtml" xmlns:cx="http://xmlcalabash.com/ns/extensions" xmlns:pxi="http://www.daisy.org/ns/pipeline/xproc/internal/nordic-epub3-dtbook-migrator"
    xmlns:dc="http://purl.org/dc/elements/1.1/">

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

    <p:option name="fail-on-error" select="'true'"/>
    <p:option name="output-dir" required="true"/>

    <p:import href="validation-status.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/file-utils/library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/common-utils/library.xpl"/>
    <p:import href="../upstream/fileset-utils/fileset-load.xpl"/>
    <p:import href="../upstream/fileset-utils/fileset-add-entry.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/fileset-utils/library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/epub3-ocf-utils/library.xpl"/>

    <px:assert message="'fail-on-error' should be either 'true' or 'false'. was: '$1'. will default to 'true'.">
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
                <p:empty/>
            </p:output>
            <p:output port="report.out" sequence="true">
                <p:empty/>
            </p:output>










            <p:group name="store.epub3">
                <!-- TODO: replace this p:group with px:epub3-store when px:set-doctype is fixed in the next pipeline 2 version -->

                <p:output port="result" primary="false">
                    <p:pipe port="result" step="zip"/>
                </p:output>

                <p:delete match="/*/d:file/@doctype"/>
                <p:add-attribute match="/*/d:file[@indent='true']" attribute-name="indent" attribute-value="false">
                    <!-- temporary workaround until https://github.com/daisy/pipeline-modules-common/issues/69 is fixed -->
                </p:add-attribute>
                <px:fileset-store name="fileset-store">
                    <p:input port="in-memory.in">
                        <p:pipe port="in-memory.in" step="main"/>
                    </p:input>
                </px:fileset-store>

                <p:viewport match="/*/d:file" name="store.epub3.doctype">
                    <p:viewport-source>
                        <p:pipe port="fileset.out" step="fileset-store"/>
                    </p:viewport-source>

                    <p:choose>
                        <p:when test="/*/@media-type='application/xhtml+xml'">
                            <px:set-doctype doctype="&lt;!DOCTYPE html&gt;">
                                <p:with-option name="href" select="resolve-uri(/*/@href,base-uri(/*))"/>
                            </px:set-doctype>
                            <p:add-attribute match="/*" attribute-value="&lt;!DOCTYPE html&gt;">
                                <p:with-option name="attribute-name" select="'doctype'">
                                    <!-- p:with-option uses default connection as context, thus making sure px:set-doctype is run before p:add-attribute -->
                                </p:with-option>
                                <p:input port="source">
                                    <p:pipe port="current" step="store.epub3.doctype"/>
                                </p:input>
                            </p:add-attribute>
                        </p:when>
                        <p:otherwise>
                            <p:identity/>
                        </p:otherwise>
                    </p:choose>
                </p:viewport>

                <px:epub3-ocf-zip name="zip" cx:depends-on="fileset-store">
                    <p:with-option name="target" select="concat($output-dir,/*/text(),'.epub')">
                        <p:pipe port="result" step="metadata.identifier"/>
                    </p:with-option>
                </px:epub3-ocf-zip>
            </p:group>
            <!--<px:epub3-store name="store.epub3">
                <p:input port="in-memory.in">
                    <p:pipe port="in-memory.in" step="main"/>
                </p:input>
                <p:with-option name="href" select="concat($output-dir,/*/@content,'.epub')">
                    <p:pipe port="result" step="metadata.identifier"/>
                </p:with-option>
            </px:epub3-store>-->

            <px:fileset-create>
                <p:with-option name="base" select="$output-dir">
                    <p:pipe port="result" step="store.epub3"/>
                </p:with-option>
            </px:fileset-create>
            <pxi:fileset-add-entry media-type="application/epub+zip">
                <p:with-option name="href" select="concat(/*/text(),'.epub')">
                    <p:pipe port="result" step="metadata.identifier"/>
                </p:with-option>
            </pxi:fileset-add-entry>
            <p:identity name="result.fileset"/>

            <!-- get metadata -->
            <pxi:fileset-load media-types="application/oebps-package+xml">
                <p:input port="fileset">
                    <p:pipe port="fileset.in" step="main"/>
                </p:input>
                <p:input port="in-memory">
                    <p:pipe port="in-memory.in" step="main"/>
                </p:input>
            </pxi:fileset-load>
            <px:assert test-count-min="1" test-count-max="1" message="There must be exactly one Package Document in the EPUB." error-code="NORDICDTBOOKEPUB011"/>
            <p:filter select="//dc:identifier"/>
            <px:assert message="The EPUB Package Document (the OPF file) must have a 'dc:identifier' element" test-count-min="1" error-code="NORDICDTBOOKEPUB012"/>
            <p:split-sequence test="position() = 1"/>
            <p:identity name="metadata.identifier"/>
            <p:sink/>










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
