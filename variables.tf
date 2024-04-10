variable "region" {
  default = "eu-east-1"
}

variable "vpc_cidr" {
  default = "100.64.0.0/16"
}

variable "azs" {
  default = ["eu-east-1a", "eu-east-1b", "eu-east-1c"]
}

variable "public_cidr_blocks" {
  default = ["100.64.1.0/24", "100.64.2.0/24", "100.64.3.0/24"]
}

variable "ami" {
  default = "ami-0a55ba1c20b74fc30"
}

variable "key_name" {
  default = "tf-key"
}

variable "instance_type" {
  default = "t2.micro"
}

