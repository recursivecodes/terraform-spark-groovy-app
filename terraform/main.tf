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

