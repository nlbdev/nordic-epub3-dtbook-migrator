<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" xmlns:px="http://www.daisy.org/ns/pipeline/xproc" xmlns:d="http://www.daisy.org/ns/pipeline/data"
    type="px:nordic-dtbook-to-epub3" name="main" version="1.0" xmlns:epub="http://www.idpf.org/2007/ops" xmlns:l="http://xproc.org/library" xmlns:dtbook="http://www.daisy.org/z3986/2005/dtbook/"
    xmlns:html="http://www.w3.org/1999/xhtml" xmlns:cx="http://xmlcalabash.com/ns/extensions" xmlns:pxi="http://www.daisy.org/ns/pipeline/xproc/internal/nordic-epub3-dtbook-migrator">

    <p:documentation xmlns="http://www.w3.org/1999/xhtml">
        <h1 px:role="name">Nordic DTBook to EPUB3</h1>
        <p px:role="desc">Transforms a DTBook document into an EPUB3 publication according to the nordic markup guidelines.</p>
    </p:documentation>

    <p:output port="html-report" px:media-type="application/vnd.pipeline.report+xml">
        <p:documentation xmlns="http://www.w3.org/1999/xhtml">
            <h1 px:role="name">HTML Report</h1>
            <p px:role="desc">An HTML-formatted version of the validation report.</p>
        </p:documentation>
        <p:pipe port="result" step="html"/>
    </p:output>

    <p:output port="validation-status" px:media-type="application/vnd.pipeline.status+xml">
        <p:documentation xmlns="http://www.w3.org/1999/xhtml">
            <h1 px:role="name">Validation status</h1>
            <p px:role="desc">Validation status (http://code.google.com/p/daisy-pipeline/wiki/ValidationStatusXML).</p>
        </p:documentation>
        <p:pipe port="result" step="status"/>
    </p:output>

    <p:option name="dtbook" required="true" px:type="anyFileURI" px:media-type="application/x-dtbook+xml">
        <p:documentation xmlns="http://www.w3.org/1999/xhtml">
            <h2 px:role="name">DTBook</h2>
            <p px:role="desc">Input DTBook to be converted.</p>
        </p:documentation>
    </p:option>

    <p:option name="temp-dir" required="true" px:output="temp" px:type="anyDirURI">
        <p:documentation xmlns="http://www.w3.org/1999/xhtml">
            <h2 px:role="name">Temporary directory</h2>
            <p px:role="desc">Temporary directory for use by the script.</p>
        </p:documentation>
    </p:option>

    <p:option name="output-dir" required="true" px:output="result" px:type="anyDirURI">
        <p:documentation xmlns="http://www.w3.org/1999/xhtml">
            <h2 px:role="name">Output directory</h2>
            <p px:role="desc">Output directory for the EPUB publication.</p>
        </p:documentation>
    </p:option>

    <p:option name="discard-intermediary-html" required="false" select="'true'" px:type="boolean">
        <p:documentation xmlns="http://www.w3.org/1999/xhtml">
            <h2 px:role="name">Discard intermediary HTML</h2>
            <p px:role="desc">Whether or not to include the intermediary HTML in the output (does not include external resources such as images). Set to false to include the HTML.</p>
        </p:documentation>
    </p:option>

    <p:option name="assert-valid" required="false" select="'true'" px:type="boolean">
        <p:documentation xmlns="http://www.w3.org/1999/xhtml">
            <h2 px:role="name">Stop processing on validation error</h2>
            <p px:role="desc">Whether or not to stop the conversion when a validation error occurs. Setting this to false may be useful for debugging or if the validation error is a minor one. The
                output is not guaranteed to be valid if this option is set to false.</p>
        </p:documentation>
    </p:option>

    <p:option name="no-legacy" required="false" px:type="boolean" select="'true'">
        <p:documentation xmlns="http://www.w3.org/1999/xhtml">
            <h2 px:role="name">Disallow legacy markup</h2>
            <p px:role="desc">If set to false, will upgrade DTBook versions earlier than 2005-3 to 2005-3, and fix some non-standard practices that appear in older DTBooks.</p>
        </p:documentation>
    </p:option>

    <p:option name="strict" select="'true'" px:type="boolean">
        <p:documentation xmlns="http://www.w3.org/1999/xhtml">
            <h2 px:role="name">Extra strict markup</h2>
            <p px:role="desc">Some validation rules are considered extra strict and can be disabled using this option. Examples of extra strict rules are pagebreaks being required in all documents and
                only a predefined list of languages, suppliers and publishers being allowed.</p>
        </p:documentation>
    </p:option>

    <p:import href="step/dtbook.validate.xpl"/>
    <p:import href="step/html.validate.xpl"/>
    <p:import href="step/epub3.validate.xpl"/>
    <p:import href="step/dtbook-to-html.convert.xpl"/>
    <p:import href="step/html-to-epub3.convert.xpl"/>
    <p:import href="step/format-html-report.step.xpl"/>
    <p:import href="step/set-doctype.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/fileset-utils/library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/dtbook-utils/library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/mediatype-utils/library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/common-utils/library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/epub3-ocf-utils/library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/dtbook-validator/dtbook-validator.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/validation-utils/library.xpl"/>

    <p:variable name="dtbook-href" select="resolve-uri($dtbook,base-uri(/*))">
        <p:inline>
            <irrelevant/>
        </p:inline>
    </p:variable>

    <px:message message="$1" name="nordic-version-message">
        <p:with-option name="param1" select="/*">
            <p:document href="../version-description.xml"/>
        </p:with-option>
    </px:message>

    <px:nordic-dtbook-validate.step name="validate.dtbook" check-images="true" cx:depends-on="nordic-version-message">
        <p:with-option name="dtbook" select="$dtbook-href"/>
        <p:with-option name="allow-legacy" select="if ($no-legacy='false') then 'true' else 'false'"/>
    </px:nordic-dtbook-validate.step>
    <p:sink/>

    <p:group name="status.dtbook">
        <p:output port="result"/>
        <p:for-each>
            <p:iteration-source select="/d:document-validation-report/d:document-info/d:error-count">
                <p:pipe port="report.out" step="validate.dtbook"/>
            </p:iteration-source>
            <p:identity/>
        </p:for-each>
        <p:wrap-sequence wrapper="d:validation-status"/>
        <p:add-attribute attribute-name="result" match="/*">
            <p:with-option name="attribute-value" select="if (sum(/*/*/number(.))&gt;0) then 'error' else 'ok'"/>
        </p:add-attribute>
        <p:delete match="/*/node()"/>
    </p:group>

    <p:choose>
        <p:when test="/*/@result='error' and $assert-valid='true'">
            <p:output port="result" sequence="true">
                <p:pipe port="report.out" step="validate.dtbook"/>
            </p:output>
            <p:sink/>
        </p:when>
        <p:otherwise>
            <p:output port="result" sequence="true"/>

            <px:nordic-dtbook-to-html-convert name="single-html">
                <p:input port="fileset.in">
                    <p:pipe port="fileset.out" step="validate.dtbook"/>
                </p:input>
                <p:input port="in-memory.in">
                    <p:pipe port="in-memory.out" step="validate.dtbook"/>
                </p:input>
                <p:with-option name="temp-dir" select="concat($temp-dir,'html/')"/>
            </px:nordic-dtbook-to-html-convert>
            <p:sink/>
            
            <p:choose>
                <p:xpath-context>
                    <p:pipe port="result" step="status.dtbook"/>
                </p:xpath-context>
                <p:when test="$discard-intermediary-html='false' or (/*/@result='error' and $assert-valid='true')">
                    <px:fileset-load media-types="application/xhtml+xml">
                        <p:input port="fileset">
                            <p:pipe port="fileset.out" step="single-html"/>
                        </p:input>
                        <p:input port="in-memory">
                            <p:pipe port="in-memory.out" step="single-html"/>
                        </p:input>
                    </px:fileset-load>
                    <px:assert message="There should be exactly one intermediary HTML file" test-count-min="1" test-count-max="1"/>
                    <p:store name="intermediary.store">
                        <p:with-option name="href" select="concat($output-dir,/*/@content,'.xhtml')">
                            <p:pipe port="identifier" step="metadata"/>
                        </p:with-option>
                    </p:store>
                    <p:identity>
                        <p:input port="source">
                            <p:pipe port="result" step="intermediary.store"/>
                        </p:input>
                    </p:identity>
                </p:when>
                <p:otherwise>
                    <p:identity>
                        <p:input port="source">
                            <p:empty/>
                        </p:input>
                    </p:identity>
                </p:otherwise>
            </p:choose>
            <p:identity name="store-intermediary"/>
            <p:sink/>

            <px:nordic-html-validate.step name="validate.html" document-type="Nordic HTML (intermediary single-document)" cx:depends-on="store-intermediary">
                <p:input port="fileset.in">
                    <p:pipe port="fileset.out" step="single-html"/>
                </p:input>
                <p:input port="in-memory.in">
                    <p:pipe port="in-memory.out" step="single-html"/>
                </p:input>
                <p:with-option name="strict" select="$strict"/>
            </px:nordic-html-validate.step>
            <p:sink/>

            <p:group name="status.html">
                <p:output port="result"/>
                <p:for-each>
                    <p:iteration-source select="/d:document-validation-report/d:document-info/d:error-count">
                        <p:pipe port="report.out" step="validate.html"/>
                    </p:iteration-source>
                    <p:identity/>
                </p:for-each>
                <p:wrap-sequence wrapper="d:validation-status"/>
                <p:add-attribute attribute-name="result" match="/*">
                    <p:with-option name="attribute-value" select="if (sum(/*/*/number(.))&gt;0) then 'error' else 'ok'"/>
                </p:add-attribute>
                <p:delete match="/*/node()"/>
            </p:group>
            <p:sink/>

            <p:identity>
                <p:input port="source">
                    <p:pipe port="result" step="status.html"/>
                </p:input>
            </p:identity>
            <p:choose>
                <p:when test="/*/@result='error' and $assert-valid='true'">
                    <p:output port="result" sequence="true">
                        <p:pipe port="report.out" step="validate.dtbook"/>
                        <p:pipe port="report.out" step="validate.html"/>
                    </p:output>
                    <p:sink/>
                </p:when>
                <p:otherwise>
                    <p:output port="result" sequence="true">
                        <p:pipe port="report.out" step="validate.dtbook"/>
                        <p:pipe port="report.out" step="validate.html"/>
                        <p:pipe port="report.out" step="validate.epub3"/>
                    </p:output>

                    <px:nordic-html-to-epub3-convert name="convert.epub3">
                        <p:input port="fileset.in">
                            <p:pipe port="fileset.out" step="single-html"/>
                        </p:input>
                        <p:input port="in-memory.in">
                            <p:pipe port="in-memory.out" step="single-html"/>
                        </p:input>
                        <p:with-option name="temp-dir" select="concat($temp-dir,'epub/')"/>
                        <p:with-option name="compatibility-mode" select="'true'"/>
                    </px:nordic-html-to-epub3-convert>


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
                                <p:pipe port="in-memory.out" step="convert.epub3"/>
                            </p:input>
                        </px:fileset-store>

                        <p:viewport match="/*/d:file" name="store.epub3.doctype">
                            <p:viewport-source>
                                <p:pipe port="fileset.out" step="fileset-store"/>
                            </p:viewport-source>

                            <p:choose>
                                <p:when test="/*/@media-type='application/xhtml+xml'">
                                    <pxi:set-doctype doctype="&lt;!DOCTYPE html&gt;">
                                        <p:with-option name="href" select="resolve-uri(/*/@href,base-uri(/*))"/>
                                    </pxi:set-doctype>
                                    <p:add-attribute match="/*" attribute-value="&lt;!DOCTYPE html&gt;">
                                        <p:with-option name="attribute-name" select="'doctype'">
                                            <!-- p:with-option uses default connection as context, thus making sure pxi:set-doctype is run before p:add-attribute -->
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
                            <p:with-option name="target" select="concat($output-dir,/*/@content,'.epub')">
                                <p:pipe port="identifier" step="metadata"/>
                            </p:with-option>
                        </px:epub3-ocf-zip>
                    </p:group>
                    <!--<px:epub3-store name="store.epub3">
                        <p:input port="in-memory.in">
                            <p:pipe port="in-memory.out" step="convert.epub3"/>
                        </p:input>
                        <p:with-option name="href" select="concat($output-dir,/*/@content,'.epub')">
                            <p:pipe port="identifier" step="metadata"/>
                        </p:with-option>
                    </px:epub3-store>-->

                    <px:fileset-create>
                        <p:with-option name="base" select="$output-dir">
                            <p:pipe port="result" step="store.epub3"/>
                        </p:with-option>
                    </px:fileset-create>
                    <px:fileset-add-entry media-type="application/epub+zip">
                        <p:with-option name="href" select="concat(/*/@content,'.epub')">
                            <p:pipe port="identifier" step="metadata"/>
                        </p:with-option>
                    </px:fileset-add-entry>
                    <px:nordic-epub3-validate.step name="validate.epub3" cx:depends-on="store.epub3">
                        <p:with-option name="temp-dir" select="concat($temp-dir,'validate-epub/')"/>
                        <p:input port="in-memory.in">
                            <p:pipe port="in-memory.out" step="convert.epub3"/>
                        </p:input>
                        <p:with-option name="strict" select="$strict"/>
                    </px:nordic-epub3-validate.step>
                    <p:sink/>

                </p:otherwise>
            </p:choose>

        </p:otherwise>
    </p:choose>
    <p:identity name="reports"/>

    <px:nordic-format-html-report.step/>
    <p:xslt>
        <!-- pretty print to make debugging easier -->
        <p:with-param name="preserve-empty-whitespace" select="'false'"/>
        <p:input port="stylesheet">
            <p:document href="../xslt/pretty-print.xsl"/>
        </p:input>
    </p:xslt>
    <p:identity name="html"/>

    <p:group name="status">
        <p:output port="result"/>
        <p:for-each>
            <p:iteration-source select="/d:document-validation-report/d:document-info/d:error-count">
                <p:pipe port="result" step="reports"/>
            </p:iteration-source>
            <p:identity/>
        </p:for-each>
        <p:wrap-sequence wrapper="d:validation-status"/>
        <p:add-attribute attribute-name="result" match="/*">
            <p:with-option name="attribute-value" select="if (sum(/*/*/number(.))&gt;0) then 'error' else 'ok'"/>
        </p:add-attribute>
        <p:delete match="/*/node()"/>
    </p:group>

    <!-- get metadata -->
    <p:group name="metadata">
        <p:output port="identifier">
            <p:pipe port="result" step="metadata.identifier"/>
        </p:output>
        <p:output port="title">
            <p:pipe port="result" step="metadata.title"/>
        </p:output>
        <px:fileset-load media-types="application/x-dtbook+xml">
            <p:input port="fileset">
                <p:pipe port="fileset.out" step="validate.dtbook"/>
            </p:input>
            <p:input port="in-memory">
                <p:pipe port="in-memory.out" step="validate.dtbook"/>
            </p:input>
        </px:fileset-load>
        <px:assert message="There must be exactly one DTBook in the input fileset" test-count-min="1" test-count-max="1" error-code="NORDICDTBOOKEPUB008"/>
        <p:identity name="metadata.dtbook"/>
        <p:sink/>

        <p:for-each>
            <p:iteration-source select="//dtbook:head/dtbook:meta[@name='dtb:uid']">
                <p:pipe port="result" step="metadata.dtbook"/>
            </p:iteration-source>
            <p:identity/>
        </p:for-each>
        <px:assert message="The DTBook must have a 'dtb:uid' meta element" test-count-min="1" test-count-max="1" error-code="NORDICDTBOOKEPUB009"/>
        <p:identity name="metadata.identifier"/>

        <p:for-each>
            <p:iteration-source select="//dtbook:head/dtbook:meta[@name='dc:Title']">
                <p:pipe port="result" step="metadata.dtbook"/>
            </p:iteration-source>
            <p:identity/>
        </p:for-each>
        <px:assert message="The DTBook must have a 'dc:Title' meta element" test-count-min="1" test-count-max="1" error-code="NORDICDTBOOKEPUB010"/>
        <p:identity name="metadata.title"/>
    </p:group>

</p:declare-step>
