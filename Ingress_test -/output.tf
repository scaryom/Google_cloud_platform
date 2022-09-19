output "cluster" {
  value       = google_container_cluster.cls_1.name
  description = "Cluster Name"

}
output "location" {
  value       = google_container_cluster.cls_1.node_locations
  description = "Node Locations"
}