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
#Ждем создания инстанса
depends_on = [local_file.hosts_cfg]

#Добавление ПРИВАТНОГО ssh ключа в ssh-agent
  provisioner "local-exec" {
    command = "cat ~/.ssh/id_ed25519 | ssh-add -"
  }

#Костыль!!! Даем ВМ 60 сек на первый запуск. Лучше выполнить это через wait_for port 22 на стороне ansible
# В случае использования cloud-init может потребоваться еще больше времени
#  provisioner "local-exec" {
#    command = "sleep 60"
#  }

#Запуск ansible-playbook
  provisioner "local-exec" {
    command  = "export ANSIBLE_HOST_KEY_CHECKING=False; ansible-playbook -i ${abspath(path.module)}/hosts.cfg ${abspath(path.module)}/test.yml"
    on_failure = continue #Продолжить выполнение terraform pipeline в случае ошибок
    environment = { ANSIBLE_HOST_KEY_CHECKING = "False" }
    #срабатывание триггера при изменении переменных
  }
    triggers = {
      always_run         = "${timestamp()}" #всегда т.к. дата и время постоянно изменяются
      playbook_src_hash  = file("${abspath(path.module)}/test.yml") # при изменении содержимого playbook файла
      ssh_public_key     = var.vms_ssh.pub_key # при изменении переменной
    }

}