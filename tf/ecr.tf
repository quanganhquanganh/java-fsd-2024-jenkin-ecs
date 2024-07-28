module "ecr" {
  source = "terraform-aws-modules/ecr/aws"

  repository_name = "sb_app"

  repository_read_write_access_arns = [
    aws_iam_role.task_role.arn
  ]
  repository_lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1,
        description  = "Keep last 2 images",
        selection = {
          tagStatus     = "tagged",
          tagPrefixList = ["v"],
          countType     = "imageCountMoreThan",
          countNumber   = 2
        },
        action = {
          type = "expire"
        }
      }
    ]
  })

  depends_on = [ 
    aws_iam_role.task_role
  ]
}