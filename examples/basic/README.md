<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.20.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_mwaa"></a> [mwaa](#module\_mwaa) | ../.. | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | Name of MWAA Environment | `string` | `"basic-mwaa"` | no |
| <a name="input_private_subnet_ids"></a> [private\_subnet\_ids](#input\_private\_subnet\_ids) | Private subnet CIDRs for MWAA environment | `list(string)` | <pre>[<br>  "subnet-014a974fbd4d17b5f",<br>  "subnet-0df42f1af3be0dc32"<br>]</pre> | no |
| <a name="input_region"></a> [region](#input\_region) | region | `string` | `"us-west-2"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Default tags | `map(string)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC Id for MWAA Security groups | `string` | `"vpc-0a8bc75bb6754df82"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_mwaa_arn"></a> [mwaa\_arn](#output\_mwaa\_arn) | The ARN of the MWAA Environment |
| <a name="output_mwaa_role_arn"></a> [mwaa\_role\_arn](#output\_mwaa\_role\_arn) | The ARN of the MWAA Environment |
| <a name="output_mwaa_security_group_id"></a> [mwaa\_security\_group\_id](#output\_mwaa\_security\_group\_id) | The ARN of the MWAA Environment |
| <a name="output_mwaa_service_role_arn"></a> [mwaa\_service\_role\_arn](#output\_mwaa\_service\_role\_arn) | The Service Role ARN of the Amazon MWAA Environment |
| <a name="output_mwaa_status"></a> [mwaa\_status](#output\_mwaa\_status) | The status of the Amazon MWAA Environment |
| <a name="output_mwaa_webserver_url"></a> [mwaa\_webserver\_url](#output\_mwaa\_webserver\_url) | The webserver URL of the MWAA Environment |
<!-- END_TF_DOCS -->