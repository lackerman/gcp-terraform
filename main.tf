resource "google_compute_instance_group" "default" {
  name        = "${var.project_name}-instance-group"
  description = "The default instance group for server instances"
  zone        = "${var.region}-c"
  network     = google_compute_network.default.self_link

  instances = [google_compute_instance.default.*.self_link]

  named_port {
    name = "http"
    port = "8080"
  }

  named_port {
    name = "https"
    port = "443"
  }
}

resource "google_compute_instance" "default" {
  count        = var.num_instances
  name         = "${var.project_name}-${count.index + 1}"
  zone         = "${var.region}-c"
  machine_type = "f1-micro"

  project = var.project_id

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1704"
    }
  }

  network_interface {
    network       = "default"
    access_config = {}
  }

  provisioner "remote-exec" {
    inline = [
      "apt-get update",
      "apt-get upgrade",
      "apt-get install nginx",
    ]
  }
}

output "instance_ids" {
  value = google_compute_instance.default.*.self_link
}