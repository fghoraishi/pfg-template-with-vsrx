##############################################################################
# IBM Cloud Provider
##############################################################################

provider "ibm" {
  ibmcloud_api_key = var.ibmcloud_api_key
  region           = var.region
  ibmcloud_timeout = 60
}

provider "ibm" {
  alias                 = "classic"
  ibmcloud_timeout      = 60
  iaas_classic_username = var.iaas_classic_username
  iaas_classic_api_key  = var.iaas_classic_api_key
}

provider "ibm" {
  alias            = "power_vs_dal10"
  ibmcloud_api_key = var.ibmcloud_api_key
  region           = "us-south"
  zone             = "dal10"
  ibmcloud_timeout = 60
}

##############################################################################

##############################################################################
# Vpc VPC Module
##############################################################################

module "vpc_vpc" {
  source    = "./vpc_vpc"
  region    = var.region
  prefix    = var.prefix
  vpc_rg_id = ibm_resource_group.vpc_rg.id
  tags = [
    "hello",
    "world"
  ]
}

##############################################################################
