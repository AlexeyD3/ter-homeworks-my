resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}


data "yandex_compute_image" "ubuntu" {
  family = var.vms_resources.web.image
}
resource "yandex_compute_instance" "platform" {
  name        = "${local.company}-${local.stage}-${local.app}-web"
  platform_id = var.vms_resources.web.platform
  resources {
    cores         = var.vms_resources.web.core_count
    memory        = var.vms_resources.web.memory
    core_fraction = var.vms_resources.web.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = var.vms_resources.web.preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.vms_resources.web.nat
  }

  metadata = {
    serial-port-enable = var.vms_ssh.serial-port-enable
    ssh-keys           = "${var.vms_ssh_user}:${file(var.vms_ssh.pub_key)}"
  }

}

resource "yandex_compute_instance" "database" {
  name        = "${local.company}-${local.stage}-${local.app}-db"
  platform_id = var.vms_resources.db.platform
  resources {
    cores         = var.vms_resources.db.core_count
    memory        = var.vms_resources.db.memory
    core_fraction = var.vms_resources.db.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = var.vms_resources.db.preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.vms_resources.db.nat
  }

  metadata = {
    serial-port-enable = var.vms_ssh.serial-port-enable
    ssh-keys           = "${var.vms_ssh_user}:${file(var.vms_ssh.pub_key)}"
  }

}
