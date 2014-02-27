# Fixeala
# Delete SVN files
echo "#######################################"
echo "    Delete SVN files from FIXEALA!     "
echo "#######################################"
echo ""
echo "Beginning svn folders removal..."

cd Documents/dev/workspaces/fixeala-git/fixeala-project-parentpom
find . -type d -name .svn -exec rm -rf {} \;

echo "Deletion finished."