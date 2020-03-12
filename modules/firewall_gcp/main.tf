resource "google_compute_firewall" "default" {
  name    = "tfe-firewall"
  network = "default"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "443", "6443", "8800"]
  }

  // source_tags = ["web"]
}