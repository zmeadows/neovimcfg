#!/bin/sh

OLDDIR=$(pwd)
cd $NEOVIM_CFG_REPO

if [[ $(git status -s) ]]; then
    echo "You have un-commited changes to neovim cfg, fix it!"
    echo "You have un-commited changes to neovim cfg, fix it!"
    echo "You have un-commited changes to neovim cfg, fix it!"
else
    git remote update
    echo "Updating neovim cfg repo..."
    git pull
    echo "Finished."
fi

cd $OLDDIR
