# cloud-init knowledge bombs

- *REMEMBER THAT CLOUD-INIT ONLY RUNS ONCE ON INSTANCE CREATION*
- return ec2 instance userdata `curl http://169.254.169.254/latest/user-data`
- your userdata is written out to `/var/lib/cloud/instance/`, at least on amazon ec2
- `sudo cloud-init collect-logs` will create a tarball of your cloud-init logs in your current working directory.
- [cloud-init documentation](https://cloudinit.readthedocs.io/en/latest/)
