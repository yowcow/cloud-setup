resource "google_project_iam_custom_role" "certbot-renew-role" {
  role_id = "certbot.renewer"
  title   = "Certbot Renew Role"
  permissions = [
    "dns.changes.create",
    "dns.changes.get",
    "dns.changes.list",
    "dns.managedZones.get",
    "dns.managedZones.list",
    "dns.resourceRecordSets.create",
    "dns.resourceRecordSets.delete",
    "dns.resourceRecordSets.list",
    "dns.resourceRecordSets.update",
  ]
}

resource "google_service_account" "certbot-account" {
  account_id   = "terraform-certbot"
  display_name = "Certbot service account"
}

resource "google_service_account_iam_member" "certbot-account-iam" {
  service_account_id = google_service_account.certbot-account.name
  role               = "projects/${var.project}/roles/certbot.renewer"
  member             = "serviceAccount:${google_service_account.certbot-account.email}"
}
