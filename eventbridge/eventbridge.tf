resource "aws_scheduler_schedule" "example" {
  name       = "pause-redshift"
  group_name = "default"
  flexible_time_window {
    mode = "OFF"
  }

  schedule_expression = "cron(35 18 * * ? *)"

  target {
    arn      = aws_redshift_cluster.my_cluster
    role_arn = vars.role
  }
}