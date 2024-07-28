output "alb_hostname" {
  value = "${aws_alb.main.dns_name}"
}

output "ecr_repository" {
  value = "${module.ecr.repository_url}"
}

output "jenkins_ecr_user_access_key" {
  value = aws_iam_access_key.jenkins_ecr_user_key.id
}

output "jenkins_ecr_user_secret_key" {
  value     = aws_iam_access_key.jenkins_ecr_user_key.secret
  sensitive = true
}