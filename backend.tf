terraform {
  backend "s3" {
    bucket  = "adigaokpkyake1234"                 # Replace with your bucket name
    key     = "eks-cluster/terraform.tfstate"     # Path inside bucket
    region  = "us-east-1"
    encrypt = true
  }
}
