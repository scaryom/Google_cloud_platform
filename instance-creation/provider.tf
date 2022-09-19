terraform {
    required_version = ">=0.13"
  required_providers{
      google={
          source="hashicorp/google"
          version= ">=3.50"
      }
  }
}

provider "google" {
    region="location"
    project = "project_id"
    credentials = file("service_file")
  
}

# provider "google-beta" {
#     region ="location"
#     project = "project_id"
#     credentials = file("service_file")
# }