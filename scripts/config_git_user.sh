#!/usr/bin/env bash
#
# I use a lot of different personas when working, this helps keep my commits to different repos straight
#
set -euf -o pipefail
MSG="fncz-gitlab or github or fnni-gitlab or gen6-gitlab"
if [[ $# -lt 1 ]]; then
    echo "Usage: $0 $MSG"
    exit 1
else
    case $1 in 
    fncz-gitlab)
        git config user.name "James Phillips" && \
        git config user.email "jamesrphillips_jr@yahoo.com"
        ;;
    github)
        git config user.name "James Phillips" && \
        git config user.email "phillips.james@gmail.com"
        ;;
    fnni-gitlab)
        git config user.name "James Phillips" && \
        git config user.email "jphillips@fnni.com"
        ;;
    gen6-gitlab)
        git config user.name "James Phillips" && \
        git config user.email "james@gen6ventures.com"
        ;;
    *)
        echo " your options are: $MSG"
    esac
fi