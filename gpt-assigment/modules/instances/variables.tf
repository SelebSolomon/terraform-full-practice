variable "instance_name" {
  type = string
  default = "instance_gpt"
}

variable "public_subnet_id" {
  type =  list(string)
  description = "public subnet id"
}

variable "private_subnet_id" {
  type = list(string)
  description = "private subnet id"
}

variable "security_group_ids" {
  type =  list(string)
  description = "Security groups ids"
}