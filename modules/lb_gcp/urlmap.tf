resource "google_compute_url_map" "tfe" {
  name        = "${var.name}-urlmap"
  description = "tfe"

  default_service = google_compute_backend_service.primary.self_link

  host_rule {
    hosts        = ["${var.tfe_name}.${var.site_domain}"]
    path_matcher = "allpaths"
  }

  path_matcher {
    name            = "allpaths"
    default_service = google_compute_backend_service.primary.self_link

    path_rule {
      paths   = ["/dashboard"]
      service = google_compute_backend_service.dashboard.self_link
    }

    path_rule {
      paths   = ["/dashboard/*"]
      service = google_compute_backend_service.dashboard.self_link
    }

    path_rule {
      paths   = ["/*"]
      service = google_compute_backend_service.primary.self_link
    }
  }
}

resource "google_compute_backend_service" "dashboard" {
  name        = "${var.name}-dashboard"
  port_name   = "replicated-dashboard-https"
  protocol    = "HTTPS"
  timeout_sec = 10

  health_checks = [google_compute_health_check.primary.self_link]

  backend {
    description = "primary servers"
    group       = var.instance_group
  }
}

resource "google_compute_backend_service" "primary" {
  name        = "${var.name}-primary-backend"
  port_name   = "tfe-https"
  protocol    = "HTTPS"
  timeout_sec = 10

  health_checks = [google_compute_health_check.primary.self_link]

  backend {
    description = "primary servers"
    group       = var.instance_group
  }
}

resource "google_compute_health_check" "primary" {
  name               = "${var.name}-primary-healthcheck"
  check_interval_sec = 5
  timeout_sec        = 4

  https_health_check {
    request_path = "/_health_check"
    port         = "443"
  }
}