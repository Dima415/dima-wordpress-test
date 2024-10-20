
variable "project_id" {
  description = "The GCP project ID"
  type        = string
  default     = "<ENTER-PROJECT-NAME>"
}

variable "region" {
  description = "The GCP region"
  type        = string
  default     = "us-central1"
}

variable "cluster_name" {
  description = "The GKE cluster name"
  type        = string
  default     = "wordpress-cluster"
}
variable "gke_num_nodes" {
  default     = 2
  description = "number of gke nodes"
}