#Loadbalancer
resource "aws_elb" "bar" {
  name               = "foobar-terraform-elb"

  security_groups = [aws_security_group.public.id]
  subnets = [var.private-subnet1,var.private-subnet2]
    listener {
    instance_port     = 8484
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:8484/"
    interval            = 30
  }

  instances                   = [aws_instance.app1.id,aws_instance.app2.id]
  cross_zone_load_balancing   = true
  idle_timeout                = 10
  connection_draining         = true
  connection_draining_timeout = 10

}
# Output
output "elb_output" {
    value = aws_elb.bar.dns_name
}
