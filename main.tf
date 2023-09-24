terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  backend "s3" {
    
  }

}

provider "aws" {
  region = "us-east-1"
}

# Web server

resource "aws_instance" "nginx" {
  ami             = "ami-053b0d53c279acc90"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.nginx_sg.name]
  key_name        = data.aws_key_pair.web-key-pair.key_name
  user_data       = file("./script.sh")

  tags = {
    Name = "NGINX"
  }
}

# Security group for the web server

resource "aws_security_group" "nginx_sg" {
  name = "Allow Public Access on ssh and web server"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  tags = {
    Name = "Nginx Web Server-sg"
  }
}