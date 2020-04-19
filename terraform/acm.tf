resource "aws_acm_certificate" "cert" {
  domain_name       = "www.abaltra.me"

  subject_alternative_names = [
    "abaltra.me"
  ]

  validation_method = "DNS"

  tags = {
    Environment = "test"
  }

  lifecycle {
    create_before_destroy = true
  }
}

# resource "aws_acm_certificate_validation" "cert_validation" {
#   certificate_arn = "${aws_acm_certificate.default.arn}"
# }
