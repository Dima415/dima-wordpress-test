
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
variable "gke_num_nodes" {
  default     = 2
  description = "number of gke nodes"
}