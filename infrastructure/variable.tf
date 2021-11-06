
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