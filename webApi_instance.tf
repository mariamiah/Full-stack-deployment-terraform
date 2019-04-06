# creates the API instance in the public subnet
resource "aws_instance" "webAPI_instance" {
  ami           = "ami-07dc734dc14746eab"
  instance_type = "t2.micro"
  security_groups = ["${aws_security_group.VPC_security.id}"]
  subnet_id = "${aws_subnet.private-subnet-b.id}"
  key_name        = "${aws_key_pair.mykeypair.key_name}"
  tags = {
    Name = "webAPI_instance"
  }
}
