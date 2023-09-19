# VPC

resource "aws_vpc" "aurora" {
  cidr_block           = "60.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.aurora.id
  cidr_block              = "60.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.aurora.id
  cidr_block              = "60.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = false
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.aurora.id
}

# resource "aws_internet_gateway_attachment" "igw_attachment" {
#   vpc_id             = aws_vpc.aurora.id
#   internet_gateway_id = aws_internet_gateway.internet_gateway.id
# }