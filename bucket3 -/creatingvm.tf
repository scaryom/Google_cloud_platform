resource "google_compute_address" "ext-1" {
  name         = "ext-1"
  address_type = "EXTERNAL"

}

resource "google_compute_instance" "ins-1" {
  name         = "ins-1"
  machine_type = "f1-micro"
  zone         = "asia-south1-a"
  tags         = ["https-server", "http-server"]
  boot_disk {
    auto_delete = true
    mode        = "READ_WRITE"
    initialize_params {
      size  = 10
      image = "projects/ubuntu-os-cloud/global/images/ubuntu-1804-bionic-v20220118"
      type  = "pd-standard"
    }

  }
  scheduling {
    automatic_restart   = false
    preemptible         = true
    on_host_maintenance = "TERMINATE"
  }
  shielded_instance_config {
    enable_vtpm        = true
    enable_secure_boot = false

  }
  network_interface {
    network = "default"
    access_config {
      nat_ip = google_compute_address.ext-1.address

    }
  }

}

resource "google_compute_instance" "ins-2" {
  name         = "ins-2"
  machine_type = "f1-micro"
  zone         = "asia-south1-b"
  tags         = ["https-server", "http-server"]
  boot_disk {
    auto_delete = true
    mode        = "READ_WRITE"
    initialize_params {
      size  = 10
      type  = "pd-standard"
      image = "projects/ubuntu-os-cloud/global/images/ubuntu-1804-bionic-v20220118"
    }

  }
  scheduling {
    automatic_restart   = false
    preemptible         = true
    on_host_maintenance = "TERMINATE"
  }
  network_interface {
    network = "default"
    access_config {

    }
  }
  shielded_instance_config {
    enable_vtpm        = true
    enable_secure_boot = true
  }
  metadata_startup_script = file("~/Desktop/terraform/script/test.sh")


}



resource "google_compute_instance_template" "tmp-1" {
  name         = "tmp-1"
  machine_type = "f1-micro"
  tags         = ["https-server", "http-sever"]
  network_interface {
    network = "default"
    access_config {
    }
  }
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
  metadata_startup_script = file("~/Desktop/terraform/script/test.sh")
}

resource "google_compute_instance_group_manager" "grp_from_tmp_1" {
  name = "insgrp"
  version {
    instance_template = google_compute_instance_template.tmp-1.id
  }
  base_instance_name = "grp"
  zone               = "asia-south1-a"
  target_size        = 2
}



resource "google_storage_bucket" "bucket-1" {
    name = "gcp_buc_1213"
    uniform_bucket_level_access = true
    storage_class = "STANDARD"
    location = "asia-south1"
    force_destroy = true
    labels = {
      "bucket" = "test_bucket"
    }
    lifecycle_rule {
      action {
        type = "SetStorageClass"
        storage_class = "ARCHIVE"
      }
      condition {
        age = 1
        matches_storage_class = [ "STANDARD" ]

      }
    }
}
resource "google_storage_bucket_object" "obj-1" {
  name   = "output"
  source = "output.jpeg"
  bucket = google_storage_bucket.bucket-1.name
}

resource "null_resource" "folder_upload_bucket" {
  provisioner "local-exec" {
    command = "gsutil cp -r ~/Desktop/terraform/script gs://gcp_buc_1213"
  }

}