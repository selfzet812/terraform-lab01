module "vpc_dev" {
  source          = "../modules/vpc"
  name            = var.name
  cidr            = var.cidr
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  create_nat      = var.create_nat
}