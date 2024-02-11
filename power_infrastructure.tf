##############################################################################
# Power VS Workspace Prod
##############################################################################

resource "ibm_resource_instance" "power_vs_workspace_prod" {
  provider          = ibm.power_vs_dal10
  name              = "${var.prefix}-power-workspace-prod"
  service           = "power-iaas"
  plan              = "power-virtual-server-group"
  location          = "dal10"
  resource_group_id = ibm_resource_group.power_rg.id
  tags = [
    "hello",
    "world"
  ]
  timeouts {
    create = "6m"
    update = "5m"
    delete = "10m"
  }
}

##############################################################################

##############################################################################
# Prod Workspace SSH Keys
##############################################################################

resource "ibm_pi_key" "power_vs_ssh_key_prod_ssh_key" {
  provider             = ibm.power_vs_dal10
  pi_cloud_instance_id = ibm_resource_instance.power_vs_workspace_prod.guid
  pi_key_name          = "${var.prefix}-power-prod-prod-ssh-key-key"
  pi_ssh_key           = var.power_prod_prod_ssh_key_key
}

##############################################################################

##############################################################################
# Prod Workspace Network
##############################################################################

resource "ibm_pi_network" "power_network_prod_primary" {
  provider             = ibm.power_vs_dal10
  pi_cloud_instance_id = ibm_resource_instance.power_vs_workspace_prod.guid
  pi_network_name      = "${var.prefix}-power-network-primary"
  pi_cidr              = "10.134.1.0/24"
  pi_network_type      = "vlan"
  pi_network_jumbo     = false
  pi_dns = [
    "127.0.0.0"
  ]
}

resource "ibm_pi_network" "power_network_prod_replication" {
  provider             = ibm.power_vs_dal10
  pi_cloud_instance_id = ibm_resource_instance.power_vs_workspace_prod.guid
  pi_network_name      = "${var.prefix}-power-network-replication"
  pi_cidr              = "172.20.50.0/24"
  pi_network_type      = "vlan"
  pi_network_jumbo     = false
  pi_dns = [
    "127.0.0.0"
  ]
  depends_on = [
    ibm_pi_network.power_network_prod_primary
  ]
}

resource "ibm_pi_network" "power_network_prod_i_scsi" {
  provider             = ibm.power_vs_dal10
  pi_cloud_instance_id = ibm_resource_instance.power_vs_workspace_prod.guid
  pi_network_name      = "${var.prefix}-power-network-i-scsi"
  pi_cidr              = "172.20.60.0/24"
  pi_network_type      = "vlan"
  pi_network_jumbo     = false
  pi_dns = [
    "127.0.0.1"
  ]
  depends_on = [
    ibm_pi_network.power_network_prod_replication
  ]
}

##############################################################################

##############################################################################
# Prod Workspace Images
##############################################################################

resource "ibm_pi_image" "power_image_prod_7100_05_09" {
  provider             = ibm.power_vs_dal10
  pi_cloud_instance_id = ibm_resource_instance.power_vs_workspace_prod.guid
  pi_image_id          = "a857bbbd-6fee-4bf7-816d-04fb4cdbf65e"
  pi_image_name        = "7100-05-09"
  timeouts {
    create = "9m"
  }
}

resource "ibm_pi_image" "power_image_prod_7200_05_03" {
  provider             = ibm.power_vs_dal10
  pi_cloud_instance_id = ibm_resource_instance.power_vs_workspace_prod.guid
  pi_image_id          = "0f9818b7-1646-407a-80a1-b2cbf1154549"
  pi_image_name        = "7200-05-03"
  timeouts {
    create = "9m"
  }
  depends_on = [
    ibm_pi_image.power_image_prod_7100_05_09
  ]
}

resource "ibm_pi_image" "power_image_prod_7200_05_05" {
  provider             = ibm.power_vs_dal10
  pi_cloud_instance_id = ibm_resource_instance.power_vs_workspace_prod.guid
  pi_image_id          = "ccbaef35-c26e-40d3-8cc1-10dc34624b65"
  pi_image_name        = "7200-05-05"
  timeouts {
    create = "9m"
  }
  depends_on = [
    ibm_pi_image.power_image_prod_7200_05_03
  ]
}

resource "ibm_pi_image" "power_image_prod_7300_00_01" {
  provider             = ibm.power_vs_dal10
  pi_cloud_instance_id = ibm_resource_instance.power_vs_workspace_prod.guid
  pi_image_id          = "24083f6f-6ab7-4b59-bbd1-3ccb9e24a8db"
  pi_image_name        = "7300-00-01"
  timeouts {
    create = "9m"
  }
  depends_on = [
    ibm_pi_image.power_image_prod_7200_05_05
  ]
}

resource "ibm_pi_image" "power_image_prod_7300_01_01" {
  provider             = ibm.power_vs_dal10
  pi_cloud_instance_id = ibm_resource_instance.power_vs_workspace_prod.guid
  pi_image_id          = "142d55ca-d24c-4114-a2f9-4174e96ed96e"
  pi_image_name        = "7300-01-01"
  timeouts {
    create = "9m"
  }
  depends_on = [
    ibm_pi_image.power_image_prod_7300_00_01
  ]
}

