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

	<p:import href="http://www.daisy.org/pipeline/modules/epub3-utils/library.xpl">
		<p:documentation>
			px:epub3-merge-prefix
			px:epub3-add-prefix
		</p:documentation>
	</p:import>

	<px:epub3-merge-prefix>
		<p:with-option name="implicit-input-prefixes"  select="'a11y:      http://www.idpf.org/epub/vocab/package/a11y/#
		                                                        dc:        http://purl.org/dc/elements/1.1/
		                                                        dcterms:   http://purl.org/dc/terms/
		                                                        epubsc:    http://idpf.org/epub/vocab/sc/#
		                                                        marc:      http://id.loc.gov/vocabulary/
		                                                        media:     http://www.idpf.org/epub/vocab/overlays/#
		                                                        msv:       http://www.idpf.org/epub/vocab/structure/magazine/#
		                                                        nordic:    http://www.mtm.se/epub/
		                                                        onix:      http://www.editeur.org/ONIX/book/codelists/current.html#
		                                                        prism:     http://www.prismstandard.org/specifications/3.0/PRISM_CV_Spec_3.0.htm#
		                                                        rendition: http://www.idpf.org/vocab/rendition/#
		                                                        schema:    http://schema.org/
		                                                        xsd:       http://www.w3.org/2001/XMLSchema#
		                                                        z3998:     http://www.daisy.org/z3998/2012/vocab/structure/#'"/>
		<p:with-option name="implicit-output-prefixes" select="'dc:        http://purl.org/dc/elements/1.1/
		                                                        dcterms:   http://purl.org/dc/terms/'"/>
	</px:epub3-merge-prefix>

	<px:epub3-add-prefix prefixes="nordic: http://www.mtm.se/epub/"/>

</p:declare-step>

