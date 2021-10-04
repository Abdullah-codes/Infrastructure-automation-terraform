provider "aws" {
  region = var.region
}

resource "aws_vpc" "module_vpc" {
  cidr_block = var.vpc_cidr_block
  enable_dns_hostnames = true

  tags = {
    Name="Ec2-VPC"
  }
}

resource "aws_subnet" "module_public_subnet_1" {
  cidr_block = var.public_subnet_1_cidr
  vpc_id = aws_vpc.module_vpc.id
  availability_zone = "${var.region}a"
  map_public_ip_on_launch = true

  tags = {
    Name="Public-Subnet-1-ec2"
  }
}


resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.module_vpc.id
  tags = {
    Name="Public-Route-Table-ec2"
  }
}

resource "aws_route_table_association" "public_subnet_1_association" {
  route_table_id = aws_route_table.public_route_table.id
  subnet_id = aws_subnet.module_public_subnet_1.id
}


resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.module_vpc.id

  tags = {
    Name="Ec2-IGW"
  }
}

resource "aws_route" "igw_route" {
  route_table_id = aws_route_table.public_route_table.id
  gateway_id = aws_internet_gateway.internet_gateway.id
  destination_cidr_block = "0.0.0.0/0"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name = "name"
    #values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "my-first-ec2-instance" {
  ami = data.aws_ami.ubuntu.id
  instance_type = var.ec2_instance_type
  key_name = var.ec2_keypair
  vpc_security_group_ids = [aws_security_group.ec2-security-group.id]
  subnet_id = aws_subnet.module_public_subnet_1.id
}

resource "aws_security_group" "ec2-security-group" {
  name = "EC2-Instance-SG-ec2"
  vpc_id = aws_vpc.module_vpc.id

  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "TLS from VPC" #TODO: Fix description
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "TLS from VPC" #TODO: Fix description
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "TLS from VPC" #TODO: Fix description
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}