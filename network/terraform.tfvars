public_subnets = {
  public-a = { cidr = "10.10.0.0/24", az = "eu-central-1a" }
  public-b = { cidr = "10.10.1.0/24", az = "eu-central-1b" }
}


private_subnets = {
  private-a = { cidr = "10.10.10.0/24", az = "eu-central-1a" }
  private-b = { cidr = "10.10.11.0/24", az = "eu-central-1b" }
}

name = "lab01"

cidr = "10.10.0.0/16"

create_nat = true


region = "eu-central-1"