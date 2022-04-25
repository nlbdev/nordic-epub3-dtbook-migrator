<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
                xmlns:c="http://www.w3.org/ns/xproc-step"
                xmlns:px="http://www.daisy.org/ns/pipeline/xproc"
                xmlns:d="http://www.daisy.org/ns/pipeline/data"
                xmlns:opf="http://www.idpf.org/2007/opf"
                xmlns:html="http://www.w3.org/1999/xhtml"
                xmlns:dtbook="http://www.daisy.org/z3986/2005/dtbook/"
                type="px:nordic-determine-guidelines-version"
                name="main" version="1.0">

    <p:option name="href" required="true">
        <p:documentation>The full path to an .epub or .opf file.</p:documentation>
    </p:option>

    <p:output port="result">
        <p:documentation>The OPF meta element for the guidelines version (&lt;meta property="nordic:guidelines"&gt;…&lt;/meta&gt;).</p:documentation>
    </p:output>

    <p:import href="http://www.daisy.org/pipeline/modules/fileset-utils/library.xpl">
        <p:documentation>
            px:fileset-load
        </p:documentation>
    </p:import>
    <p:import href="http://www.daisy.org/pipeline/modules/epub-utils/library.xpl">
        <p:documentation>
            px:epub-load
        </p:documentation>
    </p:import>
    
    <p:choose>
        <p:when test="ends-with($href, '.xhtml') or ends-with($href, '.html')">
            <!-- HTML fileset -->
            
            <!-- load the HTML -->
            <p:load>
                <p:with-option name="href" select="$href"></p:with-option>
            </p:load>
            
            <!-- get the nordic:guidelines metadata (default to "unknown" if none were found - so that there is always exactly one meta element returned) -->
            <p:filter select="/html:html/html:head/html:meta[lower-case(@name) = 'nordic:guidelines']" name="html.versions"/>
            <p:identity>
                <p:input port="source">
                    <p:pipe port="result" step="html.versions"/>
                    <p:inline><html:meta name="nordic:guidelines" content="unknown"/></p:inline>
                </p:input>
            </p:identity>
            <p:split-sequence test="position()=1"/>
            
            <!-- convert from HTML meta element to OPF meta element -->
            <p:template>
                <p:input port="parameters">
                    <p:empty/>
                </p:input>
                <p:input port="template">
                    <p:inline exclude-inline-prefixes="#all">
                        <meta xmlns="http://www.idpf.org/2007/opf" property="nordic:guidelines">{string(/*/@content)}</meta>
                    </p:inline>
                </p:input>
            </p:template>
        </p:when>
        
        <p:when test="ends-with($href, '.xml')">
            <!-- DTBook fileset -->
            
            <!-- load the HTML -->
            <p:load>
                <p:with-option name="href" select="$href"></p:with-option>
            </p:load>
            
            <!-- get the track:Guidelines metadata (default to "unknown" if none were found - so that there is always exactly one meta element returned) -->
            <p:filter select="/dtbook:dtbook/dtbook:head/dtbook:meta[lower-case(@name) = 'track:guidelines']" name="dtbook.versions"/>
            <p:identity>
                <p:input port="source">
                    <p:pipe port="result" step="dtbook.versions"/>
                    <p:inline><dtbook:meta name="track:Guidelines" content="unknown"/></p:inline>
                </p:input>
            </p:identity>
            <p:split-sequence test="position()=1"/>
            
            <!-- convert from DTBook meta element to OPF meta element -->
            <p:template>
                <p:input port="parameters">
                    <p:empty/>
                </p:input>
                <p:input port="template">
                    <p:inline exclude-inline-prefixes="#all">
                        <meta xmlns="http://www.idpf.org/2007/opf" property="nordic:guidelines">{string(/*/@content)}</meta>
                    </p:inline>
                </p:input>
            </p:template>
        </p:when>
        
        <p:otherwise>
            <!-- EPUB file/fileset -->
    
            <!-- create a fileset for the EPUB -->
            <px:epub-load name="epub.load">
                <p:with-option name="href" select="$href"/>
            </px:epub-load>
            
            <!-- load the OPF -->
            <px:fileset-load media-types="application/oebps-package+xml" fail-on-not-found="true">
                <p:input port="in-memory">
                    <p:pipe port="result.in-memory" step="epub.load"/>
                </p:input>
            </px:fileset-load>
            <p:split-sequence test="position()=1"/>
            
            <!-- get the nordic:guidelines metadata (default to "unknown" if none were found - so that there is always exactly one meta element returned) -->
            <p:filter select="/opf:package/opf:metadata/opf:meta[lower-case(@property) = 'nordic:guidelines']" name="epub.versions"/>
            <p:identity>
                <p:input port="source">
                    <p:pipe port="result" step="epub.versions"/>
                    <p:inline><meta xmlns="http://www.idpf.org/2007/opf" property="nordic:guidelines">unknown</meta></p:inline>
                </p:input>
            </p:identity>
            <p:split-sequence test="position()=1"/>
        </p:otherwise>
    </p:choose>

</p:declare-step>
