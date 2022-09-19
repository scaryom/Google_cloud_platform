resource "google_storage_bucket" "bucket-1" {
    name = "gcp_buc_1212"
    uniform_bucket_level_access = true
    storage_class = "STANDARD"
    location = "asia-south1"
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
    name = "edoonu"
    source = "output.jpeg"
    bucket = google_storage_bucket.bucket-1.name
  
}