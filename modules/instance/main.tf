resource "aws_instance" "this" {
  ami           = data.aws_ami.awslinux2.id
  count         = var.instance_count
  instance_type = var.instance_type
  key_name      = var.key_name

  root_block_device {
    delete_on_termination = true
    volume_type           = "gp3"
    volume_size           = 10
  }

  vpc_security_group_ids = var.security_groups
  user_data              = file("${path.module}/user_data.sh")

  tags = {
    Name = var.name
  }
}
