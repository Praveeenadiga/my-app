terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# --- VPC module ---
module "vpc" {
  source               = "./vpc"
  aws_region           = var.aws_region
  project              = var.project
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
}

# --- EKS module ---
module "eks" {
  source          = "./eks"
  project         = var.project
  private_subnets = module.vpc.private_subnets
}
