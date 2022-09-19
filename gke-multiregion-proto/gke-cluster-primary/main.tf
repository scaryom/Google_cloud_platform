terraform{
    required_providers{
        google={
            version="=3.63.0"
            source="hashicorp/google"
        }
    }
    required_version=">=0.13"
}
provider "google"{
    project=var.project_id
    credentials=file("service_file")
}
resource "google_container_cluster" "primary"{
    name="${var.project_id}-gke-primary"
    location=var.region
    enable_autopilot=true 
    
    release_channel{
        channel="STABLE"
    }
    node_locations=["europe-west4-a","europe-west4-b"]
    network=var.vpc_name
    subnetwork=var.subnet_name

}