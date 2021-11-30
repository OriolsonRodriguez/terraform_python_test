
variable "region" {
    description = "Region for cloud provider"
    type = string
}

variable "instance_name" {
    description = "Name of EC2 instances"
    type = string
}

variable "bucket_name" {
    description = "Name of S3 bucket"
    type = string
}
variable "owner" {
    description = "Intance's owner name"
    type = string
}

variable "ssh_pub_key"{
    description = "ssh public key"
    type = string
}

variable "connection_user"{
    description = "User that connects to EC2 instance"
    type = string
}

variable "path_to_priv_key"{
    description = "Path to local private key"
    type = string
}

variable "AWS_ACCESS_KEY_ID"{
    description = "AWS access key"
    type = string
}

variable "AWS_SECRET_ACCESS_KEY"{
    description = "AWS secret key"
    type = string
}