#!/usr/bin/env zsh
set -euf -o pipefail
# https://www.businessinsider.com/how-to-see-wifi-password-on-mac
security find-generic-password -ga $1 | grep "password:"