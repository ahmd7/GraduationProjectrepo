# Kubernetes Deployment for Microservices Application

This repository contains the Kubernetes manifests for deploying a microservices-based application on a Kubernetes cluster. The application consists of multiple services, including front-end, edge router, catalogue, carts, orders, shipping, payment, user, and their respective databases.

## Table of Contents

- [Overview](#overview)
- [Architecture](#architecture)
- [Prerequisites](#prerequisites)
- [Deployment](#deployment)
- [Management](#management)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [License](#license)

## Overview

This microservices application includes the following components:

- **Front-end**: User interface for the application.
- **Edge Router**: Handles incoming HTTP requests and routes them to appropriate services.
- **Catalogue**: Manages the product catalog.
- **Carts**: Manages user shopping carts.
- **Orders**: Handles order management.
- **Shipping**: Manages shipping information.
- **Payment**: Handles payment processing.
- **User**: Manages user information.
- **Databases**: Each service has its own database for storing relevant data.
- **Queue Master**: Handles asynchronous processing using RabbitMQ.

## Architecture

![Architecture Diagram](architecture.png) <!-- Include an architecture diagram if available -->

## Prerequisites

Before deploying the application, ensure you have the following:

- A running Kubernetes cluster (local or cloud-based).
- `kubectl` command-line tool configured to interact with your cluster.
- Docker images for each service are available in a container registry.

## Deployment

### 1. Clone the Repository

```bash
git clone https://github.com/ahmd7/GraduationProjectrepo.git
cd GraduationProjectrepo
```

### 2. Create Namespace

Create a namespace for your application to isolate its resources.


```bash
kubectl apply -f namespace.yaml
```
### 3. Apply ConfigMap and Secrets
ConfigMaps and Secrets are used to store non-sensitive and sensitive configuration data, respectively.

```bash
kubectl apply -f configmap.yaml
kubectl apply -f secret.yaml
```
### 4. Deploy Services
Apply the Kubernetes manifests for each service and their associated databases.

```bash
kubectl apply -f front-end.yaml
kubectl apply -f edge-router.yaml
kubectl apply -f catalogue.yaml
kubectl apply -f catalogue-db.yaml
kubectl apply -f carts.yaml
kubectl apply -f carts-db.yaml
kubectl apply -f orders.yaml
kubectl apply -f orders-db.yaml
kubectl apply -f shipping.yaml
kubectl apply -f queue-master.yaml
kubectl apply -f rabbitmq.yaml
kubectl apply -f payment.yaml
kubectl apply -f user.yaml
kubectl apply -f user-db.yaml
kubectl apply -f user-sim.yaml
```
### 5. Verify Deployment
Check the status of your Pods to ensure all services are running correctly.

```bash
kubectl get pods -n my-app
```
### 6. Access the Application
Determine how to access the front-end service (e.g., via a LoadBalancer or Ingress), and open it in your browser.

```bash
kubectl get svc -n my-app
```
