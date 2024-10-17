# 創建多個 S3 bucket，並應用統一的標籤
resource "aws_s3_bucket" "my_bucket" {
  count  = length(var.bucket_names)
  bucket = var.bucket_names[count.index]

  tags = var.tags  # 使用變數中的標籤
}
