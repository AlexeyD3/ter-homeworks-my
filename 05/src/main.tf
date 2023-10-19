# Create network and subnets
module "vpc" {
  source       = "./vpc"
  vpc_name     = var.vpc_name
  subnets      = [
    { zone = "ru-central1-a", v4_cidr_blocks = "10.0.1.0/24" },
    { zone = "ru-central1-b", v4_cidr_blocks = "10.0.2.0/24" },
    { zone = "ru-central1-c", v4_cidr_blocks = "10.0.3.0/24" }
  ]
}

# Create VMs for nginx
module "test-vm" {
  source          = "git::https://github.com/udjin10/yandex_compute_instance?ref=95c286e"
  env_name        = var.nginx_vm.env_name
  instance_name   = var.nginx_vm.instance_name
  instance_count  = var.nginx_vm.instance_count
  image_family    = var.nginx_vm.image_family
  public_ip       = var.nginx_vm.public_ip
  network_id      = module.vpc.network_id
  subnet_zones    = element(module.vpc.availability_zone,0)
  subnet_ids      = element(module.vpc.subnet_ids,0)

  metadata = {
      user-data          = data.template_file.cloudinit.rendered
      serial-port-enable = var.vms_ssh.serial-port-enable
  }

}

# Cloud-init install nginx on VMs
data "template_file" "cloudinit" {
  template = file("./cloud-init.yml")

  vars = {
    username           = var.vms_ssh.user
    ssh_public_key     = file(var.vms_ssh.pub_key)
  }
}

# Create MySQL Cluster (task 5.1)
module "mysql" {
  source       = "./mysql"
  name         = "managed"
  HA           = true    # change to <true> for cluster with 3 hosts, or <false> for cluster with 1 host
  network_id   = module.vpc.network_id
  subnet_ids   = element(module.vpc.subnet_ids,0)
  subnet_zones = element(module.vpc.availability_zone,0)
}

# Create MySQL user & database (task 5.2)
module "mysql-user-db" {
  depends_on = [module.mysql]
  source       = "./mysql-user-db"
  cluster_id   = module.mysql.cluster_id
  user_name    = "user"
  db_name      = "db1"
}

# Create MySQL Cluster (task 5.3)
module "mysql_example" {
  source       = "./mysql"
  name         = "example"
  HA           = true    # change to <true> for cluster with 3 hosts, or <false> for cluster with 1 host
  network_id   = module.vpc.network_id
  subnet_ids   = element(module.vpc.subnet_ids,0)
  subnet_zones = element(module.vpc.availability_zone,0)
}

# Create MySQL user & database (task 5.3)
module "mysql-app-test" {
  depends_on = [module.mysql_example]
  source       = "./mysql-user-db"
  cluster_id   = module.mysql_example.cluster_id
  db_name      = "test"
  user_name    = "app"
}
