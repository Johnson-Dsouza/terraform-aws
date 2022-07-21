variable "aws_region" {
  default = "us-east-1"
}

variable "vpc-cidr" {
  default = "10.0.0.0/16"
  description = "VPC CIDR BLOCK"
  type = string
}

variable "azs" {
  type = list
  default = ["us-east-1a", "us-east-1b"]
}

variable "public_subnets_cidr" {
  type = list
  default = ["10.0.0.0/24", "10.0.2.0/24"]
}

variable "private_subnets_cidr" {
  type = list
  default = ["10.0.1.0/24", "10.0.3.0/24"]
}

variable "subnet_count" {
  type = number
  default = 2
}

variable "ssh-location" {
  default = "0.0.0.0/0"
  description = "SSH variable for bastion host"
  type = string
}

variable "instance_type" {
  default = "t2.micro"
  type = string
}

variable "key_name" {
  default = "Issue16"
  type = string
}

variable "ec2_ami" {
  default = "ami-0cff7528ff583bf9a"
}

variable "ec2_count" {
  type = number
  default = 2
}

variable "public_instance_tags" {
  type = list
  default = ["EC2-Public-1A", "EC2-Public-2A"]
}

variable "private_instance_tags" {
  type = list
  default = ["EC2-Private-1B", "EC2-Private-2B"]
}
