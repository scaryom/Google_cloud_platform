terraform{
    required_providers{
        google={
            version=">=3.36"
            source="hashicorp/google"
        }
    }
}
provider "google"{
    project=var.project_id
    credentials=file("service_file")
    region=var.region
}

resource "google_container_cluster" "cluster-1" {
    name="${var.project_id}-cluster-1"
    location=var.region
    remove_default_node_pool=true 
    initial_node_count=1    
}

resource "google_container_node_pool" "np-1"{
    name="${var.project_id}-np-1"
    location=google_container_cluster.cluster-1.location
    cluster=google_container_cluster.cluster-1.name
    node_count=2
    autoscaling{
        max_node_count=3
        min_node_count=2

    }
    node_config{
        machine_type="e2-medium"
        preemptible=true 
    }

}