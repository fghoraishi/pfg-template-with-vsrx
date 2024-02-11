##############################################################################
# SSH Keys
##############################################################################

resource "ibm_is_ssh_key" "ssh_key" {
  name           = "${var.prefix}-ssh-key"
  public_key     = var.ssh_key_public_key
  resource_group = ibm_resource_group.vpc_rg.id
  tags = [
    "hello",
    "world"
  ]
}

##############################################################################
