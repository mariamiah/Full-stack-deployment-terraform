# This resource defines the Key pair that shall be used to access AWS
resource "aws_key_pair" "mykeypair" {
  key_name   = "myAwsKey"
  public_key = "${file("${var.PUBLIC_KEY}")}"
}
