#!/usr/bin/env bash
#
# get signatures and stuff from a pem-encoded certificate
# https://www.ibm.com/support/pages/openssl-commands-check-and-verify-your-ssl-certificate-key-and-csr
# 
set -euf -o pipefail
CERTFILE=$1
`which openssl` x509 -in $CERTFILE -text -noout