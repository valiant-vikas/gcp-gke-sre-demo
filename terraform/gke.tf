resource "google_container_cluster" "central" {
  name                = "profile-cluster"
  location            = var.primary_region
  enable_autopilot    = true
  deletion_protection = false

  depends_on = [google_project_service.required_apis]
}

resource "google_container_cluster" "east" {
  name                = "profile-cluster-east"
  location            = var.dr_region
  enable_autopilot    = true
  deletion_protection = false

  depends_on = [google_project_service.required_apis]
}
