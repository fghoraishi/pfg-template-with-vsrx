##############################################################################
# Image Data Sources
##############################################################################

data "ibm_is_image" "ibm_windows_server_2022_full_standard_amd64_10" {
  name = "ibm-windows-server-2022-full-standard-amd64-10"
}

##############################################################################

##############################################################################
# Vpc VPC Example Deployment Deployment
##############################################################################

resource "ibm_is_instance" "vpc_vpc_example_deployment_vsi_1_1" {
  name           = "${var.prefix}-vpc-example-deployment-vsi-zone-1-1"
  image          = data.ibm_is_image.ibm_windows_server_2022_full_standard_amd64_10.id
  profile        = "bx2-2x8"
  resource_group = ibm_resource_group.vpc_rg.id
  vpc            = module.vpc_vpc.id
  zone           = "${var.region}-1"
  tags = [
    "hello",
    "world"
  ]
  primary_network_interface {
    subnet = module.vpc_vpc.vsi_zone_1_id
    security_groups = [
      module.vpc_vpc.vpc_sg_id
    ]
  }
  boot_volume {
    encryption = ibm_kms_key.kms_cos_key.crn
  }
  keys = [
    ibm_is_ssh_key.ssh_key.id
  ]
  volumes = [
  ]
}

resource "ibm_is_instance" "vpc_vpc_example_deployment_vsi_2_1" {
  name           = "${var.prefix}-vpc-example-deployment-vsi-zone-2-1"
  image          = data.ibm_is_image.ibm_windows_server_2022_full_standard_amd64_10.id
  profile        = "bx2-2x8"
  resource_group = ibm_resource_group.vpc_rg.id
  vpc            = module.vpc_vpc.id
  zone           = "${var.region}-2"
  tags = [
    "hello",
    "world"
  ]
  primary_network_interface {
    subnet = module.vpc_vpc.vsi_zone_2_id
    security_groups = [
      module.vpc_vpc.vpc_sg_id
    ]
  }
  boot_volume {
    encryption = ibm_kms_key.kms_cos_key.crn
  }
  keys = [
    ibm_is_ssh_key.ssh_key.id
  ]
  volumes = [
  ]
}

resource "ibm_is_instance" "vpc_vpc_example_deployment_vsi_3_1" {
  name           = "${var.prefix}-vpc-example-deployment-vsi-zone-3-1"
  image          = data.ibm_is_image.ibm_windows_server_2022_full_standard_amd64_10.id
  profile        = "bx2-2x8"
  resource_group = ibm_resource_group.vpc_rg.id
  vpc            = module.vpc_vpc.id
  zone           = "${var.region}-3"
  tags = [
    "hello",
    "world"
  ]
  primary_network_interface {
    subnet = module.vpc_vpc.vsi_zone_3_id
    security_groups = [
      module.vpc_vpc.vpc_sg_id
    ]
  }
  boot_volume {
    encryption = ibm_kms_key.kms_cos_key.crn
  }
  keys = [
    ibm_is_ssh_key.ssh_key.id
  ]
  volumes = [
  ]
}

##############################################################################
