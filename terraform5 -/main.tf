

resource "google_container_cluster" "cluster" {
    name = "${var.project_id}-cluster"
    location = var.region
    remove_default_node_pool =  true 
    initial_node_count=1

}

resource "google_container_node_pool" "np" {
    name = "${var.project_id}-np"
    location = google_container_cluster.cluster.location 
    cluster = google_container_cluster.cluster.name
    node_count = 2
    node_config {
      machine_type="e2-medium"
      preemptible=true 
    }
    autoscaling {
      min_node_count=2
      max_node_count = 3
    }
}