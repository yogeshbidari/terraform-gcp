output "ip" {
  value = "${google_compute_instance.default.network_interface.0.access_config.0.nat_ip}"
}
output "internal-ip" {
  value = "${google_compute_address.int-static-ip.address}"
}
