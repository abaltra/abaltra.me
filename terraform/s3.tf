resource "aws_s3_bucket" "bucket" {
  bucket = "abaltra.me"
  acl    = "public-read"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
                "s3:GetObject"
            ],
            "Resource": [
                "arn:aws:s3:::abaltra.me/*"
            ]
        }
    ]
}
EOF

  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}

resource "aws_s3_bucket_object" "indexes" {
  for_each = fileset("../site/", "*")

  content_type = "text/html"
  bucket = aws_s3_bucket.bucket.id
  key    = each.value
  source = "../site/${each.value}"
  # etag makes the file update when it changes; see https://stackoverflow.com/questions/56107258/terraform-upload-file-to-s3-on-every-apply
  etag   = filemd5("../site/${each.value}")
}

resource "aws_s3_bucket_object" "js" {
  for_each = fileset("../site/js/", "*")

  content_type = "text/javascript"
  bucket = aws_s3_bucket.bucket.id
  key    = "js/${each.value}"
  source = "../site/js/${each.value}"
  # etag makes the file update when it changes; see https://stackoverflow.com/questions/56107258/terraform-upload-file-to-s3-on-every-apply
  etag   = filemd5("../site/js/${each.value}")
}

resource "aws_s3_bucket_object" "css" {
  for_each = fileset("../site/css/", "*")

  content_type = "text/css"
  bucket = aws_s3_bucket.bucket.id
  key    = "css/${each.value}"
  source = "../site/css/${each.value}"
  # etag makes the file update when it changes; see https://stackoverflow.com/questions/56107258/terraform-upload-file-to-s3-on-every-apply
  etag   = filemd5("../site/css/${each.value}")
}

resource "aws_s3_bucket_object" "png" {
  for_each = fileset("../site/png/", "*")

  content_type = "img/png"
  bucket = aws_s3_bucket.bucket.id
  key    = "png/${each.value}"
  source = "../site/png/${each.value}"
  # etag makes the file update when it changes; see https://stackoverflow.com/questions/56107258/terraform-upload-file-to-s3-on-every-apply
  etag   = filemd5("../site/png/${each.value}")
}

resource "aws_s3_bucket_object" "ico" {
  for_each = fileset("../site/ico/", "*")

  content_type = "image/ico"
  bucket = aws_s3_bucket.bucket.id
  key    = "ico/${each.value}"
  source = "../site/ico/${each.value}"
  # etag makes the file update when it changes; see https://stackoverflow.com/questions/56107258/terraform-upload-file-to-s3-on-every-apply
  etag   = filemd5("../site/ico/${each.value}")
}

resource "aws_s3_bucket_object" "pdf" {
  for_each = fileset("../site/pdf/", "*")

  content_type = "application/pdf"
  bucket = aws_s3_bucket.bucket.id
  key    = "pdf/${each.value}"
  source = "../site/pdf/${each.value}"
  # etag makes the file update when it changes; see https://stackoverflow.com/questions/56107258/terraform-upload-file-to-s3-on-every-apply
  etag   = filemd5("../site/pdf/${each.value}")
}