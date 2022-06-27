# Amazon MWAA environment with new VPC

This example deploys the following Amazon MWAA with VPC

- Creates a new sample VPC, 2 Private Subnets and 2 Public Subnets
- Creates Internet gateway for Public Subnets and NAT Gateway for Private Subnets
- Creates Amazon MWAA Environment with S3 bucket, Security Group and IAM Role

## How to Deploy

### Prerequisites:
Ensure that you have installed the following tools in your Mac or Windows Laptop before start working with this module and run Terraform Plan and Apply

1. [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)
2. [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)

### Deployment Steps
#### Step 1: Clone the repo using the command below

```sh
git clone https://github.com/aws-ia/terraform-aws-mwaa.git
```

#### Step 2: Run Terraform INIT
Initialize a working directory with configuration files

```sh
cd examples/basic/
terraform init
```

#### Step 3: Run Terraform PLAN
Verify the resources created by this execution

```sh
export AWS_REGION=<ENTER YOUR REGION>   # default set to `us-west-2`
terraform plan
```

#### Step 4: Finally, Terraform APPLY
Create the resources

```sh
terraform apply
```

Enter `yes` to apply.

#### Step 5: Verify the Amazon MWAA with login

NOTE: Amazon MWAA environment takes about twenty to thirty minutes to create an environment.

Output of Terraform apply should look similar

```
Changes to Outputs:
  + mwaa_arn               = "arn:aws:airflow:us-west-2:1234567897:environment/basic-mwaa"
  + mwaa_role_arn          = "arn:aws:iam::1234567897:role/mwaa-executor20220627111648219100000002"
  + mwaa_security_group_id = "sg-080b8fd440147d816"
  + mwaa_service_role_arn  = "arn:aws:iam::1234567897:role/aws-service-role/airflow.amazonaws.com/AWSServiceRoleForAmazonMWAA"
  + mwaa_status            = "AVAILABLE"
  + mwaa_webserver_url     = "b193b9bb-03d7-4086-ad83-c4e6ab5a023a.c24.us-west-2.airflow.amazonaws.com"
```

Open the output URL(`mwaa_webserver_url`) from a browser to verify the Amazon MWAA

## Cleanup
To clean up your environment, destroy the Terraform module.

```sh
terraform destroy -auto-approve
```

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
