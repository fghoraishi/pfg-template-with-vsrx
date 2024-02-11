##############################################################################
# Gw Classic Gateway
##############################################################################

resource "ibm_network_gateway" "classic_gateway_gw" {
  name = "${var.prefix}-gw"
  members {
    hostname             = "example-com-1"
    domain               = "example.com"
    datacenter           = "dal10"
    network_speed        = "1000"
    private_network_only = false
    tcp_monitoring       = false
    redundant_network    = true
    public_bandwidth     = "5000"
    memory               = "64"
    ipv6_enabled         = false
    private_vlan_id      = ibm_network_vlan.classic_vlan_dal10private.id
    public_vlan_id       = ibm_network_vlan.classic_vlan_dal10_public.id
    package_key_name     = "VIRTUAL_ROUTER_APPLIANCE_1_GPBS"
    os_key_name          = "OS_JUNIPER_VSRX_19_4_UP_TO_1GBPS_STANDARD_SRIOV"
    process_key_name     = "INTEL_XEON_4210_2_20"
    ssh_key_ids = [
      ibm_compute_ssh_key.classic_ssh_key_classic_ssh_key.id
    ]
    disk_key_names = [
      "HARD_DRIVE_2_00_TB_SATA_2"
    ]
  }
}

##############################################################################
