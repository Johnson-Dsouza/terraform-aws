#Create VPC
#terraform aws create vpc
resource "aws_vpc" "vpc" {
  cidr_block       = "${var.vpc-cidr}"
  instance_tenancy = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "Test-VPC"
  }
}

#Create Internet Gateway and Attach it to VPC
#terraform aws create internet gateway
resource "aws_internet_gateway" "internet-gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "Internet-Gateway"
  }
}


# Create Route Table and Add Public Route
# terraform aws create route table
resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet-gateway.id
  }

  tags = {
    Name = "Public-Route-Table"
  }
}


#Create Public Subnet 1A
#terraform  aws create subnet
resource "aws_subnet" "public-subnet" {
  count = var.subnet_count
  vpc_id     = aws_vpc.vpc.id
  cidr_block = element(var.public_subnets_cidr, count.index)
  availability_zone = element(var.azs, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "Public-Subnet-${count.index+1}"
  }
}

# Associate Public Subnet 1A to "Public Route Table"
# terraform aws associate subnet with route table
resource "aws_route_table_association" "public-subnet-1-route-table-association" {
  count = length(var.public_subnets_cidr)
  subnet_id = element(aws_subnet.public-subnet.*.id, count.index)
  #subnet_id = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.public-route-table.id
}

# Create Private Subnet 1B
# terraform aws create subnet
resource "aws_subnet" "private-subnet" {
  count = var.subnet_count
  vpc_id     = aws_vpc.vpc.id
  cidr_block = element(var.private_subnets_cidr, count.index)
  availability_zone = element(var.azs, count.index)
  map_public_ip_on_launch = false

  tags = {
    Name = "Private-Subnet-${count.index+1}"
  }
}

