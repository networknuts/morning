#provider "aws" {
#	region = "ap-south-1"
#}

#defining and calling variables
#variable "vpc_id" {}
#variable "subnet_id" {}
variable "name" {}



#creating security group

resource "aws_security_group" "nilesh-ssh-http" {
	name = "${var.name} http by terraform"
	description = "allow http and ssh traffic"
#	vpc_id = "${var.vpc_id}"
	ingress {
		from_port = 22
		to_port = 22
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}

	ingress {
		from_port = 80
		to_port = 80
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}

	egress {
		from_port = 0
		to_port = 0
		protocol = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}

}
#security group end here

#instance code start here

resource "aws_instance" "our-webserver" {
	ami = "ami-5b673c34"
	instance_type = "t2.small"
# 	availability_zone = "ap-south-1c"	
#	subnet_id = "${var.subnet_id}"
#	vpc_security_group_ids = ["${aws_security_group.nilesh-ssh-http.id}"]
	key_name = "zoomkey"
	user_data = <<-EOF
		#!/bin/bash
		sudo yum install httpd -y
		sudo systemctl start httpd
		sudo systemctl enable httpd
		echo "<h1>sample webpage using terraform</h1>" >> /var/www/html/index.html
	EOF
	tags = {
		Name = "${var.name}"
	}
}

#instance code end here




