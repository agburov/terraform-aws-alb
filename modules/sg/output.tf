output "aws_security_group_alb_sg" {
  value       = aws_security_group.alb_sg.id
  description = "ID for ALB security group"
}

output "aws_security_group_instance_sg" {
  value       = aws_security_group.instance_sg.id
  description = "ID for Instance security group"
}
