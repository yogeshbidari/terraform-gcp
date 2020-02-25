provider "google" {
 project     = "fit-parity-253610"
 region      = "${var.region}"
}

resource "google_compute_address" "static-ip" {
  name = "static-ip"
  address_type = "EXTERNAL"
  region = "${var.region}"
}
