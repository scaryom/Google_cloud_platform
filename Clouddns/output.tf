output "networkname" {
  value = google_compute_network.custnetwork.name 
  description = "Custom Network Name: "
  
}
output "subnetname" {
  value = google_compute_subnetwork.custsubnetwork1.name
  description = "Custom Subnetwork Name: "
}

output "instancetemplate" {
  value = google_compute_instance_template.tmp-1.name
  description = "Instance Template Name: "
}

# output "dns-1" {
#     value = google_dns_record_set.frontend1.name
#     description = "DNS-1"
# }

# output "dns-2" {
#     value = google_dns_record_set.frontend2.name
#     description = "DNS-2"
  
# }