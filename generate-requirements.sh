#!/bin/bash

# shellcheck disable=SC2312

# check if virtualenv is installed
if [[ "$(command -v virtualenv)" == "" ]]; then
	echo "virtualenv not installed."
	echo "Install with:"
	echo "  sudo apt install python3-virtualenv"
	exit 1
fi

# check if python version $DOCKERFILE_PYTHON_VERSION is installed locally
DOCKERFILE_PYTHON_VERSION=$(grep "FROM python:" Dockerfile | sed 's/^.*\?\(3\.[0-9]\+\)\($\|[^0-9].*\)/\1/')
if [[ "$(command -v "python${DOCKERFILE_PYTHON_VERSION}")" == "" ]]; then
	echo "Python ${DOCKERFILE_PYTHON_VERSION} not installed. Please install Python ${DOCKERFILE_PYTHON_VERSION} before continuing. Suggestion:"
	echo "sudo apt install software-properties-common -y"
	echo 'echo "deb [trusted=yes] https://ppa.launchpadcontent.net/deadsnakes/ppa/ubuntu jammy main" | sudo tee /etc/apt/sources.list.d/deadsnakes.list'
	echo 'echo "deb-src [trusted=yes] https://ppa.launchpadcontent.net/deadsnakes/ppa/ubuntu jammy main" | sudo tee -a /etc/apt/sources.list.d/deadsnakes.list'
	echo "sudo apt update"
	echo "sudo apt install python${DOCKERFILE_PYTHON_VERSION} python${DOCKERFILE_PYTHON_VERSION}-distutils"
	exit 1
fi

# create virtualenv if it doesn't exist
if [[ ! -d ".venv" ]]; then
	echo "Creating virtualenv with python${DOCKERFILE_PYTHON_VERSION}"
	virtualenv --python="$(command -v "python${DOCKERFILE_PYTHON_VERSION}")" .venv
fi

# check that python version in .venv/pyvenv.cfg is the same as in the Dockerfile
VENV_PYTHON_VERSION=$(grep "^version_info" .venv/pyvenv.cfg | sed 's/^.*\?\(3\.[0-9]\+\)\($\|[^0-9].*\)/\1/')
if [[ ${DOCKERFILE_PYTHON_VERSION} != "${VENV_PYTHON_VERSION}" ]]; then
	echo "Python version mismatch between Dockerfile and .venv/pyvenv.cfg"
	echo "Dockerfile: ${DOCKERFILE_PYTHON_VERSION}"
	echo ".venv/pyvenv.cfg: ${VENV_PYTHON_VERSION}"
	exit 1
fi

# check that python version in Dockerfile is the same as in .python-version
if [[ ! -f ".python-version" ]]; then
	echo ".python-version not found, creating it with '${DOCKERFILE_PYTHON_VERSION}'"
	echo "${DOCKERFILE_PYTHON_VERSION}" >.python-version
fi
PYTHON_VERSION_FILE=$(cat .python-version)
if [[ ${DOCKERFILE_PYTHON_VERSION} != "${PYTHON_VERSION_FILE}" ]]; then
	echo "Python version mismatch between Dockerfile and .python-version"
	echo "Dockerfile: ${PYTHON_VERSION}"
	echo ".python-version: ${PYTHON_VERSION_FILE}"
	exit 1
fi

# instructions for updating requirements.txt
echo "First, load the correct python environment:"
echo "source .venv/bin/activate"
echo
echo "If you haven't already, install pipreqs and pip-tools."
echo "You'll have to reload your environment after installing."
echo "pip install pipreqs pip-tools"
echo "source .venv/bin/activate"
echo
echo "Then, modify requirements.in manually."
echo "You can also recreate it automatically, but you should"
echo "then manually inspect it afterwards:"
echo "pipreqs src --force --print | sed 's/=.*//' | sort | uniq > requirements.in"
echo
echo "Finally, compile a new requirements.txt:"
echo "pip-compile requirements.in > requirements.txt"
