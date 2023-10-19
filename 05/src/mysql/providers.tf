terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">=0.13"
  backend "s3" {
    endpoint = "storage.yandexcloud.net"
    bucket = "tfstate-netology-ad"
    key = "terraform.tfstate"
    region = "ru-central1"

    skip_region_validation = true
    skip_credentials_validation = true

#    dynamodb_endpoint = "https://docapi.serverless.yandexcloud.net/ru-central1/b1gm5cnlfgcnmeq4an1v/etn1oq33gdbq5bu4bk5t"
#    dynamodb_table = "state-lock-table"
  }
}
