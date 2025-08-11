# 2. keep scripts that delete things away from other scripts

Date: 2025-08-11

## Status

Accepted

## Context

When all scripts in a repo are in the same directory structure, tab autocompletion could result in accidentally executing a deletion script with disasterous results.

## Decision

Keep very dangerous script, eg. scripts that delete the entire contents of every S3 bucket in an AWS account, far away from scripts that are more commonly executed. This enforces intent on the part of the user executing the script by choosing a directory path away from scripts more commonly executed.

## Consequences

It should become more difficult to have a negligent execution if dangerous scripts are kept out of the directory path of non-dangerous scripts.
