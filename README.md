# 🚀 GCP GKE SRE Demo Project

## 👨‍💻 Author
Vikas | Java | SRE | GCP | Kubernetes

---

## 📌 Overview
This project demonstrates how to deploy a Spring Boot microservice on Google Kubernetes Engine (GKE) with scalability, observability, and reliability using SRE best practices.

---

## 🎯 Objectives
- Deploy microservices on GKE
- Implement auto-scaling using HPA
- Enable logging and monitoring
- Design a scalable and reliable architecture
- Use containerization with Docker and Artifact Registry

---

## 🧩 Architecture Components
- Google Cloud Platform (GCP)
- Google Kubernetes Engine (GKE)
- Artifact Registry (Docker Images)
- Kubernetes (Deployment, Service, HPA)
- Cloud Logging
- Cloud Monitoring

---

## 📦 Application
- Spring Boot REST API: `profile-service`
- Endpoints:
  - `/profiles`
  - `/health`
  - `/version`

---

## ⚙️ Features
- Multi-pod deployment
- Horizontal Pod Autoscaler (HPA)
- Readiness and Liveness Probes
- Centralized logging
- Metrics monitoring

---

## 🏗️ Architecture Flow
Client → LoadBalancer → Kubernetes Service → Pods (Spring Boot App)

---

## 📅 Project Plan

### Phase 1
- [ ] Create Spring Boot application
- [ ] Dockerize application

### Phase 2
- [ ] Push image to Artifact Registry
- [ ] Create GKE cluster

### Phase 3
- [ ] Deploy application on Kubernetes
- [ ] Expose service externally

### Phase 4
- [ ] Configure HPA
- [ ] Enable logging and monitoring

### Phase 5 (Optional)
- [ ] Add second microservice
- [ ] Add Terraform for infrastructure

---

## 📊 Observability
- Logs → Cloud Logging
- Metrics → Cloud Monitoring
- Future: Grafana / BigQuery dashboards

---

## 🔐 Security (Planned)
- Workload Identity
- Secret Manager
- Secure communication between services

---

## 📌 Status
🚧 Project setup in progress...
