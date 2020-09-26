# Blast

[Blast](https://acronymify.com/BLAST?q=bare+metal+immutable+cluster) (**B**are Meta**l** Immut**a**ble clu**st**er) for an immutable, low-cost Kuberetes Distribution, based on [K3OS](https://github.com/rancher/k3os)/[K3S](https://github.com/rancher/k3s) and leveraging [GitOps](https://www.weave.works/technologies/gitops/) to the greatest extent possible.

## Vision and Goals

My vision is a cluster that can be composed of a variety of low end systems (Intel NUC like) that will leverage distributed technologies to provided a distributed, fault tolerant system.

## Preliminary Plans

- *v1.0.0* - MVP
  - Simple secrets (Kustomize based overlays from this cluster, stored in local repo)
  - Distributed Storage (Longhorn, RWOnce only for now)
  - Local Repo (Gitea) - For overlay configuration, and secrets NOT stores accessibly
  - Manual installation, with config.yaml kept in repo
- *v1.5.0* - MVP PXE
  - PXE Bootable Install from k3s (90% done with PXE boot, but need to make it more consumable)
  - config.yaml in Matchbox
- *v2.0.0* - Airgap
  - Airgap installation possible
- *v3.0.0* - Auto-installation
  - Process to onboard new PXE booted hardware in an automated fashion.
  - PROBABLY some sort of Operator on top of matchbox that auto-configurs systems
- Appwork - Ongoing
  - Management GUI in place
  - More app buildout/refinement


## Architecture

### Network

Using Ubiquity EdgerouterX and Ubiquity Unifi wireless for core network needs (DHCP, DNS, Routing)

### Server

- **k3os:**  [Readme for k3os](https://github.com/rancher/k3os#sample-configyaml) indicates kvm is available (shown in example), so going to try to use this as basis 
[Kubernetes Cluster API](https://github.com/kubernetes-sigs/cluster-api)
- **k3s:**  Looking for lightweight, and want to be able to include Raspberry Pi's in my architecture. 
- **[Matchbox](https://github.com/poseidon/matchbox):** PXE Provisioning for k3os 
- **[Klum](https://github.com/ibuildthecloud/klum):**  Easy way to manage users/kubeconfigs
- **Storage**
  - **Longhorn** Distributed storage.  Would rather avoid centralized NAS/storage for primary storage
  - **hostdir** for large or IO intensive storage.  Backup would have to be one-off jobs.
- **Backup:** Built in backup in Longhorn.   
- GitOps workflow
  - Gitea for version control of local manifests
  - ??? For local container registry (ligthweight...Harbor itself is too heavy)
  - [Gitops Toolkit](https://toolkit.fluxcd.io/) for deployment.  Still early, but future direction of Flux and ArgoCD
