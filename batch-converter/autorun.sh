#!/bin/bash

# TIP: set up a cron job to run this script once each minute

# change these variables to fit your system
export DP2="`echo ~/daisy-pipeline`" # path to DAISY Pipeline 2 directory
export TARGET="/media/500GB/tmp/nordic-epub3-dtbook-migrator" # results can be big; use this directory to store results
export SOURCE="/media/500GB/DTBook" # read *.xml files in this directory and its subdirectories

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SCRIPT_FILENAME="`basename $0`"

mkdir -p "$DIR/results/commits/"
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


if [ "`ps aux | grep -v grep | grep \"$SCRIPT_FILENAME\" | wc -l`" -gt "2" ]; then
    echo "already running; exiting..."
    exit
fi

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
    find "$DIR/results/nordic-epub3-dtbook-migrator" | grep nordic-epub3-dtbook-migrator-$VERSION-SNAPSHOT.jar | xargs cp -t "$DIR/results/commits/$COMMIT/"
    rm -r "$DP2/modules/nordic-epub3-dtbook-migrator*"
    cp "$DIR/commits/$COMMIT/*.jar" "$DP2/modules/"
    IS_MASTER="`cd $MIGRATOR_DIR && git log --oneline --first-parent master | grep \"$COMMIT\" | wc -l`"
    
    if [ $IS_MASTER ]; then
        echo "is on master branch"
        # execute run.sh
        # send summary and link to report as e-mail
        # make list of books that fail
        
    else
        echo "is not on master branch"
        # pick last failed book (or first available if none is found)
        # perform a conversion on it including a report similar to run.sh
        # send summary and link to report as e-mail
    fi
    
    exit
done

    