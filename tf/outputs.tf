output "alb_hostname" {
  value = "${aws_alb.main.dns_name}"
}

output "ecr_repository" {
  value = "${module.ecr.repository_url}"
}
