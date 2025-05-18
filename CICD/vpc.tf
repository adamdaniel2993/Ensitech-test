locals {
  vpc_subnets = cidrsubnets(var.vpc_cird_block, 2, 2, 2, 2)
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.8.1"

  name = "${var.tenant}-${var.environment}-vpc"
  cidr = var.vpc_cird_block

  azs             = ["us-east-2a", "us-east-2b"]
  private_subnets = [local.vpc_subnets[0], local.vpc_subnets[1]]
  public_subnets  = [local.vpc_subnets[2], local.vpc_subnets[3]]

  enable_nat_gateway = true
}