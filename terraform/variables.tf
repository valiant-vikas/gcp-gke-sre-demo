variable "project_id" {
  type = string
}

variable "project_number" {
  type = string
}

variable "primary_region" {
  type    = string
  default = "us-central1"
}

variable "dr_region" {
  type    = string
  default = "us-east1"
}

variable "artifact_repo" {
  type    = string
  default = "app-repo"
}
variable "west_region" {
  type    = string
  default = "us-west1"
}

variable "south_region" {
  type    = string
  default = "us-south1"
}
variable "github_repo" {
  type    = string
  default = "valiant-vikas/gcp-gke-sre-demo"
}
