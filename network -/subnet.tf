resource "google_compute_subnetwork" "sub-custom-vpc-tf" {
  name          = "sub-custom-vpc-tf"
  network       = google_compute_network.custom-vpc-tf.id
  ip_cidr_range = "10.0.0.0/24"
  region        = "asia-south1"
}

output "sub-1" {
  value = google_compute_subnetwork.sub-custom-vpc-tf.id
}