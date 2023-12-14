locals {
  rg_name  = "${var.business_unit}-${var.environment}-${var.resoure_group_name}"
  net_name = "${var.business_unit}-${var.environment}-${var.virtual_network_name}"

  service_name = "demo"
  owner        = "Mangesh"
  common_tags = {
    service = local.service_name
    owner   = local.owner
  }
}

