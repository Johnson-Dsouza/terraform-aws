terraform {
  backend "s3" {
    bucket = "terraformdemo-s3-backend-demo"
    key    = "terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform-s3-backend-demo-table"
  }
}
