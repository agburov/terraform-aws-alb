provider "aws" {

  default_tags {
    tags = {
      Project = "Terrafrom Practice"
      Task    = "13"
    }
  }
}

locals {
  alb_name      = "alb"
  instance_name = "ec2"
}

module "example_alb" {
  source = "./modules/alb"

  name            = local.alb_name
  security_groups = [module.sg.aws_security_group_alb_sg]

  vpc_id       = data.aws_vpc.main.id
  subnets      = data.aws_subnets.main.ids
  instance_ids = module.example_instance.id

  depends_on = [module.sg]
}

module "example_instance" {
  source = "./modules/instance"

  name            = local.instance_name
  security_groups = [module.sg.aws_security_group_instance_sg]

  key_name   = "arthur-key-nvirginia"
  depends_on = [module.sg]
}

module "sg" {
  source = "./modules/sg"
}

output "web_page_address" {
  value     = module.example_alb.dns_name
  sensitive = false
}
