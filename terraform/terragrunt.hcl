remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    key = "${path_relative_to_include()}/terraform.tfstate"
    bucket         = "terraform-state-e9d8d0c6-3b10-475a-a8b2-1b5e84f2441b"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-locks"
    encrypt        = true
  }
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "skip"


  contents = <<EOF
provider "aws" {
  profile = "personal"
  region  = "us-east-1"
}
EOF
}
