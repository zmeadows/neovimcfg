#!/bin/sh

set -e

OLDDIR=$(pwd)
cd $NEOVIM_CFG_REPO

# create a lock file, to prevent git errors when attempting to run
# this script from many terminals at once (ex: open 10 terminals at same time)
LOCK="/tmp/zmeadows_neovimcfg_update_lock"
exec 200>$LOCK
flock -n 200 || exit 1

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
