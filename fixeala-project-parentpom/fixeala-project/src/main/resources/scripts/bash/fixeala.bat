@echo ""
@echo "======== FIXEALA BUILD ========"
@echo "==============================="
@echo "packaging war..."


cd c:/

cd desarrollo/workspaces/fixeala-svn/fixeala-project-parentpom/fixeala-project

mvn package -Dmaven.test.skip=true

@echo "packaging finished."

pause >nul