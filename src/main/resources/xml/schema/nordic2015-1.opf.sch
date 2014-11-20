<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">

    <title>Schematron tests for Nordic EPUB 2015-1 OPF rules</title>

    <ns prefix="opf" uri="http://www.idpf.org/2007/opf"/>
    <ns prefix="dc" uri="http://purl.org/dc/elements/1.1/"/>
    <ns prefix="epub" uri="http://www.idpf.org/2007/ops"/>
    <ns prefix="nordic" uri="http://www.mtm.se/epub/"/>

    <pattern id="opf_nordic_1">
        <rule context="/*">
            <assert test="ends-with(base-uri(/*),'.opf')">[opf1] the OPF file must have the extension .opf</assert>
            <assert test="matches(base-uri(/*),'.*/package.opf')">[opf1] the filename of the OPF must be package.opf</assert>
            <assert test="matches(base-uri(/*),'EPUB/package.opf')">[opf1] the OPF must be contained in a folder named EPUB</assert>
        </rule>
    </pattern>

    <pattern id="opf_nordic_2">
        <rule context="opf:package">
            <assert test="@version = '3.0'">[opf2] the version attribute must be 3.0</assert>
            <assert test="@unique-identifier = 'pub-identifier'">[opf2] on the package element; the unique-identifier-attribute must be present and equal 'pub-identifier'</assert>
            <assert test="namespace-uri-for-prefix('dc',.) = 'http://purl.org/dc/elements/1.1/'">[opf2] on the package element; the dublin core namespace (xmlns:dc="http://purl.org/dc/elements/1.1/")
                must be declared on the package element</assert>
            <assert test="@prefix = 'nordic: http://www.mtm.se/epub/'">[opf2] on the package element; the prefix attribute must declare the nordic metadata namespace (prefix="nordic:
                http://www.mtm.se/epub/")</assert>
        </rule>
    </pattern>

    <pattern id="opf_nordic_3">
        <rule context="opf:metadata">
            <assert test="count(dc:identifier) = 1">[opf3a] there must be exactly one dc:identifier element</assert>
            <assert test="parent::opf:package/@unique-identifier = dc:identifier/@id">[opf3a] the id of the dc:identifier must equal the value of the package elements unique-identifier
                attribute</assert>

            <assert test="count(dc:title[not(@refines)]) = 1">[opf3b] exactly one dc:title (without a "refines" attribute) must be present</assert>

            <assert test="count(dc:language[not(@refines)]) = 1">[opf3c] exactly one dc:language (without a "refines" attribute) must be present</assert>
            <assert test="matches(dc:language, '^[a-z][a-z](-[A-Z][A-Z])?$')">[opf3c] the language code must be either a "two-letter lower case" code or a "two-letter lower case + hyphen + two-letter
                upper case" code</assert>
            <!--<assert test="dc:language = ('no','nn-NO','nb-NO','sv','sv-FI','fi','da','en','de','de-CH','fr')" flag="warning">the language code should be one of: 'no' (Norwegian), 'nn-NO' (Norwegian
                Nynorsk), 'nb-NO' (Norwegian Bokmål), 'sv' (Swedish), 'sv-FI' (Swedish (Finland)), 'fi' (Finnish), 'da' (Danish), 'en' (English), 'de' (German), 'de-CH' (German (Switzerland)), 'fr'
                (French)</assert>-->

            <assert test="count(dc:date[not(@refines)]) = 1">[opf3d] exactly one dc:date (without a "refines" attribute) must be present</assert>
            <assert test="matches(dc:date[not(@refines)], '\d\d\d\d-\d\d-\d\d')">[opf3d] the dc:date must be of the format YYYY-MM-DD (year-month-day)</assert>

            <assert test="count(dc:publisher[not(@refines)]) = 1">[opf3e] exactly one dc:publisher (without a "refines" attribute) must be present</assert>
            <!--<assert test="dc:publisher[not(@refines)] = ('TPB','MTM','SPSM','Nota','NLB','Celia','SBS')" flag="warning">the publisher should be one of:
                'TPB','MTM','SPSM','Nota','NLB','Celia','SBS'</assert>-->

            <assert test="opf:meta[@property='dcterms:modified' and not(@refines)]">[opf3f] a last modified date must be present</assert>
            <assert test="matches(opf:meta[@property='dcterms:modified' and not(@refines)], '\d\d\d\d-\d\d-\d\dT\d\d:\d\d:\d\dZ')">[opf3f] the last modified date must be use UTC time and be on the
                form "CCYY-MM-DDThh:mm:ssZ" (year-month-date "T" hour:minute:second "Z")</assert>

            <assert test="count(dc:creator[not(@refines)]) &gt;= 1">[opf3g] at least one author (dc:creator; without a "refines" attribute) must be present</assert>

            <!-- dc:contributor not required -->

            <assert test="count(dc:source[not(@refines)]) = 1">[opf3h] exactly one dc:source (without a "refines" attribute) must be present</assert>
            <assert test="starts-with(dc:source[not(@refines)],'urn:isbn:')">[opf3h] the dc:source must start with 'urn:isbn:'</assert>
            <assert test="matches(dc:source[not(@refines)],'urn:isbn:[\d-]+')">the ISBN can only contain numbers and hyphens</assert>

            <assert test="count(opf:meta[@property='nordic:guidelines' and not(@refines)]) = 1">[opf3i] there must be exactly one meta element with the property "nordic:guidelines" (without a
                "refines" attribute)</assert>
            <assert test="opf:meta[@property='nordic:guidelines' and not(@refines)] = '2015-1'">[opf3i] the value of nordic:guidelines must be '2015-1'</assert>

            <assert test="count(opf:meta[@property='nordic:supplier' and not(@refines)]) = 1">[opf3j] there must be exactly one meta element with the property "nordic:supplier" (without a "refines"
                attribute)</assert>
        </rule>
    </pattern>

    <pattern id="opf_nordic_4">
        <rule context="opf:meta[@property and not(@refines)]">
            <assert test="parent::*/opf:meta/@name = @property">[opf4] all EPUB3 meta elements without a refines attribute must have an equivalent OPF2 meta element (&lt;meta name="..."
                content="..."/&gt;)</assert>
            <assert test="parent::*/opf:meta[@name = current()/@property]/string(@content) = string(.)">[opf4] the value of the EPUB3 meta elements must equal their equivalent OPF2 meta
                elements</assert>
        </rule>
    </pattern>

    <pattern id="opf_nordic_5_a">
        <rule context="opf:manifest">
            <assert test="opf:item[@media-type='application/x-dtbncx+xml']">[opf5a] a NCX must be present in the manifest (media-type="application/x-dtbncx+xml")</assert>
        </rule>
    </pattern>

    <pattern id="opf_nordic_5_b">
        <rule context="opf:item[@media-type='application/x-dtbncx+xml']">
            <assert test="@href = 'nav.ncx'">[opf5b] the NCX must be located in the same directory as the package document, and must be named 'nav.ncx'</assert>
        </rule>
    </pattern>

    <pattern id="opf_nordic_6">
        <rule context="opf:spine">
            <assert test="@toc">the toc attribute must be present</assert>
            <assert test="/opf:package/opf:manifest/opf:item/@id = @toc">[opf6] the toc attribute must refer to an item in the manifest</assert>
        </rule>
    </pattern>

    <pattern id="opf_nordic_7">
        <rule context="opf:item[@media-type='application/xhtml+xml' and tokenize(@properties,'\s+')='nav']">
            <assert test="@href = 'nav.xhtml'">[opf7] the Navigation Document must be located in the same directory as the package document, and must be named 'nav.xhtml'</assert>
        </rule>
    </pattern>

    <pattern id="opf_nordic_8">
        <rule context="opf:item[starts-with(@media-type,'image/')]">
            <assert test="matches(@href,'^images/[^/]+$')">[opf8] all images must be stored in the "images" directory (which is a subdirectory relative to the package document)</assert>
        </rule>
    </pattern>

    <pattern id="opf_nordic_9">
        <rule context="opf:item[@media-type='application/xhtml+xml' and not(tokenize(@properties,'\s+')='nav')]">
            <report test="contains(@href,'/')">[opf9] all content files must be located in the same directory as the package document</report>
            <assert test="matches(@href,'^[^-]+-\d+-\w+.xhtml$')">[opf9] all content files must have a filename matching "[identifier]-[position]-[type].xhtml"; for instance
                "C00000-03-chapter.xhtml"</assert>
        </rule>
    </pattern>

    <pattern id="opf_nordic_10">
        <rule context="opf:itemref[../../opf:manifest/opf:item[@media-type='application/xhtml+xml' and ends-with(@href,'-cover.xhtml')]/@id = @idref]">
            <assert test="@linear = 'no'">[opf10] Cover must be marked as secondary in the spine (i.e. set linear="no" on the itemref element corresponding to the cover)</assert>
        </rule>
    </pattern>

    <pattern id="opf_nordic_11">
        <rule context="opf:itemref[../../opf:manifest/opf:item[@media-type='application/xhtml+xml' and ends-with(@href,'-rearnotes.xhtml')]/@id = @idref]">
            <assert test="@linear = 'no'">[opf11] Rearnotes must be marked as secondary in the spine (i.e. set linear="no" on the itemref element corresponding to the rearnote)</assert>
        </rule>
    </pattern>

    <pattern id="opf_nordic_12_a">
        <rule context="opf:item[@media-type='application/xhtml+xml' and not(@href='nav.xhtml' or tokenize(@properties,'\s+')='nav')]">
            <assert test="matches(@href,'^.*-\d+-[a-z]+\.xhtml$')">[opf12a] Content documents must match the "[identifier]-[number]-[string].xhtml" file naming convention.</assert>
        </rule>
    </pattern>

    <pattern id="opf_nordic_12_b">
        <rule context="opf:item[@media-type='application/xhtml+xml' and not(@href='nav.xhtml' or tokenize(@properties,'\s+')='nav') and matches(@href,'^.*-\d+-[a-z]+\.xhtml$')]">
            <let name="identifier" value="replace(@href,'^(.*)-\d+-[a-z]+.xhtml$','$1')"/>
            <let name="position" value="replace(@href,'^.*-(\d+)-[a-z]+.xhtml$','$1')"/>
            <let name="type" value="replace(@href,'^.*-\d+-([a-z]+).xhtml$','$1')"/>
            <assert
                test="$type = ('cover','frontmatter','bodymatter','backmatter','acknowledgments','afterword','appendix','assessment','bibliography','chapter','colophon','conclusion','contributors','dedication','discography','division','epigraph','epilogue','errata','filmography','footnotes','foreword','glossary','halftitlepage','imprimatur','imprint','index','introduction','landmarks','loa','loi','lot','lov','notice','part','practices','preamble','preface','prologue','qna','rearnotes','section','standard','subchapter','subsection','titlepage','toc','volume','warning')"
                >[opf12b] The filename of content documents must end with a epub:type value (the same as the one used on the content documents body tag).</assert>
            <assert
                test="string-length($position) = string-length(../opf:item[@media-type='application/xhtml+xml' and not(@href='nav.xhtml' or tokenize(@properties,'\s+')='nav') and matches(@href,'^.*-\d+-[a-z]+\.xhtml$')][1]/replace(@href,'^.*-(\d+)-[a-z]+.xhtml$','$1'))"
                >[opf12b] The numbering of the content documents must all have the equal number of digits.</assert>
            <report
                test="number($position) = ( (../opf:item except .)[@media-type='application/xhtml+xml' and not(@href='nav.xhtml' or tokenize(@properties,'\s+')='nav') and matches(@href,'^.*-\d+-[a-z]+\.xhtml$')]/number(replace(@href,'^.*-(\d+)-[a-z]+.xhtml$','$1')) )"
                >[opf12b] The numbering of the content documents must be unique for each content document. <value-of select="$position"/> is also used by another content document in the OPF.</report>
            <assert
                test="number($position)-1 = ( 0 , (../opf:item except .)[@media-type='application/xhtml+xml' and not(@href='nav.xhtml' or tokenize(@properties,'\s+')='nav') and matches(@href,'^.*-\d+-[a-z]+\.xhtml$')]/number(replace(@href,'^.*-(\d+)-[a-z]+.xhtml$','$1')) )"
                >[opf12b] The numbering of the content documents must start at 1 and increase with 1 for each item.</assert>
            <assert test="../../opf:spine/opf:itemref[xs:integer(number($position))]/@idref = @id">[opf12b] iremref #<value-of select="$position"/> (with the id: <value-of
                    select="../../opf:spine/opf:itemref[xs:integer(number($position))]/@id"/>) should refer to item with href="<value-of select="@href"/>".</assert>
        </rule>
    </pattern>

    <pattern id="opf_nordic_13">
        <rule context="opf:item[@media-type='application/xhtml+xml' and @href='nav.xhtml']">
            <assert test="tokenize(@properties,'\s+')='nav'">[opf13] the Navigation Document must be identified with the attribute properties="nav" in the OPF manifest</assert>
        </rule>
    </pattern>

    <pattern id="opf_nordic_14">
        <rule context="opf:itemref">
            <let name="itemref" value="."/>
            <report test="count(//opf:item[@id=$itemref/@idref and (tokenize(@properties,'\s+')='nav' or @href='nav.xhtml')])">[opf14] the Navigation Document must not be present in the OPF
                spine.</report>
        </rule>
    </pattern>

</schema>
