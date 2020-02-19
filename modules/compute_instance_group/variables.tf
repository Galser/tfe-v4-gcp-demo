variable "name" {
  description = "name of the project4, or your tfe installation"
  type        = string
  default     = "tfe"
}

variable "instances" {
  description = "List of instances to attach into group"
  type        = list
  default     = []
}

variable "availabilityZone" {
  default = "us-central1-c"
}
  