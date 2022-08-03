# Public Endpoints for Testing purposes

## SSH/SFTP

* sftp://itcsubmit.wustl.edu

## Example test script

``` bash
#!/bin/bash
set -o
sftp -o BatchMode=yes -o ConnectTimeout=5 itcsubmit.wustl.edu
```