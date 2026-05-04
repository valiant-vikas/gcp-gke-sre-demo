resource "google_container_cluster" "central" {
  name                = "profile-cluster"
  location            = var.primary_region
  enable_autopilot    = true
  deletion_protection = true

  lifecycle {
    ignore_changes = [
      in_transit_encryption_config
    ]
  }

  depends_on = [google_project_service.required_apis]
}

resource "google_container_cluster" "east" {
  name                = "profile-cluster-east"
  location            = var.dr_region
  enable_autopilot    = true
  deletion_protection = true

  lifecycle {
    ignore_changes = [
      in_transit_encryption_config
    ]
  }

  depends_on = [google_project_service.required_apis]
}

resource "google_container_cluster" "west" {
  name                = "profile-cluster-west"
  location            = var.west_region
  enable_autopilot    = true
  deletion_protection = true

  network    = google_compute_network.sre_vpc.id
  subnetwork = google_compute_subnetwork.gke_west.id

  ip_allocation_policy {
    cluster_secondary_range_name  = "gke-west-pods"
    services_secondary_range_name = "gke-west-services"
  }

  depends_on = [
    google_project_service.required_apis,
    google_service_networking_connection.private_service_access
  ]

  lifecycle {
    ignore_changes = [
      in_transit_encryption_config
    ]
  }
}

resource "google_container_cluster" "south" {
  name                = "profile-cluster-south"
  location            = var.south_region
  enable_autopilot    = true
  deletion_protection = true

  network    = google_compute_network.sre_vpc.id
  subnetwork = google_compute_subnetwork.gke_south.id

  ip_allocation_policy {
    cluster_secondary_range_name  = "gke-south-pods"
    services_secondary_range_name = "gke-south-services"
  }

  depends_on = [
    google_project_service.required_apis,
    google_service_networking_connection.private_service_access
  ]

  lifecycle {
    ignore_changes = [
      in_transit_encryption_config
    ]
  }
}
