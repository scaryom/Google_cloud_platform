resource "google_cloud_run_service" "run-1" {
    name="run-1"
  location = "asia-south1"
template {
  spec{
      containers{
          #image="gcr.io/google-samples/hello-app:1.0"
          image="gcr.io/google-samples/hello-app:2.0"
      }
      timeout_seconds = 300
  }
}
traffic {
  percent=50
  latest_revision=false
   revision_name = "run-1-6ckk8"
}
traffic {
  percent=50
  latest_revision=true
}
}
data "google_iam_policy" "viwer" {
    name=""
  
}



