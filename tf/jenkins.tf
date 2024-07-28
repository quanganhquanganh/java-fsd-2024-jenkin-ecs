# Define the IAM User
resource "aws_iam_user" "jenkins_user" {
  name = "sb-ecs-jenkins-user"
}

# Attach policy to allow user to assume the task role
resource "aws_iam_policy" "assume_task_role_policy" {
  name        = "AssumeTaskRolePolicy"
  description = "Policy to allow user to assume the ECS task role"
  policy      = data.aws_iam_policy_document.assume_task_role_policy_document.json
}

data "aws_iam_policy_document" "assume_task_role_policy_document" {
  statement {
    effect = "Allow"
    actions = ["sts:AssumeRole"]
    resources = [aws_iam_role.task_role.arn]
  }
}

resource "aws_iam_user_policy_attachment" "attach_assume_role_policy" {
  user       = aws_iam_user.jenkins_user.name
  policy_arn = aws_iam_policy.assume_task_role_policy.arn
}

# Create access keys for the user
resource "aws_iam_access_key" "user_access_key" {
  user = aws_iam_user.jenkins_user.name
}