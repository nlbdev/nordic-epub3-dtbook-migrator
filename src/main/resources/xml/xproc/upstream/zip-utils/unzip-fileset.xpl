<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step type="pxi:unzip-fileset" xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" xmlns:d="http://www.daisy.org/ns/pipeline/data"
    xmlns:px="http://www.daisy.org/ns/pipeline/xproc" version="1.0" name="main" xmlns:letex="http://www.le-tex.de/namespace" xmlns:cx="http://xmlcalabash.com/ns/extensions"
    xmlns:pxi="http://www.daisy.org/ns/pipeline/xproc/internal/nordic-epub3-dtbook-migrator">

    <!-- TODO: remove when this is merged and released: https://github.com/daisy/pipeline-modules-common/pull/84 -->

    <p:output port="result" sequence="true" primary="true">
        <p:pipe port="result" step="result"/>
    </p:output>

    <p:output port="fileset">
        <p:pipe port="result" step="fileset"/>
    </p:output>

    <p:option name="href" required="true"/>
    <p:option name="file"/>
    <p:option name="content-type"/>

    <p:option name="unzipped-basedir"/>
    <p:option name="load-to-memory"/>
    <p:option name="store-to-disk" select="'false'"/>
    <p:option name="overwrite" select="'false'"/>

    <p:import href="http://www.daisy.org/pipeline/modules/file-utils/library.xpl"/>
    <p:import href="../fileset-utils/fileset-add-entry.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/fileset-utils/library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/common-utils/library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/zip-utils/library.xpl"/>
    <p:import href="library.xpl"/>

    <p:choose name="choose">
        <p:when test="p:value-available('load-to-memory')">
            <p:output port="result" sequence="true" primary="true">
                <p:pipe port="result" step="choose.inner"/>
            </p:output>
            <p:output port="otherwise">
                <p:pipe port="otherwise" step="choose.inner"/>
            </p:output>
            <p:choose name="choose.inner">
                <p:when test="p:value-available('file') and $load-to-memory = 'false'">
                    <p:output port="result" sequence="true" primary="true"/>
                    <p:output port="otherwise">
                        <p:inline exclude-inline-prefixes="#all">
                            <c:otherwise>false</c:otherwise>
                        </p:inline>
                    </p:output>

                    <!-- single file; don't load to memory, return manifest instead containing only the requested file -->

                    <px:unzip>
                        <p:with-option name="href" select="$href"/>
                    </px:unzip>
                    <p:delete>
                        <p:with-option name="match" select="concat('/*/*[not(@name=''',replace($file,'''',''''''),''')]')"/>
                    </p:delete>

                </p:when>
                <p:when test="not(p:value-available('file')) and $load-to-memory = 'true'">
                    <p:output port="result" sequence="true" primary="true"/>
                    <p:output port="otherwise">
                        <p:inline exclude-inline-prefixes="#all">
                            <c:otherwise>false</c:otherwise>
                        </p:inline>
                    </p:output>

                    <!-- all files; load to memory -->

                    <px:unzip>
                        <p:with-option name="href" select="$href"/>
                    </px:unzip>
                    <p:delete match="/*/*[ends-with(@name,'/')]"/>
                    <p:for-each>
                        <p:iteration-source select="/*/*"/>
                        <p:variable name="entry-name" select="/*/@name"/>
                        <p:choose>
                            <p:when test="p:value-available('content-type')">
                                <px:unzip>
                                    <p:with-option name="href" select="$href"/>
                                    <p:with-option name="file" select="$entry-name"/>
                                    <p:with-option name="content-type" select="$content-type"/>
                                </px:unzip>
                            </p:when>
                            <p:otherwise>
                                <px:unzip content-type="application/octet-stream">
                                    <p:with-option name="href" select="$href"/>
                                    <p:with-option name="file" select="$entry-name"/>
                                </px:unzip>
                            </p:otherwise>
                        </p:choose>
                        <p:choose>
                            <p:when test="p:value-available('unzipped-basedir')">
                                <p:variable name="basedir" select="if (ends-with($unzipped-basedir,'/')) then $unzipped-basedir else concat($unzipped-basedir,'/')"/>
                                <p:add-attribute match="/*" attribute-name="xml:base">
                                    <p:with-option name="attribute-value" select="resolve-uri($entry-name, $basedir)"/>
                                </p:add-attribute>
                            </p:when>
                            <p:otherwise>
                                <p:identity/>
                            </p:otherwise>
                        </p:choose>
                    </p:for-each>
                </p:when>
                <p:otherwise>
                    <p:output port="result" sequence="true" primary="true"/>
                    <p:output port="otherwise">
                        <p:inline exclude-inline-prefixes="#all">
                            <c:otherwise>true</c:otherwise>
                        </p:inline>
                    </p:output>

                    <p:identity>
                        <p:input port="source">
                            <p:empty/>
                        </p:input>
                    </p:identity>
                </p:otherwise>
            </p:choose>
        </p:when>
        <p:otherwise>
            <p:output port="result" sequence="true" primary="true"/>
            <p:output port="otherwise">
                <p:inline exclude-inline-prefixes="#all">
                    <c:otherwise>true</c:otherwise>
                </p:inline>
            </p:output>

            <p:identity>
                <p:input port="source">
                    <p:empty/>
                </p:input>
            </p:identity>
        </p:otherwise>
    </p:choose>
    <p:choose>
        <p:xpath-context>
            <p:pipe port="otherwise" step="choose"/>
        </p:xpath-context>
        <p:when test="not(/*/text()='true')">
            <p:identity/>
        </p:when>
        <p:otherwise>
            <!-- default pxp:unzip behavior -->

            <p:choose>
                <p:when test="p:value-available('file') and p:value-available('content-type')">
                    <px:unzip>
                        <p:with-option name="href" select="$href"/>
                        <p:with-option name="file" select="$file"/>
                        <p:with-option name="content-type" select="$content-type"/>
                    </px:unzip>
                </p:when>
                <p:when test="p:value-available('file')">
                    <px:unzip>
                        <p:with-option name="href" select="$href"/>
                        <p:with-option name="file" select="$file"/>
                    </px:unzip>
                </p:when>
                <p:otherwise>
                    <px:unzip>
                        <p:with-option name="href" select="$href"/>
                    </px:unzip>
                </p:otherwise>
            </p:choose>

            <p:choose>
                <p:when test="p:value-available('file') and p:value-available('unzipped-basedir')">
                    <!-- set basedir for unzipped file -->
                    <p:variable name="basedir" select="if (ends-with($unzipped-basedir,'/')) then $unzipped-basedir else concat($unzipped-basedir,'/')"/>
                    <p:add-attribute match="/*" attribute-name="xml:base">
                        <p:with-option name="attribute-value" select="resolve-uri(replace($file,'.*/',''), $basedir)"/>
                    </p:add-attribute>
                </p:when>
                <p:otherwise>
                    <p:identity/>
                </p:otherwise>
            </p:choose>

        </p:otherwise>
    </p:choose>
    <p:identity name="result"/>
    <p:sink/>

    <p:choose>
        <p:when test="$store-to-disk = 'true' and not(p:value-available('unzipped-basedir'))">
            <px:error code="PZU001" message="When store-to-disk='true' then unzipped-basedir must also be defined"/>

        </p:when>
        <p:when test="$store-to-disk = 'true'">
            <!-- store first, then create fileset -->

            <p:variable name="basedir" select="if (ends-with($unzipped-basedir,'/')) then $unzipped-basedir else concat($unzipped-basedir,'/')"/>

            <p:choose>
                <p:when test="p:step-available('letex:unzip')">
                    <!-- unzip a single or multiple files directly to disk -->

                    <p:choose>
                        <p:when test="p:value-available('file')">
                            <letex:unzip>
                                <p:with-option name="zip" select="$href"/>
                                <p:with-option name="dest-dir" select="$basedir"/>
                                <p:with-option name="overwrite" select="if ($overwrite = 'true') then 'yes' else 'no'"/>
                                <p:with-option name="file" select="$file"/>
                            </letex:unzip>
                        </p:when>
                        <p:otherwise>
                            <letex:unzip>
                                <p:with-option name="zip" select="$href"/>
                                <p:with-option name="dest-dir" select="$basedir"/>
                                <p:with-option name="overwrite" select="if ($overwrite = 'true') then 'yes' else 'no'"/>
                            </letex:unzip>
                        </p:otherwise>
                    </p:choose>
                    <p:rename match="/*" new-name="d:fileset"/>
                    <p:rename match="/*/*" new-name="d:file"/>
                    <p:rename match="/*/*/@name" new-name="href"/>
                    <p:viewport match="/*/*">
                        <p:add-attribute match="/*" attribute-name="original-href">
                            <p:with-option name="attribute-value" select="resolve-uri(/*/@href,base-uri(.))"/>
                        </p:add-attribute>
                    </p:viewport>

                </p:when>
                <p:otherwise>
                    <!-- load files to memory, then store to disk -->


                    <p:choose>
                        <p:when test="p:value-available('file')">
                            <!-- a single file -->

                            <p:add-attribute match="/*/*" attribute-name="name">
                                <p:input port="source">
                                    <p:inline exclude-inline-prefixes="#all">
                                        <c:zipfile xmlns:c="http://www.w3.org/ns/xproc-step">
                                            <c:file/>
                                        </c:zipfile>
                                    </p:inline>
                                </p:input>
                                <p:with-option name="attribute-value" select="$file"/>
                            </p:add-attribute>

                        </p:when>
                        <p:otherwise>
                            <!-- all files -->

                            <px:unzip>
                                <p:with-option name="href" select="$href"/>
                            </px:unzip>
                        </p:otherwise>
                    </p:choose>
                    <px:message severity="WARN"
                        message="letex:unzip is not available (you are probably running this outside of the DAISY Pipeline 2 framework); unzipping will be slow for big ZIP files"/>

                    <p:for-each>
                        <p:iteration-source select="/*/c:file"/>

                        <p:variable name="entry-name" select="/*/@name"/>
                        <p:variable name="target-href" select="resolve-uri(if (p:value-available('file')) then replace($entry-name,'.*/','') else $entry-name, $basedir)"/>

                        <p:try>
                            <p:group>
                                <px:info>
                                    <p:with-option name="href" select="$target-href"/>
                                </px:info>
                            </p:group>
                            <p:catch>
                                <p:identity>
                                    <p:input port="source">
                                        <p:empty/>
                                    </p:input>
                                </p:identity>
                            </p:catch>
                        </p:try>
                        <p:count/>

                        <p:choose>
                            <p:when test="/*/text() = '0' or $overwrite = 'true'">
                                <px:unzip content-type="application/octet-stream">
                                    <p:with-option name="href" select="$href"/>
                                    <p:with-option name="file" select="$entry-name"/>
                                </px:unzip>
                                <p:store name="store-file" cx:decode="true" encoding="base64">
                                    <p:with-option name="href" select="$target-href"/>
                                </p:store>
                                <p:rename match="/*" new-name="d:file">
                                    <p:input port="source">
                                        <p:pipe port="result" step="store-file"/>
                                    </p:input>
                                </p:rename>
                                <p:add-attribute match="/*" attribute-name="original-href">
                                    <p:with-option name="attribute-value" select="/*/text()"/>
                                </p:add-attribute>
                                <p:delete match="/*/text()"/>
                                <p:add-attribute match="/*" attribute-name="href">
                                    <p:with-option name="attribute-value" select="replace(/*/@original-href,'.*/','')"/>
                                </p:add-attribute>
                                <p:wrap-sequence wrapper="d:fileset"/>
                                <p:add-attribute match="/*" attribute-name="xml:base">
                                    <p:with-option name="attribute-value" select="replace(/*/*/@original-href,'[^/]+$','')"/>
                                </p:add-attribute>

                            </p:when>
                            <p:otherwise>
                                <!-- don't overwrite existing file -->

                                <px:fileset-create>
                                    <p:with-option name="base" select="replace($target-href,'[^/]+$','')"/>
                                </px:fileset-create>
                                <pxi:fileset-add-entry>
                                    <p:with-option name="href" select="replace($target-href,'.*/','')"/>
                                </pxi:fileset-add-entry>
                            </p:otherwise>
                        </p:choose>
                    </p:for-each>
                    <px:fileset-join/>

                </p:otherwise>
            </p:choose>

        </p:when>
        <p:when test="p:value-available('file')">
            <!-- single-file fileset -->

            <p:choose>
                <p:when test="p:value-available('unzipped-basedir')">
                    <p:variable name="basedir" select="if (ends-with($unzipped-basedir,'/')) then $unzipped-basedir else concat($unzipped-basedir,'/')"/>
                    <px:fileset-create>
                        <p:with-option name="base" select="$basedir"/>
                    </px:fileset-create>
                </p:when>
                <p:otherwise>
                    <px:fileset-create/>
                </p:otherwise>
            </p:choose>

            <pxi:fileset-add-entry>
                <p:with-option name="href" select="replace($file,'.*/','')"/>
            </pxi:fileset-add-entry>

        </p:when>
        <p:otherwise>
            <!-- create fileset by reading zip manifest -->

            <px:unzip>
                <p:with-option name="href" select="$href"/>
            </px:unzip>
            <p:rename match="/*" new-name="d:fileset"/>
            <p:choose>
                <p:when test="p:value-available('unzipped-basedir')">
                    <p:variable name="basedir" select="if (ends-with($unzipped-basedir,'/')) then $unzipped-basedir else concat($unzipped-basedir,'/')"/>
                    <p:add-attribute match="/*" attribute-name="xml:base">
                        <p:with-option name="attribute-value" select="$basedir"/>
                    </p:add-attribute>
                </p:when>
                <p:otherwise>
                    <p:identity/>
                </p:otherwise>
            </p:choose>
            <p:delete match="/*/@*[not(name()='xml:base')]"/>
            <p:delete match="/*/*[ends-with(@name,'/')]"/>
            <p:viewport match="/*/*">
                <p:rename match="/*" new-name="d:file"/>
                <p:add-attribute match="/*" attribute-name="href">
                    <p:with-option name="attribute-value" select="/*/@name"/>
                </p:add-attribute>
            </p:viewport>
            <p:delete match="/*/*/@*[not(name()='href')]"/>

        </p:otherwise>
    </p:choose>
    <p:identity name="fileset"/>
    <p:sink/>

</p:declare-step>
