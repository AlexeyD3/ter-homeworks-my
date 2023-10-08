resource "local_file" "hosts_cfg" {
  depends_on = [
    yandex_compute_instance.node,
    yandex_compute_instance.for-web,
    yandex_compute_instance.storage
  ]
  content = templatefile("${path.module}/hosts.tftpl",
    {
      webservers = [for i in yandex_compute_instance.for-web : i]
      databases  = [for k, v in yandex_compute_instance.node : v]
      storages   = tolist([yandex_compute_instance.storage])
    })
  filename = "${abspath(path.module)}/hosts.cfg"
}

resource "null_resource" "web_hosts_provision" {
depends_on = [local_file.hosts_cfg]
  provisioner "local-exec" {
    command = "cat ~/.ssh/id_ed25519 | ssh-add -"
  }
  provisioner "local-exec" {
    command  = "export ANSIBLE_HOST_KEY_CHECKING=False; ansible-playbook -i ${abspath(path.module)}/hosts.cfg ${abspath(path.module)}/test.yml"
    on_failure = continue
    environment = { ANSIBLE_HOST_KEY_CHECKING = "False" }
  }
    triggers = {
      always_run         = "${timestamp()}"
      playbook_src_hash  = file("${abspath(path.module)}/test.yml")
      ssh_public_key     = var.vms_ssh.pub_key
    }

}