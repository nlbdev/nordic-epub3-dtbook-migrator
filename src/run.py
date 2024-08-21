#!/bin/env python3

import sys


def test():
    print("test(): Not implemented")
    # TODO: rewrite xprocspec tests into python tests
    sys.exit(1)


def main():
    print("main(): Not implemented")
    # 0. assert that some expected files exist:
    #     - META-INF/container.xml
    #     - mimetype
    #     - EPUB∕package.opf
    #     - EPUB∕nav.xhtml
    # 1. list spine items
    # 2. pick body from spine items and use the body elements as sections (so that they have an id)
    # 3. use the html tag and the head element from the first content document for the new document
    # 4. fix-section-hierarchy.xsl:
    #    - xpath to calculcate h level: `count(ancestor::section | ancestor::article | ancestor::nav | ancestor::aside | ancestor::header)`
    # 5. make-uris-relative-to-document.xsl:
    #    - xpath @href|@src|@xlink:href|@altimg|@data[parent::object]
    #    - if value starts with the filename of a content document, then replace it with the filename of the new document (for intstance 123456-chapter-1.xhtml -> 123456.xhtml)
    # 6. insert at beginning: <header xmlns="http://www.w3.org/1999/xhtml"><h1 epub:type="fulltitle" class="title">dc:title</h1></header>
    # 7. update nav.xhtml
    # 8. update package.opf
    # 9. validate with epubcheck
    sys.exit(1)


if __name__ == '__main__':
    if len(sys.argv) >= 2 and sys.argv[1] == 'test':
        test()
    else:
        main()
