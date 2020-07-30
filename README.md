# Blast

[Blast](https://acronymify.com/BLAST?q=bare+metal+immutable+cluster) (**B**are Meta**l** Immut**a**ble clu**st**er) for an immutable, low-cost cluster leveraging [GitOps](https://www.weave.works/technologies/gitops/) to the greatest extent possible.

## Vision and Goals

My vision is a cluster that I can throw random hardware at, and that hardware will be installed and 
configured for use.  Any class of hardware will work, as long as it runs Linux.

## Preliminary Plans

- *v1.0.0* - MVP
  - Distributed Storage (Longhorn, RWOnce only for now)
  - DNS provided by dnsmasq (as part of matchbox in the future)
  - Simple secrets (Kustomize based overlays from this cluster, stored in local repo)
  - Local Repo (Gitea) - For overlay configuration, and secrets NOT stores accessibly
  - Manual installation, with Node config.yaml kept in repo
- *v1.5.0* - MVP PXE
  - PXE Bootable Install from k3s (90% done with PXE boot, but need to make it more consumable)
    - Auto-generate SSL keys with initContainer on Matchbox, potentially
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
  - **hostdir** for large or IO intentenstive storage.  Backup would have to be one-off jobs.
- **[NFS Server](https://estl.tech/multi-writer-file-storage-on-gke-6d044ec96a46)** for RWM volumes if necessary
- **Backup:** Built in backup in Longhorn.   Might need to run quick NFS server, attached to USB drive, to "receive" backup. Or <https://restic.net/> could be used to get good deduplication. 
- **Kubevirt** for virtualization outside of docker/linux
  - [OKD Dashboard for KubeVirt](https://kubevirt.io/2020/OKD-web-console-install.html)
- **[Kubebox](https://github.com/astefanutti/kubebox):**  Terminal/Web Console for k8s
- GitOps workflow
  - Gitea for version control of local manifests
  - [Harbor](https://github.com/goharbor/harbor) for local docker images, including [pass through configuration](https://github.com/goharbor/harbor/blob/master/contrib/Configure_mirror.md)
  - [Gitops Engine](https://github.com/argoproj/gitops-engine) for deployment.  Still early, but future direction of Flux and ArgoCD
  - [Tekton](https://github.com/tektoncd/pipeline) for workflow/job needs
  - [Kubevious](https://github.com/kubevious/kubevious) and/or [Kubernetes Dashboard](https://github.com/kubernetes/dashboard)

### Applications/Resource

- Pi-hole on Kubernetes: https://github.com/MoJo2600/pihole-kubernetes
  - Configured for Local DNS resolution
- Plex
- HomeAssistant
- General Fileserver 
- [Ubiquity Network Controller](https://github.com/helm/charts/tree/master/stable/unifi)
  - [SSH Adoption](https://github.com/jacobalberty/unifi-docker#ssh-adoption) instruction from the base image.
  - Default SSH username/password: ubnt/ubnt (note, you can change these using unifi controller)
- Ubiquity management (UNMS) 
- [Skydive](https://github.com/skydive-project/skydive): Might be a great network visualization tool. . . 
- [Online Dev with Eclipse Che](https://www.eclipse.org/che/docs/che-7/introduction-to-eclipse-che/)
- Local static page with all available management links (and services hosted by network)
- Website for captive portal for guests
- apt-cacher-ng: Mostly for existing Debian/Ubuntu based systems.  Might not be necessary in later builds


### Standards

- [Checkov](https://github.com/bridgecrewio/checkov) For scanning generated files and identify concerns
- [Docker Bechmark](https://github.com/docker/docker-bench-security)
- [Claire](https://github.com/quay/clair)

Source Info:
https://kauri.io/build-your-very-own-self-hosting-platform-with-raspberry-pi-and-kubernetes/5e1c3fdc1add0d0001dff534/c

