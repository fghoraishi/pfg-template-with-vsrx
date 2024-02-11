##############################################################################
# Dal 10 VLANs
##############################################################################

resource "ibm_network_vlan" "classic_vlan_dal10private" {
  provider   = ibm.classic
  name       = "${var.prefix}-dal10private"
  datacenter = "dal10"
  type       = "PRIVATE"
  tags = [
    "hello",
    "world"
  ]
}

##############################################################################

##############################################################################
# Us South VLANs
##############################################################################

resource "ibm_network_vlan" "classic_vlan_dal10_public" {
  provider   = ibm.classic
  name       = "${var.prefix}-dal10-public"
  datacenter = "us-south"
  type       = "PUBLIC"
  tags = [
    "hello",
    "world"
  ]
}

##############################################################################

##############################################################################
# Classic SSH Keys
##############################################################################

resource "ibm_compute_ssh_key" "classic_ssh_key_classic_ssh_key" {
  provider   = ibm.classic
  label      = "classic-ssh-key"
  public_key = var.classic_classic_ssh_key_public_key
}

##############################################################################
