provider "google" {
  credentials = file("/Users/dimaokun/Code/terraform-key.json")
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

  remove_default_node_pool = true # Remove default node pool

  ip_allocation_policy {} # Enable VPC-native (IP aliasing)

  node_locations = ["us-central1-a", "us-central1-b", "us-central1-c"] # Multiple zones for HA

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }
  release_channel {
  channel = "STABLE"  # Options: RAPID, REGULAR, STABLE
  
  }    
  logging_service    = "logging.googleapis.com/kubernetes"
  monitoring_service = "monitoring.googleapis.com/kubernetes"  
}
# Separately Managed Node Pool - To be able to rebuild the nodes without touch the cluster
resource "google_container_node_pool" "primary_nodes" {
  name     = google_container_cluster.gke_cluster.name
  location = var.region
  cluster  = google_container_cluster.gke_cluster.name

  version = data.google_container_engine_versions.gke_version.latest_node_version
  node_config {
    preemptible  = true        # Use preemptible VMs for cost savings
    machine_type = "e2-medium" # Cost-efficient machine type

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]

    labels = {
      environment = "production"
    }

    tags = ["wordpress-node", "cost-efficient"]
  }

  autoscaling {
    min_node_count = 1
    max_node_count = 5
  }

  management {
    auto_upgrade = true
    auto_repair  = true
  }

  initial_node_count = 1

  node_locations = ["us-central1-a", "us-central1-b", "us-central1-c"] # Multiple zones
}