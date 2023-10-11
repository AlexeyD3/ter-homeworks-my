locals {
  host_count = "${var.config_cluster == true ? 3 : 1}"
}