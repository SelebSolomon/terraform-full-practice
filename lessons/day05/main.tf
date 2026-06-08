terraform {
      backend "s3" {
    bucket = "terraform-lockfiles-8276377282"
    key    = "dev/terraform.tfstate"
    region = "eu-north-1"
    use_lockfile = true
    encrypt = true
  }

  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  # Configuration options
    region = "eu-north-1"
}

variable "environment" {
  description = "The environment to deploy to"
  type        = string
  default     = "dev"
  
}

# Create a S3 bucket
resource "aws_s3_bucket" "tf_test_bucket" {
  bucket = "my-tf-test-bucket-10100022"

  tags = {
    Name        = "My bucket"
    Environment = var.environment
  }
}

