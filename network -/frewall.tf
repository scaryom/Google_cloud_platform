resource "google_compute_firewall" "firewall-custom-vpc-tf" {
  name    = "firewall-custom-vpc-tf"
  network = google_compute_network.custom-vpc-tf.id
  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
  allow {
    protocol = "udp"
  }
  allow {
    protocol = "icmp"
  }
  source_ranges = ["10.0.0.0/24"]
}