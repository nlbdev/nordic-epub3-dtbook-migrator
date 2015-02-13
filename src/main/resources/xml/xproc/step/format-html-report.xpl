<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" xmlns:px="http://www.daisy.org/ns/pipeline/xproc" xmlns:d="http://www.daisy.org/ns/pipeline/data"
    type="px:nordic-format-html-report" name="main" version="1.0" xmlns:epub="http://www.idpf.org/2007/ops" xmlns:html="http://www.w3.org/1999/xhtml" xmlns:opf="http://www.idpf.org/2007/opf"
    xmlns:pxi="http://www.daisy.org/ns/pipeline/xproc/internal/nordic-epub3-dtbook-migrator">

    <p:input port="source" sequence="true"/>
    <p:output port="result">
        <p:pipe port="result" step="html"/>
    </p:output>

    <p:import href="http://www.daisy.org/pipeline/modules/validation-utils/library.xpl"/>

    <p:split-sequence test="/*[.//d:property[@name='Tool Name']/@content = 'epubcheck']" name="epubcheck-report-split"/>
    <p:count/>
    <p:choose name="html.epubcheck">
        <p:when test="/*=1">
            <p:output port="html-report" sequence="true">
                <p:pipe port="result" step="html.epubcheck.validation-reports"/>
            </p:output>
            <p:xslt>
                <p:input port="source">
                    <p:pipe port="matched" step="epubcheck-report-split"/>
                </p:input>
                <p:input port="parameters">
                    <p:empty/>
                </p:input>
                <p:input port="stylesheet">
                    <p:document href="../../xslt/epubcheck-pipeline-report-to-html-report.xsl"/>
                </p:input>
            </p:xslt>
            <p:filter select="/*/html:body/html:div[@class='document-validation-report']"/>
            <p:identity name="html.epubcheck.validation-reports"/>

        </p:when>
        <p:otherwise>
            <p:output port="html-report" sequence="true"/>
            <p:identity>
                <p:input port="source">
                    <p:empty/>
                </p:input>
            </p:identity>
        </p:otherwise>
    </p:choose>

    <p:split-sequence test="/*/html:head/html:meta[@name='report.type']/@content = 'category'" name="category-report-split">
        <p:input port="source">
            <p:pipe port="not-matched" step="epubcheck-report-split"/>
        </p:input>
    </p:split-sequence>
    <p:for-each>
        <p:iteration-source select="/*/html:body"/>
        <p:rename match="/*" new-name="div" new-namespace="http://www.w3.org/1999/xhtml"/>
    </p:for-each>
    <p:identity name="category-report"/>
    <p:sink/>

    <px:validation-report-to-html toc="false">
        <p:input port="source">
            <p:pipe port="not-matched" step="category-report-split"/>
        </p:input>
    </px:validation-report-to-html>
    <p:insert match="//html:body/*[1]" position="after">
        <p:input port="insertion">
            <p:pipe port="html-report" step="html.epubcheck"/>
        </p:input>
    </p:insert>
    <p:insert match="//html:body" position="last-child">
        <p:input port="insertion">
            <p:pipe port="result" step="category-report"/>
        </p:input>
    </p:insert>

    <p:xslt>
        <p:input port="parameters">
            <p:empty/>
        </p:input>
        <p:input port="stylesheet">
            <p:document href="../../xslt/improve-html-report-readability.xsl"/>
        </p:input>
    </p:xslt>

    <p:identity name="html"/>
    <p:sink/>

</p:declare-step>
