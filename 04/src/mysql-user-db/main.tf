resource "yandex_mdb_mysql_database" "db1" {
  cluster_id = var.cluster_id
  name       = var.mysql_db.name
}

resource "yandex_mdb_mysql_user" "client" {
  cluster_id = var.cluster_id
  name       = var.name
  password   = var.user_password
  permission {
    database_name = yandex_mdb_mysql_database.db1.name
    roles         = var.user_roles
  }
}