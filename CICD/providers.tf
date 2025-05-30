terraform {
  backend "s3" {
    bucket = "ensitech-test-ad"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}


provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      APP         = "Ensitech"
      Terraform   = "true"
      Environment = var.environment
    }
  }
}

data "aws_caller_identity" "this" {}
