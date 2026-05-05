# 🚀 GCP GKE SRE Demo Project
## 👨‍💻 Author

Vikas | Java | SRE | GCP | Kubernetes

## 📌 Overview

This project demonstrates a production-style SRE architecture on Google Cloud using Kubernetes, CI/CD, Terraform, and observability best practices.

It showcases how to design, deploy, monitor, and scale microservices in a multi-region, highly available setup.

## 🎯 Objectives
Deploy microservices on GKE (multi-cluster)
Implement auto-scaling using HPA
Build CI/CD using GitHub Actions
Enable observability (logs, metrics, dashboards)
Design a scalable and fault-tolerant architecture
Implement Infrastructure as Code (Terraform)
## 🧩 Architecture Components
Core Platform
Google Cloud Platform (GCP)
Google Kubernetes Engine (GKE) – Multi-cluster
Artifact Registry – Container images
Kubernetes
Deployments
Services (ClusterIP)
Ingress (GCE)
Horizontal Pod Autoscaler (HPA)
CI/CD & Infra
GitHub Actions (Build + Deploy + Cleanup)
Terraform (Infrastructure provisioning)
Workload Identity Federation (no service keys)
Observability
Cloud Logging
Cloud Monitoring
BigQuery (log analytics)
Grafana (planned dashboards)
## 📦 Application
Microservices
profile-service (Spring Boot)
order-service (Spring Boot)
API Endpoints
/profiles
/profile-orders
/health
/version
## ⚙️ Features
Multi-cluster deployment (Central + West)
Internal service-to-service communication
Horizontal Pod Autoscaling (HPA)
GCE Ingress with external HTTP(S) Load Balancer
Centralized logging and metrics
CI/CD pipeline with selective cluster deployment
Terraform-based infrastructure management
## 🏗️ System Architecture Diagram (SAD)
## 🌐 Current Architecture (Working Setup)
Customer Browser
|
v
Cloud DNS (kavi.solutions)
|
v
Global Static IP
|
v
Google Global HTTP(S) Load Balancer
|
v
GKE Ingress (profile-ingress)
|
v
profile-service (ClusterIP)
|
v
Profile Pods (Spring Boot)
|
| Internal DNS → http://order-service:80/orders
v
order-service (ClusterIP)
|
v
Order Pods (Spring Boot)
## 🌍 Multi-Cluster Architecture
+----------------------+
|   Customer Browser   |
+----------+-----------+
|
v
+----------------------+
|   Cloud DNS          |
|   kavi.solutions     |
+----------+-----------+
|
v
+----------------------+
| Global HTTP(S) LB    |
+----------+-----------+
|
+-------+--------+
|                |
v                v
+----------------+  +----------------+
| West Cluster   |  | Central Cluster|
| (Primary)      |  | (DR / Failover)|
+----------------+  +----------------+
| profile-service |  | profile-service|
| order-service   |  | order-service  |
+----------------+  +----------------+
## 🔄 Traffic Flow
User Request
→ Global Load Balancer
→ GKE Ingress
→ profile-service
→ order-service (internal DNS)
→ Response to user
## 📊 Observability
Implemented
Logs → Cloud Logging
Metrics → Cloud Monitoring
Ingress & Load Balancer metrics
Request volume
Latency
Error rates (5xx)
Advanced (Implemented / In Progress)
Log sink → BigQuery
Latency analysis (p50, p95, p99)
Grafana dashboards (in progress)
## 🚀 CI/CD Workflow
GitHub Actions Pipelines
Deploy Workflow
Build Spring Boot apps
Build Docker images
Push to Artifact Registry
Deploy to selected clusters (central / west / east / south)
Multi-cluster selection supported
Cleanup Workflow
Scale workloads to zero OR delete resources
Supports multi-cluster cleanup
Terraform Workflow
Provision infrastructure
Manage state via GCS backend
Uses Workload Identity (secure auth)
## 🔐 Security
Workload Identity Federation (no service account keys)
IAM role-based access model (Dev / Ops / SRE)
Private cluster networking (partial)
Firewall rules and VPC segmentation
## 📦 Terraform (Infrastructure as Code)
Managed Resources
GKE clusters (West via Terraform)
VPC, subnets, NAT
IAM roles and service accounts
Workload Identity Federation
Logging sinks & observability (partial)
## 📅 Project Evolution
## Phase 1

✔ Spring Boot app
✔ Dockerization

## Phase 2

✔ Artifact Registry
✔ GKE clusters

## Phase 3

✔ Kubernetes deployment
✔ Ingress setup

## Phase 4

✔ HPA
✔ Logging & Monitoring

## Phase 5 (Advanced)

✔ Multi-cluster deployment
✔ Terraform integration
✔ CI/CD automation

## Phase 6 (In Progress)

## 🔄 Grafana dashboards
## 🔄 Advanced alerting
## 🔄 Failover automation

## 🎤 Key SRE Highlights
Multi-region architecture
Infrastructure as Code (Terraform)
Secure CI/CD with Workload Identity
Observability with latency & error metrics
Auto-scaling with HPA
Production-style ingress with GCP Load Balancer

