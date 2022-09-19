resource "google_storage_bucket" "bucket-1213" {
  name                        = "gcs-om-1214"
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true
  force_destroy               = true
  location                    = "asia-south1"
}

resource "google_storage_bucket_object" "obj-1" {
  bucket = google_storage_bucket.bucket-1213.name
  name   = "test.zip"
  source = "test.zip"
}

resource "google_cloudfunctions_function" "func-1" {
  name                  = "func-1"
  runtime               = "python39"
  available_memory_mb   = 128
  source_archive_bucket = google_storage_bucket.bucket-1213.name
  source_archive_object = google_storage_bucket_object.obj-1.name
  min_instances         = 0
  max_instances         = 10
  trigger_http          = true
  region                = "asia-south1"
  timeout               = 60
  entry_point           = "hello_world"

}

resource "google_cloudfunctions_function_iam_member" "mem-1" {
  cloud_function = google_cloudfunctions_function.func-1.name
  region         = google_cloudfunctions_function.func-1.region
  project        = google_cloudfunctions_function.func-1.project
  member         = "allUsers"
  role           = "roles/cloudfunctions.invoker"
  

}