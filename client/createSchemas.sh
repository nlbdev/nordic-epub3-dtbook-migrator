#!/bin/bash

SCHXSLT_PATH=schxslt
MIGRATOR_PATH=..
SCHEMA_PATH=$MIGRATOR_PATH/src/main/resources/xml/schema
XSLT_PATH=$MIGRATOR_PATH/src/main/resources/xml/xslt

mkdir -p src/main/resources/2015-1
mkdir -p src/main/resources/2020-1

cp $SCHEMA_PATH/2015-1/nordic-html5.rng src/main/resources/2015-1
sed -i 's/http:\/\/www.daisy.org\/pipeline\/modules\/mathml-utils\/mathml3.rng/mathml3.rng/' src/main/resources/2015-1/nordic-html5.rng
sed -i 's/<define name="annotation">/<define name="annotation" combine="choice">/' src/main/resources/2015-1/nordic-html5.rng
sed -i 's/<define name="list">/<define name="list" combine="choice">/' src/main/resources/2015-1/nordic-html5.rng
sed -i '/<start combine="choice">/,/<\/start>/d' src/main/resources/2015-1/nordic-html5.rng

saxon11-xslt -s:$SCHEMA_PATH/2015-1/nordic2015-1.nav-ncx.sch -o:src/main/resources/2015-1/nordic2015-1.nav-ncx.xsl -xsl:$SCHXSLT_PATH/src/main/resources/content/transpile.xsl
saxon11-xslt -s:$SCHEMA_PATH/2015-1/nordic2015-1.nav-references.sch -o:src/main/resources/2015-1/nordic2015-1.nav-references.xsl -xsl:$SCHXSLT_PATH/src/main/resources/content/transpile.xsl
saxon11-xslt -s:$SCHEMA_PATH/2015-1/nordic2015-1.opf-and-html.sch -o:src/main/resources/2015-1/nordic2015-1.opf-and-html.xsl -xsl:$SCHXSLT_PATH/src/main/resources/content/transpile.xsl
saxon11-xslt -s:$SCHEMA_PATH/2015-1/nordic2015-1.opf.sch -o:src/main/resources/2015-1/nordic2015-1.opf.xsl -xsl:$SCHXSLT_PATH/src/main/resources/content/transpile.xsl
saxon11-xslt -s:$SCHEMA_PATH/2015-1/nordic2015-1.sch -o:src/main/resources/2015-1/nordic2015-1.xsl -xsl:$SCHXSLT_PATH/src/main/resources/content/transpile.xsl

cp $SCHEMA_PATH/2020-1/nordic-html5.rng src/main/resources/2020-1
sed -i 's/http:\/\/www.daisy.org\/pipeline\/modules\/mathml-utils\/mathml3.rng/mathml3.rng/' src/main/resources/2020-1/nordic-html5.rng
sed -i 's/<define name="annotation">/<define name="annotation" combine="choice">/' src/main/resources/2020-1/nordic-html5.rng
sed -i 's/<define name="list">/<define name="list" combine="choice">/' src/main/resources/2020-1/nordic-html5.rng
sed -i '/<start combine="choice">/,/<\/start>/d' src/main/resources/2020-1/nordic-html5.rng

saxon11-xslt -s:$SCHEMA_PATH/2020-1/nordic2020-1.nav-ncx.sch -o:src/main/resources/2020-1/nordic2020-1.nav-ncx.xsl -xsl:$SCHXSLT_PATH/src/main/resources/content/transpile.xsl
saxon11-xslt -s:$SCHEMA_PATH/2020-1/nordic2020-1.nav-references.sch -o:src/main/resources/2020-1/nordic2020-1.nav-references.xsl -xsl:$SCHXSLT_PATH/src/main/resources/content/transpile.xsl
saxon11-xslt -s:$SCHEMA_PATH/2020-1/nordic2020-1.opf-and-html.sch -o:src/main/resources/2020-1/nordic2020-1.opf-and-html.xsl -xsl:$SCHXSLT_PATH/src/main/resources/content/transpile.xsl
saxon11-xslt -s:$SCHEMA_PATH/2020-1/nordic2020-1.opf.sch -o:src/main/resources/2020-1/nordic2020-1.opf.xsl -xsl:$SCHXSLT_PATH/src/main/resources/content/transpile.xsl
saxon11-xslt -s:$SCHEMA_PATH/2020-1/nordic2020-1.sch -o:src/main/resources/2020-1/nordic2020-1.xsl -xsl:$SCHXSLT_PATH/src/main/resources/content/transpile.xsl


mkdir -p src/main/resources/xslt/2015-1
mkdir -p src/main/resources/xslt/2020-1
cp $XSLT_PATH/2015-1/list-heading-and-pagebreak-references.xsl src/main/resources/xslt/2015-1
cp $XSLT_PATH/2020-1/list-heading-and-pagebreak-references.xsl src/main/resources/xslt/2020-1


mkdir -p src/main/resources/dtbook/compiled
saxon11-xslt -s:src/main/resources/dtbook/sch/dtbook.mathml.nimas.sch -o:src/main/resources/dtbook/compiled/dtbook.mathml.nimas.xsl -xsl:$SCHXSLT_PATH/src/main/resources/content/transpile.xsl
saxon11-xslt -s:src/main/resources/dtbook/sch/dtbook.mathml.sch -o:src/main/resources/dtbook/compiled/dtbook.mathml.xsl -xsl:$SCHXSLT_PATH/src/main/resources/content/transpile.xsl
