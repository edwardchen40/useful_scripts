/*
* 1. You have to add remote repo -> "git remote add upstream https://github.com/iCHEF/Autotest.git"
* 2. Fetch -> rebase -> push to your gitbub
*/

// file path
ICHEF_AUTO_REPO="/Users/edwardchen/git/Autotest"


cd "${ICHEF_AUTO_REPO}"
git fetch upstream&&git checkout master&&git rebase upstream/master&&git push -f origin master
