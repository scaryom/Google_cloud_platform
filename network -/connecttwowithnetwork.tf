resource "google_compute_instance" "ins-1" {
  name         = "ins-1"
  machine_type = "f1-micro"
  tags         = ["https-server", "http-server"]
  zone         = "asia-south1-a"
  boot_disk {
    mode        = "READ_WRITE"
    auto_delete = true
    initialize_params {
      image = "projects/ubuntu-os-cloud/global/images/ubuntu-1804-bionic-v20220118"
      size  = 10
      type  = "pd-standard"
    }
  }
  scheduling {
    preemptible         = true
    automatic_restart   = false
    on_host_maintenance = "TERMINATE"
  }
  network_interface {
    network    = google_compute_network.custom-vpc-tf.id
    subnetwork = google_compute_subnetwork.sub-custom-vpc-tf.id
  }

}

