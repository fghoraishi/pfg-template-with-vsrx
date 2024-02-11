##############################################################################
# Security Group Vpc Sg
##############################################################################

resource "ibm_is_security_group" "vpc_vpc_vpc_sg_sg" {
  name           = "${var.prefix}-vpc-vpc-sg-sg"
  vpc            = ibm_is_vpc.vpc_vpc.id
  resource_group = var.vpc_rg_id
  tags = [
    "hello",
    "world"
  ]
}

resource "ibm_is_security_group_rule" "vpc_vpc_vpc_sg_sg_rule_allow_ibm_inbound" {
  group     = ibm_is_security_group.vpc_vpc_vpc_sg_sg.id
  remote    = "161.26.0.0/16"
  direction = "inbound"
}

resource "ibm_is_security_group_rule" "vpc_vpc_vpc_sg_sg_rule_allow_ibm_outbound" {
  group     = ibm_is_security_group.vpc_vpc_vpc_sg_sg.id
  remote    = "161.26.0.0/16"
  direction = "outbound"
}

resource "ibm_is_security_group_rule" "vpc_vpc_vpc_sg_sg_rule_allow_network_inbound" {
  group     = ibm_is_security_group.vpc_vpc_vpc_sg_sg.id
  remote    = "10.0.0.0/8"
  direction = "inbound"
}

resource "ibm_is_security_group_rule" "vpc_vpc_vpc_sg_sg_rule_allow_network_outbound" {
  group     = ibm_is_security_group.vpc_vpc_vpc_sg_sg.id
  remote    = "10.0.0.0/8"
  direction = "inbound"
}

##############################################################################
