<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" version="1.0"
                xmlns:px="http://www.daisy.org/ns/pipeline/xproc"
                xmlns:pxi="http://www.daisy.org/ns/pipeline/xproc/internal"
                xmlns:html="http://www.w3.org/1999/xhtml"
                type="px:html-to-dtbook" name="main">

    <p:input port="source.fileset" primary="true"/>
    <p:input port="source.in-memory" sequence="true">
        <p:empty/>
    </p:input>

    <p:output port="result.fileset" primary="true"/>
    <p:output port="result.in-memory" sequence="true">
        <p:pipe step="add-dtbook" port="result.in-memory"/>
    </p:output>

    <p:option name="dtbook-file-name" select="''">
        <p:documentation xmlns="http://www.w3.org/1999/xhtml">
            <p>Defaults to the name of the HTML file with file extension ".xml"</p>
        </p:documentation>
    </p:option>
    <p:option name="imply-headings" select="'false'">
        <p:documentation xmlns="http://www.w3.org/1999/xhtml">
            <p>Whether to generate headings for untitled levels.</p>
        </p:documentation>
    </p:option>

    <p:import href="http://www.daisy.org/pipeline/modules/fileset-utils/library.xpl">
        <p:documentation>
            px:fileset-load
            px:fileset-filter
            px:fileset-add-entry
        </p:documentation>
    </p:import>
    <p:import href="http://www.daisy.org/pipeline/modules/html-utils/library.xpl">
        <p:documentation>
            px:html-outline
        </p:documentation>
    </p:import>
    <p:import href="http://www.daisy.org/pipeline/modules/common-utils/library.xpl">
        <p:documentation>
            px:assert
        </p:documentation>
    </p:import>
    <p:import href="http://www.daisy.org/pipeline/modules/file-utils/library.xpl">
        <p:documentation>
            px:set-base-uri
        </p:documentation>
    </p:import>
    <p:import href="extract-svg.xpl">
        <p:documentation>
            pxi:html-extract-svg
        </p:documentation>
    </p:import>

    <!--
        Load HTML
    -->
    <px:fileset-filter media-types="application/xhtml+xml" name="filter-html">
        <p:input port="source.in-memory">
            <p:pipe step="main" port="source.in-memory"/>
        </p:input>
    </px:fileset-filter>
    <px:fileset-load>
        <p:input port="in-memory">
            <p:pipe step="main" port="source.in-memory"/>
        </p:input>
    </px:fileset-load>
    <px:assert test-count-min="1" test-count-max="1" message="There must be exactly one HTML file in the fileset." error-code="XXXXX"/>
    <px:assert message="The HTML file must have a file extension." error-code="XXXXX">
        <p:with-option name="test" select="$dtbook-file-name!='' or matches(base-uri(/*),'.*[^\.]\.[^\.]*$')"/>
    </px:assert>
    <p:identity name="html"/>

    <!--
        epub3-to-dtbook.xsl makes certain assumptions about the input structure
        - sectioning content elements have sectioning (root/content) element as parent
        - heading elements have sectioning element as parent
        - body becomes book
        - child 'header' element of body becomes doctitle/covertitle/docauthor
        - child sectionining elements of body become frontmatter/bodymatter/rearmatter
    -->
    <p:group name="prepare-html">
        <p:output port="result"/>
        <!--
            Add missing sectioning elements so that there are no implied sections
        -->
        <px:html-outline fix-sectioning="no-implied" name="fix-sectioning"
                         output-base-uri="file:/tmp/irrelevant.html"/>
        <p:sink/>
        <!--
            Move everything one level down if step above resulted in multiple body elements
        -->
        <p:wrap match="/*/html:body[preceding-sibling::html:body|following-sibling::html:body]"
                group-adjacent="true()" wrapper="html:body">
            <p:input port="source">
                <p:pipe step="fix-sectioning" port="content-doc"/>
            </p:input>
        </p:wrap>
        <p:rename match="/*/html:body/html:body" new-name="html:section"/>
        <!--
            Move body one level down if it contains content beside sectioning and heading elements
        -->
        <p:wrap match="/*/html:body[text()[normalize-space()]
                                   |*[not(self::html:section  |self::html:h1
                                         |self::html:article  |self::html:h2
                                         |self::html:aside    |self::html:h3
                                         |self::html:nav      |self::html:h4
                                         |self::html:header   |self::html:h5
                                         |self::html:hgroup   |self::html:h6
                                         )]]"
                wrapper="html:body"/>
        <p:rename match="/*/html:body/html:body" new-name="html:section"/>
        <!--
            Add missing headings
        -->
        <p:choose>
            <p:when test="$imply-headings='true'">
                <px:html-outline fix-untitled-sections="imply-heading" name="fix-untitled-sections"
                                 output-base-uri="file:/tmp/irrelevant.html"/>
                <p:sink/>
                <p:identity>
                    <p:input port="source">
                        <p:pipe step="fix-untitled-sections" port="content-doc"/>
                    </p:input>
                </p:identity>
            </p:when>
            <p:otherwise>
                <p:identity/>
            </p:otherwise>
        </p:choose>
        <!--
            Wrap body's heading element inside header
        -->
        <p:wrap match="/*/html:body/*[self::html:h1
                                     |self::html:h2
                                     |self::html:h3
                                     |self::html:h4
                                     |self::html:h5
                                     |self::html:hgroup]"
                group-adjacent="true()" wrapper="html:header"/>
        <!--
            Move sectioning and heading elements up
        -->
        <p:xslt>
            <p:input port="stylesheet">
                <p:document href="../xslt/prepare-html.xsl"/>
            </p:input>
            <p:input port="parameters">
                <p:empty/>
            </p:input>
        </p:xslt>
    </p:group>
    <p:sink/>

    <!--
        Extract SVG images into their own files and link to with img element
    -->
    <pxi:html-extract-svg name="extract-svg">
        <p:input port="source.fileset">
            <p:pipe step="main" port="source.fileset"/>
        </p:input>
        <p:input port="source.in-memory">
            <p:pipe step="prepare-html" port="result"/>
            <p:pipe step="filter-html" port="not-matched.in-memory"/>
        </p:input>
    </pxi:html-extract-svg>

    <!--
        Convert HTML to DTBook
    -->
    <px:fileset-filter media-types="application/xhtml+xml" name="filter-html-2">
        <p:input port="source.in-memory">
            <p:pipe step="extract-svg" port="result.in-memory"/>
        </p:input>
    </px:fileset-filter>
    <p:sink/>
    <p:xslt>
        <p:input port="source">
            <p:pipe step="filter-html-2" port="result.in-memory"/>
        </p:input>
        <p:input port="stylesheet">
            <p:document href="../xslt/epub3-to-dtbook.xsl"/>
        </p:input>
        <p:input port="parameters">
            <p:empty/>
        </p:input>
    </p:xslt>
    <px:set-base-uri>
        <p:with-option name="base-uri"
                       select="resolve-uri(($dtbook-file-name[.!=''],
                                            concat(replace(base-uri(/*),'^(.*)\.[^/\.]*$','$1'),'.xml'))[1],
                                           base-uri(/*))"/>
    </px:set-base-uri>
    <p:identity name="dtbook"/>
    <p:sink/>

    <!--
        Combine DTBook with resources
    -->
    <px:fileset-filter not-media-types="text/css" name="filter-resources">
        <p:input port="source">
            <p:pipe step="filter-html-2" port="not-matched"/>
        </p:input>
        <p:input port="source.in-memory">
            <p:pipe step="filter-html-2" port="not-matched.in-memory"/>
        </p:input>
    </px:fileset-filter>
    <px:fileset-add-entry media-type="application/x-dtbook+xml" name="add-dtbook">
        <p:input port="source.in-memory">
            <p:pipe step="filter-resources" port="result.in-memory"/>
        </p:input>
        <p:input port="entry">
            <p:pipe step="dtbook" port="result"/>
        </p:input>
        <p:with-param port="file-attributes" name="omit-xml-declaration" select="'false'"/>
        <p:with-param port="file-attributes" name="version" select="'1.0'"/>
        <p:with-param port="file-attributes" name="encoding" select="'utf-8'"/>
        <p:with-param port="file-attributes" name="doctype-public" select="'-//NISO//DTD dtbook 2005-3//EN'"/>
        <p:with-param port="file-attributes" name="doctype-system" select="'http://www.daisy.org/z3986/2005/dtbook-2005-3.dtd'"/>
    </px:fileset-add-entry>

</p:declare-step>
