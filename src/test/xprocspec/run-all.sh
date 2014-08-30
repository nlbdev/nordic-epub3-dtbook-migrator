#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# This script allows for easy execution and reporting of all xprocspec tests at once
# (until we get it working as part of the maven build itself).
#
# Note: Support for relax ng validation is required.
#       The files "jing.jar" (20091111) and "isorelax.jar"
#       must be placed in the calabash lib directory.
#
# This script depends on calabash, xprocspec, pipeline-scripts, pipeline-scripts-utils and pipeline-common-utils.
# The pipeline-* repositories are expected to be located as defined in catalog.xml.
# The location of calabash and xprocspec can be changed in the variables below.

CALABASH="`echo ~/xmlcalabash-1.0.18-95/calabash.jar`"
XPROCSPEC="`echo ~/xprocspec/src/main/resources/content/xml/xproc/xprocspec.xpl`"
TEMP_DIR="file:/tmp/"
RESULT_DIR="$DIR/report/"

mkdir -p $RESULT_DIR

echo "<!DOCTYPE html>" > $RESULT_DIR/index.html
echo "<html>" >> $RESULT_DIR/index.html
echo "<head><title>xprocspec tests</title></head>" >> $RESULT_DIR/index.html
echo "<body><h1>xprocspec tests</h1><ul>" >> $RESULT_DIR/index.html

ls *.xprocspec | while read TESTFILE;
do
    FILENAME="`echo \"$TESTFILE\" | sed -e 's/\.xprocspec$//'`"
    java -Dxml.catalog.files="catalog.xml" -Xmx1024m -jar "$CALABASH" \
                temp-dir="$TEMP_DIR" \
                --input source="file:$DIR/$TESTFILE" \
                --output html="file:$RESULT_DIR/$FILENAME.html" \
                --output result="file:$RESULT_DIR/$FILENAME.result.xml" \
                --output junit="file:$RESULT_DIR/$FILENAME.junit.xml" \
                --config config-calabash.xml \
                $XPROCSPEC
    RESULT="`cat $RESULT_DIR/$FILENAME.junit.xml | tr '\n' ' ' | sed -e 's/^.*<testsuites//' | sed -e 's/>.*//'`"
    TESTS="`echo \"$RESULT\" | sed -e 's/.*tests=\"//' | sed -e 's/\".*//'`"
    FAILURES="`echo \"$RESULT\" | sed -e 's/.*failures=\"//' | sed -e 's/\".*//'`"
    ERRORS="`echo \"$RESULT\" | sed -e 's/.*errors=\"//' | sed -e 's/\".*//'`"
    TIME="`echo \"$RESULT\" | sed -e 's/.*time=\"//' | sed -e 's/\".*//'`"
    echo "<li style=\"background-color: " >> $RESULT_DIR/index.html
    if [ "$FAILURES" -eq "0" ] && [ "$ERRORS" -eq "0" ]; then
        echo "#BFFFBF" >> $RESULT_DIR/index.html
    else
        echo "#FFBFBF" >> $RESULT_DIR/index.html
    fi
    echo ";\">" >> $RESULT_DIR/index.html
    echo "<strong><a href=\"$FILENAME.html\">$FILENAME</a></strong>" >> $RESULT_DIR/index.html
    echo "<small>(<a href=\"$FILENAME.result.xml\">XML</a> / <a href=\"$FILENAME.junit.xml\">JUnit</a>)</small>" >> $RESULT_DIR/index.html
    echo "<p>tests: $TESTS, failures: $FAILURES, errors: $ERRORS, time: $TIME</p>" >> $RESULT_DIR/index.html
    echo "</li>" >> $RESULT_DIR/index.html
done

echo "</ul></body></html>" >> $RESULT_DIR/index.html
gnome-open $RESULT_DIR/index.html