# create multiple s3
resource "aws_s3_bucket" "my_bucket" {
  count  = length(var.bucket_names)
  bucket = var.bucket_names[count.index]
  tags = var.tags  # select the tag in variable
}
