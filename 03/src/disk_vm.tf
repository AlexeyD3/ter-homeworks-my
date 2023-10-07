resource "yandex_compute_disk" "empty-disk" {
  count      = var.vm_disk.count
  name       = "${var.vm_disk.name}-${count.index + 1}"
  type       = var.vm_disk.type
  zone       = var.default_zone
  size       = var.vm_disk.size
#  block_size = <размер_блока>
}

resource "yandex_compute_instance" "storage" {
  depends_on = [yandex_compute_disk.empty-disk]
  name        = local.storage
  platform_id = var.vms_resources.storage.platform
  resources {
    cores         = var.vms_resources.storage.core_count
    memory        = var.vms_resources.storage.memory
    core_fraction = var.vms_resources.storage.core_fraction
  }
  dynamic "secondary_disk" {
    for_each = { for i in yandex_compute_disk.empty-disk[*]: i.name=> i }
    content {
      disk_id     = secondary_disk.value.id
      auto_delete = var.vm_disk.auto_delete
    }
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = var.vms_resources.storage.preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.vms_resources.storage.nat
  }

  metadata = {
    serial-port-enable = var.vms_ssh.serial-port-enable
    ssh-keys           = "${var.vms_ssh.user}:${file(var.vms_ssh.pub_key)}"
  }

}