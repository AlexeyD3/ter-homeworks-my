module "vpc" {
  source       = "./vpc"
  vpc_name     = "develop"
  yc_token     = var.yc_token
  yc_cloud_id  = var.yc_cloud_id
  yc_folder_id = var.yc_folder_id
  subnets      = [
    { zone = "ru-central1-a", v4_cidr_blocks = "10.0.1.0/24" },
    { zone = "ru-central1-b", v4_cidr_blocks = "10.0.2.0/24" },
    { zone = "ru-central1-c", v4_cidr_blocks = "10.0.3.0/24" }
  ]
}

module "test-vm" {
  source          = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name        = "develop"
  instance_name   = "web"
  instance_count  = 2
  image_family    = "ubuntu-2004-lts"
  public_ip       = true
  network_id      = module.vpc.network_id
  subnet_zones    = "${module.vpc.availability_zone}"
  subnet_ids      = "${module.vpc.subnet_ids}"

  metadata = {
      user-data          = data.template_file.cloudinit.rendered
      serial-port-enable = var.vms_ssh.serial-port-enable
  }

}

#Пример передачи cloud-config в ВМ для демонстрации №3
data "template_file" "cloudinit" {
  template = file("./cloud-init.yml")

  vars = {
    username           = var.vms_ssh.user
    ssh_public_key     = file(var.vms_ssh.pub_key)
  }
}

module "mysql" {
  source       = "./mysql"
  name         = "managed"
  HA           = true    # change to <true> for cluster with 3 hosts, or <false> for cluster with 1 host
  network_id   = module.vpc.network_id
  subnet_ids   = "${module.vpc.subnet_ids}"
  subnet_zones = "${module.vpc.availability_zone}"
  yc_token     = var.yc_token
  yc_cloud_id  = var.yc_cloud_id
  yc_folder_id = var.yc_folder_id
}

module "mysql-user-db" {
  source       = "./mysql-user-db"
  cluster_id   = module.mysql.cluster_id
  user_name    = "user"
  db_name      = "db1"
  yc_token     = var.yc_token
  yc_cloud_id  = var.yc_cloud_id
  yc_folder_id = var.yc_folder_id
}

module "mysql_example" {
  source       = "./mysql"
  name         = "example"
  HA           = true    # change to <true> for cluster with 3 hosts, or <false> for cluster with 1 host
  network_id   = module.vpc.network_id
  subnet_ids   = "${module.vpc.subnet_ids}"
  subnet_zones = "${module.vpc.availability_zone}"
  yc_token     = var.yc_token
  yc_cloud_id  = var.yc_cloud_id
  yc_folder_id = var.yc_folder_id
}

module "mysql-app-test" {
  source       = "./mysql-user-db"
  cluster_id   = module.mysql_example.cluster_id
  db_name      = "test"
  user_name    = "app"
  yc_token     = var.yc_token
  yc_cloud_id  = var.yc_cloud_id
  yc_folder_id = var.yc_folder_id
}