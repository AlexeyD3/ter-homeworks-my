resource "local_file" "hosts_cfg" {
  depends_on = [yandex_compute_instance.storage]
  content = templatefile("${path.module}/hosts.tftpl",
    {
      webservers = [for i in yandex_compute_instance.for-web : i]
      databases  = [for k, v in yandex_compute_instance.node : v]
      storages   = tolist([yandex_compute_instance.storage])
    })
  filename = "${abspath(path.module)}/hosts.cfg"
}
