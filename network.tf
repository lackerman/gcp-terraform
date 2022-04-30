resource "google_compute_network" "default" {
  name    = "default-${var.region}"
  project = var.project_id
}

output "network_gateway_ip" {
  value = google_compute_network.default.gateway_ipv4
}
