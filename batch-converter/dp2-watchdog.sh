#!/bin/bash -x

DP2_CLI="/home/server/daisy-pipeline/cli/dp2"

# In case DP2 gets stuck (whoops!)...

if [ "`ps aux | grep pipeline2 | grep -v grep`" = "" ]; then
    echo "DP2 not running; nothing to kill..."
else
    if [ "`$DP2_CLI 2>&1 | grep \"[ERROR]  WS Internal Failure:\" | wc -l`" ]; then
        echo "DP2 is stuck, killing..."
        killall pipeline2
    else
        echo "DP2 is running fine; won't kill..."
    fi
fi
    
