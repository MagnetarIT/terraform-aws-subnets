<a href=https://magnetarconsulting.co.uk><img src="https://magnetarconsulting.co.uk/wp-content/uploads/2020/04/small-helping-you-innovate-magnetar.png" width="300"></a>


# terraform-aws-subnets
Terraform (>= 0.12.0) module to create private & public subnets dynamically 

[![Build Status](https://dev.azure.com/MagnetarIT/terraform-aws-subnets/_apis/build/status/MagnetarIT.terraform-aws-subnets?branchName=master)](https://dev.azure.com/MagnetarIT/terraform-aws-subnets/_build/latest?definitionId=14&branchName=master) ![Latest Release](https://img.shields.io/github/release/MagnetarIT/terraform-aws-subnets.svg)


- [Intro](#Intro)
- [Example](#Example)
- [Inputs](#Inputs)
- [Outputs](#Outputs)
- [Support](#Support)
- [License](#License)

----

## Example
```hcl

provider "aws" {
  region = "eu-west-2"
}

module "vpc" {
  source                      = "git::https://github.com/MagnetarIT/terraform-aws-vpc.git?ref=tags/0.1.0"
  cidr_block                  = "10.255.0.0/16"
  namespace                   = "mag"
  environment                 = "dev"
  name                        = "vpc"
  create_aws_internet_gateway = true
}

module "subnets" {
  source             = "git::https://github.com/MagnetarIT/terraform-aws-subnets.git?ref=tags/0.1.0"
  namespace          = "mag"
  environment        = "dev"
  name               = "app"
  vpc_id             = module.vpc.vpc_id
  igw_id             = module.vpc.igw_id
  cidr_block         = "10.255.0.0/22"
  max_subnet_count   = 3
  availability_zones = list("eu-west-2a","eu-west-2b","eu-west-2c",)
}

```

----

## Intro
This module will create the following resources
- Public Subnets
- Private Subnets

---

## Providers

| Name | Version |
|------|---------|
| aws | ~> 2.0 |

---

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| attributes | Additional attributes (e.g. `1`) | `list(string)` | `[]` | no |
| availability\_zones | List of Availability Zones where subnets will be created | `list(string)` | `[]` | no |
| cidr\_block | Base CIDR block which will be divided into subnet CIDR blocks (e.g. `10.0.0.0/16`) | `string` | n/a | yes |
| environment | The environment name if not using stage | `string` | `""` | no |
| igw\_id | Internet Gateway ID the public route table will point to (e.g. `igw-9c26a123`) | `string` | n/a | yes |
| map\_public\_ip\_on\_launch | Instances launched into a public subnet should be assigned a public IP address | `bool` | `true` | no |
| max\_subnet\_count | Sets the maximum amount of subnets to deploy. 0 will deploy a subnet for every provided availablility zone (in `availability_zones` variable) within the region | `number` | `0` | no |
| name | Solution name, e.g. 'app' or 'cluster' | `string` | `""` | no |
| namespace | Namespace, which could be your organization name or abbreviation, e.g. 'eg' or 'cp' | `string` | `""` | no |
| private\_network\_acl\_id | Network ACL ID that will be added to private subnets. If empty, a new ACL will be created | `string` | `""` | no |
| private\_subnets\_additional\_tags | Additional tags to be added to private subnets | `map(string)` | `{}` | no |
| public\_network\_acl\_id | Network ACL ID that will be added to public subnets. If empty, a new ACL will be created | `string` | `""` | no |
| public\_subnets\_additional\_tags | Additional tags to be added to public subnets | `map(string)` | `{}` | no |
| subnet\_type\_tag\_key | Key for subnet type tag to provide information about the type of subnets, e.g. `subnet_type=private` or `subnet_type=public` | `string` | `"subnet_type"` | no |
| subnet\_type\_tag\_value\_format | This is using the format interpolation symbols to allow the value of the subnet\_type\_tag\_key to be modified. | `string` | `"%s"` | no |
| tags | Additional tags to apply to all resources that use this label module | `map(string)` | `{}` | no |
| vpc\_default\_route\_table\_id | Default route table for public subnets. If not set, will be created. (e.g. `rtb-f4f0ce12`) | `string` | `""` | no |
| vpc\_id | VPC ID where subnets will be created (e.g. `vpc-aceb2723`) | `string` | n/a | yes |

---

## Outputs

| Name | Description |
|------|-------------|
| availability\_zones | List of Availability Zones where subnets were created |
| private\_route\_table\_ids | IDs of the created private route tables |
| private\_subnet\_cidrs | CIDR blocks of the created private subnets |
| private\_subnet\_ids | IDs of the created private subnets |
| public\_route\_table\_ids | IDs of the created public route tables |
| public\_subnet\_cidrs | CIDR blocks of the created public subnets |
| public\_subnet\_ids | IDs of the created public subnets |

---

## Support

Reach out to me at one of the following places!

- Website at <a href="https://magnetarconsulting.co.uk" target="_blank">`magnetarconsulting.co.uk`</a>
- Twitter at <a href="https://twitter.com/magnetarIT" target="_blank">`@magnetarIT`</a>
- LinkedIn at <a href="https://www.linkedin.com/company/magnetar-it-consulting" target="_blank">`magnetar-it-consulting`</a>

---

## License 

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0) 

See [LICENSE](LICENSE) for full details.

    Licensed to the Apache Software Foundation (ASF) under one
    or more contributor license agreements.  See the NOTICE file
    distributed with this work for additional information
    regarding copyright ownership.  The ASF licenses this file
    to you under the Apache License, Version 2.0 (the
    "License"); you may not use this file except in compliance
    with the License.  You may obtain a copy of the License at

      https://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing,
    software distributed under the License is distributed on an
    "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
    KIND, either express or implied.  See the License for the
    specific language governing permissions and limitations
    under the License.
