#!/bin/bash

clear

# deploy script for OpenShift

echo “Packaging war... ”

cd Documents/dev/workspaces/fixeala-jpa/fixeala-project-parentpom/fixeala-project
mvn clean package -Dmaven.test.skip=true

echo “Copying to local repo... ”

cd target
sudo cp -f ROOT.war /Users/cora/fixeala-git/webapps

echo “Uploading to remote repo...”

cd /Users/cora/fixeala-git/webapps
git add ROOT.war
git commit -am "se sube versión de prueba"
git push

echo “Final commit...”

#chmod u+x fixeala-deploy.sh
#sh fixeala-deploy.sh