<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">

    <title>Nordic EPUB3 Package Document rules</title>

    <ns prefix="opf" uri="http://www.idpf.org/2007/opf"/>
    <ns prefix="dc" uri="http://purl.org/dc/elements/1.1/"/>
    <ns prefix="epub" uri="http://www.idpf.org/2007/ops"/>
    <ns prefix="nordic" uri="http://www.mtm.se/epub/"/>
    <ns prefix="a11y" uri="http://www.idpf.org/epub/vocab/package/a11y/#"/>

    <pattern id="opf_nordic_1">
        <title>Rule 1</title>
        <p></p>
        <rule context="/*">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <assert test="ends-with(base-uri(/*),'.opf')">[opf1] the OPF file must have the extension .opf</assert>
            <assert test="matches(base-uri(/*),'.*/package.opf')">[opf1] the filename of the OPF must be package.opf</assert>
            <assert test="matches(base-uri(/*),'EPUB/package.opf')">[opf1] the OPF must be contained in a folder named EPUB</assert>
        </rule>
    </pattern>

    <pattern id="opf_nordic_2">
        <title>Rule 2</title>
        <p></p>
        <rule context="opf:package">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <assert test="@version = '3.0'">[opf2] the version attribute must be 3.0</assert>
            <assert test="@unique-identifier = 'pub-identifier'">[opf2] on the package element; the unique-identifier-attribute must be present and equal 'pub-identifier'</assert>
            <assert test="namespace-uri-for-prefix('dc',.) = 'http://purl.org/dc/elements/1.1/'">[opf2] on the package element; the dublin core namespace (xmlns:dc="http://purl.org/dc/elements/1.1/")
                must be declared on the package element</assert>
            <assert test="matches(@prefix, '(^|\s)nordic:\s+http://www.mtm.se/epub/(\s|$)') or not(opf:meta[starts-with(@property, 'nordic:')])">[opf2] on the package element; the prefix attribute must declare the nordic metadata namespace using the correct namespace URI (prefix="nordic:
                http://www.mtm.se/epub/")</assert>
            <assert test="matches(@prefix, '(^|\s)a11y:\s+http://www.idpf.org/epub/vocab/package/a11y/#(\s|$)') or not(opf:meta[starts-with(@property, 'a11y:')])">[opf2] on the package element; the prefix attribute must declare the a11y metadata namespace using the correct URI (prefix="a11y:
                http://www.idpf.org/epub/vocab/package/a11y/#")</assert>
        </rule>

        <rule context="opf:meta[boolean(@property) and contains(@property, ':') and not(substring-before(@property, ':') = ('dc', 'dcterms', 'a11y', 'schema', 'marc', 'media', 'onix', 'rendition', 'xsd'))]">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <let name="prefix" value="substring-before(@property, ':')"/>
            <assert test="matches(string(ancestor::opf:package[1]/@prefix[1]), concat('(^|\s)', $prefix, ':(\s|$)'))">[opf2] on the package element; the prefix attribute must declare the '<value-of select="$prefix"/>' prefix</assert>
        </rule>
    </pattern>

    <pattern id="opf_nordic_3">
        <title>Rule 3</title>
        <p></p>
        <rule context="opf:metadata">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <assert test="count(dc:identifier) = 1">[opf3a] there must be exactly one dc:identifier element</assert>
            <assert test="parent::opf:package/@unique-identifier = dc:identifier/@id">[opf3a] the id of the dc:identifier must equal the value of the package elements unique-identifier
                attribute</assert>

            <let name="main-title-id" value="opf:meta[text() = 'main' and @property = 'title-type']/translate(@refines, '#', '')"/>
            <assert test="count(dc:title[@id=$main-title-id]) = 1 or count(dc:title) = 1">[opf3b] exactly one dc:title must be present in the package document when no title is uniquely defined as main.</assert>
            <assert test="string-length(normalize-space(dc:title[1]/text()))">[opf3b] the dc:title must not be empty.</assert>

            <assert test="count(dc:language[not(@refines)]) = 1">[opf3c] exactly one dc:language <value-of select="if (dc:language[@refines]) then '(without a &quot;refines&quot; attribute)' else ''"
                /> must be present in the package document.</assert>
            <assert test="count(dc:language[not(@refines)]) = 1 and matches(dc:language[not(@refines)]/text(), '^[a-z]{2,3}(-[A-Za-z0-9]+)*$')">[opf3c] the language code ("<value-of
                    select="dc:language[not(@refines)]/text()"/>") must be either a "two- or three-letter lower case" code or a "two- or three-letter lower case and groups of hyphen followed by numbers or letters" (i.e. zh-Hanz-UTF8) code.</assert>
            <!--<assert test="dc:language = ('no','nn-NO','nb-NO','sv','sv-FI','fi','da','en','de','de-CH','fr')" flag="warning">the language code should be one of: 'no' (Norwegian), 'nn-NO' (Norwegian
                Nynorsk), 'nb-NO' (Norwegian Bokmål), 'sv' (Swedish), 'sv-FI' (Swedish (Finland)), 'fi' (Finnish), 'da' (Danish), 'en' (English), 'de' (German), 'de-CH' (German (Switzerland)), 'fr'
                (French)</assert>-->

            <assert test="count(dc:date[not(@refines)]) = 1">[opf3d] exactly one dc:date <value-of select="if (dc:date[@refines]) then '(without a &quot;refines&quot; attribute)' else ''"/> must be
                present</assert>
            <assert test="count(dc:date[not(@refines)]) = 1 and matches(dc:date[not(@refines)], '\d\d\d\d-\d\d-\d\d')">[opf3d] the dc:date (<value-of select="dc:date/text()"/>) must be of the format
                YYYY-MM-DD (year-month-day)</assert>

            <assert test="count(dc:publisher[not(@refines)]) = 1">[opf3e] exactly one dc:publisher <value-of
                    select="if (dc:publisher[@refines]) then '(without a &quot;refines&quot; attribute)' else ''"/> must be present</assert>
            <assert test="count(dc:publisher[not(@refines)]) = 1 and dc:publisher[not(@refines)]/normalize-space(text())">[opf3e] the dc:publisher cannot be empty</assert>
            <!--<assert test="dc:publisher[not(@refines)] = ('TPB','MTM','SPSM','Nota','NLB','Celia','SBS')" flag="warning">the publisher should be one of:
                'TPB','MTM','SPSM','Nota','NLB','Celia','SBS'</assert>-->

            <assert test="count(dc:creator[not(@refines)]) &gt;= 1">[opf3g] at least dc:creator (i.e. book author) <value-of
                    select="if (dc:creator[@refines]) then '(without a &quot;refines&quot; attribute)' else ''"/> must be present</assert>

            <!-- dc:contributor not required -->

            <assert test="count(dc:source[not(@refines)]) = 1">[opf3h] exactly one dc:source <value-of select="if (dc:source[@refines]) then '(without a &quot;refines&quot; attribute)' else ''"/> must
                be present</assert>
            <assert test="not(matches(dc:source[not(@refines)],'^urn:is[bs]n:')) or matches(dc:source[not(@refines)],'^urn:is[bs]n:[\d-]+X?$')">[opf3h] the ISBN or ISSN in dc:source ("<value-of
                    select="dc:source[not(@refines)]/text()"/>") can only contain numbers and hyphens, in addition to the 'urn:isbn:' or 'urn:issn:' prefix. The last digit can also be a 'X' in some
                ISBNs.</assert>

            <assert test="count(opf:meta[@property='nordic:guidelines' and not(@refines)]) = 1">[opf3i] there must be exactly one meta element with the property "nordic:guidelines" <value-of
                    select="if (opf:meta[@property='nordic:guidelines' and @refines]) then '(without a &quot;refines&quot; attribute)' else ''"/></assert>
            <assert test="opf:meta[@property='nordic:guidelines' and not(@refines)] = '2020-1'">[opf3i] the value of nordic:guidelines must be '2020-1'</assert>

            <assert test="count(opf:meta[@property='nordic:supplier' and not(@refines)]) = 1">[opf3j] there must be exactly one meta element with the property "nordic:supplier" <value-of
                    select="if (opf:meta[@property='nordic:supplier' and @refines]) then '(without a &quot;refines&quot; attribute)' else ''"/></assert>
        </rule>
    </pattern>

    <pattern id="opf_nordic_5_b">
        <title>Rule 5b</title>
        <p></p>
        <rule context="opf:item[@media-type='application/x-dtbncx+xml']">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <assert test="@href = 'nav.ncx'">[opf5b] the NCX must be located in the same directory as the package document, and must be named "nav.ncx" (not "<value-of select="@href"/>")</assert>
        </rule>
    </pattern>

    <pattern id="opf_nordic_6">
        <title>Rule 6</title>
        <p></p>
        <rule context="opf:spine">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <let name="toc-doc" value="/opf:package/opf:manifest/opf:item[@media-type='application/x-dtbncx+xml']"/>
            <assert test="not($toc-doc) or @toc">[opf6] the toc attribute must be present</assert>
            <assert test="not($toc-doc) or $toc-doc/@id = @toc">[opf6] the toc attribute must refer to the nav.ncx item in the manifest</assert>
        </rule>
    </pattern>

    <pattern id="opf_nordic_7">
        <title>Rule 7</title>
        <p></p>
        <rule context="opf:item[@media-type='application/xhtml+xml' and tokenize(@properties,'\s+')='nav']">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <assert test="@href = 'nav.xhtml'">[opf7] the Navigation Document must be located in the same directory as the package document, and must be named 'nav.xhtml' (not "<value-of
                    select="@href"/>")</assert>
        </rule>
    </pattern>

    <pattern id="opf_nordic_8">
        <title>Rule 8</title>
        <p></p>
        <rule context="opf:item[starts-with(@media-type,'image/')]">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <assert test="matches(@href,'^images/[^/]+$')">[opf8] all images must be stored in the "images" directory (which is a subdirectory relative to the package document). The image file
                    "<value-of select="replace(@href,'.*/','')"/>" is located in "<value-of select="replace(@href,'[^/]+$','')"/>".</assert>
        </rule>
    </pattern>

    <pattern id="opf_nordic_9">
        <title>Rule 9</title>
        <p></p>
        <rule context="opf:item[@media-type='application/xhtml+xml' and not(tokenize(@properties,'\s+')='nav')]">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <report test="contains(@href,'/')">[opf9] all content files must be located in the same directory as the package document. The content file file "<value-of select="replace(@href,'.*/','')"
                />" is located in "<value-of select="replace(@href,'[^/]+$','')"/>".</report>
        </rule>
    </pattern>

    <pattern id="opf_nordic_10">
        <title>Rule 10</title>
        <p></p>
        <rule context="opf:itemref[../../opf:manifest/opf:item[@media-type='application/xhtml+xml' and ends-with(@href,'-cover.xhtml')]/@id = @idref]">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <assert test="@linear = 'no'">[opf10] Cover must be marked as secondary in the spine (i.e. set linear="no" on the itemref with idref="<value-of select="@idref"/>", which refers to the cover)</assert>
            <assert test="count(preceding-sibling::opf:itemref[not(@linear='no')]) = 0">[opf10] All preceeding documents to the cover must be marked as secondary in the spine (i.e. set linear="no")</assert>
        </rule>
        <rule context="opf:itemref[../../opf:manifest/opf:item[@media-type='application/xhtml+xml' and ends-with(@href,'titlepage.xhtml')][1]/@id = @idref]">
            <assert test="count(preceding-sibling::opf:itemref[not(@linear='no')]) = 0">[opf10] All preceeding documents to the titlepage or halftitlepage must be marked as secondary in the spine (i.e. set linear="no")</assert>
        </rule>
    </pattern>

    <pattern id="opf_nordic_12_a">
        <title>Rule 12a</title>
        <p></p>
        <rule context="opf:item[@media-type='application/xhtml+xml' and not(@href='nav.xhtml' or tokenize(@properties,'\s+')='nav')]">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <assert test="matches(@href,'^[A-Za-z0-9_-]+-\d+-[a-z-]+(-\d+)?\.xhtml$')">[opf12a] The content document "<value-of select="@href"/>" has a bad filename. Content documents must match the
                "[dc:identifier]-[position in spine]-[role or epub:type].xhtml" file naming convention. Example: "DTB123-01-cover.xhtml". The identifier are allowed to contain the upper- and lower-case
                characters A-Z and a-z as well as digits (0-9), dashes (-) and underscores (_). The position is a positive whole number consisting of the digits 0-9. The role or epub:type must be all
                lower-case characters (a-z) and can contain a dash (-). An optional positive whole number (digits 0-9) can be added after the role or epub:type to be able to easily tell different files with
                the same role or epub:type apart. For instance: "DTB123-13-chapter-7.xhtml".</assert>
        </rule>
    </pattern>

    <pattern id="opf_nordic_12_b">
        <title>Rule 12b</title>
        <p></p>
        <rule context="opf:item[@media-type='application/xhtml+xml' and not(@href='nav.xhtml' or tokenize(@properties,'\s+')='nav') and matches(@href,'^[A-Za-z0-9_-]+-\d+-[a-z-]+(-\d+)?\.xhtml$')]">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <let name="identifier" value="replace(@href,'^([A-Za-z0-9_-]+)-\d+-[a-z-]+(-\d+)?\.xhtml$','$1')"/>
            <let name="position" value="replace(@href,'^[A-Za-z0-9_-]+-(\d+)-[a-z-]+(-\d+)?\.xhtml$','$1')"/>
            <let name="type" value="replace(@href,'^[A-Za-z0-9_-]+-\d+-([a-z-]+)(-\d+)?\.xhtml$','$1')"/>
            <let name="number" value="if (matches(@href,'^[A-Za-z0-9_-]+-\d+-[a-z-]+-\d+\.xhtml$')) then replace(@href,'^[A-Za-z0-9_-]+-\d+-[a-z-]+-(\d+)\.xhtml$','$1') else ''"/>
            <let name="vocab-default"
                value="('cover','frontmatter','bodymatter','backmatter','volume','part','chapter','subchapter','division','abstract','foreword','preface','prologue','introduction','preamble','conclusion','epilogue','afterword','epigraph','toc','toc-brief','landmarks','loa','loi','lot','lov','appendix','colophon','credits','keywords','index','index-headnotes','index-legend','index-group','index-entry-list','index-entry','index-term','index-editor-note','index-locator','index-locator-list','index-locator-range','index-xref-preferred','index-xref-related','index-term-category','index-term-categories','glossary','glossterm','glossdef','bibliography','biblioentry','titlepage','halftitlepage','copyright-page','seriespage','acknowledgments','imprint','imprimatur','contributors','other-credits','errata','dedication','revision-history','case-study','help','marginalia','notice','pullquote','sidebar','warning','halftitle','fulltitle','covertitle','title','subtitle','label','ordinal','bridgehead','learning-objective','learning-objectives','learning-outcome','learning-outcomes','learning-resource','learning-resources','learning-standard','learning-standards','answer','answers','assessment','assessments','feedback','fill-in-the-blank-problem','general-problem','qna','match-problem','multiple-choice-problem','practice','practices','question','true-false-problem','panel','panel-group','balloon','text-area','sound-area','annotation','note','footnote','rearnote','footnotes','rearnotes','annoref','biblioref','glossref','noteref','referrer','credit','keyword','topic-sentence','concluding-sentence','pagebreak','page-list','table','table-row','table-cell','list','list-item','figure')"/>
            <let name="vocab-aria-epub"
                value="('abstract', 'acknowledgments', 'afterword', 'appendix', 'backlink', 'biblioentry', 'bibliography', 'biblioref', 'chapter', 'colophon', 'conclusion', 'cover', 'credit', 'credits', 'dedication', 'endnote', 'endnotes', 'epigraph', 'epilogue', 'errata', 'example', 'footnote', 'foreword', 'glossary', 'glossref', 'index', 'introduction', 'noteref', 'notice', 'pagebreak', 'pagelist', 'part', 'preface', 'prologue', 'pullquote', 'qna', 'subtitle', 'tip', 'toc')"/>

            <assert test="$identifier = ../../opf:metadata/dc:identifier/text()">[opf12b_identifier] The "identifier" part of the filename ("<value-of select="$identifier"/>") must be the same as
                declared in metadata, i.e.: "<value-of select="../../opf:metadata/dc:identifier/text()"/>".</assert>

            <assert test="$type = ($vocab-default, $vocab-aria-epub)">[opf12b_type] "<value-of select="$type"/>" is not a valid type. <value-of
                    select="if (count(($vocab-default,$vocab-aria-epub)[starts-with(.,substring($type,1,3))])) then concat('Did you mean &quot;',(($vocab-default,$vocab-aria-epub)[starts-with(.,substring($type,1,3))])[1],'&quot;?') else ''"
                /> The filename of content documents must end with a epub:type defined in either the EPUB3 Structural Semantics Vocabulary (http://www.idpf.org/epub/vocab/structure/#) or the
                ARIA EPUB Digital Publishing Roles (https://www.w3.org/TR/dpub-aria-1.0/#roles).</assert>

            <assert
                test="not(count(../opf:item[@media-type='application/xhtml+xml' and not(@href='nav.xhtml' or tokenize(@properties,'\s+')='nav') and not(matches(@href,'^[A-Za-z0-9_-]+-\d+-[a-z-]+(-\d+)?\.xhtml$'))])) and string-length($position) = string-length(../opf:item[@media-type='application/xhtml+xml' and not(@href='nav.xhtml' or tokenize(@properties,'\s+')='nav') and matches(@href,'^[A-Za-z0-9_-]+-\d+-[a-z-]+(-\d+)?\.xhtml$')][1]/replace(@href,'^[A-Za-z0-9_-]+-(\d+)-[a-z-]+(-\d+)?.xhtml$','$1'))"
                >[opf12b_position] The numbering of the content documents must all have the equal number of digits.</assert>

            <report
                test="not(count(../opf:item[@media-type='application/xhtml+xml' and not(@href='nav.xhtml' or tokenize(@properties,'\s+')='nav') and not(matches(@href,'^[A-Za-z0-9_-]+-\d+-[a-z-]+(-\d+)?\.xhtml$'))])) and number($position) = ( (../opf:item except .)[@media-type='application/xhtml+xml' and not(@href='nav.xhtml' or tokenize(@properties,'\s+')='nav') and matches(@href,'^[A-Za-z0-9_-]+-\d+-[a-z-]+(-\d+)?\.xhtml$')]/number(replace(@href,'^[A-Za-z0-9_-]+-(\d+)-[a-z-]+(-\d+)?.xhtml$','$1')) )"
                >[opf12b_position] The numbering of the content documents must be unique for each content document. <value-of select="$position"/> is also used by another content document in the
                OPF.</report>

            <assert
                test="not(count(../opf:item[@media-type='application/xhtml+xml' and not(@href='nav.xhtml' or tokenize(@properties,'\s+')='nav') and not(matches(@href,'^[A-Za-z0-9_-]+-\d+-[a-z-]+(-\d+)?\.xhtml$'))])) and number($position)-1 = ( 0 , (../opf:item except .)[@media-type='application/xhtml+xml' and not(@href='nav.xhtml' or tokenize(@properties,'\s+')='nav') and matches(@href,'^[A-Za-z0-9_-]+-\d+-[a-z-]+(-\d+)?\.xhtml$')]/number(replace(@href,'^[A-Za-z0-9_-]+-(\d+)-[a-z-]+(-\d+)?.xhtml$','$1')) )"
                >[opf12b_position] The numbering of the content documents must start at 1 and increase with 1 for each item.</assert>

            <assert
                test="not(count(../opf:item[@media-type='application/xhtml+xml' and not(@href='nav.xhtml' or tokenize(@properties,'\s+')='nav') and not(matches(@href,'^[A-Za-z0-9_-]+-\d+-[a-z-]+(-\d+)?\.xhtml$'))])) and ../../opf:spine/opf:itemref[xs:integer(number($position))]/@idref = @id"
                >[opf12b_position] The <value-of select="xs:integer(number($position))"/><value-of
                    select="if (ends-with($position,'1') and not(number($position)=11)) then 'st' else if (ends-with($position,'2') and not(number($position)=12)) then 'nd' else if (ends-with($position,'3') and not(number($position)=13)) then 'rd' else 'th'"
                /> itemref (&lt;iremref idref="<value-of select="../../opf:spine/opf:itemref[xs:integer(number($position))]/@id"/>" href="..."&gt;)
                should refer to &lt;item id="<value-of select="@id"/>" href="<value-of select="@href"/>"&gt;.</assert>
        </rule>
    </pattern>

    <pattern id="opf_nordic_13">
        <title>Rule 13</title>
        <p></p>
        <rule context="opf:item[@media-type='application/xhtml+xml' and @href='nav.xhtml']">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <assert test="tokenize(@properties,'\s+')='nav'">[opf13] the Navigation Document must be identified with the attribute properties="nav" in the OPF manifest. It currently <value-of
                    select="if (not(@properties)) then 'does not have a &quot;properties&quot; attribute' else concat('has the properties: ',string-join(tokenize(@properties,'\s+'),', '),', but not &quot;nav&quot;')"
                /></assert>
        </rule>
    </pattern>

    <pattern id="opf_nordic_14">
        <title>Rule 14</title>
        <p></p>
        <rule context="opf:itemref">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <let name="itemref" value="."/>
            <report test="count(//opf:item[@id=$itemref/@idref and (tokenize(@properties,'\s+')='nav' or @href='nav.xhtml')])">[opf14] the Navigation Document must not be present in the OPF spine
                (itemref with idref="<value-of select="@idref"/>").</report>
        </rule>
    </pattern>

    <pattern id="opf_nordic_15_a">
        <title>Rule 15a</title>
        <p></p>
        <rule context="opf:item[substring-after(@href,'/') = 'cover.jpg']">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <assert test="tokenize(@properties,'\s+') = 'cover-image'">[opf15a] The cover image must have a properties attribute containing the value 'cover-image': <value-of select="$context"/></assert>
        </rule>
    </pattern>

    <pattern id="opf_nordic_15_b">
        <title>Rule 15b</title>
        <p></p>
        <rule context="opf:item[tokenize(@properties,'\s+') = 'cover-image']">
            <let name="context" value="concat('(&lt;', name(), string-join(for $a in (@*) return concat(' ', $a/name(), '=&quot;', $a, '&quot;'), ''), '&gt;)')"/>
            <assert test="substring-after(@href,'/') = 'cover.jpg'">[opf15b] The image with property value 'cover-image' must have the filename 'cover.jpg': <value-of select="$context"/></assert>
        </rule>
    </pattern>

</schema>
