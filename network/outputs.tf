output "public_subnet_ids" {
  value = module.vpc_dev.public_subnet_ids
}


output "private_subnet_ids" {
  value = module.vpc_dev.private_subnet_ids
}


output "vpc_id" {
  value = module.vpc_dev.vpc_id
}

