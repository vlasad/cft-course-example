provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "us-west-2"
}

resource "aws_vpc" "training_vpc" {
    cidr_block = "10.0.0.0/16"
    enable_dns_hostnames = true
}

resource "aws_security_group" "training_sg" {
    vpc_id = "${aws_vpc.training_vpc.id}"
    description = "Training security group"

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

    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 2222
        to_port = 2222
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 25555
        to_port = 25555
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 5432
        to_port = 5432
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

resource "aws_subnet" "vpc_public_subnet" {
    vpc_id = "${aws_vpc.training_vpc.id}"
    map_public_ip_on_launch = true
    cidr_block = "10.0.0.0/24"
}

resource "aws_instance" "example" {
  ami           = "ami-0ee2276e"
  instance_type = "t2.micro"
  tags {
    Name = "HW-1"
  }
  key_name = "${aws_key_pair.tango.key_name}"
  vpc_security_group_ids = ["${aws_security_group.training_sg.id}"]
  subnet_id = "${aws_subnet.vpc_public_subnet.id}"
  associate_public_ip_address = true
  source_dest_check = false
}

resource "aws_key_pair" "tango" {
  key_name_prefix = "cf-training-"
  public_key = "${var.platform_public_key}"
}


output "jumpbox_ip" {
  value = "192.168.0.2"
}

output "jumpbox_user" {
  value = "ubuntu"
}

output "aws_key_path" {
  value = "1234"
}

output "ssh_port" {
  value = "22"
}
