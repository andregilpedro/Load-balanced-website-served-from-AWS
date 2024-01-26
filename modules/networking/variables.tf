variable "vpc" {
  type        = object({ id = string })
  description = "VPC resource"
}

variable "public_subnets" {
  type        = map(any)
  description = "Public Subnets"
}

variable "private_subnets" {
  type        = map(any)
  description = "Private Subnets"
}

variable "nat_zone" {
  type        = string
  description = "nat availability zone"
}
