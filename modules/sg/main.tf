locals {
  alb_name      = "example-alb"
  instance_name = "example_ec2"
}

#ALB security group
resource "aws_security_group" "alb_sg" {
  name        = local.alb_name
  description = "SG for our example ALB"
  vpc_id      = data.aws_vpc.main.id

  ingress {
    from_port   = var.tcp80
    to_port     = var.tcp80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = var.tcp80
    to_port         = var.tcp80
    protocol        = "tcp"
    security_groups = [aws_security_group.instance_sg.id]
  }
}

#Instance security group
resource "aws_security_group" "instance_sg" {
  name        = local.instance_name
  description = "SG for our example instance"
  vpc_id      = data.aws_vpc.main.id

  ingress {
    from_port   = var.tcp80
    to_port     = var.tcp80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
