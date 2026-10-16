locals {
  region             = var.region
  name_prefix        = "lab01-${var.env}"
  private_subnet_ids = data.terraform_remote_state.network.outputs.private_subnet_ids
  public_subnet_ids  = data.terraform_remote_state.network.outputs.public_subnet_ids
  vpc_id             = data.terraform_remote_state.network.outputs.vpc_id

  sg_ids = {
    "alb" = aws_security_group.alb.id
    "web" = aws_security_group.web.id
  }
  http_link = "http://${aws_lb.web.dns_name}"
}