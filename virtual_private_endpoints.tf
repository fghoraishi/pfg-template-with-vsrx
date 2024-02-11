##############################################################################
# Vpc VPE Resources
##############################################################################

resource "ibm_is_subnet_reserved_ip" "vpc_vpc_vpe_zone_1_subnet_vpe_ip" {
  subnet = module.vpc_vpc.vpe_zone_1_id
}

resource "ibm_is_subnet_reserved_ip" "vpc_vpc_vpe_zone_2_subnet_vpe_ip" {
  subnet = module.vpc_vpc.vpe_zone_2_id
}

resource "ibm_is_subnet_reserved_ip" "vpc_vpc_vpe_zone_3_subnet_vpe_ip" {
  subnet = module.vpc_vpc.vpe_zone_3_id
}

resource "ibm_is_virtual_endpoint_gateway" "vpc_vpc_cos_vpe_gateway" {
  name           = "${var.prefix}-vpc-cos-vpe-gw"
  vpc            = module.vpc_vpc.id
  resource_group = ibm_resource_group.vpc_rg.id
  tags = [
    "hello",
    "world"
  ]
  security_groups = [
    module.vpc_vpc.vpc_sg_id
  ]
  target {
    crn           = "crn:v1:bluemix:public:cloud-object-storage:global:::endpoint:s3.direct.${var.region}.cloud-object-storage.appdomain.cloud"
    resource_type = "provider_cloud_service"
  }
}

resource "ibm_is_virtual_endpoint_gateway_ip" "vpc_vpc_cos_gw_vpe_zone_1_gateway_ip" {
  gateway     = ibm_is_virtual_endpoint_gateway.vpc_vpc_cos_vpe_gateway.id
  reserved_ip = ibm_is_subnet_reserved_ip.vpc_vpc_vpe_zone_1_subnet_vpe_ip.reserved_ip
}

resource "ibm_is_virtual_endpoint_gateway_ip" "vpc_vpc_cos_gw_vpe_zone_2_gateway_ip" {
  gateway     = ibm_is_virtual_endpoint_gateway.vpc_vpc_cos_vpe_gateway.id
  reserved_ip = ibm_is_subnet_reserved_ip.vpc_vpc_vpe_zone_2_subnet_vpe_ip.reserved_ip
}

resource "ibm_is_virtual_endpoint_gateway_ip" "vpc_vpc_cos_gw_vpe_zone_3_gateway_ip" {
  gateway     = ibm_is_virtual_endpoint_gateway.vpc_vpc_cos_vpe_gateway.id
  reserved_ip = ibm_is_subnet_reserved_ip.vpc_vpc_vpe_zone_3_subnet_vpe_ip.reserved_ip
}

##############################################################################
