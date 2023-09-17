terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
    region = "us-east-1"
}


data "aws_key_pair" "web-key-pair" {
  key_name           = var.key_pair_name
  include_public_key = true
}

# Web server

resource "aws_instance" "nginx" {
    ami = "ami-053b0d53c279acc90"
    instance_type = "t2.micro"
    security_groups = [ aws_security_group.nginx_sg.name ]
    key_name = data.aws_key_pair.web-key-pair.key_name
    tags = { 
    Name  = "NGINX"
  }
}

# Security group for the web server

resource "aws_security_group" "nginx_sg" {
    name = "Allow Public Access"

    ingress {
      from_port = 8080
      to_port = 8080 
      cidr_blocks = ["0.0.0.0/0"]   
    }

    tags = {
      Name = "Nginx Web Server-sg"
    }
}