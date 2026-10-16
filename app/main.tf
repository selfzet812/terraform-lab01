#=================SECURITY-GROUPS===============
resource "aws_security_group" "alb" {
  name   = "${local.name_prefix}-sg-alb"
  vpc_id = local.vpc_id
}

resource "aws_security_group" "web" {
  name   = "${local.name_prefix}-sg-web"
  vpc_id = local.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "http_web" {
  security_group_id            = aws_security_group.web.id
  referenced_security_group_id = aws_security_group.alb.id
  from_port                    = 80
  to_port                      = 80
  ip_protocol                  = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "http_alb" {
  security_group_id = aws_security_group.alb.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
}


resource "aws_vpc_security_group_egress_rule" "all" {
  for_each          = local.sg_ids
  security_group_id = each.value
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

#=========================

resource "aws_launch_template" "web" {
  name_prefix            = local.name_prefix
  image_id               = data.aws_ami.latest_amazon_linux.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.web.id]
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = local.name_prefix
    }
  }
  lifecycle {
    create_before_destroy = true
  }
  user_data = base64encode(templatefile("user_data.sh", {
    env   = var.env
    owner = var.Owner
  }))
}


resource "aws_autoscaling_group" "Web" {
  name                = "Web-ASG"
  min_size            = var.asg_min
  max_size            = var.asg_max
  min_elb_capacity    = var.asg_min
  health_check_type   = "ELB"
  vpc_zone_identifier = local.private_subnet_ids
  target_group_arns   = [aws_lb_target_group.web.arn]

  launch_template {
    id      = aws_launch_template.web.id
    version = aws_launch_template.web.latest_version
  }
}


resource "aws_lb" "web" {
  name               = local.name_prefix
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = local.public_subnet_ids
}

resource "aws_lb_target_group" "web" {
  name                 = local.name_prefix
  vpc_id               = local.vpc_id
  port                 = 80
  protocol             = "HTTP"
  deregistration_delay = 10
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.web.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web.arn
  }
}