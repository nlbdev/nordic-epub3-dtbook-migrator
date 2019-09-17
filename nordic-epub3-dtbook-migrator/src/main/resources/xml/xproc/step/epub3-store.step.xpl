<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" version="1.0"
                xmlns:px="http://www.daisy.org/ns/pipeline/xproc"
                xmlns:d="http://www.daisy.org/ns/pipeline/data"
                xmlns:dc="http://purl.org/dc/elements/1.1/"
                type="px:nordic-epub3-store.step" name="main">

    <p:input port="fileset.in" primary="true"/>
    <p:input port="in-memory.in" sequence="true">
        <p:empty/>
    </p:input>
    <p:input port="report.in" sequence="true">
        <p:empty/>
    </p:input>
    <p:input port="status.in">
        <p:inline>
            <d:validation-status result="ok"/>
        </p:inline>
    </p:input>

    <p:output port="fileset.out" primary="true">
        <p:pipe port="fileset.out" step="choose"/>
    </p:output>
    <p:output port="in-memory.out" sequence="true">
        <p:pipe port="in-memory.out" step="choose"/>
    </p:output>
    <p:output port="report.out" sequence="true">
        <p:pipe port="report.in" step="main"/>
        <p:pipe port="report.out" step="choose"/>
    </p:output>
    <p:output port="status.out">
        <p:pipe port="result" step="status"/>
    </p:output>

    <p:option name="fail-on-error" required="true"/>
    <p:option name="output-dir" required="true"/>

    <p:import href="validation-status.xpl">
        <p:documentation>
            px:nordic-validation-status
        </p:documentation>
    </p:import>
    <p:import href="http://www.daisy.org/pipeline/modules/common-utils/library.xpl">
        <p:documentation>
            px:assert
        </p:documentation>
    </p:import>
    <p:import href="http://www.daisy.org/pipeline/modules/fileset-utils/library.xpl">
        <p:documentation>
            px:fileset-filter
            px:fileset-create
            px:fileset-add-entry
            px:fileset-load
            px:fileset-join
        </p:documentation>
    </p:import>
    <p:import href="http://www.daisy.org/pipeline/modules/epub3-utils/library.xpl">
        <p:documentation>
            px:epub3-store
        </p:documentation>
    </p:import>

    <px:assert message="'fail-on-error' should be either 'true' or 'false'. was: '$1'. will default to 'true'.">
        <p:with-option name="param1" select="$fail-on-error"/>
        <p:with-option name="test" select="$fail-on-error = ('true','false')"/>
    </px:assert>

    <p:choose name="choose">
        <p:xpath-context>
            <p:pipe port="status.in" step="main"/>
        </p:xpath-context>
        <p:when test="/*/@result='ok' or $fail-on-error = 'false'">
            <p:output port="fileset.out" primary="true">
                <p:pipe port="result" step="epub3-store.step.result.fileset"/>
            </p:output>
            <p:output port="in-memory.out" sequence="true">
                <p:empty/>
            </p:output>
            <p:output port="report.out" sequence="true">
                <p:empty/>
            </p:output>

            <!--
                Files must be loaded into memory for @doctype and @xml-declaration to have effect
            -->
            <px:fileset-filter media-types="*/xml *+xml" name="epub3-store.step.store-epub3.xml">
                <p:input port="source.in-memory">
                    <p:pipe step="main" port="in-memory.in"/>
                </p:input>
            </px:fileset-filter>
            <px:fileset-load name="epub3-store.step.store-epub3.xml.in-memory">
                <p:input port="in-memory">
                    <p:pipe step="main" port="in-memory.in"/>
                </p:input>
            </px:fileset-load>
            <p:sink/>
            <p:identity>
                <p:input port="source">
                    <p:pipe step="epub3-store.step.store-epub3.xml.in-memory" port="result.fileset"/>
                </p:input>
            </p:identity>
            <!--
                Don't indent XML (temporary workaround until https://github.com/daisy/pipeline-modules-common/issues/69 is fixed)
            -->
            <p:add-attribute match="d:file[@indent='true']" attribute-name="indent" attribute-value="false"/>
            <!--
                Encode XML files with us-ascii so that all non-ASCII characters are stored as XML entities
            -->
            <p:add-attribute match="d:file" attribute-name="encoding" attribute-value="us-ascii"/>
            <!--
                Set doctype of XHTML files
            -->
            <p:delete match="d:file/@doctype"/>
            <p:add-attribute match="d:file[@media-type='application/xhtml+xml']"
                             attribute-name="doctype" attribute-value="&lt;!DOCTYPE html&gt;"/>
            <!--
                Set XML declaration of XHTML/XML files
                Note that the encoding can be set to utf-8 because it is compatible with us-ascii
            -->
            <p:add-attribute match="d:file"
                             attribute-name="xml-declaration"
                             attribute-value="&lt;?xml version=&quot;1.0&quot; encoding=&quot;utf-8&quot;?&gt;"/>
            <!--
                Zip up the EPUB
            -->
            <p:identity name="epub3-store.step.store-epub3.xml.fileset"/>
            <p:sink/>
            <px:fileset-join>
                <p:input port="source">
                    <p:pipe step="epub3-store.step.store-epub3.xml" port="not-matched"/>
                    <p:pipe step="epub3-store.step.store-epub3.xml.fileset" port="result"/>
                </p:input>
            </px:fileset-join>
            <px:epub3-store name="epub3-store.step.store-epub3">
                <p:input port="in-memory.in">
                    <p:pipe step="epub3-store.step.store-epub3.xml" port="not-matched.in-memory"/>
                    <p:pipe step="epub3-store.step.store-epub3.xml.in-memory" port="result"/>
                </p:input>
                <p:with-option name="href" select="concat($output-dir,/*/text(),'.epub')">
                    <p:pipe step="epub3-store.step.metadata.identifier" port="result"/>
                </p:with-option>
            </px:epub3-store>

            <!--
                Return fileset that contains a single file which is the .epub file
            -->
            <px:fileset-create name="epub3-store.step.create-epub-fileset">
                <p:with-option name="base" select="$output-dir"/>
            </px:fileset-create>
            <px:fileset-add-entry media-type="application/epub+zip" name="epub3-store.step.add-epub-to-fileset">
                <p:with-option name="href" select="string(/*)">
                    <p:pipe step="epub3-store.step.store-epub3" port="result"/>
                </p:with-option>
            </px:fileset-add-entry>
            <p:identity name="epub3-store.step.result.fileset"/>

            <!--
                Get identifier from OPF
            -->
            <p:group>
                <px:fileset-load media-types="application/oebps-package+xml" name="epub3-store.step.metadata.load-opf">
                    <p:input port="fileset">
                        <p:pipe port="fileset.in" step="main"/>
                    </p:input>
                    <p:input port="in-memory">
                        <p:pipe port="in-memory.in" step="main"/>
                    </p:input>
                </px:fileset-load>
                <px:assert test-count-min="1" test-count-max="1" error-code="NORDICDTBOOKEPUB011"
                           message="There must be exactly one Package Document in the EPUB."/>
                <p:filter select="//dc:identifier[not(@refines)]" name="epub3-store.step.metadata.filter-dc-identifier"/>
                <px:assert test-count-min="1" error-code="NORDICDTBOOKEPUB012"
                           message="The EPUB Package Document (the OPF file) must have a 'dc:identifier' element"/>
                <p:split-sequence test="position() = 1" name="epub3-store.step.metadata.get-first-dc-identifier"/>
            </p:group>
            <p:identity name="epub3-store.step.metadata.identifier"/>
            <p:sink/>

        </p:when>
        <p:otherwise>
            <p:output port="fileset.out" primary="true"/>
            <p:output port="in-memory.out" sequence="true">
                <p:pipe port="fileset.in" step="main"/>
            </p:output>
            <p:output port="report.out" sequence="true">
                <p:empty/>
            </p:output>

            <p:identity/>
        </p:otherwise>
    </p:choose>

    <p:choose name="status">
        <p:xpath-context>
            <p:pipe port="status.in" step="main"/>
        </p:xpath-context>
        <p:when test="/*/@result='ok' and $fail-on-error='true'">
            <p:output port="result"/>
            <px:nordic-validation-status>
                <p:input port="source">
                    <p:pipe port="report.out" step="choose"/>
                </p:input>
            </px:nordic-validation-status>
        </p:when>
        <p:otherwise>
            <p:output port="result"/>
            <p:identity>
                <p:input port="source">
                    <p:pipe port="status.in" step="main"/>
                </p:input>
            </p:identity>
        </p:otherwise>
    </p:choose>

</p:declare-step>
