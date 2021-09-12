# Blast

[Blast](https://acronymify.com/BLAST?q=bare+metal+immutable+cluster) (**B**are Meta**l** Immut**a**ble clu**st**er) for an immutable, light-weight Kuberetes Distribution for edge and cloud use cases.  The goal is to leverage Kubernetes APIs and Operators/CRDs to define the local datacenter entirely through code.

## Repositroy Layout

Based on [FluxV2 Repository Layout](https://fluxcd.io/docs/guides/repository-structure/#monorepo) (and yes, I do realize the irony of using Flux's layout while deploying ArgoCD)


- /clusters: Actual cluster definition in ClusterAPI, as well as ArgoCD Cluster Definitions
- /infrastructure: Core Infrastructure that is generally installed across all clusters
- /apps: Individual apps to be installed by end-clusters
- /docker: Docker build and associated build tooling
- /scripts: Scripting to support primarily the bootstraping process.  Most scripts should be embedded in docker containers.


## Architecture

### Network

Should work across all network equipment.  Some focus on the Ubuiqity Lite-AP and 

### Server

- Core Infrastructure
  - **[k3d](https://k3d.io):** For bootstraping and CI/CD purposes.  Choosen for minimal resources
  - **[Kubernetes Cluster API](https://cluster-api.sigs.k8s.io/):** Central way to define clusters
    - **[Talos](https://www.talos.dev/):** - Native K8S Linux Distro, will be default for all cloud providers that support it
    - **[Sidero](https://www.sidero.dev/)** - Bootstrap for on-prem hardware installs
  - **[Crossplane.io](https://crossplane.io/):** To be used to manage any resources NOT natively defined in k8s
- Core K8S AddOns
  - **[Klum](https://github.com/ibuildthecloud/klum):**  Easy way to manage users/kubeconfigs
  - **[ArgoCD](https://argoproj.github.io/argo-cd/):** GitOps Opertor for once Clusters are provisioned
  - **[SealedSecrets](https://github.com/bitnami-labs/sealed-secrets):** For safe secrets management directly in the repository
- Storage
  - **Mayastore** or **Rook** Distributed storage.  Would rather avoid centralized NAS/storage for primary storage
  - **hostdir** for large or IO intensive storage.  Backup would have to be one-off jobs.
- Backup
  - **Minio** for providing external storage in a bucket interface
  - **Kastaen K10** Easiest way to backup 

### Applications/Resource


### Standards

- [Checkov](https://github.com/bridgecrewio/checkov) For scanning generated files and identify concerns
- [Docker Bechmark](https://github.com/docker/docker-bench-security)
- [Claire](https://github.com/quay/clair)
