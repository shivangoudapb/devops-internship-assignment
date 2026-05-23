# DevOps Internship Assignment

## Overview

This project deploys a distributed inferencing prototype using the iii runtime framework. The system exposes model inference through a JSON HTTP API and demonstrates RPC communication between distributed workers implemented in different languages.

The architecture consists of:

- A TypeScript caller-worker that exposes an HTTP API endpoint.
- A Python inference-worker that processes inference requests.
- The iii runtime engine that orchestrates worker communication through RPC.

The deployment was implemented on Oracle Cloud Infrastructure (OCI).

---

# Architecture

## Components

| Component | Language | Responsibility |
|---|---|---|
| caller-worker | TypeScript | Handles HTTP requests and dispatches RPC calls |
| inference-worker | Python | Processes inference requests |
| iii runtime | Rust runtime | Worker orchestration and RPC communication |

---

# Architecture Diagram

```text
                    Internet
                        |
                        v
               +----------------+
               |   Public VM    |
               |----------------|
               | iii runtime    |
               | caller-worker  |
               | inference-worker|
               +----------------+
                        |
                        v
              HTTP POST /v1/chat/completions
                        |
                        v
              inference::get_response
                        |
                        v
             inference::run_inference
```

---

# Infrastructure

## Cloud Provider

Oracle Cloud Infrastructure (OCI)

## Networking

- VCN created using OCI networking
- Public subnet configured for API access
- Security rules configured for:
  - SSH (22)
  - HTTP API (3111)

## Compute

- Ubuntu 22.04 VM
- Node.js 20
- Python 3.10
- iii runtime v0.12.0

---

# Deployment Steps

## 1. Clone Repository

```bash
git clone <repo-url>
cd devops-internship-assignment
```

---

## 2. Install Dependencies

```bash
chmod +x scripts/setup.sh
./scripts/setup.sh
```

---

## 3. Start Runtime

```bash
chmod +x scripts/run.sh
./scripts/run.sh
```

---

# API Usage

## Endpoint

```text
POST /v1/chat/completions
```

---

## Sample Request

```bash
curl -X POST http://127.0.0.1:3111/v1/chat/completions \
-H "Content-Type: application/json" \
-d '{
  "messages": [
    {
      "role": "user",
      "content": "Hello from DevOps assignment"
    }
  ]
}'
```

---

## Sample Response

```json
{
  "result": {
    "response": "Mock inference response for: Hello from DevOps assignment",
    "status": "success",
    "success": "You've connected two workers and they're interoperating seamlessly, now let's add a few more workers to expand this project's functionality."
  }
}
```

---

# Production Hardening

Before deploying this system into production, the following improvements would be implemented:

- HTTPS/TLS termination
- API authentication and authorization
- Rate limiting
- Secrets management
- Centralized logging and monitoring
- Autoscaling worker nodes
- Health checks and restart policies
- Containerization using Docker/Kubernetes
- Dedicated private inference nodes
- CI/CD pipeline integration

---

# Scaling for Larger Models

If the model size increased significantly (100x larger), the architecture would evolve as follows:

- Dedicated GPU inference nodes
- Model sharding and batching
- Distributed inference serving
- Queue-based request handling
- Kubernetes orchestration
- Horizontal autoscaling
- vLLM or TensorRT-LLM inference optimization
- Separate API and inference clusters
- Shared distributed storage for model weights

---

# Notes

The original quickstart implementation used a lightweight Gemma GGUF model. Due to OCI free-tier memory and virtualization constraints, a lightweight mocked inference worker was used for the final demonstrable deployment while preserving the distributed RPC architecture and worker orchestration flow.

The deployment successfully demonstrates:

- RPC communication between workers
- HTTP API integration
- Worker orchestration using iii runtime
- Cloud deployment
- Infrastructure setup
- End-to-end request handling

---

# Screenshots

Screenshots of:
- OCI networking
- VM configuration
- Runtime execution
- Successful API responses

are included in the `screenshots/` directory.