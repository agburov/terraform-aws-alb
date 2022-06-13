variable "name" {
  type        = string
  description = "Name required"
}

variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "Instance type"
}

variable "docker_image" {
  type        = string
  description = "Docker image required"
}

variable "target_group_arn" {
  type    = string
  default = "Target group ARN"
}

variable "key_name" {
  type        = string
  description = "Key required for SSH debug connetction"
}

variable "security_group_ids" {
  type        = list(string)
  default     = []
  description = "IDs of security group"
}

variable "aws_asg_min" {
  type        = string
  default     = 1
  description = "Minimum instance size"
}

variable "aws_asg_max" {
  type        = string
  default     = 3
  description = "Maximim instance size"
}

variable "aws_asg_desired" {
  type        = string
  default     = 1
  description = "Desired instance size"
}

variable "aws_ecs_desired" {
  type        = string
  default     = 2
  description = "Desired ecs services size"
}
