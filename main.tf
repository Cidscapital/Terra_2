# Provider configuration
provider "aws" {
  region = "us-east-1"
}

# Modules
module "vpc_blue" {
  source = "./modules/vpc"
  vpc_cidr_block = "100.64.0.0/16"
  public_subnet_cidr_blocks = ["100.64.1.0/24", "100.64.2.0/24", "100.64.3.0/24"]
  availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

module "security_group_blue" {
  source = "./modules/security_group"
  vpc_id = module.vpc_blue.vpc_id
}

module "ha_infrastructure_blue" {
  source = "./modules/high_availability_infrastructure"
  region = "us-east-1"
  ami_id = "ami-080e1f13689e07408"
  key_name = "tf-key"
  user_data = <<-EOF
    #!/bin/bash
    apt update
    apt install -y docker.io
    docker pull nginx
    docker run -d --name docker-nginx -p 80:80 nginx
    docker run -d --name nginx-container-1 -p 8080:80 nginx
    docker run -d --name nginx-container-2 -p 8081:80 nginx
  EOF
}

module "vpc_green" {
  source = "./modules/vpc"
  public_subnet_cidr_blocks = ["192.168.1.0/24", "192.168.2.0/24", "192.168.3.0/24"]
  availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
  vpc_cidr_block = "192.168.0.0/16"
}

module "security_group_green" {
  source = "./modules/security_group"
  vpc_id = module.vpc_green.vpc_id
}

module "ha_infrastructure_green" {
  source = "./modules/high_availability_infrastructure"
  region = "us-east-1"
  ami_id = "ami-080e1f13689e07408"
  key_name = "tf-key"
  user_data = <<-EOF
    #!/bin/bash
    apt update
    apt install -y docker.io
    docker pull nginx
    docker run -d --name docker-nginx -p 80:80 nginx
    docker run -d --name nginx-container-1 -p 8080:80 nginx
    docker run -d --name nginx-container-2 -p 8081:80 nginx
  EOF
  
}
