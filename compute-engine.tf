resource "google_compute_address" "www-x28" {
  name = "www-x28"
}

resource "google_compute_instance" "www-x28" {
  name         = "www-x28"
  machine_type = "e2-micro"
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
    }
  }

  network_interface {
    network = "default"
    access_config {
      nat_ip = google_compute_address.www-x28.address
    }
  }

  service_account {
    email  = google_service_account.gce-account.email
    scopes = ["cloud-platform"]
  }
}
