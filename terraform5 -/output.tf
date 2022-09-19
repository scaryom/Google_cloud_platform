output "ClusterName" {
    value = google_container_cluster.cluster.name
    description="Cluster Name : "
}

output "NodeName" {
    value = google_container_node_pool.np.name
    description = "Node Pool Name : "
  
}