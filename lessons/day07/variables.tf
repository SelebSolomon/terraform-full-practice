variable "environment" {
  description = "The environment to deploy to"
  type        = string
  default     = "dev"
  
}

variable "instance_count" {
  type = number
  default = 1
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

variable "ec2_tags" {
  type = map(string)
  default = {
    Name = "dev-ec2-instance"
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