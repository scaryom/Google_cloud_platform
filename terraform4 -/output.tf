output "clustername"{
    value=google_container_cluster.cluster-1.name
    description="Cluster Name"
}
output "nodepoolname" {
    value=google_container_node_pool.np-1.name
    description="Node Pool Name"
}

