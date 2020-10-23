<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" version="1.0"
                xmlns:px="http://www.daisy.org/ns/pipeline/xproc"
                type="px:nordic-pretty-print">

	<p:input port="source"/>
	<p:output port="result"/>
	<p:option name="preserve-empty-whitespace" select="'true'"/>

	<p:xslt>
		<p:with-param name="preserve-empty-whitespace" select="$preserve-empty-whitespace"/>
		<p:input port="stylesheet">
			<p:document href="../../xslt/pretty-print.xsl"/>
		</p:input>
	</p:xslt>

</p:declare-step>
