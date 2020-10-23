<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" version="1.0"
                xmlns:px="http://www.daisy.org/ns/pipeline/xproc"
                type="px:nordic-opf-to-html-metadata" name="main">

	<p:input port="source"/>
	<p:output port="result"/>

	<!-- for testing purposes -->
	<p:input port="parameters" kind="parameter" primary="false"/>

	<p:import href="http://www.daisy.org/pipeline/modules/epub3-to-html/library.xpl">
		<p:documentation>
			px:opf-to-html-metadata
		</p:documentation>
	</p:import>

	<px:opf-to-html-metadata>
		<p:input port="parameters">
			<p:pipe step="main" port="parameters"/>
		</p:input>
	</px:opf-to-html-metadata>

	<!--
	    Add viewport, reorder meta elements, add namespace declarations.
	    The epub:prefix attribute normalized later when px:nordic-update-epub-prefixes is applied.
	-->
	<p:xslt>
		<p:input port="stylesheet">
			<p:document href="../../xslt/process-html-metadata.xsl"/>
		</p:input>
		<p:input port="parameters">
			<p:empty/>
		</p:input>
	</p:xslt>

</p:declare-step>
