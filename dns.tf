##############################################################################
# Dns DNS Service
##############################################################################

resource "ibm_resource_instance" "dns_dns_instance" {
  name              = "${var.prefix}-dns-dns-instance"
  resource_group_id = ibm_resource_group.service_rg.id
  location          = "global"
  service           = "dns-svcs"
  plan              = "standard-dns"
}

##############################################################################

##############################################################################
# Dns DNS Custom Resolvers
##############################################################################

resource "ibm_dns_custom_resolver" "dns_dns_instance_resolver_dns_to_vpe" {
  name              = "dns-to-vpe"
  instance_id       = ibm_resource_instance.dns_dns_instance.guid
  description       = ""
  high_availability = true
  enabled           = true
  locations {
    subnet_crn = module.vpc_vpc.vpe_zone_1_crn
    enabled    = true
  }
  locations {
    subnet_crn = module.vpc_vpc.vpe_zone_2_crn
    enabled    = true
  }
  locations {
    subnet_crn = module.vpc_vpc.vpe_zone_3_crn
    enabled    = true
  }
}

##############################################################################
