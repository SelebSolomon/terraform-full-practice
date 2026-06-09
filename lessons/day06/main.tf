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

# variable for environment
variable "environment" {
  description = "The environment to deploy to"
  type        = string
  default     = "dev"
  
}

# local variable for bucket name
locals {
  bucket_name = "my-tf-test-bucket-10100022"
}
# Create a S3 bucket
resource "aws_s3_bucket" "tf_test_bucket" {
  bucket = local.bucket_name

  tags = {
    Name        = "My bucket"
    Environment = var.environment
  }
}

output "bucket_name" {
  description = "Name of the S3 bucket"
  value       = aws_s3_bucket.tf_test_bucket.id
}