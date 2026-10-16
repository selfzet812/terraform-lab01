variable "region" {
  type        = string
  description = "Region Name"

}


variable "env" {
  type        = string
  description = "Env"
  validation {
    condition     = contains(["dev", "staging", "prod"], var.env)
    error_message = "env must be one of: dev, staging, prod."
  }
}


variable "instance_type" {
  default     = "t3.micro"
  description = "instance type"
  type        = string
}


variable "asg_min" {
  description = "AutoScaling Group Min Instances"
  type        = number
}

variable "asg_max" {
  description = "AutoScaling Group Max Instances"
  type        = number
}

variable "Owner" {
  description = "owner name"
}



