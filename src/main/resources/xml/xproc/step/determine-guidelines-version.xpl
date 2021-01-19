<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
                xmlns:c="http://www.w3.org/ns/xproc-step"
                xmlns:px="http://www.daisy.org/ns/pipeline/xproc"
                xmlns:d="http://www.daisy.org/ns/pipeline/data"
                xmlns:opf="http://www.idpf.org/2007/opf"
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
    
    <!-- create a fileset for the EPUB -->
    <px:epub-load name="determine-guidelines-version.epub-load">
        <p:with-option name="href" select="$href"/>
    </px:epub-load>
    
    <!-- load the OPF -->
    <px:fileset-load media-types="application/oebps-package+xml" fail-on-not-found="true">
        <p:input port="in-memory">
            <p:pipe port="result.in-memory" step="determine-guidelines-version.epub-load"/>
        </p:input>
    </px:fileset-load>
    <p:split-sequence test="position()=1"/>
    
    <!-- get the nordic:guidelines metadata (default to "unknown" if none were found - so that there is always exactly one meta element returned) -->
    <p:filter select="/opf:package/opf:metadata/opf:meta[@property='nordic:guidelines']" name="determine-guidelines-version.versions"/>
    <p:identity>
        <p:input port="source">
            <p:pipe port="result" step="determine-guidelines-version.versions"/>
            <p:inline><opf:meta property="nordic:guidelines">unknown</opf:meta></p:inline>
        </p:input>
    </p:identity>
    <p:split-sequence test="position()=1"/>

</p:declare-step>
