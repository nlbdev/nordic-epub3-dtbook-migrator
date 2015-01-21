<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" xmlns:px="http://www.daisy.org/ns/pipeline/xproc" xmlns:d="http://www.daisy.org/ns/pipeline/data"
    type="px:nordic-format-html-report.step" name="main" version="1.0" xmlns:epub="http://www.idpf.org/2007/ops" xmlns:html="http://www.w3.org/1999/xhtml" xmlns:opf="http://www.idpf.org/2007/opf"
    xmlns:pxi="http://www.daisy.org/ns/pipeline/xproc/internal/nordic-epub3-dtbook-migrator">

    <p:input port="source" sequence="true"/>
    <p:output port="result" sequence="true">
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
    <p:delete match="/*/html:body/html:div[@class='document-validation-report' and count(*)=0]"/>

    <p:viewport match="//*[tokenize(lower-case(@class),'\s+')=('error','fatal','exception','message-error','message-fatal','message-exception')]">
        <p:add-attribute match="/*" attribute-name="style">
            <p:with-option name="attribute-value" select="concat('background-color: #f2dede; ',/*/@style)"/>
        </p:add-attribute>
    </p:viewport>
    <p:viewport match="//*[tokenize(lower-case(@class),'\s+')=('warn','warning','message-warn','message-warning')]">
        <p:add-attribute match="/*" attribute-name="style">
            <p:with-option name="attribute-value" select="concat('background-color: #fcf8e3; ',/*/@style)"/>
        </p:add-attribute>
    </p:viewport>

    <!--
        Improve HTML reports readability
        
        - xpath expressions are not useful for most people; make it more readable and put it into the "hover" text of the list item (title attribute)
        - delete <h3>Location (XPath)</h3> headlines
        - don't use full file: URIs in headlines
        - remove technical info from RNG messages
        - add information about inaccurate line numbers
        - add horizontal lines (<hr/>) between reports
    -->
    <p:viewport match="//html:li[.//html:pre[starts-with(text(),'/*')]]">
        <p:add-attribute match="/*" attribute-name="title">
            <p:with-option name="attribute-value" select="replace(replace((.//html:pre[starts-with(text(),'/*')]/text())[1],'\*:',''),'\[namespace[^\]]*\]','')"/>
        </p:add-attribute>
        <p:delete match=".//html:pre[starts-with(text(),'/*')]"/>
        <p:delete match=".//html:h3[text()='Location (XPath)']"/>
    </p:viewport>
    <p:viewport match="//html:h2[ancestor::html:div[@class='document-validation-report']]">
        <p:add-attribute match="/*" attribute-name="style">
            <p:with-option name="attribute-value" select="string-join((/*/@style,'font-size: 24px;'),' ')"/>
        </p:add-attribute>
        <p:rename match="html:code" new-name="span" new-namespace="http://www.w3.org/1999/xhtml"/>
        <p:viewport match=".//*[starts-with(text(),'file:')]">
            <p:string-replace match="/*/text()" replace="replace(/*/text(),'.*/','')"/>
        </p:viewport>
    </p:viewport>
    <p:viewport match="//html:h3[ancestor::html:div[@class='document-validation-report']]">
        <p:add-attribute match="/*" attribute-name="style">
            <p:with-option name="attribute-value" select="string-join((/*/@style,'font-size: 18px;'),' ')"/>
        </p:add-attribute>
    </p:viewport>
    <p:viewport match="//html:p[text()='0 issues found.']">
        <p:add-attribute match="/*" attribute-name="style">
            <p:with-option name="attribute-value" select="string-join((/*/@style, 'background-color: #AAFFAA;'),' ')"/>
        </p:add-attribute>
    </p:viewport>
    <p:viewport match="//html:p[starts-with(text(),'org.xml.sax.SAXParseException')]">
        <p:variable name="filename" select="if (matches(/*/text(),'systemId: [^;]*/')) then replace(/*/text(), '.*systemId: [^;]*/([^/;]*)(;.*|$)', '$1') else ''"/>
        <p:variable name="lineNumber" select="if (matches(/*/text(),'lineNumber: \d+')) then replace(/*/text(), '.*lineNumber: (\d+)(;.*|$)', '$1') else ''"/>
        <p:variable name="columnNumber" select="if (matches(/*/text(),'columnNumber: \d+')) then replace(/*/text(), '.*columnNumber: (\d+)(;.*|$)', '$1') else ''"/>
        <p:variable name="message" select="replace(/*/text(),'.*;','')"/>
        <p:string-replace match="/*/text()">
            <p:with-option name="replace"
                select="concat( '''', replace( string-join( ( string-join( ( $filename, if ($lineNumber or $columnNumber) then concat( if ($filename) then '(' else '' , string-join( ( if ($lineNumber) then concat( 'line: ', $lineNumber ) else (), if ($columnNumber) then concat( 'column: ', $columnNumber ) else () ), ', ' ), if ($filename) then ')' else '' ) else '' ), ' ' ), $message ), ': ' ), '''', '' ) , '''' )"
            />
        </p:string-replace>
    </p:viewport>
    <p:insert match="//html:ul[.//text()[contains(., 'line: ')]]" position="before">
        <p:input port="insertion">
            <p:inline>
                <p xmlns="http://www.w3.org/1999/xhtml">Note that line numbers tend to be offset by a couple of lines because the doctype and xml declarations are not counted as lines.</p>
            </p:inline>
        </p:input>
    </p:insert>
    <p:insert match="//html:div[@class='document-validation-report']" position="last-child">
        <p:input port="insertion">
            <p:inline>
                <hr xmlns="http://www.w3.org/1999/xhtml"/>
            </p:inline>
        </p:input>
    </p:insert>

    <p:identity name="html"/>
    <p:sink/>

</p:declare-step>
