terraform {
  required_version = ">= 1.10"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.80"
    }
  }

  # Backend blocks cannot use variables, so these are literal values.
  backend "s3" {
    bucket       = "trdl-tfstate-050254549866"
    key          = "poc/terraform.tfstate"
    region       = "eu-north-1"
    encrypt      = true
    use_lockfile = true
  }
}
