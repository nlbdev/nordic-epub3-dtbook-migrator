Nordic EPUB3/DTBook Migrator
============================

Branch for converting from EPUB 3 to HTML using a Python script.


## Running with Docker

Requirements:

    - Docker

Usage:

```
./run.sh <source> [target] [options]
```

`target` defaults to the `target/` directory if it's not specified.


## Running with Python

Requirements:

    - Python 3.11+ (might work with earlier versions of Python 3, but it is only tested with 3.11)
    - Epubcheck (environment variable `EPUBCHECK_HOME` must point to the directory containing `epubcheck.jar`)

Usage:

```
source .venv/bin/activate
pip install -r requirements.txt
src/run.py <source> <target> [options]
```

## Options

```
    --fix-heading-levels=true|false (default: true)
    --add-header-element=true|false (default: true)
```

Results will be stored in the target directory both as an expanded version and as a zipped version.
