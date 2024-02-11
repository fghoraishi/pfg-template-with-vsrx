##############################################################################
# LogDNA Instance
##############################################################################

resource "ibm_resource_instance" "logdna" {
  name              = "${var.prefix}-logdna"
  resource_group_id = ibm_resource_group.service_rg.id
  service           = "logdna"
  plan              = "14-day"
  location          = var.region
  service_endpoints = "public"
  tags = [
    "hello",
    "world"
  ]
}

resource "ibm_resource_key" "logdna_key" {
  name                 = "${var.prefix}-logdna-key"
  resource_instance_id = ibm_resource_instance.logdna.id
  tags = [
    "hello",
    "world"
  ]
}

##############################################################################

##############################################################################
# Sysdig Instance
##############################################################################

resource "ibm_resource_instance" "sysdig" {
  name              = "${var.prefix}-sysdig"
  resource_group_id = ibm_resource_group.service_rg.id
  service           = "sysdig-monitor"
  plan              = "graduated-tier"
  location          = var.region
  service_endpoints = "public"
  tags = [
    "hello",
    "world"
  ]
}

resource "ibm_resource_key" "sysdig_key" {
  name                 = "${var.prefix}-sysdig-key"
  resource_instance_id = ibm_resource_instance.sysdig.id
  role                 = "Manager"
  tags = [
    "hello",
    "world"
  ]
}

##############################################################################
