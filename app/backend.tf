terraform {
  backend "s3" {
    bucket       = "lab01-terraform"
    region       = "eu-central-1"
    key          = "app/terraform.tfstate"
    use_lockfile = true
    encrypt      = true
  }
}