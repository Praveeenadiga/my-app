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


provider "kubernetes" {
  host = data.aws_eks_cluster.eks.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.eks.token
}

data "aws_eks_cluster" "eks" {
  name = module.eks.cluster_name
}


data "aws_eks_cluster_auth" "eks" {
  name = module.eks.cluster_name
}

# Create a namespace
resource "kubernetes_namespace" "my_namespace" {
  metadata {
    name = "my-namespace"
  }
}