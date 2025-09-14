# Configure the AWS provider
provider "aws" {
region = "<your-aws-region>" #Change to the region your EC2 instance is in
}

# Data source for the latest UBUNTU AMI
data "aws_ami" "ubuntu" {
most_recent = true
owners = ["099720109477"] # Canonical's AWS account ID for Ubuntu AMIs

filter {
name = "name"
values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
}

filter {
name = "virtualization-type"
values = ["hvm"]
}
}

# Security group for Jenkins
resource "aws_security_group" "jenkins_test_sg" { # Change <name> to your desired resource name
    name        = "jenkins_test_sg" # Change to your desired security group name
    description = "Allow HTTP and SSH access for Jenkins"

    ingress {
        description = "HTTP for Jenkins"
        from_port   = 8080 #Jenkins default port, adjust if necessary and/or make it as list type for additional ports
        to_port     = 8080 #Jenkins default port, adjust if necessary and/or make it as list type for additional ports
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
}

    ingress {
        description = "SSH access"
        from_port   = 22 #SSH default port, adjust if necessary and/or make it as list type for additional ports
        to_port     = 22 #SSH default port, adjust if necessary and/or make it as list type for additional ports
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"] #Restrict to your IP for security purposes
    }

    egress {
        from_port   = 0 #Allow all outbound traffic adjust if necessary and/or make it as list type for additional ports
        to_port     = 0 #Allow all outbound traffic adjust if necessary and/or make it as list type for additional ports
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"] #Restrict to your IP for security purposes
    }
}

# EC2 instance for Jenkins
resource "aws_instance" "<jenkins_server>" { # Change <name-of-your-ec2-instance> to your desired resource name
    ami = data.aws_ami.ubuntu.id
    instance_type = "t2.micro" #Adjust instance type as needed
    security_groups = [aws_security_group.jenkins_test_sg.name]
    key_name = "<your-key-pair-name>" #The name of your existing key pair
    tags = {
        Name = "Jenkins-Server" #The name of your EC2 instance
    }
}

#Output the public IP of the Jenkins server
output "jenkins_url" {
value = "http://${aws_instance.jenkins_server.public_ip}:8080"
description = "URL to access Jenkins"
}