resource "google_compute_network" "custnetwork" {
  name = "${var.project_id}-custnetwork"
  auto_create_subnetworks = false  
}

resource "google_compute_subnetwork" "custsubnetwork1" {
  name="${var.project_id}-custnetwork-subnet-1"
  region="asia-south1"
  network=google_compute_network.custnetwork.name
  ip_cidr_range="10.0.0.0/24"
  
}

resource "google_compute_firewall" "custfirewall"{
  name = "${var.project_id}-firewall"
  network = google_compute_network.custnetwork.name 
  allow {
    protocol = "all"
  }
  source_ranges = [ "10.0.0.0/24" ]
}

resource "google_compute_instance_template" "tmp-1" {
  name = "${var.project_id}-template"
  tags = [ "http-server","https-server" ]
  machine_type="e2-medium"
  disk {
    auto_delete=true 
    boot=true 
    mode="READ_WRITE"
    disk_type="pd-standard"
    disk_size_gb=10
    source_image="ubuntu-os-cloud/ubuntu-1804-bionic-arm64-v20220901"
  }
  scheduling {
    automatic_restart= false
    preemptible=true 
    on_host_maintenance="TERMINATE"
  }
  network_interface {
    network=google_compute_network.custnetwork.id 
    subnetwork= google_compute_subnetwork.custsubnetwork1.id
    access_config{

    }
  }
}

resource "google_compute_instance_group_manager" "custgrp" {
  name="${var.project_id}-grp"
  version{
    instance_template = google_compute_instance_template.tmp-1.id
  }  
  base_instance_name = "${var.project_id}"
  target_size = 2
  zone = "asia-south1-a"
}

resource "google_dns_managed_zone" "prod" {
  name = "${var.project_id}-dns"
  dns_name = "${var.dns_name}"
  visibility = "private"
  private_visibility_config {
    networks {
      network_url = google_compute_network.custnetwork.id
    }
  }
}

resource "google_dns_record_set" "frontend1" {
  name = "frontend1.${google_dns_managed_zone.prod.dns_name}"
  type = "A"
  ttl = 300
  managed_zone = "pras-1213-dns"
  rrdatas = ["10.0.0.2"]
}

resource "google_dns_record_set" "frontend2" {
  name = "frontend2.${google_dns_managed_zone.prod.dns_name}"
  type = "A"
  ttl = 300
  managed_zone = "pras-1213-dns"
  rrdatas = ["10.0.0.3"]
}