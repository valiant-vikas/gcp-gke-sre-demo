resource "google_compute_network" "sre_vpc" {
  name                    = "sre-demo-vpc"
  auto_create_subnetworks = false
  routing_mode            = "GLOBAL"

  depends_on = [google_project_service.required_apis]
}

resource "google_compute_subnetwork" "gke_west" {
  name          = "gke-west-subnet"
  ip_cidr_range = "10.40.0.0/20"
  region        = var.west_region
  network       = google_compute_network.sre_vpc.id

  private_ip_google_access = true

  secondary_ip_range {
    range_name    = "gke-west-pods"
    ip_cidr_range = "10.50.0.0/16"
  }

  secondary_ip_range {
    range_name    = "gke-west-services"
    ip_cidr_range = "10.60.0.0/20"
  }
}

resource "google_compute_subnetwork" "gke_south" {
  name          = "gke-south-subnet"
  ip_cidr_range = "10.41.0.0/20"
  region        = var.south_region
  network       = google_compute_network.sre_vpc.id

  private_ip_google_access = true

  secondary_ip_range {
    range_name    = "gke-south-pods"
    ip_cidr_range = "10.51.0.0/16"
  }

  secondary_ip_range {
    range_name    = "gke-south-services"
    ip_cidr_range = "10.61.0.0/20"
  }
}

resource "google_compute_router" "west_router" {
  name    = "west-cloud-router"
  region  = var.west_region
  network = google_compute_network.sre_vpc.id
}

resource "google_compute_router_nat" "west_nat" {
  name                               = "west-cloud-nat"
  router                             = google_compute_router.west_router.name
  region                             = google_compute_router.west_router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}

resource "google_compute_router" "south_router" {
  name    = "south-cloud-router"
  region  = var.south_region
  network = google_compute_network.sre_vpc.id
}

resource "google_compute_router_nat" "south_nat" {
  name                               = "south-cloud-nat"
  router                             = google_compute_router.south_router.name
  region                             = google_compute_router.south_router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}

resource "google_compute_global_address" "private_service_range" {
  name          = "private-service-access-range"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.sre_vpc.id
}

resource "google_service_networking_connection" "private_service_access" {
  network                 = google_compute_network.sre_vpc.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_service_range.name]
}

resource "google_compute_firewall" "allow_internal_sre_vpc" {
  name    = "allow-internal-sre-vpc"
  network = google_compute_network.sre_vpc.name

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "icmp"
  }

  source_ranges = ["10.0.0.0/8"]
}
