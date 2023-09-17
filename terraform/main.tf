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


# Web server

resource "aws_instance" "nginx" {
    ami = "ami-053b0d53c279acc90"
    instance_type = "t2.micro"

    tags = { 
    Name  = "NGINX"
  }
}