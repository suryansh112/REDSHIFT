data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_lambda_redshift"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "archive_file" "lambda_function_file" {
  type = "zip"
  source_file = "${var.github_workspace}/lambda/lambda.py"
  output_path = "${var.github_workspace}/lambda/lambda.zip"
}

resource "aws_lambda_function" "my_lambda" {
  function_name = "pause-redshift"
  role          = aws_iam_role.iam_for_lambda.arn
  
handler       = "lambda.lambda_handler"
  runtime = "python3.8"
  filename      = "${var.github_workspace}/lambda/lambda.zip"
  source_code_hash = data.archive_file.lambda_function_file.output_base64sha256



}




resource "aws_s3_bucket_notification" "redshift-bucket-notification" {
  bucket = "suryanshredshiftbucket"

  lambda_function {
    lambda_function_arn = aws_lambda_function.my_lambda.arn
    events              = ["s3:ObjectCreated:Put"]

    filter_prefix = "redshift/"
  }
}

resource "aws_lambda_permission" "allow_s3" {
  statement_id  = "AllowExecutionFromS3"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.my_lambda.function_name
  principal     = "s3.amazonaws.com"

  source_arn = var.bucket
}



resource "aws_iam_policy" "lambda_policy" {
  name        = "lambda_basic_policy"
  description = "IAM policy for Lambda to access CloudWatch Logs"

  policy = jsonencode({
    Version = "2012-10-17",
    
    Statement = [
      
      {
        effect = Allow
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
        ],
        Effect = "Allow",
        Resource = "arn:aws:logs:*:*:*",
      },
    ],
  })
}

resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}

resource "aws_iam_role_policy_attachment" "lambda_policy_attachment_access" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = var.redshift_lambda_access
}
resource "aws_cloudwatch_log_group" "example" {
  name              = "/aws/lambda/aws_lambda_function.my_lambda"
  retention_in_days = 14
}