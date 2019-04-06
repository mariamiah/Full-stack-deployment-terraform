# creates the nat Instance in the public subnet
resource "aws_instance" "nat-instance" {
  ami             = "ami-02e62b1808a107d41"
  instance_type   = "t2.micro"
  security_groups = ["${aws_security_group.VPC_security.id}"]
  subnet_id = "${aws_subnet.public-subnet-a.id}"
  associate_public_ip_address = true
  source_dest_check           = false
  key_name        = "${aws_key_pair.mykeypair.key_name}"
  tags = {
    Name = "nat-instance"
  }
}

# Assign Elastic IP address for the NAT instance
resource "aws_eip" "nat-instance-eip" {
  instance = "${aws_instance.nat-instance.id}"
  vpc      = true
}