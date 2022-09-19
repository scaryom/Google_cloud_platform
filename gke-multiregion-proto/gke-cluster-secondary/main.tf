terraform {
  required_providers {
    google = {
      version = "3.63.0"
      source  = "hashicorp/google"
    }
  }
}

provider "google" {
  #region = "asia-south1"
  project     = var.project_id
  credentials = file("service_file")
}
resource "google_container_cluster" "secondary" {
  name             = "${var.project_id}-sec-cluster"
  location         = var.region
  network          = var.vpc_name
  subnetwork       = var.subnet_name
  enable_autopilot = true
  release_channel {
    channel = "STABLE"
  }
  node_locations = ["europe-west2-a", "europe-west2-b"]

}