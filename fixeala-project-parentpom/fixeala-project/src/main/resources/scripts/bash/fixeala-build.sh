# Fixeala
# Package build
echo "#######################################"
echo "    FIXEALA Project by UrbanusJam!     "
echo "#######################################"
echo ""
echo "Building war package..."

cd Documents/dev/workspaces/fixeala/fixeala-project-parentpom
mvn package -Dmaven.test.skip=true

echo "Packaging finished."
