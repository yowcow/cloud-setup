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
  default     = "us-west1"
}

variable "zone" {
  type        = string
  description = "Zone"
  default     = "us-west1-c"
}
