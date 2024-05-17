#!/usr/bin/env bash
# Creating a directory (mkdir is based on alias with the -pv), 
# then moving to the new directory
# 
# add to ~/.bash_aliases:
# echo 'source ~/.scripts/functions/make_dir_igi.sh' >> ~/.bash_aliases

function mkd() {
    mkdir "$1"
    cd $_
}
