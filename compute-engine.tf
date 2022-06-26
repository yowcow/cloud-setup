data "google_compute_image" "common-image" {
  project = "ubuntu-os-cloud"
  family  = "ubuntu-2204-lts"
}

resource "google_compute_project_default_network_tier" "default" {
  network_tier = "PREMIUM"
}

resource "google_compute_instance" "www-x28" {
  name                      = "www-x28"
  machine_type              = "f1-micro"
  zone                      = var.zone
  allow_stopping_for_update = true

  tags = ["http-server"]

  boot_disk {
    initialize_params {
      image = data.google_compute_image.common-image.self_link
    }
  }

  network_interface {
    network = "default"

    access_config {}
  }

  service_account {
    email  = google_service_account.gce-account.email
    scopes = ["cloud-platform"]
  }
}

resource "google_compute_backend_service" "www-x28" {
  name        = "www-x28-backend-service"
  port_name   = "http"
  protocol    = "HTTP"
  timeout_sec = 5000

  backend {
    group = google_compute_instance_group.www-x28.id
  }

  health_checks = [
    google_compute_health_check.www-x28.id
  ]
}

resource "google_compute_instance_group" "www-x28" {
  name = "www-x28-instance-group"
  zone = var.zone

  instances = [
    google_compute_instance.www-x28.id
  ]

  named_port {
    name = "http"
    port = "80"
  }
}

resource "google_compute_health_check" "www-x28" {
  name                = "www-x28-health-check"
  timeout_sec         = 5
  check_interval_sec  = 10
  healthy_threshold   = 2
  unhealthy_threshold = 5

  tcp_health_check {
    port = "80"
  }

  log_config {
    enable = true
  }
}

resource "google_compute_firewall" "www-x28" {
  name    = "www-x28-firewall"
  network = "default"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["35.191.0.0/16", "130.211.0.0/22"]
  target_tags   = ["http-server"]
}

resource "google_compute_global_address" "www-x28" {
  name = "www-x28-global-address"
}

resource "google_compute_global_forwarding_rule" "www-x28-http" {
  name       = "www-x28-http-forwarding-rule"
  ip_address = google_compute_global_address.www-x28.address
  port_range = "80"
  target     = google_compute_target_http_proxy.www-x28.id
}

resource "google_compute_target_http_proxy" "www-x28" {
  name    = "www-x28-target-http-proxy"
  url_map = google_compute_url_map.www-x28.id
}

resource "google_compute_global_forwarding_rule" "www-x28-https" {
  name       = "www-x28-https-forwarding-rule"
  ip_address = google_compute_global_address.www-x28.address
  port_range = "443"
  target     = google_compute_target_https_proxy.www-x28.id
}

resource "google_compute_target_https_proxy" "www-x28" {
  name             = "www-x28-target-https-proxy"
  url_map          = google_compute_url_map.www-x28.id
  ssl_certificates = [google_compute_managed_ssl_certificate.www-x28.id]
}

resource "google_compute_url_map" "www-x28" {
  name            = "www-x28-load-balancer"
  default_service = google_compute_backend_service.www-x28.id

  host_rule {
    hosts = [
      "test.x28.co",
      "test.x19.dev",
    ]
    path_matcher = "default"
  }

  path_matcher {
    name            = "default"
    default_service = google_compute_backend_service.www-x28.id

    path_rule {
      paths   = ["/*"]
      service = google_compute_backend_service.www-x28.id
    }
  }
}

resource "google_compute_managed_ssl_certificate" "www-x28" {
  name = "www-x28-certificate"

  managed {
    domains = [
      "test.x28.co.",
      "test.x19.dev.",
    ]
  }
}
