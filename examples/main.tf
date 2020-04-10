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
  source             = "../"
  namespace          = "mag"
  environment        = "dev"
  name               = "app"
  vpc_id             = module.vpc.vpc_id
  igw_id             = module.vpc.igw_id
  cidr_block         = "10.255.0.0/22"
  max_subnet_count   = 3
  availability_zones = list("eu-west-2a", "eu-west-2b", "eu-west-2c", )
}


