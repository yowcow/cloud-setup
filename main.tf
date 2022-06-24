terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.26.0"
    }
  }

  backend "gcs" {
    bucket = "yowcow-terraform"
  }
}

provider "google" {
  credentials = file(var.credentials_file)
  project     = var.project
  region      = var.region
  zone        = var.zone
}
