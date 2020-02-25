output "internal-ip" {
  value = "${google_compute_address.int-static-ip.address}"
}
