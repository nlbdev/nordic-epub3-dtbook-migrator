#!/bin/bash

BUILD=`git rev-list HEAD | wc -l`
DATE=`git log -n 1 | grep Date | sed 's/^Date: *\(.*\)$/\1/'`
mvn clean package -DbuildNr="-build-$BUILD" -Dtimestamp="$DATE"

