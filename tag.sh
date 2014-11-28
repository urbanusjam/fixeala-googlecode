#!/bin/bash

echo Generando tag...

mvn -X release:clean release:prepare -Dmaven.test.skip=true -DpreparationGoals=clean
