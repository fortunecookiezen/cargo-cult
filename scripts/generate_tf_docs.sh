#!/bin/bash
#
# uses terraform-docs to generate documentation from terraform code
set -euf -o pipefail
terraform-docs markdown "${PWD}" --output-file=README.md
