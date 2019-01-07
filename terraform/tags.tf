resource "oci_identity_tag_namespace" "tag-namespace1" {
  provider = "oci.oci-ash"
  compartment_id = "${var.compartment_ocid}"
  description    = "${var.tag_namespace_description}"
  name           = "${var.tag_namespace_name}"
}

resource "null_resource" "delay" {
  provisioner "local-exec" {
    command = "sleep 15"
  }
  triggers = {
    "before" = "${oci_identity_tag_namespace.tag-namespace1.id}"
  }
}

resource "oci_identity_tag" "tag1" {
  provider = "oci.oci-ash"
  description      = "tf example tag"
  name             = "tf-example-tag"
  tag_namespace_id = "${oci_identity_tag_namespace.tag-namespace1.id}"
}

resource "oci_identity_tag" "tag2" {
  provider = "oci.oci-ash"
  description      = "tf example tag 2"
  name             = "tf-example-tag-2"
  tag_namespace_id = "${oci_identity_tag_namespace.tag-namespace1.id}"
}