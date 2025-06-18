# Nomad Learning Cluster

This repository is designed as a hands-on lab for learning [HashiCorp Nomad](https://www.nomadproject.io/). It simulates a multi-node Nomad cluster using Docker containers, allowing you to experiment with job scheduling and orchestration as if you were running across multiple physical/virtual machines—all locally!

---

## 📁 Structure

- **example-job.nomad**  
  Example Nomad job file for testing your cluster.  
- **nomad-cluster/**
  - **server/** — Nomad server ("chief") configuration and setup.
  - **client1/** — Example Nomad client agent setup (add more clients as needed).
  - **jobs/** — Place additional Nomad job files here.

---

## 🚀 Getting Started

### 1. Prerequisites

- [Docker](https://www.docker.com/)
- [Nomad CLI](https://developer.hashicorp.com/nomad/downloads) (optional, for local commands and job submission)

### 2. Start the Cluster

Spin up all agents and clients via Docker Compose or individual Docker commands (see scripts/configs in `nomad-cluster/`).  
Example with Docker Compose:
```sh
docker-compose up -d
```
Or manually run your containers using the appropriate configuration in each subfolder.

### 3. Verify Cluster

Connect to the server (chief) container:
```sh
docker exec -it <server-container-name> /bin/sh
nomad server members
nomad node status
```

Or connect to a client and verify it registers with the server.

---

## 📝 Submitting and Testing Jobs

### Example Job

The provided `example-job.nomad` runs a simple batch job using BusyBox:

```hcl
job "example-job" {
  datacenters = ["dc1"]
  type = "batch" 

  group "example-group" {
    task "hello" {
      driver = "docker"

      config {
        image = "busybox"
        args  = ["echo", "Hello, Nomad!"]
      }
    }
  }
}
```

### Run the Example Job

From inside any Nomad agent container (server or client, if CLI is installed):

```sh
nomad job run example-job.nomad
```

### Monitor Job Status

```sh
nomad job status
nomad alloc status <allocation-id>
nomad alloc logs <allocation-id>
```

### Stop a Job

```sh
nomad job stop example-job
```

---

## 🗂 Adding More Clients & Jobs

- Add more client folders in `nomad-cluster/` as needed, updating your Docker Compose or scripts.
- Put new job files in `nomad-cluster/jobs/` or root as desired.

---

## 💡 Tips

- Modify the example job or create your own to experiment with different drivers, resources, and volume mounts.
- Use Nomad's Web UI (if enabled in your config) for easier monitoring.

---

## 📚 References

- [Nomad Documentation](https://developer.hashicorp.com/nomad/docs)
- [Nomad Job Spec](https://developer.hashicorp.com/nomad/docs/job-specification)
- [Nomad Tutorials](https://developer.hashicorp.com/nomad/tutorials)

---

Happy scheduling!