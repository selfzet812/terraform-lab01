output "vpc_id" {
  value = aws_vpc.main.id
}


output "public_subnet_ids" {
  value = local.public_subnet_ids
}



output "private_subnet_ids" {
  value = local.private_subnet_ids
}


output "nat_gateway_id" {
  value =  var.create_nat ? aws_nat_gateway.nat[0].id : null
}
