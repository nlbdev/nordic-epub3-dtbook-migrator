#!/bin/bash -x


# TIP: set up a cron job to run this script once each minute

# change these variables to fit your system
export DP2="`echo ~/daisy-pipeline`" # path to DAISY Pipeline 2 directory
export TARGET="/media/500GB/tmp/nordic-epub3-dtbook-migrator" # results can be big; use this directory to store results
export SOURCE="/media/500GB/DTBook" # read *.xml files in this directory and its subdirectories
IP="128.39.251.143"

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SCRIPT_FILENAME="`basename $0`"
FAILED_BOOKS="$TARGET/failed-books.csv"
STATUS_SUMMARY="$TARGET/status-summary.csv"

for pid in $(pidof -x $SCRIPT_FILENAME); do
    if [ $pid != $$ ]; then
        echo "[$(date)] : $SCRIPT_FILENAME : Process is already running with PID $pid"
        exit 1
    fi
done

mkdir -p "$DIR/results/commits/"

# set up logging
DATEUID="`date --rfc-3339=seconds --utc | sed 's/\+.*//' | sed 's/[^0-9]//g'`"
LOGFILE="$TARGET/$DATEUID.log"
exec > >(tee "$LOGFILE")
exec 2>&1

echo "See full log file at http://$IP/nordic-epub3-dtbook-migrator/$DATEUID.log" > "$DIR/results/email.txt"

if [ ! -d "$DIR/results/nordic-epub3-dtbook-migrator" ]; then
    git clone https://github.com/nlbdev/nordic-epub3-dtbook-migrator.git results/nordic-epub3-dtbook-migrator
fi

MIGRATOR_DIR="`cd $DIR/results/nordic-epub3-dtbook-migrator && pwd`"


function assertSuccess(){
    if [ $? -ne 0 ]; then echo "$SCRIPT_FILENAME failed" && exit 1; fi
}

function build(){
    cd "$1"; assertSuccess
    git stash
    if [ `git status | grep detached | wc -l` = 0 ]; then
        git pull
    fi
    git checkout $2; assertSuccess
    if [ `git status | grep detached | wc -l` = 0 ]; then
        git pull; assertSuccess
    fi
    mvn clean package
}

function email(){
    # email(subject, path)
    SUBJECT_ALLOWED_CHARACTERS="`echo \"$1\" | sed 's/[^a-zA-Z0-9\(\)]/ /g' | sed 's/^\s*//g' | sed 's/\s*$//g'`"
    echo "cat \"$2\" | mailx -v -A nlb -s \"$SUBJECT_ALLOWED_CHARACTERS\" jostein@nlb.no"
    cat "$2" | mailx -v -A nlb -s "$SUBJECT_ALLOWED_CHARACTERS" jostein@nlb.no
}

cd "$MIGRATOR_DIR" && git add -A && git pull
cd "$DIR"

git log --oneline --branches > "$DIR/results/git.log"
tac "$DIR/results/git.log" | while read LINE;
do
    COMMIT=`echo $LINE | sed 's/^\([^ ]*\) .*$/\1/'`
    COMMENT=`echo $LINE | sed 's/^[^ ]* \(.*\)$/\1/'`
    
    if [ -d "$DIR/results/commits/$COMMIT" ]; then
        continue
    fi
    
    echo "Building $COMMIT: $COMMENT"
    
    mkdir -p "$DIR/results/commits/$COMMIT/"
    build "$MIGRATOR_DIR" "$COMMIT"
    rm -r "$DP2/modules/nordic-epub3-dtbook-migrator*"
    find "$DIR/results/nordic-epub3-dtbook-migrator" | grep jar$ | xargs cp -t "$DIR/results/commits/$COMMIT/"
    find "$DIR/results/nordic-epub3-dtbook-migrator" | grep jar$ | xargs cp -t "$DP2/modules/"
    IS_MASTER="`cd $MIGRATOR_DIR && git log --oneline --first-parent master | grep \"$COMMIT\" | wc -l`"
    
    cd $DIR
    if [ "$IS_MASTER" = "1" ]; then
        echo "is on master branch"
        export HTML_REPORT="$TARGET/report-$COMMIT.html"
        bash run.sh
        echo "" >> "$DIR/results/email.txt"
        echo "Success: `cat $STATUS_SUMMARY | grep DONE | wc -l`" >> "$DIR/results/email.txt"
        echo "Failed validations: `cat $STATUS_SUMMARY | grep VALIDATION_FAIL | wc -l`" >> "$DIR/results/email.txt"
        echo "Failed conversions: `cat $STATUS_SUMMARY | grep FAILED | wc -l`" >> "$DIR/results/email.txt"
        echo "Skipped: `cat $STATUS_SUMMARY | grep SKIPPED | wc -l`" >> "$DIR/results/email.txt"
        echo "" >> "$DIR/results/email.txt"
        echo "Detailed report: http://$IP/nordic-epub3-dtbook-migrator/report-$COMMIT.html" >> "$DIR/results/email.txt"
        email "Nordic EPUB3/DTBook Migrator master branch -- $COMMENT" "$DIR/results/email.txt"
        
    else
        echo "is not on master branch; will only convert the first book that previously failed"
        export BOOK_ID="`cat $STATUS_SUMMARY | grep FAIL | head -n 1 | sed 's/\".*\",\"\(.*\)\",\".*\"/\1/'`"
        export BOOK_PATH="`cat $STATUS_SUMMARY | grep FAIL | head -n 1 | sed 's/\".*\",\".*\",\"\(.*\)\"/\1/'`"
        echo "BOOK_ID: $BOOK_ID"
        echo "BOOK_PATH: $BOOK_PATH"
        export HTML_REPORT="$TARGET/report-$COMMIT.html"
        bash run.sh
        echo "" >> "$DIR/results/email.txt"
        echo "Success: `cat $STATUS_SUMMARY | grep DONE | wc -l`" >> "$DIR/results/email.txt"
        echo "Failed validations: `cat $STATUS_SUMMARY | grep VALIDATION_FAIL | wc -l`" >> "$DIR/results/email.txt"
        echo "Failed conversions: `cat $STATUS_SUMMARY | grep FAILED | wc -l`" >> "$DIR/results/email.txt"
        echo "Skipped: `cat $STATUS_SUMMARY | grep SKIPPED | wc -l`" >> "$DIR/results/email.txt"
        echo "" >> "$DIR/results/email.txt"
        echo "Detailed report: http://$IP/nordic-epub3-dtbook-migrator/report-$COMMIT.html" >> "$DIR/results/email.txt"
        email "Nordic EPUB3/DTBook Migrator feature branch -- $COMMENT" "$DIR/results/email.txt"
    fi
    
    exit
done

    
