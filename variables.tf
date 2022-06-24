variable "credentials" {
  type        = string
  description = "Credentials file"
}

variable "project" {
  type        = string
  description = "Project ID"
  default     = "beaconsco"
}

variable "region" {
  type        = string
  description = "Region"
  default     = "asia-northeast1"
}

variable "zone" {
  type        = string
  description = "Zone"
  default     = "asia-northeast1-c"
}

variable "dns_zones" {
  type = list(object({
    zone_name = string
    dns_name  = string
    ipv4      = string
  }))
  description = "DNS Zones"
  default = [
    {
      zone_name = "terraform-x28-co",
      dns_name  = "x28.co",
      ipv4      = "188.166.198.213",
    },
    {
      zone_name = "terraform-x19-dev",
      dns_name  = "x19.dev",
      ipv4      = "188.166.198.213",
    },
  ]
}
