resource "aws_sns_topic" "ecs_events" {
  name = "ecs_events_${var.environment}_${var.cluster}"
}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {
  current = true
}

data "template_file" "ecs_task_stopped" {
  template = <<EOF
{
  "source": ["aws.ecs"],
  "detail-type": ["ECS Task State Change"],
  "detail": {
    "clusterArn": ["arn:aws:ecs:$${aws_region}:$${account_id}:cluster/$${cluster}"],
    "lastStatus": ["STOPPED"],
    "stoppedReason": ["Essential container in task exited"]
  }
}
EOF

  vars {
    account_id = data.aws_caller_identity.current.account_id
    cluster    = var.cluster
    aws_region = data.aws_region.current.name
  }
}
