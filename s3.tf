resource "aws_s3_bucket" "lambda_bucket" {
  bucket = "lambda-deploy-demo"
  force_destroy = true
}

data "archive_file" "lambda_sg_demo" {
  type = "zip"

  source_dir  = "${path.module}/sg-demo"
  output_path = "${path.module}/sg-demo.zip"
}

resource "aws_s3_object" "lambda_sg_demo" {
  bucket = aws_s3_bucket.lambda_bucket.id

  key    = "sg-demo.zip"
  source = data.archive_file.lambda_sg_demo.output_path

  etag = filemd5(data.archive_file.lambda_sg_demo.output_path)
}
