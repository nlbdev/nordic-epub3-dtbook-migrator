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

# first argument is the source EPUB (file or directory)
SOURCE="$1"
if [[ "${SOURCE}" = "" ]]; then
    echo "Usage: $0 <source>"
    exit 1
fi
SOURCE="$(realpath "${SOURCE}")"
shift

# use "target" as the output directory
TARGET="${DIR}/target"
if [[ ! -e "${SOURCE}" ]]; then
    echo "Source not found: ${SOURCE}"
    exit 1
fi
if [[ -d "${TARGET}" ]]; then
    echo "target directory already exists, fixing permissions before deleting it…"
    sudo chown -R jostein:jostein "${DIR}/target"
    rm "${TARGET}" -rf
fi
mkdir -p "${TARGET}"

set -x
set +e
docker run "${RM}" "${IT}" --network host \
    -v "${SOURCE}:/source:ro" \
    -v "${TARGET}:/target" \
    "${BUILD_ID}" /source /target "$@"
set -e

echo "Fixing permissions for target directory…"
sudo chown -R jostein:jostein "${TARGET}"
