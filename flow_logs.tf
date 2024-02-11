##############################################################################
# Flow Logs Resources
##############################################################################

resource "ibm_iam_authorization_policy" "flow_logs_to_object_storage_object_storage_policy" {
  source_service_name         = "is"
  source_resource_type        = "flow-log-collector"
  description                 = "Allow flow logs write access cloud object storage instance"
  target_service_name         = "cloud-object-storage"
  target_resource_instance_id = ibm_resource_instance.object_storage_object_storage.guid
  roles = [
    "Writer"
  ]
}

resource "ibm_is_flow_log" "vpc_flow_log_collector" {
  name           = "${var.prefix}-vpc-vpc-logs"
  target         = module.vpc_vpc.id
  active         = true
  storage_bucket = ibm_cos_bucket.object_storage_object_storage_vpc_bucket_bucket.bucket_name
  resource_group = ibm_resource_group.vpc_rg.id
  tags = [
    "hello",
    "world"
  ]
  depends_on = [
    ibm_iam_authorization_policy.flow_logs_to_object_storage_object_storage_policy
  ]
}

##############################################################################
