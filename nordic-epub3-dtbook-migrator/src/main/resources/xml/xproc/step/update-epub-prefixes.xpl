<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" version="1.0"
                xmlns:px="http://www.daisy.org/ns/pipeline/xproc"
                type="px:nordic-update-epub-prefixes">

	<p:documentation xmlns="http://www.w3.org/1999/xhtml">
		<p>Merge all <code>epub:prefix</code> attributes into a single one and declare missing
		prefixes.</p>
	</p:documentation>

	<p:input port="source">
		<p:documentation xmlns="http://www.w3.org/1999/xhtml">
			<p>An HTML document.</p>
		</p:documentation>
	</p:input>
	<p:output port="result"/>

	<p:xslt>
		<p:input port="stylesheet">
			<p:document href="../../xslt/update-epub-prefixes.xsl"/>
		</p:input>
		<p:input port="parameters">
			<p:empty/>
		</p:input>
	</p:xslt>

</p:declare-step>

