data "aws_vpc" "main" {
  filter {
    name   = "tag:Name"
    values = ["default"]
  }
}

data "aws_subnets" "main" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.main.id]
  }
}

# output "aws_subnets_id" {
#   value = data.aws_subnets.main.ids
# }
