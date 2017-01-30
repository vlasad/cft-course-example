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
}
