variable "dev_members" {
  description = "Developers with read-only GKE and Artifact Registry access"
  type        = list(string)
  default     = []
}

variable "ops_members" {
  description = "Operations users with logging and monitoring viewer access"
  type        = list(string)
  default     = []
}

variable "sre_members" {
  description = "SRE users with GKE deploy/troubleshooting and observability access"
  type        = list(string)
  default     = []
}

variable "admin_members" {
  description = "Temporary project admins for demo or break-glass access"
  type        = list(string)
  default     = []
}

# -----------------------------
# Dev Access
# -----------------------------

resource "google_project_iam_member" "dev_gke_viewer" {
  for_each = toset(var.dev_members)

  project = var.project_id
  role    = "roles/container.viewer"
  member  = each.key
}

resource "google_project_iam_member" "dev_artifact_reader" {
  for_each = toset(var.dev_members)

  project = var.project_id
  role    = "roles/artifactregistry.reader"
  member  = each.key
}

# -----------------------------
# Ops Access
# -----------------------------

resource "google_project_iam_member" "ops_logging_viewer" {
  for_each = toset(var.ops_members)

  project = var.project_id
  role    = "roles/logging.viewer"
  member  = each.key
}

resource "google_project_iam_member" "ops_monitoring_viewer" {
  for_each = toset(var.ops_members)

  project = var.project_id
  role    = "roles/monitoring.viewer"
  member  = each.key
}

# -----------------------------
# SRE Access
# -----------------------------

resource "google_project_iam_member" "sre_gke_developer" {
  for_each = toset(var.sre_members)

  project = var.project_id
  role    = "roles/container.developer"
  member  = each.key
}

resource "google_project_iam_member" "sre_logging_viewer" {
  for_each = toset(var.sre_members)

  project = var.project_id
  role    = "roles/logging.viewer"
  member  = each.key
}

resource "google_project_iam_member" "sre_monitoring_viewer" {
  for_each = toset(var.sre_members)

  project = var.project_id
  role    = "roles/monitoring.viewer"
  member  = each.key
}

resource "google_project_iam_member" "sre_artifact_reader" {
  for_each = toset(var.sre_members)

  project = var.project_id
  role    = "roles/artifactregistry.reader"
  member  = each.key
}

# -----------------------------
# Admin / Break-glass Access
# -----------------------------

resource "google_project_iam_member" "admin_owner" {
  for_each = toset(var.admin_members)

  project = var.project_id
  role    = "roles/owner"
  member  = each.key
}