Welcome to my wordpress test code.

This code will deply a gke cluster, a node-pool, and cloudsql.

Steps to deply the code:

git clone <repo>

terraform init

terrafom plan

terraform apply

Expected output when the code is complete:

Expected output terraform kubernetes_cluster_host = "<public-ipaddress>"

kubernetes_cluster_name = "gke-cluster"

node_pool_name = "gke-cluster"

project_id = "<project-name>"

region = "us-central1"
