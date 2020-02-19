# Network : GCP VPC

# Network : DNS CloudFlare
module "dns_cloudflare" {
  source = "./modules/dns_cloudflare"

  host   = var.tfe_name
  domain = var.site_domain
  #  cname_target = module.lb_aws.fqdn
  cname_target = "fd.cd.cm"

  record_ip = module.compute_gcp.public_ip
}

# Network : LB

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