variable "public_subnets" {
  type = list(string)
  description = "This is for public subnets"
}

variable "vpc_id" {
  type = string
  description = "this is the main vpc id created in the vpc module"
}


variable "instance_private" {
  type = list(string)
  description = "this is the instance i want to attach to alb"
}