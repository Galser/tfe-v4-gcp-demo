output "instance_id" {
  value = google_compute_instance.ptfe.id
}

output "link" {
  value = google_compute_instance.ptfe.self_link
}

output "public_ip" {
  //value = google_compute_instance.ptfe.public_ip
  value = google_compute_instance.ptfe.network_interface.0.access_config.0.nat_ip
}