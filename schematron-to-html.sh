#!/bin/bash

BRANCH="$1"

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

if [ "$BRANCH" = "" ] ; then
    BRANCH="master"
fi

CLONEDIR="$DIR/target/nordic-epub3-dtbook-migrator"

if [ -d "$CLONEDIR" ] ; then
    echo "$CLONEDIR already exists; assuming that repository is already cloned"
    cd "$CLONEDIR"
    git checkout master
    git pull
else
    mkdir -p "$CLONEDIR"
    git clone https://github.com/nlbdev/nordic-epub3-dtbook-migrator.git "$CLONEDIR"
    cd "$CLONEDIR"
fi

git checkout $BRANCH
pwd

mkdir -p "$DIR/schemadoc"
SCHEMADOCINDEX="$DIR/schemadoc/index.html"

echo '<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta charset="utf-8" />
    <title>Schematron documentation for Nordic EPUB3/DTBook Migrator</title>
    <link href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
    <div class="container">
    <h1>Schematron documentation for Nordic EPUB3/DTBook Migrator</h1>
    <ul>
' > "$SCHEMADOCINDEX"

for SCHEMATRON in `find -type f | grep src/main | grep sch$` ; do
    NAME="`echo $SCHEMATRON | sed 's/.*\///' | sed 's/\.sch$//'`"
    xslt "$CLONEDIR/$SCHEMATRON" "$DIR/schematron-to-html.xsl" > "$DIR/schemadoc/$NAME.html"
    TITLE="`cat "$DIR/schemadoc/$NAME.html" | grep "<title" | sed 's/.*>\(.*\)<.*/\1/'`"
    echo "<li><a href=\"$NAME.html\">$NAME.sch: $TITLE</a></li>" >> "$DIR/schemadoc/index.html"
done

TIMESTAMP="`date -u +"%Y-%m-%d %H:%M:%S"`"
echo '</ul><br />' >> "$SCHEMADOCINDEX"
echo "<footer><em>Last updated: $TIMESTAMP</em></footer><br /><br /><br /></div>" >> "$SCHEMADOCINDEX"
echo '</body></html>' >> "$SCHEMADOCINDEX"
