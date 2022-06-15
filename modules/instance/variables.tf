variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "EC2 instance type"
}

variable "name" {
  type        = string
  description = "Name of instance"
}

variable "key_name" {
  type        = string
  description = "Access key name"
}

variable "security_groups" {
  type        = list(string)
  description = "Instance security group"
}

variable "instance_count" {
  type        = number
  default     = 2
  description = "Number of EC2 instances"
}
