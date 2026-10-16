variable "name" {
  type        = string
  description = "Tag Name"
}


variable "cidr" {
  type        = string
  description = "CIDR VPC"
}

variable "public_subnets" {
  type        = map(object({ cidr = string, az = string }))
  description = "map = (cidr = string , az = string)"
}

variable "private_subnets" {
  type        = map(object({ cidr = string, az = string }))
  description = "map = (cidr = string , az = string)"
}

variable "create_nat" {
  type        = bool
  description = "create nat + eip ?"
  default     = false
}

