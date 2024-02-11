##############################################################################
# Key Management Instance Kms
##############################################################################

resource "ibm_resource_instance" "kms" {
  name              = "${var.prefix}-kms"
  resource_group_id = ibm_resource_group.service_rg.id
  service           = "kms"
  plan              = "tiered-pricing"
  location          = var.region
  tags = [
    "hello",
    "world"
  ]
}

resource "ibm_kms_key_rings" "kms__ring" {
  key_ring_id = "${var.prefix}-kms"
  instance_id = ibm_resource_instance.kms.guid
}

resource "ibm_kms_key" "kms_cos_key" {
  instance_id   = ibm_resource_instance.kms.guid
  key_name      = "${var.prefix}-kms-cos"
  standard_key  = false
  key_ring_id   = ibm_kms_key_rings.kms__ring.key_ring_id
  force_delete  = false
  endpoint_type = "public"
}

resource "ibm_kms_key_policies" "kms_cos_key_policy" {
  instance_id   = ibm_resource_instance.kms.guid
  endpoint_type = "public"
  key_id        = ibm_kms_key.kms_cos_key.key_id
  rotation {
    interval_month = 1
  }
  dual_auth_delete {
    enabled = false
  }
}

resource "ibm_kms_key" "kms_atracker_key" {
  instance_id   = ibm_resource_instance.kms.guid
  key_name      = "${var.prefix}-kms-atracker"
  standard_key  = false
  key_ring_id   = ibm_kms_key_rings.kms__ring.key_ring_id
  force_delete  = false
  endpoint_type = "public"
}

resource "ibm_kms_key_policies" "kms_atracker_key_policy" {
  instance_id   = ibm_resource_instance.kms.guid
  endpoint_type = "public"
  key_id        = ibm_kms_key.kms_atracker_key.key_id
  rotation {
    interval_month = 1
  }
  dual_auth_delete {
    enabled = false
  }
}

##############################################################################

