## Application Overview

This application consists of three custom services — **vote**, **result**, and **worker** — each packaged as a Docker image. These images are built in the CI/CD pipeline and pushed to **Amazon ECR**.

The data services (**Redis** and **PostgreSQL**) are supporting infrastructure components and are deployed using **official public container images**, rather than custom-built ones.

---

## Networking & Deployment Decisions

In a production environment, Kubernetes worker nodes are typically deployed in **private subnets**, while the external **Application/Network Load Balancer runs in public subnets**. This reduces the attack surface and improves overall security.

However, in this implementation, **all nodes and resources run in public subnets**. This design choice was made deliberately to:

* keep the solution simpler to deploy and operate
* reduce AWS infrastructure cost
* avoid the need for NAT Gateways and additional routing complexity

Security controls such as IAM scoping and security groups are still applied, but this setup remains optimized for **clarity, speed, and cost-efficiency rather than full production hardening**.

