variable "region" {
  default = "us-east-1"
}

variable "vpc_cidr" {
  default = "100.64.0.0/16"
}

variable "azs" {
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "public_cidr_blocks" {
  default = ["100.64.1.0/24", "100.64.2.0/24", "100.64.3.0/24"]
}

variable "ami" {
  default = "ami-080e1f13689e07408"
}

variable "key_name" {
  default = "tf-key"
}

variable "instance_type" {
  default = "t2.micro"
}

