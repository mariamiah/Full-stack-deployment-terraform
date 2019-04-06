# creates the webserver instance in the public subnet
resource "aws_instance" "webserver_instance" {
  ami           = "ami-042f574086d1e980e"
  instance_type = "t2.micro"
  security_groups = ["${aws_security_group.VPC_security.id}"]
  subnet_id = "${aws_subnet.public-subnet-b.id}"
  associate_public_ip_address = true
  key_name        = "${aws_key_pair.mykeypair.key_name}"

  tags = {
    Name = "webserver_instance"
  }
}