resource "ibm_pi_image" "power_image_prod_ibmi_71_11_2924_6" {
  provider             = ibm.power_vs_dal10
  pi_cloud_instance_id = ibm_resource_instance.power_vs_workspace_prod.guid
  pi_image_id          = "a99343e9-b32e-4a38-85f8-3c1122bb3a0f"
  pi_image_name        = "IBMi-71-11-2924-6"
  timeouts {
    create = "9m"
  }
  depends_on = [
    ibm_pi_image.power_image_prod_7300_01_01
  ]
}

resource "ibm_pi_image" "power_image_prod_ibmi_71_11_2984_6" {
  provider             = ibm.power_vs_dal10
  pi_cloud_instance_id = ibm_resource_instance.power_vs_workspace_prod.guid
  pi_image_id          = "1d93b604-fd7e-4aff-a261-d4d415625ff2"
  pi_image_name        = "IBMi-71-11-2984-6"
  timeouts {
    create = "9m"
  }
  depends_on = [
    ibm_pi_image.power_image_prod_ibmi_71_11_2924_6
  ]
}

resource "ibm_pi_image" "power_image_prod_ibmi_72_09_2924_8" {
  provider             = ibm.power_vs_dal10
  pi_cloud_instance_id = ibm_resource_instance.power_vs_workspace_prod.guid
  pi_image_id          = "e8b83a74-aba7-4ca2-a67a-8437ce7574d3"
  pi_image_name        = "IBMi-72-09-2924-8"
  timeouts {
    create = "9m"
  }
  depends_on = [
    ibm_pi_image.power_image_prod_ibmi_71_11_2984_6
  ]
}

resource "ibm_pi_image" "power_image_prod_ibmi_72_09_2984_8" {
  provider             = ibm.power_vs_dal10
  pi_cloud_instance_id = ibm_resource_instance.power_vs_workspace_prod.guid
  pi_image_id          = "98a65798-af17-482a-9e45-e8c4b42352ba"
  pi_image_name        = "IBMi-72-09-2984-8"
  timeouts {
    create = "9m"
  }
  depends_on = [
    ibm_pi_image.power_image_prod_ibmi_72_09_2924_8
  ]
}

resource "ibm_pi_image" "power_image_prod_ibmi_73_13_2924_1" {
  provider             = ibm.power_vs_dal10
  pi_cloud_instance_id = ibm_resource_instance.power_vs_workspace_prod.guid
  pi_image_id          = "625beea2-e63d-4861-b8d8-fadd229d4c87"
  pi_image_name        = "IBMi-73-13-2924-1"
  timeouts {
    create = "9m"
  }
  depends_on = [
    ibm_pi_image.power_image_prod_ibmi_72_09_2984_8
  ]
}

resource "ibm_pi_image" "power_image_prod_ibmi_73_13_2984_1" {
  provider             = ibm.power_vs_dal10
  pi_cloud_instance_id = ibm_resource_instance.power_vs_workspace_prod.guid
  pi_image_id          = "ad1b1e1e-08f7-40ef-80bc-3f4d6611fec4"
  pi_image_name        = "IBMi-73-13-2984-1"
  timeouts {
    create = "9m"
  }
  depends_on = [
    ibm_pi_image.power_image_prod_ibmi_73_13_2924_1
  ]
}

resource "ibm_pi_image" "power_image_prod_ibmi_74_07_2924_1" {
  provider             = ibm.power_vs_dal10
  pi_cloud_instance_id = ibm_resource_instance.power_vs_workspace_prod.guid
  pi_image_id          = "ee786c60-8b77-4fb8-a8cb-2a9dc47afa45"
  pi_image_name        = "IBMi-74-07-2924-1"
  timeouts {
    create = "9m"
  }
  depends_on = [
    ibm_pi_image.power_image_prod_ibmi_73_13_2984_1
  ]
}

resource "ibm_pi_image" "power_image_prod_ibmi_74_07_2984_1" {
  provider             = ibm.power_vs_dal10
  pi_cloud_instance_id = ibm_resource_instance.power_vs_workspace_prod.guid
  pi_image_id          = "4b584df5-4b58-42f5-a614-6ab4b6fedef3"
  pi_image_name        = "IBMi-74-07-2984-1"
  timeouts {
    create = "9m"
  }
  depends_on = [
    ibm_pi_image.power_image_prod_ibmi_74_07_2924_1
  ]
}

resource "ibm_pi_image" "power_image_prod_ibmi_75_01_2924_2" {
  provider             = ibm.power_vs_dal10
  pi_cloud_instance_id = ibm_resource_instance.power_vs_workspace_prod.guid
  pi_image_id          = "d22a080f-d1b3-4e80-898e-5e8d46cb86ca"
  pi_image_name        = "IBMi-75-01-2924-2"
  timeouts {
    create = "9m"
  }
  depends_on = [
    ibm_pi_image.power_image_prod_ibmi_74_07_2984_1
  ]
}

resource "ibm_pi_image" "power_image_prod_ibmi_75_01_2984_2" {
  provider             = ibm.power_vs_dal10
  pi_cloud_instance_id = ibm_resource_instance.power_vs_workspace_prod.guid
  pi_image_id          = "02f8f2f8-8dfc-4130-88bb-e91105c3d274"
  pi_image_name        = "IBMi-75-01-2984-2"
  timeouts {
    create = "9m"
  }
  depends_on = [
    ibm_pi_image.power_image_prod_ibmi_75_01_2924_2
  ]
}

##############################################################################
