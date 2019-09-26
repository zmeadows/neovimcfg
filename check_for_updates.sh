#!/bin/sh

OLDDIR=$(pwd)
cd $NEOVIM_CFG_REPO
git remote update

UPSTREAM=${1:-'@{u}'}
LOCAL=$(git rev-parse @)
REMOTE=$(git rev-parse "$UPSTREAM")
BASE=$(git merge-base @ "$UPSTREAM")

if [ $LOCAL = $REMOTE ]; then
    :
elif [ $LOCAL = $BASE ]; then
    echo "Updating neovim cfg repo..."
    git pull
    echo "Finished."
elif [ $REMOTE = $BASE ]; then
    echo "Un-pushed changes to neovim cfg are present, push them!"
    echo "Un-pushed changes to neovim cfg are present, push them!"
    echo "Un-pushed changes to neovim cfg are present, push them!"
else
    echo "WARNING: neovim cfg repo diverged from master! Fix it!"
    echo "WARNING: neovim cfg repo diverged from master! Fix it!"
    echo "WARNING: neovim cfg repo diverged from master! Fix it!"
fi

cd $OLDDIR
