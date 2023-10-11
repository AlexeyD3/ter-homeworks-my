resource "yandex_mdb_mysql_cluster" "netology" {
  name                = var.name
  environment         = var.mysql_cluster.environment
  network_id          = var.network_id
  version             = var.mysql_cluster.version
  security_group_ids  = var.mysql_cluster.security_group_ids
  deletion_protection = var.mysql_cluster.deletion_protection

  resources {
    resource_preset_id = "s2.micro"
    disk_type_id       = "network-ssd"
    disk_size          = "10"
  }


  count = var.config_cluster == true ? 3 : 1
  host {
    zone             = element(var.subnet_zones, count.index)
    subnet_id        = element(var.subnet_ids, count.index)
    assign_public_ip = true
  }
  host {
    zone             = element(var.subnet_zones, count.index+1)
    subnet_id        = element(var.subnet_ids, count.index+1)
    assign_public_ip = true
  }
  host {
    zone             = element(var.subnet_zones, count.index+2)
    subnet_id        = element(var.subnet_ids, count.index+2)
    assign_public_ip = true
  }
}
