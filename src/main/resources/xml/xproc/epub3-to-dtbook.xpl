<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" xmlns:px="http://www.daisy.org/ns/pipeline/xproc" xmlns:d="http://www.daisy.org/ns/pipeline/data"
    type="px:nordic-epub3-to-dtbook" name="main" version="1.0" xmlns:epub="http://www.idpf.org/2007/ops" xmlns:pxp="http://exproc.org/proposed/steps" xpath-version="2.0"
    xmlns:pxi="http://www.daisy.org/ns/pipeline/xproc/internal/nordic-epub3-dtbook-migrator" xmlns:cx="http://xmlcalabash.com/ns/extensions" xmlns:html="http://www.w3.org/1999/xhtml">

    <p:documentation xmlns="http://www.w3.org/1999/xhtml">
        <h1 px:role="name">Nordic EPUB3 to DTBook</h1>
        <p px:role="desc">Transforms an EPUB3 publication into DTBook according to the nordic markup guidelines.</p>
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

    <p:option name="epub" required="true" px:type="anyFileURI" px:media-type="application/epub+zip">
        <p:documentation xmlns="http://www.w3.org/1999/xhtml">
            <h2 px:role="name">EPUB3 Publication</h2>
            <p px:role="desc">EPUB3 Publication marked up according to the nordic markup guidelines.</p>
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
            <h2 px:role="name">DTBook</h2>
            <p px:role="desc">Output directory for the DTBook.</p>
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

    <p:option name="strict" select="'true'" px:type="boolean">
        <p:documentation xmlns="http://www.w3.org/1999/xhtml">
            <h2 px:role="name">Extra strict markup</h2>
            <p px:role="desc">Some validation rules are considered extra strict and can be disabled using this option. Examples of extra strict rules are pagebreaks being required in all documents and
                only a predefined list of languages, suppliers and publishers being allowed.</p>
        </p:documentation>
    </p:option>

    <p:import href="step/epub3.validate.xpl"/>
    <p:import href="step/html.validate.xpl"/>
    <p:import href="step/dtbook.validate.xpl"/>
    <p:import href="step/epub3-to-html.convert.xpl"/>
    <p:import href="step/html-to-dtbook.convert.xpl"/>
    <p:import href="step/format-html-report.step.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/validation-utils/library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/zip-utils/library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/fileset-utils/library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/mediatype-utils/library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/common-utils/library.xpl"/>

    <p:variable name="epub-href" select="resolve-uri($epub,base-uri(/*))">
        <p:inline>
            <irrelevant/>
        </p:inline>
    </p:variable>

    <px:message message="$1" name="nordic-version-message">
        <p:with-option name="param1" select="/*">
            <p:document href="../version-description.xml"/>
        </p:with-option>
    </px:message>

    <px:fileset-create cx:depends-on="nordic-version-message">
        <p:with-option name="base" select="replace($epub-href,'[^/]+$','')"/>
    </px:fileset-create>
    <px:fileset-add-entry media-type="application/epub+zip">
        <p:with-option name="href" select="replace($epub-href,'^.*/([^/]*)$','$1')"/>
    </px:fileset-add-entry>

    <px:nordic-epub3-validate.step name="validate.epub3">
        <p:with-option name="temp-dir" select="concat($temp-dir,'validate/')"/>
        <p:with-option name="strict" select="$strict"/>
    </px:nordic-epub3-validate.step>
    <p:sink/>

    <p:group name="status.epub3">
        <p:output port="result"/>
        <p:for-each>
            <p:iteration-source select="/d:document-validation-report/d:document-info/d:error-count">
                <p:pipe port="report.out" step="validate.epub3"/>
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
                <p:pipe port="report.out" step="validate.epub3"/>
            </p:output>
            <p:sink/>
        </p:when>
        <p:otherwise>
            <p:output port="result" sequence="true"/>

            <px:unzip-fileset name="unzip">
                <p:with-option name="href" select="$epub-href"/>
                <p:with-option name="unzipped-basedir" select="concat($temp-dir,'epub/')"/>
            </px:unzip-fileset>

            <!-- This is a workaround for a bug that should be fixed in Pipeline v1.8
                 see: https://github.com/daisy-consortium/pipeline-modules-common/pull/49 -->
            <p:delete match="/*/*[ends-with(@href,'/')]" name="load.in-memory.fileset-fix"/>

            <p:for-each>
                <p:iteration-source>
                    <p:pipe port="in-memory.out" step="unzip"/>
                </p:iteration-source>
                <p:choose>
                    <p:when test="ends-with(base-uri(/*),'/')">
                        <p:identity>
                            <p:input port="source">
                                <p:empty/>
                            </p:input>
                        </p:identity>
                    </p:when>
                    <p:otherwise>
                        <p:identity/>
                    </p:otherwise>
                </p:choose>
            </p:for-each>
            <p:identity name="load.in-memory"/>

            <px:fileset-store name="load.stored">
                <p:input port="fileset.in">
                    <p:pipe port="result" step="load.in-memory.fileset-fix"/>
                </p:input>
                <p:input port="in-memory.in">
                    <p:pipe port="result" step="load.in-memory"/>
                </p:input>
            </px:fileset-store>

            <px:nordic-epub3-to-html-convert name="convert.html">
                <p:input port="fileset.in">
                    <p:pipe port="fileset.out" step="load.stored"/>
                </p:input>
                <p:input port="in-memory.in">
                    <p:pipe port="result" step="load.in-memory"/>
                </p:input>
            </px:nordic-epub3-to-html-convert>

            <px:nordic-html-validate.step name="validate.html" document-type="Nordic HTML (intermediary single-document)">
                <p:input port="in-memory.in">
                    <p:pipe port="in-memory.out" step="convert.html"/>
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

            <p:choose>
                <p:when test="$discard-intermediary-html='false' or (/*/@result='error' and $assert-valid='true')">
                    <px:fileset-load media-types="application/xhtml+xml">
                        <p:input port="fileset">
                            <p:pipe port="fileset.out" step="convert.html"/>
                        </p:input>
                        <p:input port="in-memory">
                            <p:pipe port="in-memory.out" step="convert.html"/>
                        </p:input>
                    </px:fileset-load>
                    <px:assert message="There should be exactly one intermediary HTML file" test-count-min="1" test-count-max="1"/>
                    <p:store name="intermediary.store">
                        <p:with-option name="href" select="concat($output-dir,replace(base-uri(/*),'^.*/([^/]+?)\.?[^\./]*$','$1/'),replace(base-uri(/*),'.*/',''))"/>
                    </p:store>
                    <p:identity>
                        <p:input port="source">
                            <p:pipe port="result" step="intermediary.store"/>
                        </p:input>
                    </p:identity>
                </p:when>
                <p:otherwise>
                    <p:identity/>
                </p:otherwise>
            </p:choose>
            <p:sink/>

            <p:identity>
                <p:input port="source">
                    <p:pipe port="result" step="status.html"/>
                </p:input>
            </p:identity>
            <p:choose>
                <p:when test="/*/@result='error' and $assert-valid='true'">
                    <p:output port="result" sequence="true">
                        <p:pipe port="report.out" step="validate.epub3"/>
                        <p:pipe port="report.out" step="validate.html"/>
                    </p:output>
                    <p:sink/>
                </p:when>
                <p:otherwise>
                    <p:output port="result" sequence="true">
                        <p:pipe port="report.out" step="validate.epub3"/>
                        <p:pipe port="report.out" step="validate.html"/>
                        <p:pipe port="report.out" step="validate.dtbook"/>
                    </p:output>

                    <px:nordic-html-to-dtbook-convert name="convert.dtbook">
                        <p:input port="fileset.in">
                            <p:pipe port="fileset.out" step="convert.html"/>
                        </p:input>
                        <p:input port="in-memory.in">
                            <p:pipe port="in-memory.out" step="convert.html"/>
                        </p:input>
                    </px:nordic-html-to-dtbook-convert>

                    <px:fileset-move name="move">
                        <p:with-option name="new-base" select="concat($output-dir,(//d:file[@media-type='application/x-dtbook+xml'])[1]/replace(replace(@href,'.*/',''),'^(.[^\.]*).*?$','$1/'))"/>
                        <p:input port="in-memory.in">
                            <p:pipe port="in-memory.out" step="convert.dtbook"/>
                        </p:input>
                    </px:fileset-move>

                    <px:fileset-store name="fileset-store">
                        <p:input port="fileset.in">
                            <p:pipe port="fileset.out" step="move"/>
                        </p:input>
                        <p:input port="in-memory.in">
                            <p:pipe port="in-memory.out" step="move"/>
                        </p:input>
                    </px:fileset-store>

                    <px:nordic-dtbook-validate.step name="validate.dtbook">
                        <p:with-option name="dtbook" select="(/*/d:file[@media-type='application/x-dtbook+xml'])[1]/resolve-uri(@href,base-uri(.))">
                            <p:pipe port="fileset.out" step="fileset-store"/>
                        </p:with-option>
                    </px:nordic-dtbook-validate.step>
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

</p:declare-step>
