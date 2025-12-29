# Example Voting App — EKS + Terraform + GitHub Actions

This project is a simple **end-to-end deployment** of the classic **example-voting-app**.

The goal is:

* Build Docker images for `vote`, `result`, and `worker`
* Push images to **AWS ECR**
* Create **EKS cluster and network resources using Terraform**
* Deploy the app to Kubernetes **from CI pipeline**
* Access the app using **AWS Load Balancer DNS**

Everything runs automatically when code is pushed to the `main` branch.

---

## Application Overview

This application has three main custom services:

* **vote** → Web UI where user selects Cats or Dogs
* **result** → Web page showing the vote results
* **worker** → Background service that transfers votes from Redis to PostgreSQL

These three services are **built as Docker images inside the CI/CD pipeline** and pushed to **Amazon ECR** with commit-SHA tags (not `latest`).

Supporting data services:

* **Redis** → queue for storing votes
* **PostgreSQL** → persistent database for results

Redis and PostgreSQL are **not custom images**.
They are deployed from **official public Docker images**, because they are standard infrastructure components.

So only business logic images are custom-built.

---

## Architecture Overview

Short summary of AWS architecture:

* AWS VPC in **eu-west-2 (London)**
* Two public subnets in different Availability Zones
* AWS EKS cluster with managed node group
* 3 ECR repositories:

  * `example-voting-vote`
  * `example-voting-result`
  * `example-voting-worker`
* Kubernetes namespace: `voting-app`
* Deployments:

  * redis
  * postgres
  * vote
  * result
  * worker
* `vote` service is `LoadBalancer`, so AWS ELB is created automatically

User accesses the app from the ELB public DNS.

---

## Networking & Deployment Decisions

In a **real production environment**, Kubernetes worker nodes usually run in **private subnets**.
Only the Load Balancer is placed in **public subnets**.
This helps reduce attack surface and improves security.

But in this implementation:

### 👉 All nodes and resources run in public subnets.

This is **intentional** to:

✔ keep the solution simple
✔ reduce AWS cost
✔ avoid NAT Gateway and extra routing complexity

IAM permissions and security groups are still used, but the main focus here is:

> **clarity, learning, and cost-efficiency — not full enterprise hardening**

---

## CI/CD Overview

There are **two pipelines**:

### 1️⃣ Infra pipeline (Terraform)

Creates:

* VPC
* Subnets + routing
* EKS cluster + node group
* ECR repositories

No manual provisioning needed.

---

### 2️⃣ App pipeline (Build + Deploy)

This workflow:

1. Builds Docker images
2. Tags them using `commit SHA`
3. Pushes to Amazon ECR
4. Replaces image placeholders inside Kubernetes manifests
5. Applies manifests to EKS

So deployment is **fully automated and repeatable**.

---

## Kubernetes Files

Kubernetes manifests are stored in:

```
k8s/
  namespace.yaml
  app.yaml
```

Only **vote service** is exposed as a LoadBalancer.

---

## How to Run Deployment

Reviewer can reproduce by simply:

```
git clone <repo>
git push to main
```

CI/CD will do the rest.

---

## How to Verify Deployment

Pipeline prints Kubernetes services:

```
kubectl get svc -n voting-app
```

You will see something like:

```
vote  LoadBalancer  ...  a99839bcfe1834.eu-west-2.elb.amazonaws.com
```

Open in browser:

```
http://a99839bcfe1834.eu-west-2.elb.amazonaws.com
```

You should see **Cats vs Dogs** page.

At the bottom you see container ID, example:

```
Processed by container ID vote-679b798679-c4wb8
```

If you refresh and container ID sometimes changes → load balancing works.

---

## Security Notes

* GitHub OIDC is used (no long-lived AWS keys)
* IAM role created only for CI pipeline
* ECR image scanning enabled
* Images use commit SHA tags

For demo simplicity:

⚠️ Worker nodes are public
⚠️ IAM roles are broad (Admin style)

In real production, stricter controls would be applied.

---

## Cost Saving Choices

* Small EC2 instance type
* Few replicas
* No NAT Gateway
* Ability to destroy infra when finished

---

## Cleanup

To remove AWS resources:

```
terraform destroy
```

Optionally clean ECR + IAM role.

---

## Decision Log / Trade-offs

* Use **EKS** instead of self-managed cluster → simpler and stable
* Use **GitHub OIDC** → safer than static access keys
* Use **commit SHA tags** → avoid `latest` conflicts
* Keep everything public → cheaper and easier for demo
* Automate deploy → no manual kubectl

Main goals:

✔ easy to understand
✔ simple to operate
✔ fully automated
✔ still good engineering practice

---

## Final Result

When deployment is successful, you should see:

```
Cats vs Dogs!
Processed by container ID vote-xxxx
```
