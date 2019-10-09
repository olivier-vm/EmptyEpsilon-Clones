#!/bin/bash
# Script to build EE Garou Clone variant under Mac OS X, from local git repo
# Need to have the git repo in github subdirectory from script launching dir (pwd)

# Variables
EE_BUILD_HOME=`pwd`/build-ee
EE_BUILD_EE_PATH="${EE_BUILD_HOME}/EmptyEpsilon-Clones"
EE_BUILD_SP_PATH="${EE_BUILD_HOME}/SeriousProton"

EE_GITHUB_HOME=`pwd`/github
EE_GITHUB_EE_PATH="${EE_GITHUB_HOME}/EmptyEpsilon-Clones"
EE_GITHUB_SP_PATH="${EE_GITHUB_HOME}/SeriousProton"

# Create working directory if not existing
mkdir -p "${EE_BUILD_HOME}"

# Remove previous existing version of application
rm -rf "${EE_BUILD_EE_PATH}"
rm -rf "${EE_BUILD_SP_PATH}"

# Copy local github repo into working directory
# This is done to avoid mofifying the original github repo
cp -pr "${EE_GITHUB_EE_PATH}" "${EE_BUILD_HOME}/"
cp -pr "${EE_GITHUB_SP_PATH}" "${EE_BUILD_HOME}/"

# Move to EE directory, select variant Garou Clones, and build
cd "${EE_BUILD_EE_PATH}"
git checkout variant/garou

cd "${EE_BUILD_HOME}"
cmake "${EE_BUILD_EE_PATH}/CMakeLists.txt" -DSERIOUS_PROTON_DIR="${EE_BUILD_SP_PATH}/" -DCPACK_PACKAGE_VERSION_MAJOR="201910"
cd "${EE_BUILD_EE_PATH}"
make -j > "${EE_BUILD_HOME}/compile.log"
make -j install >> "${EE_BUILD_HOME}/compile.log"

# Start the game
"${EE_BUILD_EE_PATH}/EmptyEpsilon.app/Contents/MacOS/EmptyEpsilon"
