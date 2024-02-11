##############################################################################
# Vpc Acl ACL
##############################################################################

resource "ibm_is_network_acl" "vpc_acl_acl" {
  name           = "${var.prefix}-vpc-acl-acl"
  vpc            = ibm_is_vpc.vpc_vpc.id
  resource_group = var.vpc_rg_id
  tags = [
    "hello",
    "world"
  ]
  rules {
    source      = "161.26.0.0/16"
    action      = "allow"
    destination = "10.0.0.0/8"
    direction   = "inbound"
    name        = "allow-ibm-inbound"
  }
  rules {
    source      = "10.0.0.0/8"
    action      = "allow"
    destination = "161.26.0.0/16"
    direction   = "outbound"
    name        = "allow-ibm-outbound"
  }
  rules {
    source      = "10.0.0.0/8"
    action      = "allow"
    destination = "10.0.0.0/8"
    direction   = "inbound"
    name        = "allow-network-inbound"
  }
  rules {
    source      = "10.0.0.0/8"
    action      = "allow"
    destination = "10.0.0.0/8"
    direction   = "outbound"
    name        = "allow-network-outbound"
  }
}

##############################################################################
