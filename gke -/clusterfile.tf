resource "google_container_cluster" "gke-1" {
  name                     = "gke-1"
  location                 = "asia-south1"
  remove_default_node_pool = true
  initial_node_count       = 1

}

resource "google_container_node_pool" "node-pool-1" {
  name       = "node-pool-1"
  location   = "asia-south1"
  cluster    = google_container_cluster.gke-1.name
  node_count = 1
  autoscaling {
    max_node_count = 4
    min_node_count = 2
  }
  
  node_config {
    preemptible  = true
    machine_type = "e2-medium"

  }

}