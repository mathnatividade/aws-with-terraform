terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

# Create VPC
resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"
    
    tags = {
      Name = "main"
    }
}

#Create subnet
resource "aws_subnet" "main" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.1.0/24"

    tags = {
      Name = "main"
    }
}

# Create internet gateway
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main.id
}

# Create route for public subnet
resource "aws_route_table" "public_route_table" {
    vpc_id = aws_vpc.main.id
    
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
}

# Create route association for public subnet
resource "aws_route_table_association" "public_subnet_association" {
    subnet_id = aws_subnet.main.id
    route_table_id = aws_route_table.public_route_table.id
}

# Configure security group
resource "aws_security_group" "web-server-sg" {
    name_prefix = "web-server-sg"
    vpc_id = aws_vpc.main.id
    ingress = [
        {
        description = "HTTP from anywhere"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = []
        prefix_list_ids = []
        security_groups = []
        self = false
        },

        {
        description = "HTTPS from anywhere"
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = []
        prefix_list_ids = []
        security_groups = []
        self = false
        },

        {
        description = "SSH from anywhere"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = []
        prefix_list_ids = []
        security_groups = []
        self = false
        }        
    ]

    egress = [
        {
        description = "Outbound traffic to anywhere"
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = []
        prefix_list_ids = []
        security_groups = []
        self = false
        }
    ]    
}

# Set EC2 config
resource "aws_instance" "web-server" {
    ami = "ami-04823729c75214919" #Amazon Linux 2
    instance_type = "t2.micro"

    vpc_security_group_ids = [ aws_security_group.web-server-sg.id ]
    subnet_id = aws_subnet.main.id

    associate_public_ip_address = true

    key_name = "you-key-pair" # Generate an access key before on the AWS console, and download it to the directory for this archive

    user_data = <<-EOF
                #!/bin/bash
                sudo yum update -y
                sudo yum install -y docker
                sudo service docker start
                sudo usermod -aG docker ec2-user
                sudo docker run -d --name web-server -p 80:80 httpd
                EOF
    tags = {
      Name = "Web Server"
    }
}