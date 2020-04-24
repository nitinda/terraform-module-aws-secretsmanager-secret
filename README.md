# _Terraform Module: terraform-module-aws-secretsmanager-secret_
_Terraform Module for_ **_AWS Secretsmanager_**


<!--BEGIN STABILITY BANNER-->
---

![_Code : Stable_](https://img.shields.io/badge/Code-Stable-brightgreen?style=for-the-badge&logo=github)

> **_This is a stable example. It should successfully build out of the box_**
>
> _This examples does is built on Construct Libraries marked "Stable" and does not have any infrastructure prerequisites to build._

---
<!--END STABILITY BANNER-->


## _General_

_This module may be used to create_ **_Secretsmanager Secret_** _resources in AWS cloud provider......_

---


## _Prerequisites_

_This module needs_ **_Terraform 0.12.24_** _or newer._
_You can download the latest Terraform version from_ [here](https://www.terraform.io/downloads.html).

_This module deploys aws services details are in respective feature branches._


---



## _Features_

_Below we are able to check the resources that are being created as part of this module call:_

* **_Secretsmanager Secret_**



---

## _Usage_

## _Using this repo_

_To use this module, add the following call to your code:_

```tf
module "secretsmanager_secret" {
  source = "git::https://github.com/nitinda/terraform-module-aws-secretsmanager-secret.git?ref=master"

  providers = {
    aws = aws.services
  }

  name                = "rotation-example"
  rotation_lambda_arn = "${aws_lambda_function.example.arn}"

  rotation_rules = {
    automatically_after_days = 7
  }
}
```

```tf
module "launch_template" {
  source = "git::https://github.com/nitinda/terraform-module-aws-launch-template.git?ref=master"

  providers = {
    aws = aws.services
  }

  name_prefix            = "lt-"
  description            = "RabbitMQ EC2 Launch Template"
  ebs_optimized          = true
  image_id               = data.aws_ami.ami_ubuntu.id
  vpc_security_group_ids = [ module.security_group_ec2.id ]
  user_data              = base64encode("${data.template_file.template_data.rendered}")
  iam_instance_profile   = [
      {
          name = module.iam_instance_profile_ec2.name
      }
  ]
  block_device_mappings = [
      {
          device_name = "/dev/sda1"
          ebs = {
            volume_size = 20
          }
      },
      {
          device_name = "/dev/sdf"
          ebs = {
            volume_size = 20
          }
      }
  ]

  tag_specifications    = [
    {
      resource_type = "instance"
      tags          = merge(var.common_tags, map("Name", "ec2-instance",))
    },
    {
      resource_type = "volume"
      tags          = merge(var.common_tags, map("Name", "ec2-instance-volume",))
    }
  ]
  tags = merge(
    var.common_tags,
    {
      Environment = "prod"
      Name        = "iam-role-ec2"
    }
  )
}
```

---

## _Inputs_

_The variables required in order for the module to be successfully called from the deployment repository are the following:_


|**_Variable_** | **_Description_** | **_Type_** | **_Argument Status_** | **_Default Value_** |
|:----|:----|-----:|:---:|:---:|
| **_name_** | _Specifies the friendly name of the new secret_ | _string_ | **_Optional_** | **_null_** |
| **_name\_prefix_** | _Creates a unique name beginning with the specified prefix_ | _string_ | **_Optional_** | **_null_** |
| **_description_** | _A description of the secret_ | _string_ | **_Optional_** | **_null_** |
| **_kms\_key\_id_** | _Specifies the ARN or alias of the AWS KMS customer master key (CMK) to be used to encrypt the secret values in the versions stored in this secret_ | _string_ | **_Optional_** | **_null_** |
| **_policy_** | _A valid JSON document representing a resource policy_ | _string_ | **_Optional_** | **_null_** |
| **_recovery\_window\_in\_days_** | _Specifies the number of days that AWS Secrets Manager waits before it can delete the secret. This value can be 0 to force deletion without recovery or range from 7 to 30 days. The default value is 30._ | _number_ | **_Optional_** | **_30_** |
| **_rotation\_lambda\_arn_** | _Specifies the ARN of the Lambda function that can rotate the secret._ | _string_ | **_Optional_** | **_null_** |
| **_rotation\_rules_** | _A structure that defines the rotation configuration for this secret_ | _map(string)_ | **_Optional_** | **_{}_** |
| **_tags_** | _Specifies a key-value map of user-defined tags that are attached to the secret_ | _map(string)_ | **_Optional_** | **_{}_** |


---

## _Outputs_

### _General_

_This module has the following outputs:_

* **_rotation\_enabled_**
* **_id_**
* **_arn_**

---


### _Usage_

_In order for the variables to be accessed on module level please use the syntax below:_

```tf
module.<module_name>.<output_variable_name>
```

_The output variable is able to be accessed through terraform state file using the syntax below:_

```tf
data.terraform_remote_state.<module_name>.<output_variable_name>
```

---

## _Authors_

_Module maintained by Module maintained by the -_ **_Nitin Das_**