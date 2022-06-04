# cloud-config only works on instance creation. You get one shot.
# pass as user-data to instance resource
locals {
  cloud_init_config = <<-EOF
    #cloud-config
    ${yamlencode({
  write_files = [
    {
      path        = "/var/path/to/file"
      permissions = "0644"
      owner       = "root:root"
      encoding    = "b64"
      content     = filebase64("${path.module}/files/file")
    },
  ]
})}
    EOF
}

data "cloudinit_config" "cloud_init" {
  gzip          = false
  base64_encode = false

  part {
    content_type = "text/cloud-config"
    filename     = "mobilevpnnp.fnbo.com.pfx"
    content      = local.cloud_init_config
  }
}

output "user_data" {
  # single part cloud_config file
  # value = local.cloud_init_config
  # multi-part cloud_config file
  value = data.cloudinit_config.cloud_init.rendered
}
