##############################################################################
# Resource Groups
##############################################################################

resource "ibm_resource_group" "service_rg" {
  name = "${var.prefix}-service-rg"
  tags = [
    "hello",
    "world"
  ]
}

resource "ibm_resource_group" "power_rg" {
  name = "${var.prefix}-power-rg"
  tags = [
    "hello",
    "world"
  ]
}

resource "ibm_resource_group" "vpc_rg" {
  name = "${var.prefix}-vpc-rg"
  tags = [
    "hello",
    "world"
  ]
}

##############################################################################
