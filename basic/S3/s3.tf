resource "aws_s3_bucket" "main" {
  bucket = "devops-terraform-test123"

  tags = {
    Name = "devops-terraform-test123"
  }
}