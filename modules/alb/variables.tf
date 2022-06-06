variable "name" {
  type        = string
  description = "description"
}

variable "security_groups" {
  type        = list(string)
  description = "List of SG ids"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID for TG & ALB"
}

variable "subnets" {
  type        = list(string)
  description = "List of subnet ids"
}

variable "instance_ids" {
  type        = list(string)
  description = "Instance IDs"
}
