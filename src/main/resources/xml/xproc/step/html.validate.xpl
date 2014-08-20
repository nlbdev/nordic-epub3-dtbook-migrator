<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" xmlns:px="http://www.daisy.org/ns/pipeline/xproc" xmlns:d="http://www.daisy.org/ns/pipeline/data"
    type="px:nordic-html-validate.step" name="main" version="1.0" xmlns:epub="http://www.idpf.org/2007/ops" xmlns:html="http://www.w3.org/1999/xhtml" xmlns:opf="http://www.idpf.org/2007/opf"
    xmlns:pxi="http://www.daisy.org/ns/pipeline/xproc/internal/nordic-epub3-dtbook-migrator" xmlns:l="http://xproc.org/library">

    <p:serialization port="report.out" indent="true"/>

    <p:input port="fileset.in" primary="true"/>
    <p:input port="in-memory.in" sequence="true">
        <p:empty/>
    </p:input>
    <p:input port="report.in" sequence="true">
        <p:empty/>
    </p:input>

    <p:output port="fileset.out" primary="true">
        <p:pipe port="fileset.in" step="main"/>
    </p:output>
    <p:output port="in-memory.out" sequence="true">
        <p:pipe port="in-memory.in" step="main"/>
    </p:output>
    <p:output port="report.out" sequence="true">
        <p:pipe port="report.in" step="main"/>
        <p:pipe port="result" step="report"/>
    </p:output>

    <p:option name="document-type" required="false" select="'Nordic HTML'"/>
    <p:option name="title" required="true"/>
    <p:option name="strict" select="'true'"/>

    <p:import href="http://www.daisy.org/pipeline/modules/zip-utils/library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/fileset-utils/library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/validation-utils/library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/common-utils/library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/mediatype-utils/library.xpl"/>

    <px:fileset-load media-types="application/xhtml+xml">
        <p:input port="in-memory">
            <p:pipe port="in-memory.in" step="main"/>
        </p:input>
    </px:fileset-load>
    <px:assert test-count-min="1" test-count-max="1" message="There must be exactly one HTML-file in the fileset." error-code="NORDICDTBOOKEPUB031"/>
    <p:delete match="/*/@xml:base"/>
    <p:identity name="html"/>
    <p:sink/>

    <l:relax-ng-report name="validate.rng">
        <p:input port="source">
            <p:pipe step="html" port="result"/>
        </p:input>
        <p:input port="schema">
            <p:document href="../../schema/nordic-html5.rng"/>
        </p:input>
        <p:with-option name="dtd-attribute-values" select="'false'"/>
        <p:with-option name="dtd-id-idref-warnings" select="'false'"/>
    </l:relax-ng-report>
    <p:sink/>

    <p:validate-with-schematron name="validate.sch.generic" assert-valid="false">
        <p:input port="parameters">
            <p:empty/>
        </p:input>
        <p:input port="source">
            <p:pipe step="html" port="result"/>
        </p:input>
        <p:input port="schema">
            <p:document href="../../schema/nordic2015-1.sch"/>
        </p:input>
    </p:validate-with-schematron>
    <p:sink/>

    <p:choose>
        <p:when test="$strict='true'">
            <p:validate-with-schematron name="validate.sch.strict.step" assert-valid="false">
                <p:input port="parameters">
                    <p:empty/>
                </p:input>
                <p:input port="source">
                    <p:pipe step="html" port="result"/>
                </p:input>
                <p:input port="schema">
                    <p:document href="../../schema/nordic2015-1.strict.sch"/>
                </p:input>
            </p:validate-with-schematron>
            <p:identity>
                <p:input port="source">
                    <p:pipe port="report" step="validate.sch.strict.step"/>
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
    <p:identity name="validate.sch.strict"/>
    <p:sink/>

    <p:identity name="validate.sch">
        <p:input port="source">
            <p:pipe step="validate.sch.generic" port="report"/>
            <p:pipe step="validate.sch.strict" port="result"/>
        </p:input>
    </p:identity>

    <p:identity>
        <p:input port="source">
            <p:pipe step="html" port="result"/>
        </p:input>
    </p:identity>
    <p:choose>
        <p:when test="/*/html:head/html:title/text() = $title">
            <p:identity>
                <p:input port="source">
                    <p:empty/>
                </p:input>
            </p:identity>
        </p:when>
        <p:otherwise>
            <p:for-each>
                <p:iteration-source select="/*/html:head/html:title"/>
                <p:identity/>
            </p:for-each>
            <p:wrap-sequence wrapper="d:was"/>
            <p:wrap-sequence wrapper="d:error"/>
            <p:insert match="/*" position="first-child">
                <p:input port="insertion">
                    <p:inline>
                        <d:desc>PLACEHOLDER</d:desc>
                    </p:inline>
                    <p:inline>
                        <d:file>PLACEHOLDER</d:file>
                    </p:inline>
                    <p:inline>
                        <d:expected>
                            <html:title>PLACEHOLDER</html:title>
                        </d:expected>
                    </p:inline>
                </p:input>
            </p:insert>
            <p:string-replace match="/*/d:desc/text()">
                <p:with-option name="replace" select="concat('&quot;Wrong document title in: ',replace(base-uri(/*),'^.*/([^/]*)$','$1'),'&quot;')">
                    <p:pipe port="result" step="html"/>
                </p:with-option>
            </p:string-replace>
            <p:string-replace match="/*/d:file/text()">
                <p:with-option name="replace" select="concat('&quot;',base-uri(/*),'&quot;')">
                    <p:pipe port="result" step="html"/>
                </p:with-option>
            </p:string-replace>
            <p:string-replace match="/*/d:expected/html:title/text()">
                <p:with-option name="replace" select="concat('&quot;',replace($title,'&quot;','&amp;quot;'),'&quot;')"/>
            </p:string-replace>
        </p:otherwise>
    </p:choose>
    <p:wrap-sequence wrapper="d:errors"/>
    <p:identity name="validate.title"/>
    <p:sink/>

    <px:combine-validation-reports>
        <p:with-option name="document-type" select="$document-type"/>
        <p:input port="source">
            <p:pipe port="report" step="validate.rng"/>
            <p:pipe port="result" step="validate.sch"/>
            <p:pipe port="result" step="validate.title"/>
            <p:inline>
                <c:errors>
                    <!-- Temporary fix for v1.7. Will probably be fixed in v1.8. See: https://github.com/daisy-consortium/pipeline-modules-common/pull/48 -->
                </c:errors>
            </p:inline>
        </p:input>
        <p:with-option name="document-name" select="replace(base-uri(/*),'.*/','')">
            <p:pipe port="result" step="html"/>
        </p:with-option>
        <p:with-option name="document-path" select="base-uri(/*)">
            <p:pipe port="result" step="html"/>
        </p:with-option>
    </px:combine-validation-reports>
    <p:xslt>
        <!-- pretty print to make debugging easier -->
        <p:input port="parameters">
            <p:empty/>
        </p:input>
        <p:input port="stylesheet">
            <p:document href="../xslt/pretty-print.xsl"/>
        </p:input>
    </p:xslt>
    <p:identity name="report"/>
    <p:sink/>

</p:declare-step>
