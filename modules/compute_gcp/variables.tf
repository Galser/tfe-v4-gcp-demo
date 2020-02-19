variable "name" {
  type        = string
  description = "Name for tags and etc"
}

variable "image" {
  default = "ubuntu-os-cloud/ubuntu-1804-lts"
}

variable "instance_type" {
  description = "Type of instance"
  default     = "n1-standard-4"
}


variable "availabilityZone" {
  default = "us-central1-c"
}

/* variable "subnet_id" {
  type        = string
  description = "Subnet ID"
}

variable "security_groups" {
  type        = list
  description = "List of security groups IDs"
}

variable "key_name" {
  type        = string
  description = "SSH Key ID  , stored in AWS"
}
*/
variable "key_path" {
  description = "Local SSH key path (private part)"
}

variable "public_key_path" {
  description = "Local SSH key path (public part)"
}
