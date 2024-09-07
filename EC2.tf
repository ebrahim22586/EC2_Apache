provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "test_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "test-vpc"
  }
}

resource "aws_internet_gateway" "test_igw" {
  vpc_id = aws_vpc.test_vpc.id
}

resource "aws_subnet" "test_subnet" {
  vpc_id            = aws_vpc.test_vpc.id
  cidr_block        = "10.0.0.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "test-public-subnet"
  }
}

resource "aws_route_table" "routetable" {
  vpc_id = aws_vpc.test_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.test_igw.id
  }

  tags = {
    Name = "routetabe"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.test_subnet.id
  route_table_id = aws_route_table.routetable.id
}

resource "aws_security_group" "testsg" {
  name        = "testsg"
  description = "Allow HTTP and SSH"
  vpc_id      = aws_vpc.test_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "testsg"
  }
}

resource "aws_instance" "web_ec2" {
  ami           = "ami-0a5c3558529277641" 
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.test_subnet.id
  vpc_security_group_ids = [aws_security_group.testsg.id]

  user_data = file("scrpit.tpl")

  tags = {
    Name = "web_ec2"
  }
}


