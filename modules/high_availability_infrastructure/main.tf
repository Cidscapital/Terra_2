resource "aws_launch_template" "example" {
  name_prefix   = "example-"
  image_id      = var.ami_id  // Placeholder: Replace with appropriate AMI ID
  instance_type = "t2.micro"
  key_name      = var.key_name  // Placeholder: Replace with appropriate key name
  user_data     = var.user_data // Placeholder: Replace with appropriate user data

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "example-instance"
    }
  }
}

resource "aws_autoscaling_group" "example" {
  launch_template {
    id      = aws_launch_template.example.id
    version = aws_launch_template.example.latest_version
  }

  min_size         = 2
  desired_capacity = 3
  max_size         = 3

  tag {
    key                 = "Name"
    value               = "example-instance"
    propagate_at_launch = true
  }
}

resource "aws_lb" "example" {
  name               = "example-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [module.security_group_blue.security_group_id, module.security_group_green.security_group_id] // Assuming separate security groups for blue and green VPCs

  subnets            = [module.vpc_blue.public_subnets[0], module.vpc_green.public_subnets[0]] // Assuming first public subnet of each VPC for simplicity

  tags = {
    Name = "example-lb"
  }
}

resource "aws_lb_target_group" "example" {
  name        = "example-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = module.vpc_blue.vpc_id // Placeholder: Replace with appropriate VPC ID
  target_type = "instance"

  tags = {
    Name = "example-tg"
  }
}

resource "aws_lb_listener" "example" {
  load_balancer_arn = aws_lb.example.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.example.arn
  }
}
