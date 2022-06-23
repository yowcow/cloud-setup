resource "google_storage_bucket" "personal-storage" {
  name                        = "yowcow-personal"
  location                    = "asia-northeast1"
  storage_class               = "NEARLINE"
  uniform_bucket_level_access = true
}
