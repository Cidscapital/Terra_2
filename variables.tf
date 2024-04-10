variable "region" {
  default = "us-east-1"
}

variable "vpc_cidr" {
  default = "192.168.0.0/16"
}

variable "azs" {
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "public_cidr_blocks" {
  default = ["192.168.1.0/24", "192.168.2.0/24", "192.168.3.0/24"]
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

