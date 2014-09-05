Nordic EPUB3/DTBook Migrator
============================

[![Build Status](https://travis-ci.org/nlbdev/nordic-epub3-dtbook-migrator.svg)](https://travis-ci.org/nlbdev/nordic-epub3-dtbook-migrator)

The main goal of this project is to provide a EPUB3 to DTBook conversion tool for the libraries in the Nordic countries providing accessible litterature to visually impaired readers
([NLB](http://www.nlb.no/), [MTM](http://mtm.se/), [Celia](http://www.celia.fi/), [Nota](http://www.nota.nu/) and [SBS](http://sbs.ch/)).
The conversion will be implemented in XProc and XSLT. As a tool, [DAISY Pipeline 2](http://www.daisy.org/pipeline2) is recommended,
as the conversion will be made available as a Pipeline 2 script.
This conversion will allow the organizations to continue to use their respective DTBook-based tools for production of Braille and Synthetic Speech, as long as those are necessary.

The intention is also to create a 1:1 mapping between DTBook and EPUB3. As a convenience the reverse conversion, DTBook to EPUB3, will also be provided (strictly following the
Nordic markup guidelines and limitations, as opposed to the more generic script bundled with the official Pipeline 2 distribution). This allows us to generate some EPUB3 files
similar to what we can expect to receive when in production (books marked up according to the Nordic markup requirements).

While the EPUB3 will consist of multiple HTML files internally, an intermediate single-page HTML representation is useful for converting to and from DTBook. Steps for converting
between the intermediate single-document and multi-document HTML representations will also be provided, mainly so that those not familiar with XProc or XSLT can inspect the intermediate formats and help with testing the converter.

This project will provide the following Pipeline 2 scripts:

 * EPUB3 to DTBook
 * DTBook to EPUB3
 * EPUB3 Validator

The project might also result in the following Pipeline 2 scripts:

 * HTML to DTBook
 * DTBook to HTML
 * HTML splitter
 * HTML merger
 * DTBook Validator

The HTML referred to here are HTML marked up according to the Nordic markup guidelines, and will most notably make use of the
[epub:type](http://www.idpf.org/accessibility/guidelines/content/semantics/epub-type.php) attribute, which will be used to determine where to split the single-page HTML and how to
map the HTML to DTBook.

The grammar used in the EPUB3 and DTBook files is a strict subset of EPUB3 and DTBook, and is defined in the Nordic markup guidelines. Most DTBooks will work with these scripts, there
are few limitations to the DTBook grammar. There are more limitations to the HTML/EPUB3 grammar however, because there must be a way to convert it to DTBook.
Most notably, audio and video are not allowed in these EPUB3s.

See [the project homepage](http://nlbdev.github.io/nordic-epub3-dtbook-migrator/) for more information.

