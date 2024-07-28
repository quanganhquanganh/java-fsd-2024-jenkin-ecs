# Define the IAM User
resource "aws_iam_user" "jenkins_ecr_user" {
  name = "jenkins-ecr-user"
}

resource "aws_iam_access_key" "jenkins_ecr_user_key" {
  user = aws_iam_user.jenkins_ecr_user.name
}

resource "aws_iam_user_policy" "jenkins_ecr_policy" {
  name = "jenkins-ecr-policy"
  user = aws_iam_user.jenkins_ecr_user.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:GetRepositoryPolicy",
          "ecr:DescribeRepositories",
          "ecr:ListImages",
          "ecr:DescribeImages",
          "ecr:BatchGetImage",
          "ecr:InitiateLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:CompleteLayerUpload",
          "ecr:PutImage"
        ]
        Resource = "*"
      }
    ]
  })
}
