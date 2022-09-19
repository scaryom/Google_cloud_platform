resource "google_container_cluster" "cls" {
    name="${var.project_id}-cls"
    location = var.location
    remove_default_node_pool =  true 
    initial_node_count=1
    release_channel {
      channel="STABLE"
    }
    enable_shielded_nodes =  true 

}

resource "google_container_node_pool" "np" {
    name = "cls-np"
    location = google_container_cluster.cls.location
    cluster = google_container_cluster.cls.name
    node_count = 3
    autoscaling {
      min_node_count=1
      max_node_count=3
    }
    node_config {
      machine_type="e2-medium"
      preemptible=true 
      disk_type="pd-standard"
      disk_size_gb=10
    }
  
}