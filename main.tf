# Provider configuration
provider "aws" {
  region = "us-east-1"
}

# Modules
module "vpc_blue" {
  source = "./modules/vpc"
  region = "us-east-1"
  vpc_cidr_block = "100.64.0.0/16"
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
  region = "us-east-1"
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
