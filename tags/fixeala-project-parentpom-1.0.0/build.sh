#!/bin/bash

clear

echo "Building war package..."

cd Documents/dev/workspaces/fixeala/fixeala-project-parentpom
mvn package -Dmaven.test.skip=true

echo "Packaging finished."
