variable "vpc_cidr" {
  type        = string
  description = "VPC cidr"
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  type        = map(any)
  description = "Public Subnets"
  default = {
    "eu-west-1a" = "10.0.1.0/24"
    "eu-west-1b" = "10.0.2.0/24"
  }
}

variable "private_subnets" {
  type        = map(any)
  description = "Private Subnets"
  default = {
    "eu-west-1a" = "10.0.3.0/24"
    "eu-west-1b" = "10.0.4.0/24"
  }
}

variable "nat_zone" {
  type        = string
  description = "nat gateway availability zone"
  default     = "eu-west-1a"
}

variable "instance_type" {
  type        = string
  description = "Ec2 instance type"
  default     = "t3.micro"
}

variable "instance_image_id" {
  type        = string
  description = "Ec2 instance image id"
  default     = "ami-0babd2c954c7fb694"
}

variable "root_domain" {
  type        = string
  description = "root domain"
  default     = "code.studucu.com"
}

variable "subdomain" {
  type        = string
  description = "custom subdomain"
  default     = "andre.code.studucu.com"
}
