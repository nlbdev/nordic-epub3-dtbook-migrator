<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" xmlns:px="http://www.daisy.org/ns/pipeline/xproc" xmlns:d="http://www.daisy.org/ns/pipeline/data"
    type="px:nordic-format-html-report.step" name="main" version="1.0" xmlns:epub="http://www.idpf.org/2007/ops" xmlns:html="http://www.w3.org/1999/xhtml" xmlns:opf="http://www.idpf.org/2007/opf"
    xmlns:pxi="http://www.daisy.org/ns/pipeline/xproc/internal/nordic-epub3-dtbook-migrator">

    <p:input port="source" sequence="true"/>
    <p:output port="result">
        <p:pipe port="result" step="html"/>
    </p:output>

    <p:split-sequence test="/*[.//d:property[@name='Tool Name']/@content = 'epubcheck']" name="epubcheck-report-split"/>
    <p:count/>
    <p:choose name="html.epubcheck">
        <p:when test="/*=1">
            <p:output port="validation-reports" sequence="true">
                <p:pipe port="result" step="html.epubcheck.validation-reports"/>
            </p:output>
            <p:output port="extended-info" sequence="true">
                <p:pipe port="result" step="html.epubcheck.extended-info"/>
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
            <p:identity name="html.epubcheck.full-html-report"/>
            <p:delete match="//*[tokenize(@class,'\s+')='document-info']/html:table//html:tr[.//html:table]"/>
            <p:filter select="//*[tokenize(@class,'\s+')=('document-info','document-validation-report')]"/>
            <p:identity name="html.epubcheck.validation-reports"/>
            <p:sink/>

            <p:for-each>
                <p:iteration-source select="//*[tokenize(@class,'\s+')='document-info']/html:table//html:tr[.//html:table and not(ancestor::html:tr)]">
                    <p:pipe step="html.epubcheck.full-html-report" port="result"/>
                </p:iteration-source>
                <p:rename match="/*" new-name="div" new-namespace="http://www.w3.org/1999/xhtml"/>
                <p:rename match="/*/html:td[1]" new-name="h3" new-namespace="http://www.w3.org/1999/xhtml"/>
                <p:rename match="/*/html:td[position()&gt;1]" new-name="div" new-namespace="http://www.w3.org/1999/xhtml"/>
            </p:for-each>
            <p:wrap-sequence wrapper="div" wrapper-namespace="http://www.w3.org/1999/xhtml"/>
            <p:add-attribute match="/*" attribute-name="class" attribute-value="document-info"/>
            <p:insert match="/*" position="first-child">
                <p:input port="insertion">
                    <p:inline>
                        <h2 xmlns="http://www.w3.org/1999/xhtml">Extended info</h2>
                    </p:inline>
                </p:input>
            </p:insert>
            <p:identity name="html.epubcheck.extended-info"/>
            <p:sink/>

        </p:when>
        <p:otherwise>
            <p:output port="validation-reports" sequence="true">
                <p:empty/>
            </p:output>
            <p:output port="extended-info" sequence="true">
                <p:empty/>
            </p:output>
            <p:sink>
                <p:input port="source">
                    <p:empty/>
                </p:input>
            </p:sink>
        </p:otherwise>
    </p:choose>

    <px:validation-report-to-html toc="false">
        <p:input port="source">
            <p:pipe port="not-matched" step="epubcheck-report-split"/>
        </p:input>
    </px:validation-report-to-html>
    <p:insert match="//html:body/*[1]" position="after">
        <p:input port="insertion">
            <p:pipe port="validation-reports" step="html.epubcheck"/>
        </p:input>
    </p:insert>
    <p:insert match="//html:body" position="last-child">
        <p:input port="insertion">
            <p:pipe port="extended-info" step="html.epubcheck"/>
        </p:input>
    </p:insert>

    <p:viewport match="//*[tokenize(lower-case(@class),'\s+')=('error','fatal','exception')]">
        <p:add-attribute match="/*" attribute-name="style">
            <p:with-option name="attribute-value" select="concat('background-color: #f2dede; ',/*/@style)"/>
        </p:add-attribute>
    </p:viewport>
    <p:viewport match="//*[tokenize(lower-case(@class),'\s+')=('warn','warning')]">
        <p:add-attribute match="/*" attribute-name="style">
            <p:with-option name="attribute-value" select="concat('background-color: #fcf8e3; ',/*/@style)"/>
        </p:add-attribute>
    </p:viewport>

    <p:identity name="html"/>
    <p:sink/>

</p:declare-step>
