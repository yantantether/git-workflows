#!/bin/bash

rm -rf flow && mkdir flow

function graph {
  git checkout master
  echo
  git --no-pager log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all 
  echo
}

function commit {
  git add . && git commit -m "$1"
}

function merge {
  git checkout $1

  git rebase master
  git checkout master  

# force fast forward
#  git merge --ff-only $1

# force merge commit
  git merge --no-ff --log --no-edit $1

# fast forward or merge commit
#  git merge --log $1
}


cd flow

git init
touch README
commit "initial commit"
graph

git checkout -b f1
touch f1
commit "feature 1 work"
graph

git checkout master
git checkout -b f2
touch f2
commit "feature 2 work"
graph

merge f1
graph

merge f2
graph


echo
cd ..
echo finished
