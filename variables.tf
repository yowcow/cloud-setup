variable "credentials_file" {
  type    = string
  default = ".yowcow-terraformer.json"
}

variable "project" {
  type    = string
  default = "beaconsco"
}

variable "region" {
  type    = string
  default = "asia-northeast1"
}

variable "zone" {
  type    = string
  default = "asia-northeast1-c"
}

variable "dns_zones" {
  type = list(object({
    zone_name = string
    dns_name  = string
    ipv4      = string
  }))
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
