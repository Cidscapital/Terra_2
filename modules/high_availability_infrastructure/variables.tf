variable "ami_id" {
  description = "AMI ID for the launch template"
}

variable "key_name" {
  description = "Name of the key pair for EC2 instances"
}

variable "user_data" {
  description = "User data for EC2 instances"
}
