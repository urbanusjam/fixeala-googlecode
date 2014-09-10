#!/bin/bash

## Fixeala

echo "### FIXEALA BUILD ###"
echo "" 
echo "init package war..."

cd
cd Documents/dev/workspaces/fixeala-jpa/fixeala-project-parentpom/fixeala-project
mvn clean package -Dmaven.test.skip=true

echo "copy war file to git folder..."

cd target
cp ROOT.war /Users/cora/fixeala-git

echo "deploy war to openshift..."

cd
cd fixeala-git
git add webapps/ROOT.war
git commit -am "con MySQLDS maven"
git push


echo "Build finished."