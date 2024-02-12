##############################################################################
# Vpc VPC
##############################################################################

resource "ibm_is_vpc" "vpc_vpc" {
  name                        = "${var.prefix}-vpc-vpc"
  resource_group              = var.vpc_rg_id
  tags                        = var.tags
  default_network_acl_name    = null
  default_security_group_name = null
  default_routing_table_name  = null
}

resource "ibm_is_vpc_address_prefix" "vpc_vpc_zone_1_prefix" {
  name = "${var.prefix}-vpc-vpc-zone-1"
  vpc  = ibm_is_vpc.vpc_vpc.id
  zone = "${var.region}-1"
  cidr = "10.10.0.0/16"
}

resource "ibm_is_vpc_address_prefix" "vpc_vpc_zone_2_prefix" {
  name = "${var.prefix}-vpc-vpc-zone-2"
  vpc  = ibm_is_vpc.vpc_vpc.id
  zone = "${var.region}-2"
  cidr = "10.20.0.0/16"
}

resource "ibm_is_vpc_address_prefix" "vpc_vpc_zone_3_prefix" {
  name = "${var.prefix}-vpc-vpc-zone-3"
  vpc  = ibm_is_vpc.vpc_vpc.id
  zone = "${var.region}-3"
  cidr = "10.30.0.0/16"
}

resource "ibm_is_subnet" "vpc_vsi_zone_1" {
  vpc             = ibm_is_vpc.vpc_vpc.id
  name            = "${var.prefix}-vpc-vsi-zone-1"
  zone            = "${var.region}-1"
  resource_group  = var.vpc_rg_id
  tags            = var.tags
  network_acl     = ibm_is_network_acl.vpc_acl_acl.id
  ipv4_cidr_block = "10.10.0.0/29"
  depends_on = [
    ibm_is_vpc_address_prefix.vpc_vpc_zone_1_prefix
  ]
}

resource "ibm_is_subnet" "vpc_vsi_zone_2" {
  vpc             = ibm_is_vpc.vpc_vpc.id
  name            = "${var.prefix}-vpc-vsi-zone-2"
  zone            = "${var.region}-2"
  resource_group  = var.vpc_rg_id
  tags            = var.tags
  network_acl     = ibm_is_network_acl.vpc_acl_acl.id
  ipv4_cidr_block = "10.20.0.0/29"
  depends_on = [
    ibm_is_vpc_address_prefix.vpc_vpc_zone_2_prefix
  ]
}

resource "ibm_is_subnet" "vpc_vsi_zone_3" {
  vpc             = ibm_is_vpc.vpc_vpc.id
  name            = "${var.prefix}-vpc-vsi-zone-3"
  zone            = "${var.region}-3"
  resource_group  = var.vpc_rg_id
  tags            = var.tags
  network_acl     = ibm_is_network_acl.vpc_acl_acl.id
  ipv4_cidr_block = "10.30.0.0/29"
  depends_on = [
    ibm_is_vpc_address_prefix.vpc_vpc_zone_3_prefix
  ]
}

resource "ibm_is_subnet" "vpc_vpe_zone_1" {
  vpc             = ibm_is_vpc.vpc_vpc.id
  name            = "${var.prefix}-vpc-vpe-zone-1"
  zone            = "${var.region}-1"
  resource_group  = var.vpc_rg_id
  tags            = var.tags
  network_acl     = ibm_is_network_acl.vpc_acl_acl.id
  ipv4_cidr_block = "10.10.0.16/29"
  depends_on = [
    ibm_is_vpc_address_prefix.vpc_vpc_zone_1_prefix
  ]
}

resource "ibm_is_subnet" "vpc_vpe_zone_2" {
  vpc             = ibm_is_vpc.vpc_vpc.id
  name            = "${var.prefix}-vpc-vpe-zone-2"
  zone            = "${var.region}-2"
  resource_group  = var.vpc_rg_id
  tags            = var.tags
  network_acl     = ibm_is_network_acl.vpc_acl_acl.id
  ipv4_cidr_block = "10.20.0.16/29"
  depends_on = [
    ibm_is_vpc_address_prefix.vpc_vpc_zone_2_prefix
  ]
}

resource "ibm_is_subnet" "vpc_vpe_zone_3" {
  vpc             = ibm_is_vpc.vpc_vpc.id
  name            = "${var.prefix}-vpc-vpe-zone-3"
  zone            = "${var.region}-3"
  resource_group  = var.vpc_rg_id
  tags            = var.tags
  network_acl     = ibm_is_network_acl.vpc_acl_acl.id
  ipv4_cidr_block = "10.30.0.16/29"
  depends_on = [
    ibm_is_vpc_address_prefix.vpc_vpc_zone_3_prefix
  ]
}

##############################################################################
