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
  source_file = file("${var.github_workspace}/lambda/lambda.py")
  output_path = "${var.github_workspace}/lambda/lambda.zip"
}

resource "aws_lambda_function" "my_lambda" {
  function_name = "pause-redshift"
  role          = aws_iam_role.iam_for_lambda.arn
  
handler       = "lambda.lambda_handler"
  runtime = "python3.8"
  filename      = file("${var.github_workspace}/lambda/lambda.zip")
  source_code_hash = data.archive_file.lambda_function_file.output_base64sha256



}