resource "google_compute_instance" "ins-1" {
    name="ins-1"
    machine_type = "f1-micro"
    tags=["https-server","http-server"]
    zone="asia-south1-a"
    boot_disk {
      mode="READ_WRITE"
      auto_delete = true
      initialize_params {
          size=10
          type="pd-standard"
          image="projects/ubuntu-os-cloud/global/images/ubuntu-1804-bionic-v20220118"  
      } 
    }
    scheduling {
      automatic_restart=false 
      preemptible=true 
      on_host_maintenance=true
    }
    network_interface {
      network="default"
      access_config{

      }
    }
}

resource "google_compute_disk" "disk-1" {
    name = "disk-1"
    size=200
    type="pd-standard"
    zone="asia-south1-a"
}

resource "google_compute_attached_disk" "disk_attch-1" {
    instance = google_compute_instance.ins-1.id
    disk = google_compute_disk.disk-1.id
}