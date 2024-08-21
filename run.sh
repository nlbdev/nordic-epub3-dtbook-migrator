#!/bin/bash
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "${DIR}"

if [[ "${TEMPFILE}" = "" ]]; then
    TEMPFILE="$(mktemp)"
fi
echo "Building Docker image"
docker build --iidfile="${TEMPFILE}" --progress=plain .
BUILD_ID="$(cat "${TEMPFILE}")"
if [[ "${BUILD_ID}" = "" ]]; then
    echo "Build failed"
    exit 1
fi
echo "BUILD_ID: ${BUILD_ID}"
RM="--rm"
IT="-it"

set -x
docker run "${RM}" "${IT}" --network host "${BUILD_ID}" "$@"
