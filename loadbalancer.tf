# Creates the application load balancer
resource "aws_alb" "alb" {
  name            = "terraform-alb"
  security_groups = ["${aws_security_group.alb.id}"]
  subnets         = ["${aws_subnet.public-subnet-b.id}", "${aws_subnet.private-subnet-a.id}"]
  enable_deletion_protection = true
  internal = false
}

# Create the target groups
resource "aws_alb_target_group" "alb_front_http" {
	name	= "alb-front-http"
	vpc_id	= "${aws_vpc.default.id}"
	port	= "80"
	protocol	= "HTTP"
	health_check {
                path = "/healthcheck"
                port = "80"
                protocol = "HTTP"
                healthy_threshold = 2
                unhealthy_threshold = 2
                interval = 5
                timeout = 4
                matcher = "200-308"
        }
}
resource "aws_alb_target_group" "alb_server_https" {
	name	= "alb-server-https"
	vpc_id	= "${aws_vpc.default.id}"
	port	= "443"
	protocol	= "HTTPS"
	health_check {
                path = "/healthcheck"
                port = "80"
                protocol = "HTTP"
                healthy_threshold = 2
                unhealthy_threshold = 2
                interval = 5
                timeout = 4
                matcher = "200-308"
        }
}
# Add a listener 
resource "aws_alb_listener" "my-alb-listener" {
  default_action {
    target_group_arn = "${aws_alb_target_group.alb_server_https.arn}"
    type = "forward"
  }
  load_balancer_arn = "${aws_alb.alb.arn}"
  port = 80
  protocol = "HTTP"
}

# Assign the EC2 instances to the target group
resource "aws_alb_target_group_attachment" "alb_front1_http" {
  target_group_arn = "${aws_alb_target_group.alb_front_http.arn}"
  target_id        = "${aws_instance.webserver_instance.id}"
  port             = 80
}
resource "aws_alb_target_group_attachment" "alb_server1_https" {
  target_group_arn = "${aws_alb_target_group.alb_server_https.arn}"
  target_id        = "${aws_instance.webAPI_instance.id}"
  port             = 80
}