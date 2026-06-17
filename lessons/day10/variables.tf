variable "environment" {
  description = "The environment to deploy to"
  type        = string
  default     = "dev"
  
}

variable "instance_count" {
  type = number
  description = "Count of EC2 instance"
}

variable "region" {
  type = string
  default = "eu-north-1"
}

variable "monitoring_enabled" {
  default = true
  type = bool
}

variable "associate_public_id" {
  default = true
  type = bool
}

variable "cidr_block" {
  default = ["10.0.0.0/16", "10.0.1.0/24", "10.0.2.0/24" ]
  type = list(string)
  
}


variable "allowed_vm_types" {
  type = set(string)
  default = [ "t3.micro", "t3.small", "t3.medium" ]
}

variable "s3_bucket_tags" {
  type = map(string)
  default = {
    Name = "My Bucket"
  }
}


variable "ingress_values" {
  type = tuple([number, string, number])
  default = [ 443, "tcp", 443 ]
}

variable "config" {
  type = object({
    monitoring = bool,
    instance_count= number
  })

  default = {
    instance_count = 1
    monitoring = true
  }
}

variable "bucket_names" {
  type = list(string)
  default = [ "my-unique-day08-1234", "my-unique-day08-5678" ]
}

variable "bucket_name_sets" {
  type = set(string)
  default = [ "my-unique-day08-12340", "my-unique-day08-56780" ]
}

variable "ingress_rules" {
  description = "List of ingress rules for security group"
  type = list(object({
    from_port = number
    to_port = number
    cidr_blocks = list(string)
    protocol = string
    description = string
  }))

  default = [ {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTP traffic"
  } ,
  {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTPS traffic"
  }
  ]
}