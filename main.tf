### Security Group Module (10%)

# main.tf

# Resource to create the security group
resource "aws_security_group" "web_sg" {
  name        = "web-sg"
  description = "Security group for web servers"
  vpc_id      = var.vpc_id

  # Inbound rules
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow SSH access from anywhere
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow HTTP access from anywhere
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow access to Docker containers
  }

  # Outbound rule
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Allow all outbound traffic
  }

  tags = {
    Name = "web-sg"
  }
}

# outputs.tf

# Output to provide the security group ID
output "security_group_id" {
  value = aws_security_group.web_sg.id
}

### High Availability Infrastructure Module (10%)

# main.tf

# Resource to create the launch template
resource "aws_launch_template" "example" {
  name_prefix   = "example-lt-"
  image_id      = var.ami_id
  instance_type = "t2.micro"
  key_name      = var.key_name
  user_data     = var.user_data

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "example-instance"
    }
  }
}

# Resource to create the autoscaling group
resource "aws_autoscaling_group" "example" {
  name             = "example-asg"
  launch_template {
    id      = aws_launch_template.example.id
    version = aws_launch_template.example.latest_version
  }
  min_size         = 2
  desired_capacity = 3
  max_size         = 3
  vpc_zone_identifier = var.subnet_ids
  target_group_arns   = [var.target_group_arn]

  tag {
    key                 = "Name"
    value               = "example-instance"
    propagate_at_launch = true
  }
}

# outputs.tf

# Output to provide the autoscaling group ARN
output "autoscaling_group_arn" {
  value = aws_autoscaling_group.example.arn
}

### VPC Blue (35%)

# main.tf

# Resource to create the VPC
resource "aws_vpc" "vpc_blue" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = "default"
}

# Resource to create the subnets
resource "aws_subnet" "subnet_blue" {
  count             = length(var.subnet_cidr_blocks)
  vpc_id            = aws_vpc.vpc_blue.id
  cidr_block        = var.subnet_cidr_blocks[count.index]
  availability_zone = var.availability_zones[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "subnet-blue-${count.index}"
  }
}

# outputs.tf

# Output to provide the VPC ID
output "vpc_id_blue" {
  value = aws_vpc.vpc_blue.id
}

# Output to provide the subnet IDs
output "subnet_ids_blue" {
  value = aws_subnet.subnet_blue[*].id
}

### VPC Green (35%)

# main.tf

# Resource to create the VPC
resource "aws_vpc" "vpc_green" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = "default"
}

# Resource to create the subnets
resource "aws_subnet" "subnet_green" {
  count             = length(var.subnet_cidr_blocks)
  vpc_id            = aws_vpc.vpc_green.id
  cidr_block        = var.subnet_cidr_blocks[count.index]
  availability_zone = var.availability_zones[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "subnet-green-${count.index}"
  }
}

# outputs.tf

# Output to provide the VPC ID
output "vpc_id_green" {
  value = aws_vpc.vpc_green.id
}

# Output to provide the subnet IDs
output "subnet_ids_green" {
  value = aws_subnet.subnet_green[*].id
}
