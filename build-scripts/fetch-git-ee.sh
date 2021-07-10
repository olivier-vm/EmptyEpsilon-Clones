#!/bin/bash
# Script to fetch git repo before building (getting latest build script)

# Install needed packages if not installed
sudo apt install git

# Variables
EE_BUILD_HOME=`pwd`
EE_BUILD_EE_PATH="${EE_BUILD_HOME}/EmptyEpsilon-Clones"
EE_BUILD_SP_PATH="${EE_BUILD_HOME}/SeriousProton"

# Clone repos.
echo "Cloning or updating git repos..."

## Get SeriousProton and EmptyEpsilon.
if [ ! -d "${EE_BUILD_SP_PATH}" ]; then
	echo "-   Cloning SeriousProton repo to ${EE_BUILD_SP_PATH}..."
	git clone https://github.com/daid/SeriousProton.git "${EE_BUILD_SP_PATH}"
else
	echo "-   Fetching and merging SeriousProton repo at ${EE_BUILD_SP_PATH}..."
	( cd "${EE_BUILD_SP_PATH}";
	git fetch --all && git merge --ff-only; )
fi
echo

if [ ! -d "${EE_BUILD_EE_PATH}" ]; then
	echo "-   Cloning EmptyEpsilon repo to ${EE_BUILD_EE_PATH}..."
	git clone https://github.com/olivier-vm/EmptyEpsilon-Clones.git "${EE_BUILD_EE_PATH}"
else
	echo "-   Fetching and merging EmptyEpsilon repo at ${EE_BUILD_EE_PATH}..."
	( cd "${EE_BUILD_EE_PATH}";
	git fetch --all && git merge --ff-only; )
fi
echo
