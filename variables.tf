// GCP data
variable "project" {
  default = "tf-gettingstarted"
}

variable "credentials_file" {
  default = "~/Keys/tf-gettingstarted-ade17a5d7ec1.json"
}

variable "region" {
  default = "us-central1"
}

variable "availabilityZone" {
  default = "us-central1-c"
}
// end of GCP data

// TFE DNS Settings
variable "site_domain" {
  default = "guselietov.com"
}

variable "tfe_name" {
  default = "tfe-pm-ext-1"
}

variable "key_path" {
  default = "~/.ssh/id_rsa"
}

variable "public_key_path" {
  default = "~/.ssh/id_rsa.pub"
}

// Network settingds and tags

variable "cidrs" {
  default = ["10.0.0.0/16", "10.1.0.0/16"]
}

variable "vpc_tag" {
  default = "ag_ptfe_pm"
}

variable "disks_tag" {
  default = "ag_ptfe_pm"
}

variable "db_admin" {
  default = "adimini"
}

