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
    region = "location"
      project     = "project_id"
  credentials = file("service_file")
  
}
