#!/bin/bash
set -e
sourceDir=/tmp/cms
serverUser='ec2-user'
baseDir="/home/${serverUser}/apps"
dirName=cms
processName='cms'

destDir=${baseDir}/${dirName}
currDir=$destDir
currProcess=$processName
mkdir -p ${currDir}/node_modules
cacheDir=/tmp/build-cache/${dirName}
mkdir -p $cacheDir
mv ${currDir}/node_modules ${cacheDir}/
rm -rf $currDir
cp -r $sourceDir $currDir
mv ${cacheDir}/node_modules ${currDir}/
rm -rf ${cacheDir}
chown -R ${serverUser}:${serverUser} $currDir
startScript=${currDir}/scripts/start.sh
chown -R ${serverUser}:${serverUser} $startScript && chmod a+x $startScript
su - ${serverUser} -c "$startScript $currDir $currProcess"

