#create s3 bucket
resource "aws_s3_bucket" "mybucket" {
  bucket = var.bucketname
}
resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.mybucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}
resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.mybucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "example" {
  depends_on = [
    aws_s3_bucket_ownership_controls.example,
    aws_s3_bucket_public_access_block.example,
  ]

  bucket = aws_s3_bucket.mybucket.id
  acl    = "public-read"
}

resource "aws_s3_object" "index" {
  bucket = aws_s3_bucket.mybucket.id
  key = "index.html"
  source = "index.html"
  acl = "public-read"
  content_type = "text/html"
}

resource "aws_s3_object" "error" {
  bucket = aws_s3_bucket.mybucket.id
  key = "error.html"
  source = "error.html"
  acl = "public-read"
  content_type = "text/html"
}
# resource "aws_s3_object" "app" {
#   bucket = aws_s3_bucket.mybucket.id
#   key = "app.js"
#   source = "app.js"
#   acl = "public-read"
#   content_type = "text/js"
# }
# resource "aws_s3_object" "mediaSCSS" {
#   bucket = aws_s3_bucket.mybucket.id
#   key = "_media.scss"
#   source = "_media.scss"
#   acl = "public-read"
# }

resource "aws_s3_object" "profile" {
  bucket = aws_s3_bucket.mybucket.id
  key = "Nilesh Singh.jpg"
  source = "Nilesh Singh.jpg"
  acl = "public-read"
}
resource "aws_s3_object" "certificate4" {
  bucket = aws_s3_bucket.mybucket.id
  key = "CodeIN Core.png"
  source = "CodeIN Core.png"
  acl = "public-read"
}
resource "aws_s3_object" "certificate3" {
  bucket = aws_s3_bucket.mybucket.id
  key = "Cybersecurity-Es-certificate.png"
  source = "Cybersecurity-Es-certificate.png"
  acl = "public-read"
}
resource "aws_s3_object" "certificate2" {
  bucket = aws_s3_bucket.mybucket.id
  key = "hackodisha-1.png"
  source = "hackodisha-1.png"
  acl = "public-read"
}
resource "aws_s3_object" "resume" {
  bucket = aws_s3_bucket.mybucket.id
  key = "Nilesh_Kumar Singh_Resume_22-08-2023.pdf"
  source = "Nilesh_Kumar Singh_Resume_22-08-2023.pdf"
  acl = "public-read"
}
resource "aws_s3_object" "certificate1" {
  bucket = aws_s3_bucket.mybucket.id
  key = "Reskilll-Certificate-1.png"
  source = "Reskilll-Certificate-1.png"
  acl = "public-read"
}
# resource "aws_s3_object" "StylesCSS" {
#   bucket = aws_s3_bucket.mybucket.id
#   key = "styles.css"
#   source = "styles.css"
#   acl = "public-read"
# }
# resource "aws_s3_object" "stylesCSSMap" {
#   bucket = aws_s3_bucket.mybucket.id
#   key = "styles.css.map"
#   source = "styles.css.map"
#   acl = "public-read"
# }
# resource "aws_s3_object" "stylesSCSS" {
#   bucket = aws_s3_bucket.mybucket.id
#   key = "styles.scss"
#   source = "styles.scss"
#   acl = "public-read"
# }


resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.mybucket.id
  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

  depends_on = [ aws_s3_bucket_acl.example ]
}