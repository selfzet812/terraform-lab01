data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "lab01-terraform"
    key    = "network/terraform.tfstate"
    region = "eu-central-1"
  }
}


data "aws_ami" "latest_amazon_linux" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["al2023-ami-*-kernel-6.1-x86_64"]
  }
}


