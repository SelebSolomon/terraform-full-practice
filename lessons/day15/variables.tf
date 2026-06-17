variable "enviroment" {
  type = string
  default = "Demo"
}

variable "primary_region" {
  description = "for the primary region"
  type        = string
  default = "eu-north-1"
}


variable "secondary_region" {
  description = "for the secondary region"
  type        = string
  default = "eu-west-1"
}

variable "primary_vpc_cidr" {
  default = "10.0.0.0/16"
  type = string
}

variable "secondary_vpc_cidr" {
  default = "10.1.0.0/16"
  type = string
}


variable "primary_subnet_cidr" {
  description = "CIDR block for the primary subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "secondary_subnet_cidr" {
  description = "CIDR block for the secondary subnet"
  type        = string
  default     = "10.1.1.0/24"
}

variable "instance_type" {
  default = "t3.micro"
  type = string
}

variable "primary_key_name" {
  description = "Name of SSH key pair for primary VPC instance"
  type = string
  default = ""
}

variable "secondary_key_name" {
  description = "Name of SSH key pair for secondary VPC instance"
  type = string
  default = ""
}