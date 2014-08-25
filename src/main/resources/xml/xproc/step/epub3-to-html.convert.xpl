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

    <p:import href="http://www.daisy.org/pipeline/modules/html-utils/library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/fileset-utils/library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/common-utils/library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/mediatype-utils/library.xpl"/>

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
    <p:group>
        <p:variable name="nav-href" select="resolve-uri(/*/@href,base-uri(/*))"/>
        <px:message message="Loading Navigation Document: $1">
            <p:with-option name="param1" select="$nav-href"/>
        </px:message>
        <px:fileset-load>
            <p:input port="fileset">
                <p:pipe port="fileset.in" step="main"/>
            </p:input>
            <p:input port="in-memory">
                <p:pipe port="in-memory.in" step="main"/>
            </p:input>
            <p:with-option name="href" select="$nav-href"/>
        </px:fileset-load>
        <px:assert test-count-min="1" test-count-max="1" message="The Navigation Document must exist: $1" error-code="NORDICDTBOOKEPUB013">
            <p:with-option name="param1" select="$nav-href"/>
        </px:assert>
    </p:group>
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

    <p:string-replace match="//html:h1/text()">
        <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
                <header xmlns="http://www.w3.org/1999/xhtml">
                    <h1 epub:type="fulltitle">FULLTITLE</h1>
                </header>
            </p:inline>
        </p:input>
        <p:with-option name="replace" select="concat('&quot;',replace(//html:title/text(),'&quot;','&amp;quot;'),'&quot;')">
            <p:pipe port="result" step="single-html.metadata"/>
        </p:with-option>
    </p:string-replace>
    <p:insert match="/*" position="last-child">
        <p:input port="insertion" select="//html:meta[@name='dc:creator']">
            <p:pipe port="result" step="single-html.metadata"/>
        </p:input>
    </p:insert>
    <p:insert match="/*" position="last-child">
        <p:input port="insertion" select="//html:meta[@name='z3998:covertitle']">
            <p:pipe port="result" step="single-html.metadata"/>
        </p:input>
    </p:insert>
    <p:rename match="/*/html:meta" new-name="p" new-namespace="http://www.w3.org/1999/xhtml"/>
    <p:insert match="//html:p" position="first-child">
        <p:input port="insertion">
            <p:inline exclude-inline-prefixes="#all">
                <html:span>TEXT</html:span>
            </p:inline>
        </p:input>
    </p:insert>
    <p:unwrap match="//html:p/html:span"/>
    <p:viewport match="//html:p">
        <p:string-replace match="/*/text()" replace="/*/@content"/>
    </p:viewport>
    <p:add-attribute match="//html:p[@name='dc:creator']" attribute-name="epub:type" attribute-value="z3998:author"/>
    <p:add-attribute match="//html:p[@name='z3998:covertitle']" attribute-name="epub:type" attribute-value="z3998:covertitle"/>
    <p:delete match="//html:p/@*[not(name()='epub:type')]"/>
    <p:identity name="single-html.body.header"/>

    <p:replace match="//html:head">
        <p:input port="source">
            <p:pipe port="result" step="single-html.body"/>
        </p:input>
        <p:input port="replacement" select="//html:head">
            <p:pipe port="result" step="single-html.metadata"/>
        </p:input>
    </p:replace>
    <p:insert match="/*/html:body" position="first-child">
        <p:input port="insertion">
            <p:pipe port="result" step="single-html.body.header"/>
        </p:input>
    </p:insert>
    <p:add-attribute match="/*" attribute-name="xml:lang">
        <p:with-option name="attribute-value" select="/*/html:head/html:meta[@name='dc:language']/@content"/>
    </p:add-attribute>
    <p:add-attribute attribute-name="xml:base" match="/*">
        <p:with-option name="attribute-value"
            select="replace(base-uri(/*),'[^/]+$',concat((/*/html:head/html:meta[lower-case(@name)=('dc:identifier','dct:identifier','dtb:uid','dc:title')]/string(@content), /*/html:head/html:title/normalize-space(.))[1],'.xhtml'))"
        />
    </p:add-attribute>
    <p:viewport match="//*[@xml:lang]">
        <p:add-attribute match="/*" attribute-name="lang">
            <p:with-option name="attribute-value" select="/*/@xml:lang"/>
        </p:add-attribute>
    </p:viewport>
    <p:identity name="in-memory"/>

    <px:html-to-fileset>
        <p:input port="source">
            <p:pipe port="result" step="in-memory"/>
        </p:input>
    </px:html-to-fileset>
    <p:delete match="//d:file[preceding-sibling::d:file/resolve-uri(@href,base-uri(.))=resolve-uri(@href,base-uri(.))]"/>
    <p:viewport match="//d:file[starts-with(@media-type,'image/')]">
        <p:add-attribute match="/*" attribute-name="original-href">
            <p:with-option name="attribute-value" select="resolve-uri(/*/@href,base-uri(/*))"/>
        </p:add-attribute>
        <p:add-attribute match="/*" attribute-name="href">
            <p:with-option name="attribute-value" select="replace(/*/@href,'^images/','')"/>
        </p:add-attribute>
    </p:viewport>
    <px:fileset-add-entry media-type="application/xhtml+xml">
        <p:with-option name="href" select="base-uri(/*)">
            <p:pipe port="result" step="in-memory"/>
        </p:with-option>
    </px:fileset-add-entry>
    <p:add-attribute match="//d:file[@media-type='application/xhtml+xml']" attribute-name="omit-xml-declaration" attribute-value="false"/>
    <p:add-attribute match="//d:file[@media-type='application/xhtml+xml']" attribute-name="version" attribute-value="1.0"/>
    <p:add-attribute match="//d:file[@media-type='application/xhtml+xml']" attribute-name="encoding" attribute-value="utf-8"/>
    <px:mediatype-detect/>
    <p:identity name="fileset"/>

</p:declare-step>
