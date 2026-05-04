resource "google_artifact_registry_repository" "app_repo" {
  location      = var.primary_region
  repository_id = var.artifact_repo
  description   = "Docker repo for GKE SRE demo"
  format        = "DOCKER"

  depends_on = [google_project_service.required_apis]
}
