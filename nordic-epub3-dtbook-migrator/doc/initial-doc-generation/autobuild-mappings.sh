#!/bin/bash

while true; do
    change=$(inotifywait -e close_write make-human-readable-mapping.xsl)
    echo
    echo " ########## "
    echo
    echo "'make-human-readable-mapping.xsl' has changed; recompiling mapping documentation"
    xslt ../../src/main/resources/xml/xslt/epub3-to-dtbook.xsl make-human-readable-mapping.xsl > /tmp/epub3-to-dtbook.html
    xslt ../../src/main/resources/xml/xslt/dtbook-to-epub3.xsl make-human-readable-mapping.xsl > /tmp/dtbook-to-epub3.html
    cp /tmp/epub3-to-dtbook.html /tmp/dtbook-to-epub3.html /tmp/mappings/
done