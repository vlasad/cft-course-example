provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "us-west-2"
}

resource "aws_instance" "example" {
  ami           = "ami-0ee2276e"
  instance_type = "t2.micro"
  tags {
    Name = "HW-1"
  }
  key_name = "${aws_key_pair.tango.key_name}"
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
