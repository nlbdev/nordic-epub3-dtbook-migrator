<?xml version="1.0" encoding="UTF-8"?><html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
   <head>
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
      <title>Schematron rules for Nordic EPUB 2020-1</title><style>
                    body{
                        font-family: Arial, Helvetica, sans-serif;
                        font-size: 12px;
                        max-width: 95%;
                        margin: auto;
                    }
                    h1{
                        text-align: center;
                        font-size: 1.5rem;
                        margin-top: 1rem;
                        margin-bottom: 2rem;
                    }
                    table,
                    th,
                    td{
                        border: 0.1rem solid #ddd;
                        border-collapse: collapse;
                        padding: 0.5rem;
                    }
                    table{
                        margin-bottom: 2rem
                    }
                    tr:nth-child(even){
                        background-color: #f2f2f2;
                    }
                    tbody tr:hover{
                        background-color: #ddd;
                    }
                    thead{
                        background-color: #1D393C;
                        color: white;
                    }
                    td:first-child{
                        white-space: nowrap;
                    }
                    footer{
                        margin-top: 1rem;
                        margin-bottom: 1rem;
                        text-align: center;
                        font-size: 0.8rem;
                    }</style></head>
   <body>
      <h1>Schematron rules for Nordic EPUB 2020-1</h1>
      <table>
         <thead>
            <tr>
               <th>Rule</th>
               <th>Global description</th>
               <th>Detailed description</th>
            </tr>
         </thead>
         <tbody>
            <tr>
               <td>1</td>
               <td></td>
               <td>[opf1] the OPF file must have the extension .opf<br />[opf1] the filename of the OPF must be package.opf<br />[opf1] the OPF must be contained in a folder named EPUB<br /></td>
            </tr>
            <tr>
               <td>2</td>
               <td></td>
               <td>[opf2] the version attribute must be 3.0<br />[opf2] on the package element; the unique-identifier-attribute must be present and
                  equal 'pub-identifier'<br />[opf2] on the package element; the dublin core namespace (xmlns:dc="http://purl.org/dc/elements/1.1/")
                  must be declared on the package element<br />[opf2] on the package element; the prefix attribute must declare the nordic metadata
                  namespace using the correct namespace URI (prefix="nordic:
                  http://www.mtm.se/epub/")<br />[opf2] on the package element; the prefix attribute must declare the a11y metadata
                  namespace using the correct URI (prefix="a11y:
                  http://www.idpf.org/epub/vocab/package/a11y/#")[opf2] on the package element; the prefix attribute must declare the '' prefix<br /></td>
            </tr>
            <tr>
               <td>3</td>
               <td></td>
               <td>[opf3a] there must be exactly one dc:identifier element<br />[opf3a] the id of the dc:identifier must equal the value of the package elements unique-identifier
                  attribute<br />[opf3a] The identifier ("") must start with a upper- or
                  lower-case letter (A-Z or a-z), or a digit (0-9).<br />[opf3a] The identifier ("") must end with a upper- or
                  lower-case letter (A-Z or a-z), or a digit (0-9).<br />[opf3a] The identifier ("") must only contain upper-
                  or lower-case letters (A-Z or a-z), digits (0-9), dashes (-) and underscores (_).<br />[opf3b] exactly one dc:title  must be
                  present in the package document.<br />[opf3b] the dc:title  must not be empty.<br />[opf3c] exactly one dc:language  must be present in the package document.<br />[opf3c] the language code ("") must be either a "two-letter lower case" code or a
                  "two-letter lower case + hyphen + two-letter upper case" code.<br />[opf3d] exactly one dc:date  must be
                  present<br />[opf3d] the dc:date () must be of the format
                  YYYY-MM-DD (year-month-day)<br />[opf3e] exactly one dc:publisher  must be present<br />[opf3e] the dc:publisher cannot be empty<br />[opf3f] exactly one last modified date  must be present<br />[opf3f] the last modified date () must use UTC time and be on the form "CCYY-MM-DDThh:mm:ssZ"
                  (year-month-date "T" hour:minute:second "Z")<br />[opf3g] at least dc:creator (i.e. book author)  must be present<br />[opf3h] exactly one dc:source  must
                  be present<br />[opf3h] the dc:source
                  ("") must start with 'urn:isbn:' or 'urn:issn'<br />[opf3h] the ISBN or ISSN in dc:source ("") can only contain numbers and hyphens, in
                  addition to the 'urn:isbn:' or 'urn:issn:' prefix. The last digit can also be a 'X'
                  in some
                  ISBNs.<br />[opf3i] there must be exactly one meta element with the property "nordic:guidelines"
                  <br />[opf3i] the value of nordic:guidelines must be '2015-1'<br />[opf3j] there must be exactly one meta element with the property "nordic:supplier"
                  <br /></td>
            </tr>
            <tr>
               <td>5a</td>
               <td></td>
               <td>[opf5a] a NCX must be present in the manifest (media-type="application/x-dtbncx+xml")<br /></td>
            </tr>
            <tr>
               <td>5b</td>
               <td></td>
               <td>[opf5b] the NCX must be located in the same directory as the package document, and
                  must be named "nav.ncx" (not "")<br /></td>
            </tr>
            <tr>
               <td>6</td>
               <td></td>
               <td>[opf6] the toc attribute must be present<br />[opf6] the toc attribute must refer to an item in the manifest<br /></td>
            </tr>
            <tr>
               <td>7</td>
               <td></td>
               <td>[opf7] the Navigation Document must be located in the same directory as the package
                  document, and must be named 'nav.xhtml' (not "")<br /></td>
            </tr>
            <tr>
               <td>8</td>
               <td></td>
               <td>[opf8] all images must be stored in the "images" directory (which is a subdirectory
                  relative to the package document). The image file
                  "" is located in "".<br /></td>
            </tr>
            <tr>
               <td>9</td>
               <td></td>
               <td>[opf9] all content files must be located in the same directory as the package document.
                  The content file file "" is located in "".<br /></td>
            </tr>
            <tr>
               <td>10</td>
               <td></td>
               <td>[opf10] Cover must be marked as secondary in the spine (i.e. set linear="no" on the
                  itemref with idref="", which refers to the
                  cover)<br /></td>
            </tr>
            <tr>
               <td>11</td>
               <td></td>
               <td>[opf11] Rearnotes must be marked as secondary in the spine (i.e. set linear="no" on
                  the itemref with idref=", which refers to the
                  rearnote)<br /></td>
            </tr>
            <tr>
               <td>12a</td>
               <td></td>
               <td>[opf12a] The content document "" has a bad filename. Content documents must match
                  the
                  "[dc:identifier]-[position in spine]-[epub:type].xhtml" file naming convention. Example:
                  "DTB123-01-cover.xhtml". The identifier are allowed to contain the upper- and lower-case
                  characters A-Z and a-z as well as digits (0-9), dashes (-) and underscores (_). The
                  position is a positive whole number consisting of the digits 0-9. The epub:type must
                  be all
                  lower-case characters (a-z) and can contain a dash (-). An optional positive whole
                  number (digits 0-9) can be added after the epub:type to be able to easily tell different
                  files with
                  the same epub:type apart. For instance: "DTB123-13-chapter-7.xhtml".<br /></td>
            </tr>
            <tr>
               <td>12b</td>
               <td></td>
               <td>[opf12b_identifier] The "identifier" part of the filename ("") must be the same as
                  declared in metadata, i.e.: "".<br />[opf12b_type] "" is not a valid type.  The filename of content documents must end
                  with a epub:type defined in either the EPUB3 Structural Semantics Vocabulary (http://www.idpf.org/epub/vocab/structure/#)
                  or the
                  Z39.98-2012 Structural Semantics Vocabulary (http://www.daisy.org/z3998/2012/vocab/structure/).<br />[opf12b_position] The numbering of the content documents must all have the equal number
                  of digits.<br />[opf12b_position] The numbering of the content documents must be unique for each content
                  document.  is also used by another content document in the
                  OPF.<br />[opf12b_position] The numbering of the content documents must start at 1 and increase
                  with 1 for each item.<br />[opf12b_position] The  itemref (&lt;iremref id="" href="..."&gt;) should refer to &lt;item
                  href=""&gt;.<br /></td>
            </tr>
            <tr>
               <td>13</td>
               <td></td>
               <td>[opf13] the Navigation Document must be identified with the attribute properties="nav"
                  in the OPF manifest. It currently <br /></td>
            </tr>
            <tr>
               <td>14</td>
               <td></td>
               <td>[opf14] the Navigation Document must not be present in the OPF spine
                  (itemref with idref="").<br /></td>
            </tr>
            <tr>
               <td>15a</td>
               <td></td>
               <td>[opf15a] The cover image must have a properties attribute containing the value 'cover-image':
                  <br /></td>
            </tr>
            <tr>
               <td>15b</td>
               <td></td>
               <td>[opf15b] The image with property value 'cover-image' must have the filename 'cover.jpg':
                  <br /></td>
            </tr>
         </tbody>
      </table>
   </body>
</html>
