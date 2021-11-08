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
    key_name = "aws_key"
    vpc_security_group_ids = [aws_security_group.main.id]

    provisioner "remote-exec" {
    inline = ["sudo apt update",
              "sudo apt install git",
              "git clone https://github.com/OriolsonRodriguez/terraform_python_test",
              "cd terraform_python_test",
              "git checkout develop",
              "yes | sudo bash startApp.sh",
              "touch hello.txt",
              "echo helloworld remote provisioner >> hello.txt"
              
    ]
    }
   connection {
      type        = "ssh"
      host        = self.public_ip
      user        = var.connection_user
      private_key = file(var.path_to_priv_key)
      timeout     = "4m"
   }

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

#Setting up ssh connection
resource "aws_security_group" "main" {
  egress = [
    {
      cidr_blocks      = [ "0.0.0.0/0", ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    }
  ]
 ingress                = [
   {
     cidr_blocks      = [ "0.0.0.0/0", ]
     description      = ""
     from_port        = 22
     ipv6_cidr_blocks = []
     prefix_list_ids  = []
     protocol         = "tcp"
     security_groups  = []
     self             = false
     to_port          = 22
  },
  
   
   {
     cidr_blocks      = [ "0.0.0.0/0", ]
     description      = ""
     from_port        = 4000
     ipv6_cidr_blocks = []
     prefix_list_ids  = []
     protocol         = "tcp"
     security_groups  = []
     self             = false
     to_port          = 4000
  }
  ]
}


resource "aws_key_pair" "deployer" {
  key_name   = "aws_key"
  public_key = var.ssh_pub_key
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
