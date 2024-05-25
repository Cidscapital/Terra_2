output "alb_dns_name" {
  value = aws_lb.web-alb.dns_name
}

output "vpc_id" {
  value = aws_vpc.green-vpc.id
}

output "public_subnet_ids" {
  value = [
    aws_subnet.green-public-subnet1.id,
    aws_subnet.green-public-subnet2.id,
    aws_subnet.green-public-subnet3.id
  ]
}

output "security_group_id" {
  value = aws_security_group.web-sg.id
}
