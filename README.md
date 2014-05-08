# Nordic EPUB3/DTBook Migrator - batch conversion

## System Requirements

The bash script is developed for Linux.

It might work on OSX too, but I haven't tried. It might need minor modifications.

I currently have no plans to write a batch script for Windows.

The bash script requires DAISY Pipeline 2 to perform the conversions.

It also makes use of the "calc" program to perform some calculations (can probably be avoided if this is an issue for anyone). To install:
`sudo apt-get install apcalc`.

## Usage

1. Edit the variables at the top of run.sh

   Example:
   ```bash
   # change these variables to fit your system
   DP2="`echo ~/daisy-pipeline/cli/dp2`" # path to dp2 command line interface
   TARGET="/media/500GB/tmp/nordic-epub3-dtbook-migrator" # use this directory to store results
   SOURCE="/media/500GB/DTBook" # read *.xml files in this directory and its subdirectories
   ```
   
   In this example, I have unzipped the DAISY Pipeline 2 distributable to `~/daisy-pipeline`.
   I want the results of the batch conversion (EPUBs, logs and a summary report) to be stored in `/media/500GB/tmp/nordic-epub3-dtbook-migrator`.
   The DTBooks I want to convert are stored in `/media/500GB/DTBook`.

2. Run the batch script. Note that the process of converting 3945 DTBooks at NLB takes approximately 20 hours,
   so if you're connecting over ssh and want to perform big conversions, you'll probably want to start it through `screen` or something.

