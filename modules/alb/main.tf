resource "aws_lb" "this" {
  name               = var.name
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_groups
  subnets            = var.subnets

  tags = {
    Name = "Product Load Balancer"
  }
}

resource "aws_lb_target_group" "this" {
  name                 = "${var.name}-tg"
  port                 = 80
  protocol             = "HTTP"
  vpc_id               = var.vpc_id
  deregistration_delay = 30

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    interval            = 10
    timeout             = 5
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Fixed response content"
      status_code  = "200"
    }
  }
}


resource "aws_lb_listener_rule" "forward" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 99

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }

  condition {
    path_pattern {
      values = ["*", "/*"]
    }
  }
}

resource "aws_lb_listener_rule" "pong" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 98

  action {
    type = "fixed-response"


    fixed_response {
      content_type = "text/plain"
      message_body = "pong"
      status_code  = "200"
    }
  }

  condition {
    path_pattern {
      values = ["/ping"]
    }
  }
}

resource "aws_lb_target_group_attachment" "this" {
  # for_each  = toset(var.instance_ids)
  # target_id = each.key
  count            = length(var.instance_ids)
  target_id        = var.instance_ids[count.index]
  target_group_arn = aws_lb_target_group.this.arn
  port             = 80
}
