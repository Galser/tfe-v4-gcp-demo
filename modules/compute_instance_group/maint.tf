terraform {
  required_version = ">= 0.12"
}

resource "google_compute_instance_group" "ptfe_group" {
  name      = "${var.name}-tfe-instance-group"
  zone      = var.availabilityZone
  instances = var.instances

  named_port {
    name = "tfe-http-install"
    port = "80"
  }

  named_port {
    name = "tfe-https"
    port = "443"
  }

  named_port {
    name = "replicated-dashboard-https"
    port = "8800"
  }

  lifecycle {
    create_before_destroy = true
  }
}