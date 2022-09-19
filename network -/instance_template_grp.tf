resource "google_compute_instance_template" "tmp-1" {
  name         = "tmp-1"
  machine_type = "f1-micro"
  tags         = ["https-server", "http-server"]
  disk {
    auto_delete  = true
    boot         = true
    mode         = "READ_WRITE"
    disk_type    = "pd-standard"
    disk_size_gb = 10
    source_image = "projects/ubuntu-os-cloud/global/images/ubuntu-1804-bionic-v20220118"
  }
  scheduling {
    automatic_restart   = false
    preemptible         = true
    on_host_maintenance = "TERMINATE"
  }
  network_interface {
    network    = google_compute_network.custom-vpc-tf.id
    subnetwork = google_compute_subnetwork.sub-custom-vpc-tf.id
  }
}
resource "google_compute_instance_group_manager" "grp-1" {
  name = "grp-1"
  version {
    instance_template = google_compute_instance_template.tmp-1.id
  }
  base_instance_name = "grp"
  target_size        = 2
  zone               = "asia-south1-a"
}