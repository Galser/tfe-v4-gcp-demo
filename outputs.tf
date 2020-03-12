output "data_for_tfe" {
  value = {
    application_endpoint = "${var.tfe_name}.${var.site_domain}"
    primary_public_ip    = module.compute_gcp.public_ip
    loadbalancer_ip      = module.lb_gcp.lb_ip
  }
}