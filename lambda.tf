resource "aws_lambda_function" "sg_demo" {
  function_name = "SGDemo"

  s3_bucket = aws_s3_bucket.lambda_bucket.id
  s3_key    = aws_s3_object.lambda_sg_demo.key

  runtime = "nodejs18.x"
  handler = "demo.handler"

  source_code_hash = data.archive_file.lambda_sg_demo.output_base64sha256

  role = aws_iam_role.lambda_exec.arn
}

resource "aws_cloudwatch_log_group" "sg_demo" {
  name = "/aws/lambda/${aws_lambda_function.sg_demo.function_name}"

  retention_in_days = 30
}
