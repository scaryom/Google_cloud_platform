
terraform {
    required_version = ">= 0.13"
    required_providers {
      google = {   #google plugin
          source = "hashicorp/google"
          version = ">= 3.50"
      }
    }
}

provider "google" {
    region = "asia-south1"
    project = "omprakash-37246"
credentials = file("omprakash-37246-c0bf75ffce90.json")  
}


###############vminstance without empheral ip ##################################
resource "google_compute_instance" "ins-1-tf" {
    name = "ins-1"
    machine_type = "f1-micro"
    zone = "asia-south1-a"
    tags = ["https-server","http-server"]
    boot_disk {
      auto_delete = true
      mode = "READ_WRITE"
      initialize_params {
        size=10
        type="pd-standard"
        image="projects/ubuntu-os-cloud/global/images/ubuntu-1804-bionic-v20220118"

      }
    }
    scheduling {
      preemptible=true
      on_host_maintenance="TERMINATE"
      automatic_restart=false  
    }
    network_interface {
      network="default"
    }   
}

# ###############vminstance with empheral ip ##################################
# resource "google_compute_instance" "ins-2-tf" {
#     name = "ins-2"
#     machine_type = "f1-micro"
#     zone = "asia-south1-a"
#     tags = ["https-server","http-server"]
#     boot_disk {
#       auto_delete = true
#       mode = "READ_WRITE"
#       initialize_params {
#         size=10
#         type="pd-standard"
#         image="projects/ubuntu-os-cloud/global/images/ubuntu-1804-bionic-v20220118"

#       }
#     }
#     scheduling {
#       preemptible=true
#       on_host_maintenance="TERMINATE"
#       automatic_restart=false  
#     }
#     network_interface {
#       network="default"
#       access_config {
        
#       }
#     }   

# }



# #################static ip with vminstance creation#####################
# resource "google_compute_address" "net-ext-1" {
#   name="ext-1"
#   address_type="EXTERNAL"  
# }

# resource "google_compute_instance" "ins-3" {
#   name = "ins-3"
#   machine_type = "f1-micro"
#   tags = [ "https-server","http-server" ]
#   zone="asia-south1-a"
#   boot_disk {
#     auto_delete=true
#     mode="READ_WRITE"
#     initialize_params {
#       size=10
#       type="pd-standard"
#       image="projects/ubuntu-os-cloud/global/images/ubuntu-1804-bionic-v20220118"
#     }
#   }
#   scheduling {
#     automatic_restart=false
#     on_host_maintenance="TERMINATE"
#     preemptible=true
#   }
#   network_interface {
#     network="default"
#     access_config {
#       nat_ip=google_compute_address.net-ext-1.address
#     }
#   }
# }

# ###############################################################

# terraform {
#   required_version= ">=0.13"
#   required_providers{
#       google={
#       source="hashicorp/google"
#       version=">=3.50"
#       }
#   } 
# }
# provider "google" {
#     region = "asia-south1"
#     project = "omprakash-37246"
#     credentials = file("omprakash-37246-c0bf75ffce90.json")  
# }

# resource "google_compute_address" "ext-ip-1" {
#     name = "ext-1"
#     address_type = "EXTERNAL"
# }

# resource "google_storage_bucket" "gcp-bucket-1" {
#     name="gcp18-bucket18-18"
#     location = "asia-south1"
#     uniform_bucket_level_access=true
#     storage_class = "STANDARD"
# }

# resource "google_compute_instance" "ins-1" {
#     name = "ins-1"
#     machine_type = "f1-micro"
#     tags = [ "https-server","http-server" ]
#     zone="asia-south1-a"
#     boot_disk {
#       auto_delete=true
#       mode="READ_WRITE"
#       initialize_params{
#           size=10
#           type="pd-standard"
#           image="projects/ubuntu-os-cloud/global/images/ubuntu-1804-bionic-v20220118"
#       }
#     }
#     scheduling{
#         automatic_restart=false
#         preemptible=true
#         on_host_maintenance="TERMINATE"
#     }
#     network_interface{
#         network="default"
#         access_config{
#             nat_ip=google_compute_address.ext-ip-1.address
#         }
#     }
    
# }

# resource "google_compute_instance_template" "instance_temp-1" {
#     name="ins-temp-1"
#     description = "Create vm instance"
#     tags=["https-server","http-server"]

#     machine_type="f1-micro"
#     scheduling {
#       automatic_restart=false
#       preemptible=true
#       on_host_maintenance="TERMINATE"
#     }
#     disk {
#       auto_delete=true
#       source_image="projects/ubuntu-os-cloud/global/images/ubuntu-1804-bionic-v20220118"
#       boot=true
#       mode="READ_WRITE"
#       disk_size_gb=10
#       disk_type="pd-standard"

#     }
#     network_interface {
#       network="default"
#       access_config {
#       }
#     }
# }

# resource "google_compute_instance_group_manager" "instance_group-1" {
#     name = "ins-grp-1"
#     version {
#       instance_template=google_compute_instance_template.instance_temp-1.id
#     }
#     base_instance_name = "igrp"
#     zone="asia-south1-a"
#     target_size = 3
  
# }
# #sample content
# resource "local_file" "testfile0" {
#   filename = "testfile0.txt"
#   content = "I love terraform edited now "
  
# }
# #senstive content
# resource "local_sensitive_file" "testfile1"{
#   filename = "testfile1.txt"
#   content = "i love terraform edited now"
# }
# #binary content
# resource "local_file" "testfile2" {
#   filename = "testfile2.txt"
#   content_base64 = 01101 
# }

# resource "local_file" "testfile3"{
#   file_permission = 0751
#   filename = "testfile3.txt"
#   content = "hi this om prakash"
# }
