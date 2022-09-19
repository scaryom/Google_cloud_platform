resource "google_container_cluster" "cls_1" {
  name                     = "${var.project_id}-cls"
  location                 = var.location
  remove_default_node_pool = true
  initial_node_count       = 1
  enable_shielded_nodes    = true
  release_channel {
    channel = "STABLE"
  }
}

resource "google_container_node_pool" "np_1" {
  name       = "${var.project_id}-np"
  location   = google_container_cluster.cls_1.location
  cluster    = google_container_cluster.cls_1.name
  node_count = 3
  node_config {
    machine_type = "e2-medium"
    disk_size_gb = 10
    disk_type    = "pd-standard"
    preemptible  = true
    tags         = ["hori-scale-test"]
  }
  autoscaling {
    min_node_count = 1
    max_node_count = 3
  }



}