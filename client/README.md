# Nordic Validator client

This is a client containing the validator rules. 
It can validate using EPUBCheck, Ace and the Nordic guideline
rules.

### Build new version

Create a new version of the tooling with the current schema you
need to one dependency to convert the schema files to xslt.
More over you need to download and install saxon-xslt.

#### Checkout schxslt

Clone the latest release of `schxslt` and into the directory
`client/schxslt`.

git clone https://github.com/schxslt/SchXslt2-Core .

#### Installing saxon-xslt

First you need to download the package from the site or find it in your distribution.

https://github.com/Saxonica/Saxon-HE/tree/main/11/Java

Currently we use version 11 to run our conversion of the schema. Saxon is embedded in the executable
so this is only needed during the build process.

The executable the script is looking for is `saxon11-xslt`

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
