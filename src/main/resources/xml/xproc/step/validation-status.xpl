<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" xmlns:px="http://www.daisy.org/ns/pipeline/xproc" xmlns:d="http://www.daisy.org/ns/pipeline/data"
    xmlns:cx="http://xmlcalabash.com/ns/extensions" type="px:nordic-validation-status" name="main" version="1.0">

    <!-- TODO: merge with px:validation-status -->

    <p:input port="source" sequence="true"/>
    <p:output port="result"/>

    <p:for-each>
        <p:filter select="/d:document-validation-report/d:document-info/d:error-count"/>
    </p:for-each>
    <p:wrap-sequence wrapper="d:validation-status"/>
    <p:add-attribute attribute-name="result" match="/*">
        <p:with-option name="attribute-value" select="if (sum(/*/*/number(.))&gt;0) then 'error' else 'ok'"/>
    </p:add-attribute>
    <p:delete match="/*/node()"/>

</p:declare-step>
