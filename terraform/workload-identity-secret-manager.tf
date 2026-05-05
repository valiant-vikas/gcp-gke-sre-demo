resource "google_service_account" "gke_app_sa" {
  account_id   = "gke-app-runtime-sa"
  display_name = "GKE App Runtime Service Account"
  description  = "Used by GKE workloads through Workload Identity"
}

resource "google_secret_manager_secret" "demo_api_key" {
  secret_id = "demo-api-key"

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "demo_api_key_version" {
  secret      = google_secret_manager_secret.demo_api_key.id
  secret_data = var.demo_secret_value
}

resource "google_secret_manager_secret_iam_member" "secret_accessor" {
  secret_id = google_secret_manager_secret.demo_api_key.id
  role      = "roles/secretmanager.secretAccessor"
  member    = "serviceAccount:${google_service_account.gke_app_sa.email}"
}

resource "google_service_account_iam_member" "workload_identity_binding" {
  service_account_id = google_service_account.gke_app_sa.name
  role               = "roles/iam.workloadIdentityUser"

  member = "serviceAccount:${var.project_id}.svc.id.goog[${var.namespace}/${var.ksa_name}]"
}