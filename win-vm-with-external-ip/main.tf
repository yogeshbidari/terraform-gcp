provider "google" {
 project     = "fit-parity-253610"
 region      = "${var.region}"
}

resource "google_compute_address" "int-static-ip" {
  name         = "vm-${random_id.instance_id.hex}-internal-ip"
  subnetwork   = "${var.subnet}"
  address_type = "INTERNAL"
  region       = "${var.region}"
}

resource "google_compute_address" "ext-static-ip" {
  name = "vm-${random_id.instance_id.hex}-external-ip"
  address_type = "EXTERNAL"
  region = "${var.region}"
}

resource "random_id" "instance_id" {
  byte_length = 8
}

resource "google_compute_instance" "default" {
  name         = "vm-${random_id.instance_id.hex}"
  machine_type = "${var.machine_type}"
  zone         = "${var.zone}"

  boot_disk {
    initialize_params {
      image = "${var.image}"
      //type  = "pd-standard"
      //size  = "${var.disk_size}"
    }
  }

  network_interface {
    network = "${var.network}"
    subnetwork = "${var.subnet}"
    network_ip = "${google_compute_address.int-static-ip.address}"
    access_config {
      nat_ip = "${google_compute_address.ext-static-ip.address}"
    }
  }

  // Apply the firewall rule to allow external IPs to access this instance
  tags = ["http-server"]
}
