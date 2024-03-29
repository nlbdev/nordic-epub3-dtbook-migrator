Nordic EPUB3/DTBook Migrator
============================

## Project status

The current focus is on:
- finalizing and releasing an official version for validating EPUBs according to the 2020-1 guidelines
- removing the dependency on Pipeline 2

See more details for the current development phase here: https://github.com/nlbdev/nordic-epub3-dtbook-migrator/issues/522

## 2015

The first goal of this project was to provide a EPUB3 to DTBook conversion tool
for the libraries in the Nordic countries providing accessible litterature to
visually impaired readers ([NLB](http://www.nlb.no/), [MTM](http://mtm.se/),
[SPSM](http://www.spsm.se/),
[Celia](http://www.celia.fi/), [Nota](http://www.nota.nu/) and [SBS](http://sbs.ch/)).
The conversion is implemented in XProc and XSLT and provided as a
[DAISY Pipeline 2](http://www.daisy.org/pipeline2) script.
This conversion allows the organizations to continue to use their respective
DTBook-based tools for production of Braille and Synthetic Speech,
as long as those are necessary, and gradually start using EPUB when their
production tools are ready.

This tool attempts to map EPUB3 to DTBook with as little loss as possible (a 1:1 mapping).

While the EPUB3 will consist of multiple HTML files internally, an intermediate
single-page HTML representation is useful for converting to and from DTBook.

## 2020

A revision of the guidelines was started in 2020. The participating organisations are
[Celia](https://www.celia.fi/), [Dedicon](https://www.dedicon.nl/), [HBS](https://hbs.is/),
[MTM](https://mtm.se), [NLB](https://www.nlb.no/), [Nota](https://nota.dk/),
[SBS](https://www.sbs.ch/), [SPSM](https://www.spsm.se/), and [Statped](http://statped.no/).

As a result, an updated validator was needed, and EPUB validation for the new guidelines
were implemented. There is not (at least not yet) any conversion path between previous
versions of the guidelines (EPUB 2015-1 or DTBook 2011-2) and the new version (EPUB 2020-1).

## Scripts

This project provides the following Pipeline 2 scripts:

- EPUB3 to DTBook
- EPUB3 to HTML
- EPUB3 Validator
- EPUB3 ASCIIMath to MathML
- HTML to EPUB3
- HTML to DTBook
- HTML Validator
- DTBook to EPUB3
- DTBook to HTML
- DTBook Validator

The only script that currently supports the 2020-1 guidelines is
the EPUB3 Validator script.

The EPUB3 to DTBook script allows new EPUB3 files to be used
with legacy DTBook-based systems.

The DTBook to EPUB3 script allows legacy DTBooks to be upgraded to new
EPUB3-based production systems.

Scripts for converting between the intermediary single-HTML representation
of the publications are also provided. These are useful either for debugging,
or if a single-document HTML representation is needed as input to or output from
a HTML-based production system.

Validators for EPUB3, DTBook and single-document HTML files are provided.
The EPUB3 validator allows us to check that new EPUB3 files are valid according
to the nordic markup guidelines. The DTBook and HTML validators can be useful
for DTBook- or HTML-based production systems.

In the nordic markup guidelines (version 2015-1), math is marked up using ASCIIMath.
An experimental script for converting this ASCIIMath to MathML is provided.

The grammar used in the EPUB3, HTML and DTBook files is a strict subset of EPUB3, HTML and DTBook,
and is defined in the Nordic markup guidelines. Most DTBooks will work with these scripts,
there are few limitations to the input DTBook grammar. There are more limitations to the HTML/EPUB3
grammar however, because there must be a way to convert it to DTBook.
Most notably, multimedia such as audio and video are currently not allowed in these EPUB3s.

## Building

Install dependencies:

```bash
sudo apt install git maven gpg
```

Clone the repository:

```bash
git clone https://github.com/nlbdev/nordic-epub3-dtbook-migrator.git
```

The Nordic Migrator can be built with Maven,
either directly (with for instance `mvn clean package`),
or indirectly with Docker (with for instance `docker build .`).

Testing is part of the build process, but can be explicitly
invoked with `mvn test`.

<!--
To check the code conventions use a special Maven plugin: `mvn
editorconfig:check`. The conventions are defined in `.editorconfig`
which is picked up by most editors, see <https://editorconfig.org/>. You
can also fix the conventions in all files with `mvn
editorconfig:format`.
-->

## Releasing

First, make sure you have a GPG key:
https://docs.github.com/en/authentication/managing-commit-signature-verification/generating-a-new-gpg-key

And also make sure that you have set your GPG key as default in `~/.gnupg/gpg.conf`:

```
default-key ABCDEF123
```

Add your Github credentials to your local `~/.m2/settings.xml` (you should use a personal access token as the password):

```xml
  <server>
    <id>github</id>
    <username><!-- your github username here --></username>
    <password><!-- your personal access token here --></password>
  </server>
```

The convention has been to release from a feature branch or dedicated release branch, and then merge into the master branch in a merge commit.

Prepare the release:

```bash
mvn release:prepare
```

You will be asked:
- *What is the release version (…)?*
    - use semantic versioning to choose the version number. For bugfixes and similar, the default is fine: a bumped patch version number
- *What is SCM release tag or label (…)?*
    - the tags we use are a "v" followed by the release version; this is also what is suggested by default
- *What is the new development version (…)?*
    - just use the default here, which is the release version with a bumped patch version and a "-SNAPSHOT" suffix

At this point, Maven will update the version in the POM and run all the tests. This will take a few minutes.

If you look in the git log when it's done, you'll find:

```
HEAD        [maven-release-plugin] prepare for next development iteration
tag: vX.X.X [maven-release-plugin] prepare release vX.X.X
```

Then, you can publish the release artifacts using:

```bash
mvn release:perform
```

Also, remember to push the tag upstream:

```
git push origin vX.X.X
```

The project is set up so that the branch `mvn-repo` is used as a maven repository. Artifacts will be published to that branch.

If you want to use nordic migrator as a maven package in another project; add this repository to your project:

```xml
    <repository>
        <id>nordic-epub3-dtbook-migrator-mvn-repo</id>
        <url>https://github.com/nlbdev/nordic-epub3-dtbook-migrator/raw/mvn-repo/</url>
        <snapshots>
            <enabled>true</enabled>
            <updatePolicy>always</updatePolicy>
        </snapshots>
    </repository>
```


### Docker images:

Commits tagged with a version are built and tagged automatically on Docker Hub. The tag is created automatically by `mvn release:prepare`, and when you push the git tag to Github with `git push origin vX.X.X`, a webhook will tell Docker Hub to build a new image.

All commits on the master branch will be built on Docker Hub. The latest commit will be available as `:latest`.


## References

See [the project homepage](http://nlbdev.github.io/nordic-epub3-dtbook-migrator/) for more information.
