# Nordic Validator client

This is a client containing the validator rules. 
It can validate using EPUBCheck, Ace and the Nordic guideline
rules.

### Build new version

Create a new version of the tooling with the current schema you
need to one dependency to convert the schema files to xslt.
More over you need to download and install saxon-xslt.

#### Download schxslt

Download the latest release of `schxslt` and unpack it to the directory
`client/schxslt`.

https://github.com/schxslt/schxslt/releases

#### Installing saxon-xslt

First you need to download the package from the site or find it in your distribution.

https://www.saxonica.com/download/download_page.xml

Currently we use version 9 to run our conversion of the schema. Saxon is embedded in the executable
so this is only needed during the build process.

The executable the script is looking for is `saxon9-xslt`

#### Update nordic guideline rules

To update the rules we run a script to convert the schema files into
xslt that the program later will execute with saxon. 

In order to run the conversion execute the `./createSchema.sh` script.

#### Building jar file

Last but not least we can now build a version of the program by running maven in order to package 
or distribute the new version.

```
mvn package
```
