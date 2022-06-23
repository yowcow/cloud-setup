resource "google_dns_managed_zone" "zone" {
  for_each = { for i in var.dns_zones : i.zone_name => i }

  name       = each.value.zone_name
  dns_name   = "${each.value.dns_name}."
  visibility = "public"

  dnssec_config {
    state = "on"
  }
}

resource "google_dns_record_set" "root-a" {
  for_each = { for i in var.dns_zones : i.zone_name => i }

  name         = "${each.value.dns_name}."
  managed_zone = each.value.zone_name
  type         = "A"
  ttl          = 300
  rrdatas = [
    each.value.ipv4,
  ]
}

resource "google_dns_record_set" "all-a" {
  for_each = { for i in var.dns_zones : i.zone_name => i }

  name         = "*.${each.value.dns_name}."
  managed_zone = each.value.zone_name
  type         = "A"
  ttl          = 300
  rrdatas = [
    each.value.ipv4,
  ]
}

resource "google_dns_record_set" "root-mx" {
  for_each = { for i in var.dns_zones : i.zone_name => i }

  name         = "${each.value.dns_name}."
  managed_zone = each.value.zone_name
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
