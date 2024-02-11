##############################################################################
# Object Storage Instance Object Storage
##############################################################################

resource "random_string" "object_storage_random_suffix" {
  length  = 8
  special = false
  upper   = false
}

resource "ibm_resource_instance" "object_storage_object_storage" {
  name              = "${var.prefix}-object-storage-object-storage-${random_string.object_storage_random_suffix.result}"
  resource_group_id = ibm_resource_group.service_rg.id
  service           = "cloud-object-storage"
  location          = "global"
  plan              = "standard"
  tags = [
    "hello",
    "world"
  ]
}

resource "ibm_iam_authorization_policy" "object_storage_cos_to_kms_kms_policy" {
  source_service_name         = "cloud-object-storage"
  source_resource_instance_id = ibm_resource_instance.object_storage_object_storage.guid
  description                 = "Allow COS instance to read from KMS instance"
  target_service_name         = "kms"
  target_resource_instance_id = ibm_resource_instance.kms.guid
  roles = [
    "Reader"
  ]
}

resource "ibm_cos_bucket" "object_storage_object_storage_vpc_bucket_bucket" {
  bucket_name          = "${var.prefix}-object-storage-vpc-bucket-${random_string.object_storage_random_suffix.result}"
  resource_instance_id = ibm_resource_instance.object_storage_object_storage.id
  storage_class        = "standard"
  endpoint_type        = "public"
  force_delete         = false
  region_location      = var.region
  key_protect          = ibm_kms_key.kms_cos_key.crn
  depends_on = [
    ibm_iam_authorization_policy.object_storage_cos_to_kms_kms_policy
  ]
}

resource "ibm_cos_bucket" "object_storage_object_storage_logging_bucket" {
  bucket_name          = "${var.prefix}-object-storage-logging-${random_string.object_storage_random_suffix.result}"
  resource_instance_id = ibm_resource_instance.object_storage_object_storage.id
  storage_class        = "standard"
  endpoint_type        = "public"
  force_delete         = false
  region_location      = var.region
  key_protect          = ibm_kms_key.kms_cos_key.crn
  depends_on = [
    ibm_iam_authorization_policy.object_storage_cos_to_kms_kms_policy
  ]
}

##############################################################################

##############################################################################
# Object Storage Instance Atracker
##############################################################################

resource "random_string" "atracker_random_suffix" {
  length  = 8
  special = false
  upper   = false
}

resource "ibm_resource_instance" "atracker_object_storage" {
  name              = "${var.prefix}-atracker-object-storage-${random_string.atracker_random_suffix.result}"
  resource_group_id = ibm_resource_group.service_rg.id
  service           = "cloud-object-storage"
  location          = "global"
  plan              = "standard"
  tags = [
    "hello",
    "world"
  ]
}

resource "ibm_iam_authorization_policy" "atracker_cos_to_kms_kms_policy" {
  source_service_name         = "cloud-object-storage"
  source_resource_instance_id = ibm_resource_instance.atracker_object_storage.guid
  description                 = "Allow COS instance to read from KMS instance"
  target_service_name         = "kms"
  target_resource_instance_id = ibm_resource_instance.kms.guid
  roles = [
    "Reader"
  ]
}

resource "ibm_cos_bucket" "atracker_object_storage_atracker_bucket_bucket" {
  bucket_name          = "${var.prefix}-atracker-atracker-bucket-${random_string.atracker_random_suffix.result}"
  resource_instance_id = ibm_resource_instance.atracker_object_storage.id
  storage_class        = "standard"
  endpoint_type        = "public"
  force_delete         = false
  region_location      = var.region
  key_protect          = ibm_kms_key.kms_atracker_key.crn
  depends_on = [
    ibm_iam_authorization_policy.atracker_cos_to_kms_kms_policy
  ]
}

resource "ibm_resource_key" "atracker_object_storage_key_atracker_key" {
  name                 = "${var.prefix}-atracker-key-atracker-key-${random_string.atracker_random_suffix.result}"
  resource_instance_id = ibm_resource_instance.atracker_object_storage.id
  role                 = "Writer"
  tags = [
    "hello",
    "world"
  ]
}

##############################################################################

