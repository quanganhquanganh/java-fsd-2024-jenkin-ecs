resource "aws_iam_role" "task_execution_role" {
  name               = "sb-task-execution-role"
  assume_role_policy = data.aws_iam_policy_document.ecs_tasks_assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "task_execution_role_policy" {
  role       = aws_iam_role.task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

data "aws_iam_policy_document" "ecs_tasks_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecs_autoscale_role" {
  name               = "sb-ecs-autoscale-role"
  assume_role_policy = data.aws_iam_policy_document.ecs_autoscale_assume_role_policy.json
}

data "aws_iam_policy_document" "ecs_autoscale_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["application-autoscaling.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy" "ecs_autoscale_role_policy" {
  name   = "sb-ecs-autoscale-role-policy"
  role   = aws_iam_role.ecs_autoscale_role.name
  policy = data.aws_iam_policy_document.ecs_autoscale_role_policy_document.json
}

data "aws_iam_policy_document" "ecs_autoscale_role_policy_document" {
  statement {
    effect = "Allow"
    actions = [
      "ecs:DescribeServices",
      "ecs:UpdateService",
      "cloudwatch:DescribeAlarms",
      "cloudwatch:PutMetricAlarm",
      "cloudwatch:GetMetricStatistics",
      "cloudwatch:DescribeAlarmHistory",
      "cloudwatch:DescribeAlarmsForMetric",
      "cloudwatch:GetMetricData"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_role" "task_role" {
  name               = "sb-ecs-task-role"
  assume_role_policy = data.aws_iam_policy_document.task_role_assume_policy.json
}

data "aws_iam_policy_document" "task_role_assume_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}
