locals {
  web     = "${var.name.company}-${var.name.stage}-${var.name.app}-web"
  node    = "${var.name.company}-${var.name.stage}-${var.name.app}"
  storage = "${var.name.company}-${var.name.stage}-${var.name.app}-storage"
}

