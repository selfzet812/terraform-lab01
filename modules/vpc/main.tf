resource "aws_vpc" "main" {
  enable_dns_hostnames = true
  cidr_block           = var.cidr
  tags = {
    Name = var.name
  }
}
#================SUBNETS-PUBLIC=======================
resource "aws_subnet" "public" {
  for_each          = var.public_subnets
  vpc_id            = aws_vpc.main.id
  availability_zone = each.value.az
  cidr_block        = each.value.cidr
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.name}-${each.key}"
  }
}


resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = var.name
  }
}


resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
  tags = {
    Name = var.name
  }
}


resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.public)
  subnet_id      = element(local.public_subnet_ids, count.index)
  route_table_id = aws_route_table.public.id

}


#===================PRIVATE==========================
resource "aws_subnet" "private" {
  for_each          = var.private_subnets
  vpc_id            = aws_vpc.main.id
  availability_zone = each.value.az
  cidr_block        = each.value.cidr
  tags = {
    Name = "${var.name}-${each.key}"
  }
}
resource "aws_nat_gateway" "nat" {
  count         = var.create_nat ? 1 : 0
  allocation_id = aws_eip.nat[0].id
  subnet_id     = values(aws_subnet.public)[0].id
  tags = {
    Name = var.name
  }
}

resource "aws_eip" "nat" {
  count = var.create_nat ? 1 : 0

  tags = {
    Name = var.name
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  dynamic "route" {
    for_each = var.create_nat ? [1]: []
    content {
      cidr_block = "0.0.0.0/0"
      nat_gateway_id = aws_nat_gateway.nat[0].id
  }
    }
  tags = {
    Name = var.name
  }
}

resource "aws_route_table_association" "private" {
  count          = length(aws_subnet.private)
  subnet_id      = element(local.private_subnet_ids, count.index)
  route_table_id = aws_route_table.private.id
}


#======================================

locals {
  public_subnet_ids  = values(aws_subnet.public)[*].id
  private_subnet_ids = values(aws_subnet.private)[*].id
}

