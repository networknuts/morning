provider "aws" {
	region = "ap-south-1"
}


resource "aws_vpc" "vpc_by_terra" {
	cidr_block = "10.0.0.0/16"
	tags = {
		Name = "terraform_vpc"
	}

}

resource "aws_subnet" "sub_one" {
	vpc_id = "${aws_vpc.vpc_by_terra.id}"
	cidr_block = "10.0.1.0/24"
	tags = {
		Name = "subone_by_terra"
	}
}



## calling module here

module "networknuts_webserver1" {
	source = "./modules/application"
#	vpc_id = "${aws_vpc.vpc_by_terra.id}"
#	subnet_id = "${aws_subnet.sub_one.id}"
	name = "nilesh webserver1"
}


module "networknuts_webserver2" {
	source = "./modules/application"
	name = "nilesh webserver2"
}



