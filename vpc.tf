# VPC
resource "google_compute_network" "vpc" {
  name                     = "${var.project_id}-vpc"
  auto_create_subnetworks  = "false"
  enable_ula_internal_ipv6 = true
}

# Subnet
resource "google_compute_subnetwork" "subnet" {
  name                     = "${var.project_id}-subnet"
  region                   = var.region
  ip_cidr_range            = var.ip_cidr_range
  network                  = google_compute_network.vpc.id
  stack_type               = "IPV4_IPV6"
  ipv6_access_type         = "EXTERNAL"
  private_ip_google_access = var.enable_private_google_access
  secondary_ip_range {
    range_name    = "services-range" #e.g datastores
    ip_cidr_range = "192.168.0.0/24"
  }

  secondary_ip_range {
    range_name    = "pod-ranges"
    ip_cidr_range = "192.168.1.0/24"
  }
}
