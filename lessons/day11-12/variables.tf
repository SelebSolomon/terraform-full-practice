variable "project_name" {
  type = string
  default = "Seleb GREAT project"
}

variable "region" {
  type = string
  default = "us-west-1"
}

variable "allowed_ports" {
  default = "80, 443, 8080, 3306"
}

variable "instance_size" {
  default = {
    dev = "t2.micro"
    staging = "t3.small"
    prod = "t3.large"
  }
}

variable "environment" {
  default = "dev"
}

variable "instance_type" {
  default = "t2.micro"

  validation {
    condition = length(var.instance_type) >= 2 && length(var.instance_type) <= 20
    error_message = "Instance type must be between 2 to 20"
  }

  validation {
    condition = can(regex("^t[2-3]\\.", var.instance_type))
    error_message = "instance type must be between t2 or t3"
  }
}

variable "backup_name" {
  default = "daily_backup"

  validation {
    condition = endswith(var.backup_name, "_backup")
    error_message = "backup must end with _backup"
  }
}

variable "user_locations" {
  default = ["us-east-1", "us-east-2", "us-east-1"]
}

variable "default_locations" {
  default = ["us-east-1"]
}

variable "monthly_costs" {
  default = [-50, 83, 333, 833, 999, 039]
}