terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.100.0"
    }
    template = {
      source = "hashicorp/template"
      version = "2.2.0"
    }
  }
  required_version = "=1.5.7"
  backend "s3" {
    endpoint = "storage.yandexcloud.net"
    bucket = "tfstate-netology-ad"
    key = "terraform.tfstate"
    region = "ru-central1"

    skip_region_validation = true
    skip_credentials_validation = true

    dynamodb_endpoint = "https://docapi.serverless.yandexcloud.net/ru-central1/b1gm5cnlfgcnmeq4an1v/etn1oq33gdbq5bu4bk5t"
    dynamodb_table = "state-lock-table"
  }
}

provider "yandex" {
  token     = var.yc_token
  cloud_id  = var.yc_cloud_id
  folder_id = var.yc_folder_id
  zone      = var.zone
}