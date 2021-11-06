terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}


# Configure the AWS Provider
provider "aws" {
  region = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}


resource "aws_instance" "EC2-instance"{
    ami = "ami-083654bd07b5da81d"
    instance_type = "t2.micro"

    tags = {
        Name = var.instance_name
        Owner = var.owner
    }
}


 resource "aws_s3_bucket" "s3-bucket" {
   bucket = "flugel-test"
   acl    = "private"

   tags = {
     Name = var.bucket_name
     Owner = var.owner
   }
 }
