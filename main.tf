# Network : GCP VPC
# Network : Firewall
module "firewall_gcp" {
  source = "./modules/firewall_gcp"
}

# Network : DNS CloudFlare
module "dns_cloudflare" {
  source = "./modules/dns_cloudflare"

  host   = var.tfe_name
  domain = var.site_domain
  #  cname_target = module.lb_aws.fqdn
  frontend_ip = module.lb_gcp.lb_ip

  backend_ip = module.compute_gcp.public_ip
}

# Certificate : SSL from Let'sEncrypt
module "sslcert_letsencrypt" {

  source = "./modules/sslcert_letsencrypt"

  host         = var.tfe_name
  domain       = var.site_domain
  dns_provider = "cloudflare"
}

# Certificate : Upload into GCP
resource "google_compute_ssl_certificate" "tfe" {
  name_prefix = "${var.tfe_name}-tfe-"
  description = "TFE cert"
  private_key = module.sslcert_letsencrypt.cert_private_key_pem
  certificate = module.sslcert_letsencrypt.cert_pem

  lifecycle {
    create_before_destroy = true
  }
}

# SSH

# Instance : GCP
module "compute_gcp" {
  source = "./modules/compute_gcp"

  name = "ag-${var.tfe_name}"
  //  instance_type   = var.instance_type
  //  image           = ""
  /*()  security_groups = ["${module.vpc_aws.security_group_id}"]
  subnet_id       = module.vpc_aws.subnet_id 
  key_name        = module.sshkey_aws.key_id*/
  availabilityZone = var.availabilityZone
  key_path         = var.key_path
  public_key_path  = var.public_key_path
}

# Instance(s) group : 
module "compute_instance_group" {
  source           = "./modules/compute_instance_group"
  availabilityZone = var.availabilityZone
  name             = "ag-${var.tfe_name}"
  instances        = [module.compute_gcp.link]
}

# Network : LB
module "lb_gcp" {
  source           = "./modules/lb_gcp"
  name             = "ag-${var.tfe_name}"
  instance_group   = module.compute_instance_group.link
  project          = var.project
  ssl_certificates = [google_compute_ssl_certificate.tfe.self_link]
  // ! list ^^^
  tfe_name    = var.tfe_name
  site_domain = var.site_domain
  tags        = { "app" : "tfe" }
}

