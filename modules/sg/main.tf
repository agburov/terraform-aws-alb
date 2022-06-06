locals {
  port80 = var.tcp80
  port22 = var.tcp22
  port0  = var.tcp0

  alb_name      = "example-alb"
  instance_name = "example_ec2"
}

resource "aws_security_group" "alb_sg" {
  name        = local.alb_name
  description = "SG for our example ALB"
  vpc_id      = data.aws_vpc.main.id
}

resource "aws_security_group_rule" "alb_sg_ingress_80" {
  type              = "ingress"
  description       = "Allow traffic on port 80 for ALB SG"
  security_group_id = aws_security_group.alb_sg.id
  from_port         = local.port80
  to_port           = local.port80
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "alb_sg_egress_instance" {
  type                     = "egress"
  security_group_id        = aws_security_group.alb_sg.id
  description              = "Allow traffic on instances port 80 from ALB SG"
  from_port                = local.port80
  to_port                  = local.port80
  protocol                 = "TCP"
  source_security_group_id = aws_security_group.instance_sg.id
}

resource "aws_security_group" "instance_sg" {
  name        = local.instance_name
  description = "SG for our example instance"
  vpc_id      = data.aws_vpc.main.id
}

resource "aws_security_group_rule" "instance_sg_ingress_alb" {
  type                     = "ingress"
  security_group_id        = aws_security_group.instance_sg.id
  description              = "Allow traffic on port 80 from ALB"
  from_port                = local.port80
  to_port                  = local.port80
  protocol                 = "TCP"
  source_security_group_id = aws_security_group.alb_sg.id #allow traffic within the instance security group
}

resource "aws_security_group_rule" "instance_sg_ingress_ssh" {
  type              = "ingress"
  security_group_id = aws_security_group.instance_sg.id
  description       = "Allow ssh traffic for debugging"
  from_port         = local.port22
  to_port           = local.port22
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "instance_sg_egress_all" {
  type              = "egress"
  security_group_id = aws_security_group.instance_sg.id
  description       = "Allow all egress traffic"
  from_port         = local.port0
  to_port           = local.port0
  protocol          = -1
  cidr_blocks       = ["0.0.0.0/0"]
}
