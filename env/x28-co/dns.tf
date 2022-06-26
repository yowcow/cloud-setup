variable "ip_address" {
  type    = string
  default = "188.166.198.213"
}

resource "google_dns_managed_zone" "zone" {
  name       = "x28-co"
  dns_name   = "x28.co."
  visibility = "public"

  dnssec_config {
    state = "on"
  }
}

resource "google_dns_record_set" "root-a" {
  name         = "x28.co."
  managed_zone = google_dns_managed_zone.zone.name
  type         = "A"
  ttl          = 300
  rrdatas      = [var.ip_address]
}

resource "google_dns_record_set" "all-a" {
  name         = "*.x28.co."
  managed_zone = google_dns_managed_zone.zone.name
  type         = "A"
  ttl          = 300
  rrdatas      = [var.ip_address]
}

resource "google_dns_record_set" "root-mx" {
  name         = "x28.co."
  managed_zone = google_dns_managed_zone.zone.name
  type         = "MX"
  ttl          = 3600
  rrdatas = [
    "5 gmr-smtp-in.l.google.com.",
    "10 alt1.gmr-smtp-in.l.google.com.",
    "20 alt2.gmr-smtp-in.l.google.com.",
    "30 alt3.gmr-smtp-in.l.google.com.",
    "40 alt4.gmr-smtp-in.l.google.com.",
  ]
}
