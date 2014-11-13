#!/bin/bash

clear

# deploy script for OpenShift

# 1-package war

echo “====== empaquetando proyecto ======”

cd Documents/dev/workspaces/fixeala-jpa/fixeala-project-parentpom/fixeala-project
mvn clean package -Dmaven.test.skip=true

# 2-copy war to git repo

echo “====== copiando war al repositorio local ======”

cd target
sudo cp -f ROOT.war /Users/cora/fixeala-git/webapps

# 3-commit

echo “====== subiendo al repositorio ======”

cd /Users/cora/fixeala-git/webapps
git add ROOT.war
git commit -am "se sube versión de prueba"
git push

echo “fin commit”

#chmod u+x fixeala-deploy.sh
#sh fixeala-deploy.sh