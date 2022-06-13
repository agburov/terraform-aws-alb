variable "ecr_repo_name" {
  type    = string
  default = "example-application"
}

variable "git_repo_url" {
  type    = string
  default = "https://github.com/agburov/react-redux-realworld-example-app.git"

  description = "Git repository for ECS service"
}
