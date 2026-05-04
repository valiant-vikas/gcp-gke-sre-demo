output "artifact_registry_repo" {
  value = google_artifact_registry_repository.app_repo.name
}

output "central_cluster" {
  value = google_container_cluster.central.name
}

output "east_cluster" {
  value = google_container_cluster.east.name
}

output "github_service_account" {
  value = google_service_account.github_deployer.email
}

output "workload_identity_provider" {
  value = "projects/${var.project_number}/locations/global/workloadIdentityPools/${google_iam_workload_identity_pool.github_pool.workload_identity_pool_id}/providers/${google_iam_workload_identity_pool_provider.github_provider.workload_identity_pool_provider_id}"
}
