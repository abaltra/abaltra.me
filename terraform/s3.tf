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

  bucket = aws_s3_bucket.bucket.id
  key    = each.value
  source = "../site/${each.value}"
  # etag makes the file update when it changes; see https://stackoverflow.com/questions/56107258/terraform-upload-file-to-s3-on-every-apply
  etag   = filemd5("../site/${each.value}")
}

resource "aws_s3_bucket_object" "imgs" {
  for_each = fileset("../site/img/", "*")

  bucket = aws_s3_bucket.bucket.id
  key    = "img/${each.value}"
  source = "../site/img/${each.value}"
  # etag makes the file update when it changes; see https://stackoverflow.com/questions/56107258/terraform-upload-file-to-s3-on-every-apply
  etag   = filemd5("../site/img/${each.value}")
}

resource "aws_s3_bucket_object" "static" {
  for_each = fileset("../site/static/", "*")

  bucket = aws_s3_bucket.bucket.id
  key    = "static/${each.value}"
  source = "../site/static/${each.value}"
  # etag makes the file update when it changes; see https://stackoverflow.com/questions/56107258/terraform-upload-file-to-s3-on-every-apply
  etag   = filemd5("../site/static/${each.value}")
}