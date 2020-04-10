module "naming" {
  source      = "git::https://github.com/MagnetarIT/terraform-naming-standard.git?ref=tags/0.1.0"
  namespace   = var.namespace
  environment = var.environment
  name        = var.name
  attributes  = var.attributes
  tags        = var.tags
}

data "aws_vpc" "default" {
  id = var.vpc_id
}

data "aws_availability_zones" "available" {
}

data "aws_region" "current" {
}
