<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" xmlns:px="http://www.daisy.org/ns/pipeline/xproc" xmlns:d="http://www.daisy.org/ns/pipeline/data"
    type="px:nordic-html-validate" name="main" version="1.0" xmlns:epub="http://www.idpf.org/2007/ops" xmlns:pxp="http://exproc.org/proposed/steps" xmlns:html="http://www.w3.org/1999/xhtml"
    xmlns:pxi="http://www.daisy.org/ns/pipeline/xproc/internal/nordic-epub3-dtbook-migrator" xmlns:cx="http://xmlcalabash.com/ns/extensions">

    <p:output port="validation-status">
        <p:pipe port="status" step="report"/>
    </p:output>
    <p:output port="html-report">
        <p:pipe port="html" step="report"/>
    </p:output>
    <p:option name="input-href"/>
    <p:option name="output-href"/>
    
    
    <px:step-load name="load"/>
    
    <px:step-validate name="step1"/>
    
    <px:step-convert name="step2"/>
    
    <px:step-validate name="step3"/>
    
    <px:step-store name="store"/>
    
    
    <px:create-report name="report">
        <p:input port="reports">
            <p:pipe port="report" step="load"/>
            <p:pipe port="report" step="step1"/>
            <p:pipe port="report" step="step2"/>
            <p:pipe port="report" step="step3"/>
            <p:pipe port="report" step="store"/>
        </p:input>
    </px:create-report>

</p:declare-step>
