#!/bin/bash
# Script to build (under Debian) EE Garou Clone variant for Microsoft Windows

# Install needed packages if not installed
sudo apt install mingw-w64 cmake git build-essential ninja-build zip

# Variables
EE_BUILD_HOME=`pwd`
EE_BUILD_EE_PATH="${EE_BUILD_HOME}/EmptyEpsilon-Clones"
EE_BUILD_SP_PATH="${EE_BUILD_HOME}/SeriousProton"
EE_BUILD_CMAKE="${EE_BUILD_EE_PATH}/cmake"

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

# SeriousProton: check older compatible release

cd "${EE_BUILD_SP_PATH}"
git checkout EE-2019.09.09

# Build EmptyEpsilon.

cd "${EE_BUILD_EE_PATH}"
## checkout to Garou Clone variant
git checkout variant/garou

## Build EmptyEpsilon for Windows.
echo "Building EmptyEpsilon for Windows..."
cd "${EE_BUILD_EE_PATH}"

if [ ! -d _build_win32 ]; then
	mkdir _build_win32
fi
cd _build_win32

#cmake .. -G Ninja -DCMAKE_MAKE_PROGRAM=ninja -DCMAKE_TOOLCHAIN_FILE="${EE_BUILD_CMAKE}/mingw.toolchain" -DSERIOUS_PROTON_DIR="${EE_BUILD_SP_PATH}/"
#ninja -j 9 package

cmake .. -DCMAKE_MAKE_PROGRAM=make -DCMAKE_TOOLCHAIN_FILE="${EE_BUILD_CMAKE}/mingw.toolchain" -DSERIOUS_PROTON_DIR="${EE_BUILD_SP_PATH}/"
make -j 9 package