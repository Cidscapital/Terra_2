output "alb_dns_name" {
  value = aws_lb.web-alb.dns_name
}

output "vpc_id" {
  value = aws_vpc.blue-vpc.id
}

output "public_subnet_ids" {
  value = [
    aws_subnet.blue-public-subnet1.id,
    aws_subnet.blue-public-subnet2.id,
    aws_subnet.blue-public-subnet3.id
  ]
}

output "security_group_id" {
  value = aws_security_group.web-sg.id
}
