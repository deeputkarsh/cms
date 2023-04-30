#!/bin/bash
destDir=$1
processName=$2
cd $destDir
npm i --no-audit
pm2 delete $processName
pm2 start --time --name=$processName npm -- start