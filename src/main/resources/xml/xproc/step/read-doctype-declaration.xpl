<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step type="px:read-doctype-declaration" name="main" xmlns:c="http://www.w3.org/ns/xproc-step" xmlns:p="http://www.w3.org/ns/xproc" xmlns:px="http://www.daisy.org/ns/pipeline/xproc"
    xmlns:pxi="http://www.daisy.org/ns/pipeline/xproc/internal" xmlns:d="http://www.daisy.org/ns/pipeline/data" exclude-inline-prefixes="#all" version="1.0"
    xmlns:cx="http://xmlcalabash.com/ns/extensions">
    
    <!-- TODO: move this to pipeline 2 common-utils before the v1.8 release -->
    
    <p:documentation xmlns="http://www.w3.org/1999/xhtml">
        <p>Example usage:</p>
        <pre xml:space="preserve">
            &lt;!-- provide a single document on the primary input port --&gt;
            &lt;px:read-doctype-declaration/&gt;
        </pre>
        <p>Example output:</p>
        <pre xml:space="preserve">
            &lt;c:result xmlns:c="http://www.w3.org/ns/xproc-step" has-doctype-declaration="true" name="HTML" doctype-public="-//W3C//DTD HTML 4.01//EN" doctype-system="http://www.w3.org/TR/html4/strict.dtd" doctype-declaration="&amp;lt;!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd"&amp;gt;"/&gt;
        </pre>
    </p:documentation>
    
    <p:option name="href" required="true"/>
    
    <p:output port="result"/>
    
    <p:identity>
        <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
                <c:request method="GET" override-content-type="text/plain; charset=UTF-8"/>
            </p:inline>
        </p:input>
    </p:identity>
    <p:add-attribute match="/*" attribute-name="href">
        <p:with-option name="attribute-value" select="$href"/>
    </p:add-attribute>
    <p:http-request/>
    
    <p:group>
        <p:variable name="content" select="/*/text()"/>
        <p:choose>
            <p:when test="matches($content,'^(&lt;\?[^&lt;]*\?&gt;|\s)*&lt;!DOCTYPE','si')">
                <p:variable name="doctype-declaration" select="replace(/*/text(),'^(&lt;\?[^&lt;]*\?&gt;|\s)*(&lt;!DOCTYPE[^&gt;]*&gt;).*$','$2','si')"/>
                <p:variable name="parsed-doctype-declaration" select="replace(replace($doctype-declaration,'SYSTEM','PUBLIC &quot;&quot;','s'),'^&lt;!DOCTYPE\s+([^\s&gt;]+)(\s+PUBLIC\s+([&quot;''][^&quot;'']*[&quot;''])\s+([&quot;''][^&quot;'']*[&quot;'']))?.*?&gt;.*$','$1&#10;$3&#10;$4','si')"/>
                <p:add-attribute match="/*" attribute-name="doctype-declaration">
                    <p:with-option name="attribute-value" select="$doctype-declaration"/>
                    <p:input port="source">
                        <p:inline exclude-inline-prefixes="#all">
                            <c:result has-doctype-declaration="true"/>
                        </p:inline>
                    </p:input>
                </p:add-attribute>
                <p:add-attribute match="/*" attribute-name="name">
                    <p:with-option name="attribute-value" select="tokenize($parsed-doctype-declaration,'&#10;','s')[1]"/>
                </p:add-attribute>
                <p:choose>
                    <p:when test="matches($doctype-declaration,'^&lt;!DOCTYPE\s+[^\s]+\s+PUBLIC.*')">
                        <p:add-attribute match="/*" attribute-name="doctype-public">
                            <p:with-option name="attribute-value" select="replace(tokenize($parsed-doctype-declaration,'&#10;','s')[2],'^.(.*).$','$1','s')"/>
                        </p:add-attribute>
                        <p:add-attribute match="/*" attribute-name="doctype-system">
                            <p:with-option name="attribute-value" select="replace(tokenize($parsed-doctype-declaration,'&#10;','s')[3],'^.(.*).$','$1','s')"/>
                        </p:add-attribute>
                    </p:when>
                    <p:when test="matches($doctype-declaration,'^&lt;!DOCTYPE\s+[^\s]+\s+SYSTEM.*')">
                        <p:add-attribute match="/*" attribute-name="doctype-system">
                            <p:with-option name="attribute-value" select="replace(tokenize($parsed-doctype-declaration,'&#10;','s')[3],'^.(.*).$','$1','s')"/>
                        </p:add-attribute>
                    </p:when>
                    <p:otherwise>
                        <p:identity/>
                    </p:otherwise>
                </p:choose>
            </p:when>
            <p:otherwise>
                <p:identity>
                    <p:input port="source">
                        <p:inline exclude-inline-prefixes="#all">
                            <c:result has-doctype-declaration="false"/>
                        </p:inline>
                    </p:input>
                </p:identity>
            </p:otherwise>
        </p:choose>
    </p:group>
    
</p:declare-step>
