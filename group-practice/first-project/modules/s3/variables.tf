

variable "environment" {
  description = "The environment to deploy to"
  type        = string
  
  
}

variable "region" {
  type = string
  
}

variable "bucket_name" {
  type = string
  default = "isaiah-project-bucket-8282828"
}

variable "cloudfront_distribution_arn" {
  type = string
}

