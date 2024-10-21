provider "google" {
  credentials = var.google_credentials
  project     = var.project_id
  region      = var.region
}
data "google_container_engine_versions" "gke_version" {
  location       = var.region
  version_prefix = "1.30."
}
resource "google_container_cluster" "gke_cluster" {
  name               = "gke-cluster"
  location           = var.region
  initial_node_count = 1

  remove_default_node_pool = true
  ip_allocation_policy {}

  node_locations = var.availability_zone_names # Multiple zones for HA

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }
  release_channel {
    channel = var.release_channel # make sure we use stable versions for stability

  }
  logging_service    = "logging.googleapis.com/kubernetes"
  monitoring_service = "monitoring.googleapis.com/kubernetes"
}
# Separately Managed Node Pool - To be able to rebuild the nodes without touching the cluster
resource "google_container_node_pool" "primary_nodes" {
  name     = google_container_cluster.gke_cluster.name
  location = var.region
  cluster  = google_container_cluster.gke_cluster.name

  version = data.google_container_engine_versions.gke_version.latest_node_version
  node_config {
    preemptible  = false
    machine_type = var.node_type
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
    tags = ["wordpress-node", "cost-efficient"]
  }

  autoscaling {
    min_node_count = var.min_node_count
    max_node_count = var.max_node_count
  }

  management {
    auto_upgrade = true
    auto_repair  = true
  }
  node_locations = var.availability_zone_names # Multiple zones for HA
}
