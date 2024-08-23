#!/bin/bash
set -e

CWD="$(pwd)"
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
shift
if [[ "${SOURCE}" = "" ]]; then
    echo "Usage: $0 <source>"
    exit 1
fi
cd "${CWD}"
SOURCE="$(realpath "${SOURCE}")"
cd "${DIR}"
if [[ ! -e "${SOURCE}" ]]; then
    echo "Source not found: ${SOURCE}"
    exit 1
fi

# first argument is the source EPUB (file or directory)

# if $1 does not start with a hyphen, it is the target directory
if [[ "${1}" != -* ]]; then
    TARGET="$1"
    shift
else
    # use "target" as the output directory if not specified
    TARGET="${DIR}/target"
fi
cd "${CWD}"
TARGET="$(realpath "${TARGET}")"
cd "${DIR}"
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
