<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" xmlns:px="http://www.daisy.org/ns/pipeline/xproc" xmlns:d="http://www.daisy.org/ns/pipeline/data"
    type="px:nordic-html-store.step" name="main" version="1.0" xmlns:l="http://xproc.org/library" xmlns:html="http://www.w3.org/1999/xhtml" xmlns:cx="http://xmlcalabash.com/ns/extensions">

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
    <p:option name="include-resources" select="'true'"/>

    <p:import href="validation-status.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/file-utils/library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/common-utils/library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/fileset-utils/library.xpl"/>

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
                <p:pipe port="result" step="html-store.step.result-fileset"/>
            </p:output>
            <p:output port="in-memory.out" sequence="true">
                <p:pipe port="in-memory.in" step="main"/>
            </p:output>
            <p:output port="report.out" sequence="true">
                <p:empty/>
            </p:output>








            <p:for-each name="html-store.step.normalize-base">
                <p:iteration-source>
                    <p:pipe port="in-memory.in" step="main"/>
                </p:iteration-source>
                <p:output port="result" sequence="true"/>
                <px:normalize-document-base/>
            </p:for-each>
            <px:fileset-join>
                <p:input port="source">
                    <p:pipe port="fileset.in" step="main"/>
                </p:input>
            </px:fileset-join>
            <p:choose name="html-store.step.choose-include-resources">
                <p:when test="$include-resources = 'false'">
                    <p:delete match="/*/d:file[@media-type != 'application/xhtml+xml']" name="html-store.step.choose-include-resources.delete-auxiliary-resources-from-fileset"/>
                </p:when>
                <p:otherwise>
                    <p:identity name="html-store.step.choose-include-resources.include-resources"/>
                </p:otherwise>
            </p:choose>
            
            <p:delete match="/*/d:file/@doctype" name="html-store.step.delete-doctype-attribute"/>
            <p:add-attribute match="/*/d:file[@indent='true']" attribute-name="indent" attribute-value="false" name="html-store.step.set-indent-false">
                <!-- temporary workaround until https://github.com/daisy/pipeline-modules-common/issues/69 is fixed -->
            </p:add-attribute>
            <p:add-attribute match="/*/d:file[ends-with(@media-type,'+xml') or ends-with(@media-type,'/xml')]" attribute-name="encoding" attribute-value="us-ascii" name="html-store.step.set-encoding-to-ascii"/>
            <px:fileset-store name="html-store.step.html-store">
                <p:input port="in-memory.in">
                    <p:pipe port="result" step="html-store.step.normalize-base"/>
                </p:input>
            </px:fileset-store>
            <p:identity>
                <p:input port="source">
                    <p:pipe port="fileset.out" step="html-store.step.html-store"/>
                </p:input>
            </p:identity>
            <p:viewport match="d:file[@media-type='application/xhtml+xml']" name="html-store.step.viewport-doctype">
                <p:variable name="href" select="string(resolve-uri(/*/@href,base-uri(/*)))"/>
                <p:variable name="doctype" select="'&lt;!DOCTYPE html&gt;'"/>
                <px:set-doctype name="html-store.step.viewport-doctype.set-doctype">
                    <p:with-option name="doctype" select="$doctype"/>
                    <p:with-option name="href" select="$href"/>
                </px:set-doctype>
                <p:add-attribute match="/*" attribute-name="doctype" name="html-store.step.viewport-doctype.add-doctype-attribute-to-fileset" cx:depends-on="html-store.step.viewport-doctype.set-doctype">
                    <p:input port="source">
                        <p:pipe port="current" step="html-store.step.viewport-doctype"/>
                    </p:input>
                    <p:with-option name="attribute-value" select="$doctype"/>
                </p:add-attribute>
            </p:viewport>
            <p:viewport match="d:file[ends-with(@media-type,'+xml') or ends-with(@media-type,'/xml')]" name="html-store.step.store.xml-declaration">
                <p:variable name="href" select="string(resolve-uri(/*/@href,base-uri(/*)))"/>
                <p:variable name="xml-declaration" select="'&lt;?xml version=&quot;1.0&quot; encoding=&quot;utf-8&quot;?&gt;'"/>
                <px:set-xml-declaration name="html-store.step.set-xml-declaration">
                    <p:with-option name="xml-declaration" select="$xml-declaration"/>
                    <p:with-option name="href" select="$href"/>
                </px:set-xml-declaration>
                <p:add-attribute match="/*" attribute-name="xml-declaration" name="html-store.step.add-xml-declaration-attribute">
                    <p:input port="source">
                        <p:pipe port="current" step="html-store.step.store.xml-declaration"/>
                    </p:input>
                    <p:with-option name="attribute-value" select="$xml-declaration">
                        <p:pipe port="result" step="html-store.step.set-xml-declaration"/>
                    </p:with-option>
                </p:add-attribute>
            </p:viewport>
            <p:identity name="html-store.step.result-fileset"/>










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
