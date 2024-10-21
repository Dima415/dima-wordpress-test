
variable "project_id" {
  description = "The GCP project ID"
  type        = string
  default     = "devops-takehome-okundima"
}

variable "region" {
  description = "The GCP region"
  type        = string
  default     = "us-central1"
}

variable "cluster_name" {
  description = "The GKE cluster name"
  type        = string
  default     = "dimas-wordpress-cluster"
}

variable "min_node_count" {
  default     = 1
  type        = number
  description = "minimum nodes in pool"
}

variable "max_node_count" {
  default     = 5
  type        = number
  description = "max nodes in pool"
}

variable "node_type" {
  default     = "e2-medium"
  description = "Cost-efficient machine type"
}
variable "google_credentials" {
  description = "Google Cloud credentials in JSON format"
  type        = string
}

variable "availability_zone_names" {
  type    = list(string)
  default = ["us-central1-a", "us-central1-b", "us-central1-c"]
}
variable "release_channel" {
  description = "provide more control over automatic upgrades of your GKE clusters Options include RAPID, REGULAR, and STABLE."
  default     = "STABLE"
}

variable "ip_cidr_range" {
  description = "CIDR range for the subnet"
  type        = string
  default     = "10.0.0.0/16"
}
variable "enable_private_google_access" {
  description = "Enable private access to Google services"
  type        = bool
  default     = true
}