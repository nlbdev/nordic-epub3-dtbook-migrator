<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">

    <sch:title>Schematron tests for Nordic procurement - strict</sch:title>

    <sch:ns prefix="html" uri="http://www.w3.org/1999/xhtml"/>
    <sch:ns prefix="epub" uri="http://www.idpf.org/2007/ops"/>
    <sch:ns prefix="nordic" uri="http://www.mtm.se/epub/"/>

    <!-- Rule 43: dc:publisher must be 'TPB', 'MTM', 'SPSM', 'Nota', 'NLB', 'Celia' or 'SBS' -->
    <sch:pattern id="dtbook_TPB_43_strict">
        <sch:rule context="html:head[//html:body/html:header]">
            <sch:assert test="count(html:meta[@name='dc:publisher' and @content=('TPB','MTM','SPSM','Nota','NLB','Celia','SBS')])=1">[tpb43] Meta dc:publisher must exist and have value 'TPB', 'MTM',
                'SPSM', 'Nota', 'NLB', 'Celia' or 'SBS'.</sch:assert>
        </sch:rule>
    </sch:pattern>

    <!-- Rule 124 (106): All documents must have at least one pagebreak, except navigation document and cover document -->
    <sch:pattern id="dtbook_TPB_124_strict">
        <sch:rule context="html:body[not(html:nav or tokenize(@epub:type,'\s+')='cover')]">
            <sch:assert test="count(//html:*[tokenize(@epub:type,' ')='pagebreak'])>=1">[tpb124] All documents in the spine (except cover page) must contain page numbers</sch:assert>
        </sch:rule>
    </sch:pattern>

    <!-- Rule 131 (35): Allowed values in xml:lang -->
    <sch:pattern id="dtbook_TPB_131_strict">
        <sch:rule context="*[@xml:lang]">
            <sch:assert
                test="@xml:lang='sv' or @xml:lang='en' or @xml:lang='da' or @xml:lang='it' or @xml:lang='la' or @xml:lang='el' or @xml:lang='de' or @xml:lang='fr' or @xml:lang='es' or @xml:lang='fi' or @xml:lang='no' or @xml:lang='is'"
                >[tpb131] xml:lang must be one of: 'sv', 'en', 'da', 'it', 'la', 'el', 'de', 'fr', 'es', 'fi', 'no' or 'is'</sch:assert>
        </sch:rule>
    </sch:pattern>

</sch:schema>
