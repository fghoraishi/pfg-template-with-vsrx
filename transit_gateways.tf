##############################################################################
# Classic To Router Transit Gateway
##############################################################################

resource "ibm_tg_gateway" "classic_to_router" {
  name           = "${var.prefix}-classic-to-router"
  location       = var.region
  global         = false
  resource_group = ibm_resource_group.service_rg.id
  timeouts {
    create = "30m"
    delete = "30m"
  }
}

##############################################################################

##############################################################################
# Classic To Power Transit Gateway
##############################################################################

resource "ibm_tg_gateway" "classic_to_power" {
  name           = "${var.prefix}-classic-to-power"
  location       = var.region
  global         = false
  resource_group = ibm_resource_group.vpc_rg.id
  timeouts {
    create = "30m"
    delete = "30m"
  }
}

##############################################################################

##############################################################################
# Global Transit Gateway
##############################################################################

resource "ibm_tg_gateway" "global" {
  name           = "${var.prefix}-global"
  location       = var.region
  global         = true
  resource_group = ibm_resource_group.vpc_rg.id
  timeouts {
    create = "30m"
    delete = "30m"
  }
}

##############################################################################
