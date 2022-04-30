resource "google_compute_backend_service" "default" {
  name          = "${var.project_name}-backend-service"
  description   = "Default reverse proxy to internal server utils"
  port_name     = "http"
  protocol      = "HTTP"
  timeout_sec   = 10
  enable_cdn    = false

  backend {
    group = google_compute_instance_group.default.self_link
  }

  health_checks = [
    google_compute_http_health_check.default.self_link
  ]
}

resource "google_compute_http_health_check" "default" {
  name = "${var.project_name}-instance-health-check"
  project = var.project_id
  request_path = "/"
  check_interval_sec = 1
  timeout_sec = 1
}
