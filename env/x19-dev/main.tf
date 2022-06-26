terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.26.0"
    }
  }
  backend "gcs" {
    bucket = "yowcow-terraform"
    prefix = "terraform-x19-dev/state"
  }
}

provider "google" {
  credentials = file(var.credentials)
  project     = var.project
  region      = var.region
  zone        = var.zone
}
