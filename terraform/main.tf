variable "compartment_ocid" {}
variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "private_key_password" {}
variable "region" {}

provider "oci" {
  tenancy_ocid = "${var.tenancy_ocid}"
  user_ocid = "${var.user_ocid}"
  fingerprint = "${var.fingerprint}"
  private_key_path = "${var.private_key_path}"
  private_key_password = "${var.private_key_password}"
  region = "${var.region}"
}

data "oci_identity_availability_domains" "ads" {
  compartment_id = "${var.compartment_ocid}"
}

data "oci_containerengine_clusters" "test_clusters" {
    compartment_id = "${var.compartment_ocid}"
}

# Output the result
output "show-ads" {
  value = "${data.oci_identity_availability_domains.ads.availability_domains}"
}

output "test" {
  value = "${data.oci_identity_availability_domains.ads.availability_domains.0.compartment_id}"
}

output "test2" {
  value = "${data.oci_containerengine_clusters.test_clusters.clusters}"
}

