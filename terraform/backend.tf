terraform {
  backend "gcs" {
    bucket = "gke-sre-demo-tf-state"
    prefix = "terraform/state"
  }
}