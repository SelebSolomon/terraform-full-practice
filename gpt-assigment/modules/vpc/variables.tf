variable "azs" {
  description = "avialablity zones"
  type = list(string)
}

variable "public_subnets" {
  type = list(string)
  description = "subnet cidrs"
}

variable "private_subnets" {
  type = list(string)
  description = "subnet cidrs"
}