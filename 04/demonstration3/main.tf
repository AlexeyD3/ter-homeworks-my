terraform{

}
provider "vault" {
    address = "http://127.0.0.1:8200"
    skip_tls_verify = true
    token = "education"
}

resource "vault_generic_secret" "vault_write_ip" {
  path    = "secret/example_ip"
  data_json = <<EOT
{
  "ip": "192.168.2.15"
}
EOT
}

data "vault_generic_secret" "vault_write_ip" {
  depends_on = [vault_generic_secret.vault_write_ip]
  path = "secret/example_ip"
}

output "vault_write_ip" {
  depends_on = [data.vault_generic_secret.vault_write_ip]
  value = "${nonsensitive(data.vault_generic_secret.vault_write_ip.data.ip)}"
}

resource "vault_generic_secret" "vault_write_pswd" {
  path    = "secret/example"
  data_json = <<EOT
{
  "mysql_user_password": "netology2"
}
EOT
}

data "vault_generic_secret" "vault_write_pswd" {
  depends_on = [vault_generic_secret.vault_write_pswd]
  path = "secret/example"
}

output "vault_write_pswd" {
  depends_on = [data.vault_generic_secret.vault_write_pswd]
  value = "${nonsensitive(data.vault_generic_secret.vault_write_pswd.data.mysql_user_password)}"
}

