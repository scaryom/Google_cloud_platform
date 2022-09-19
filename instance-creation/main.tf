resource "google_compute_instance" "ins-1" {
    name = "ins-1"
    enable_display = true 
    machine_type="f1-micro"
    zone="asia-south1-a"
    boot_disk {
      mode="READ_WRITE"
      auto_delete=true
      initialize_params{
          type="pd-standard"
          size=10
          image="projects/ubuntu-os-cloud/global/images/ubuntu-1804-bionic-v20220118"

      }
    }
    scheduling {
      automatic_restart=false
      preemptible=true 
      on_host_maintenance="TERMINATE"
    }
    network_interface {
      network="default"
      access_config{

      }
    }
}

##attach disk
resource "google_compute_address" "static-1" {
    name="ext-stat-1"
    address_type = "EXTERNAL"
  
}

resource "google_compute_disk" "disk-1" {
    #provider = google-beta
    name="disk-1"
    size=10
    type="pd-ssd"
    zone="asia-south1-a"
    #multi_writer=true

}
resource "google_compute_instance" "ins-2"{
    name="ins-2"
    machine_type = "f1-micro"
    zone="asia-south1-a"
    tags=["https-server","http-server"]
    boot_disk {
      mode="READ_WRITE"
      auto_delete=true
      initialize_params {
        type="pd-standard"
        size=10
        image="projects/ubuntu-os-cloud/global/images/ubuntu-1804-bionic-v20220118"
      }
    }
    scheduling {
      automatic_restart=false
      preemptible=true
      on_host_maintenance="TERMINATE"
    }
    network_interface {
      network="default"
      access_config{
          nat_ip = google_compute_address.static-1.address
      }
    }
    enable_display = true 
 
}
resource "google_compute_attached_disk" "disk-attch-1" {
    disk=google_compute_disk.disk-1.id
    instance = google_compute_instance.ins-2.id
  
}

output "Network-IP" {
    value = google_compute_address.static-1.address
  
}
output "Disk-Size" {
    value= google_compute_disk.disk-1.physical_block_size_bytes
  
}
# resource "google_compute_attached_disk" "disk-attch-2" {
#     disk = google_compute_disk.disk-1.id
#     instance = google_compute_instance.ins-1.id
  
# }