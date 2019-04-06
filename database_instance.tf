data "aws_ami" "ubuntu" {
most_recent = true

filter {
name   = "name"
values = ["Store-DB-AMI*"] 
}

filter {
name   = "virtualization-type"
values = ["hvm"]
}

owners = ["136496309071"]
}
# Database instance that defines postgresql
resource "aws_instance" "DB_Instance" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.micro"
  security_groups = ["${aws_security_group.VPC_security.id}"]
  subnet_id = "${aws_subnet.private-subnet-a.id}"
  key_name        = "${aws_key_pair.mykeypair.key_name}"
  tags {
    Name = "DB_Instance"
  }
}

