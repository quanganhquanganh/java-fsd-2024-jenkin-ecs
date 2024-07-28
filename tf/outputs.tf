output "alb_hostname" {
  value = "${aws_alb.main.dns_name}"
}

output "ecr_repository" {
  value = "${module.ecr.repository_url}"
}

output "access_key_id" {
  value       = aws_iam_access_key.user_access_key.id
  description = "The access key ID for the IAM user"
}

output "secret_access_key" {
  value       = aws_iam_access_key.user_access_key.secret
  description = "The secret access key for the IAM user"
  sensitive   = true
}
