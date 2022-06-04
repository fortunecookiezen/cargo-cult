# Terraform

## Description

Terraform examples and common snippets

<!-- BEGIN_TF_DOCS -->


## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_cloudinit"></a> [cloudinit](#provider\_cloudinit) | n/a |

## Modules

No modules.

## Inputs

No inputs.

## Resources

| Name | Type |
|------|------|
| [aws_iam_instance_profile.ssm_instance_profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_role.ssm_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.ssm_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [cloudinit_config.cloud_init](https://registry.terraform.io/providers/hashicorp/cloudinit/latest/docs/data-sources/config) | data source |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_user_data"></a> [user\_data](#output\_user\_data) | n/a |
<!-- END_TF_DOCS -->