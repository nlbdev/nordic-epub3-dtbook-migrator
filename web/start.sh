#!/bin/bash
cd ..
docker build -t nordic-validator .
docker run -d -p 8080:80 --mount type=bind,source=/tmp,target=/tmp --env-file web/env.list --name nordic-validator nordic-validator
read -p "Press any key to quit ..."
docker container rm --force nordic-validator
