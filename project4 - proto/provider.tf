/*terraform {
  required_version = ">=0.13"
  required_providers {
    google ={
        source = "hashicorp/google"
        version = ">=4.0"
    }
  }
}

provider "google" {
    region = "location"
    project = "project_id"
    credentials = file("service_file")
  
}
*/
###create statis ip address
/*
resource "google_compute_address" "ext-1" {
    name = "ext-1"
    address_type = "EXTERNAL"
    lifecycle {
      create_before_destroy=true
    }
  
}

resource "google_compute_instance" "ins-1" {
    name = "ins-1"
    zone = "asia-south1-a"
    machine_type = "f1-micro"
    tags=["https-server","http-server"]
    boot_disk {
      auto_delete = true
      mode="READ_WRITE"
      initialize_params {
        size=10
        type="pd-standard"
        image = "projects/ubuntu-os-cloud/global/images/ubuntu-1804-bionic-v20220118"
      }
    }
    scheduling {
      automatic_restart=false
      preemptible=true
      on_host_maintenance = "TERMINATE"

    }
    network_interface {
      network="default"
      access_config {
        nat_ip = google_compute_address.ext-1.address
      }
    }

  
}
*/

terraform {
  required_version = ">=0.13"
  required_providers {
      google={
    source="hashicorp/google"
    version=">=4.0"
  }
}
}

provider "google" {
    region="asia-south1"
    project = "omprakash-37246"
    credentials = file("omprakash-37246-c0bf75ffce90.json")
  
}

# resource "google_compute_instance_template" "temp-1" {
#     name="temp-1"
#     description = "Create a vm instances"
#     tags=["https-server","http-server"]
#     machine_type = "f1-micro"
#     scheduling {
#         preemptible=true
#         automatic_restart=false
#         on_host_maintenance = true
#     }   
#     disk {
#       auto_delete = true
#       boot=true
#       source_image = "projects/ubuntu-os-cloud/global/images/ubuntu-1804-bionic-v20220118"
#       mode="READ_WRITE"
#       disk_size_gb = 10
#       disk_type = "pd-standard"
#     }
#     network_interface {
#       network="default"
#       access_config{

#       }
#     }
#     lifecycle {
#       #prevent_destroy=true
#     }
# }
# resource "google_compute_instance_group_manager" "group_frm_temp-1" {
#     name="insgrp-1"
#     version {
#       instance_template = google_compute_instance_template.temp-1.id
#     }
#     base_instance_name = "frmgrptemp"
#     zone="asia-south1-a"
#     target_size = 4
    
# }

