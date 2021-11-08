# terraform + python + test files
This repository contains 3 folder: **infrastructure** with terraform files to set up cloud provider infrastructure, the default provider is AWS. **src** that contains the source code of a simple service with two End points ("/tags" and "shutdown") and the Dockerfile. Finally, **test** folder where all terratest files are located.

## How to use
### Software requirements and set up
The user needs to have the following software already installed and configured:
1. terraform : https://learn.hashicorp.com/terraform?utm_source=terraform_io&utm_content=terraform_io_hero
2. Golang: https://golang.org/doc/install
3. Set AWS ENV variables to access your cloud provider. You only need to set *aws_access_key_id* and *aws_secret_access_key*: https://docs.aws.amazon.com/sdk-for-java/v1/developer-guide/setup-credentials.html
4. Clone this repository: *git clone https://github.com/OriolsonRodriguez/terraform_python_test/tree/develop*

### How to run infrastructure with terraform and deploy app automatically
First, let's take a look into the files. Inside the folder **infrastructure** you will find 3 files
1. main.tf : Contains all the code to allocate resources in AWS (default cloud provider)
2. variable.tf: declares all variable used in main.tf
3. terraform.tfvars: Set all variables to a given value. Modify this file in case you wanna change the tags.Names and tags.owner of the resources in AWS and also the region. 

If you want to open an SSH connection to EC2 instances, don't forget to set variables *ssh_pub_key* and *path_to_priv_key* in *terraform.tfvars* to your local values. You will need to generate SSH keys for that purpose.

So, to run the application just open a terminal and type the following commands:
```
cd terraform_python_test/infrastructure
terraform init
terraform apply
```
Type 'yes'  to apply changes. Then wait for a few minutes, the command prompt will print ip address of EC2 instance (*ec2_ip*). With the ip you can now connect to the endpoints of the app by accessing:
```
http://ec2_ip:4000
```
and the endpoints:

```
http://ec2_ip:4000/tags
http://ec2_ip:4000/shutdown
```

After using the app don't forget to deallocate the resources from AWS: *terraform destroy*

### How to test infrastructure with terratest
To test that the EC2 instance and S3 bucket have the proper name and owner, type the following commands in a terminal:
'''
cd terraform_python_test/test
go get
go test -v
'''
At the end of the execution you will see and *PASS*, which means all test are passed.
