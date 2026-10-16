output "alb_dns_name" {
  value = aws_lb.web.dns_name
}

output "web_url" {
  value = local.http_link
}