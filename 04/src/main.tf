module "vpc" {
  source       = "./vpc"
  vpc_name     = "develop"
  zone         = "ru-central1-a"
  cidr_blocks  = ["10.0.1.0/24"]
  yc_token     = var.yc_token
  yc_cloud_id  = var.yc_cloud_id
  yc_folder_id = var.yc_folder_id
}


module "test-vm" {
  source          = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name        = "develop"
  network_id      = module.vpc.network_id
  subnet_zones    = ["ru-central1-a"]
  subnet_ids      = [module.vpc.subnet_ids]
  instance_name   = "web"
  instance_count  = 2
  image_family    = "ubuntu-2004-lts"
  public_ip       = true

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
