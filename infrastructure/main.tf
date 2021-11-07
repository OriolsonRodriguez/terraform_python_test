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

# Output the instance's id and ips.
output "ec2_id" {
  value = aws_instance.EC2-instance.id
}

output "ec2_ip"{
  value = aws_instance.EC2-instance.public_ip
}

# Output the S3 bucket id.
output "s3_id" {
  value = aws_s3_bucket.s3-bucket.id
}
