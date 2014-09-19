#! /bin/bash

BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd ../.. && pwd )";

cd $BASEDIR
CURRENT_BRANCH="$(git branch | sed -n '/\* /s///p')"

git pull;
git push origin $CURRENT_BRANCH;