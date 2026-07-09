✅ System Architecture Document (SAD)
1. Overview

This project demonstrates a production-style Site Reliability Engineering (SRE) microservices architecture built on Google Kubernetes Engine (GKE).

The system consists of two independent Spring Boot microservices:

profile-service → externally exposed (entry point)
order-service → internal service (backend dependency)

The profile-service is exposed via GKE Ingress, while order-service is accessible internally using Kubernetes DNS:

http://order-service:80/orders
2. High-Level Architecture
   Customer
   ↓
   kavi.solutions (Domain)
   ↓
   Cloud DNS (Failover-enabled)
   ↓
   Global Static IP
   ↓
   Google Cloud HTTP(S) Load Balancer
   ↓
   GKE Ingress
   ↓
   profile-service
   ↓
   order-service
3. GKE Cluster Architecture

The system is deployed across multiple GKE clusters (West & Central regions) to support:

High availability
Regional failover
Fault isolation
Key Characteristics:
GKE Autopilot mode (no node management)
Region-based deployment:
Primary: us-west1
Secondary: us-central1
4. Application Deployment Design

Each cluster uses reusable Kubernetes manifests:

configmap.yaml
ingress.yaml
profile-deployment.yaml
profile-service.yaml
profile-backend-config.yaml
profile-hpa.yaml
order-deployment.yaml
order-service.yaml
order-hpa.yaml
Design Highlights:
Stateless microservices
Kubernetes Deployments with replica sets
Horizontal Pod Autoscaler (HPA) for scaling
Configuration externalized via ConfigMaps
Rolling updates for zero downtime
5. Networking Design
   External Traffic Flow:
   Client
   → Cloud Load Balancer
   → Network Endpoint Group (NEG)
   → Kubernetes Service
   → Pod
   Internal Communication:
   profile-service → order-service (ClusterIP)
   Key Decisions:
   profile-service → exposed via Ingress
   order-service → internal-only (ClusterIP)

👉 Improves security and reduces attack surface

6. DNS & Traffic Routing
   Domain: kavi.solutions
   Managed via Cloud DNS
   Mapped to Global Static IP:
   kavi.solutions → 136.110.133.199
   Advanced Feature Implemented:
   DNS-based Failover
   Primary: West cluster
   Backup: Central cluster
   Health-check driven routing
7. Health Check Strategy

A BackendConfig is used to align GCP Load Balancer health checks:

healthCheck:
type: HTTP
port: 8080
requestPath: /health
Why this matters:
Default health checks were insufficient
/health provides accurate application readiness
Enables reliable failover decisions
8. Observability & Monitoring
   Implemented using GCP-native tools:
   Cloud Logging
   Application logs
   Container logs
   Ingress & LB logs
   Cloud Monitoring
   CPU / Memory utilization
   Request count & traffic
   Error rates (5xx)
   Latency metrics
   Key Metrics:
   Request volume
   Error rate (5xx)
   Total latency
   Backend latency
   Percentiles:
   p50
   p95
   p99
   Design Decision:

Cloud Monitoring was chosen over Grafana due to:

Native integration
Faster setup
Lower operational overhead
9. CI/CD Architecture

Implemented using GitHub Actions + Workload Identity

Capabilities:
Build Spring Boot applications
Build & push Docker images → Artifact Registry
Deploy to:
Single cluster
Multi-cluster
Terraform Integration:
plan
apply
destroy
Cleanup workflows:
Scale down workloads
Remove unused resources (cost optimization)
10. High Availability & Failover

Implemented using:

Multi-cluster deployment
Cloud DNS failover policy
HTTP health checks
Behavior:
Scenario	Outcome
West healthy	Traffic → West
West down	Traffic → Central
West recovers	Traffic → West
11. Key Design Decisions
    Component	Decision	Benefit
    GKE Autopilot	No node mgmt	Reduced ops overhead
    ClusterIP (order-service)	Internal-only	Security
    Ingress (profile-service)	External access	LB integration
    BackendConfig	Custom health checks	Reliable failover
    ConfigMaps	External config	Flexibility
    Cloud DNS	Traffic routing	Failover capability
    Cloud Monitoring	Native observability	Simplicity
12. Security Considerations
    Internal-only services (ClusterIP)
    Reduced attack surface
    Future-ready for:
    Workload Identity
    Secret Manager
    Cloud Armor (WAF)
13. Future Enhancements
    Multi-region active-active routing
    Google-managed SSL (HTTPS)
    Cloud Armor (WAF protection)
    Secret Manager integration
    BigQuery log analytics
    Grafana dashboards
    Canary / Blue-Green deployments
    Service Mesh (mTLS, traffic shaping)
    🎯 What improved?
    More structured (interviewer-friendly)
    Stronger SRE language
    Clear HA + failover explanation
    Better readability
    Table-based decisions (very senior touch)
    💡 Optional (strong bonus)

Add at top of README:

Live Demo:
http://kavi.solutions/profiles