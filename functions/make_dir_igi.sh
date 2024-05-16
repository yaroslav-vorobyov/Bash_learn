#!/usr/bin/env bash
# Creating a directory (mkdir is based on alias with the -pv), 
# then moving to the new directory

function mkd() {
    mkdir "$1"
    cd $_
}
