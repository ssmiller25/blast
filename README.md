# Blast

[Blast](https://acronymify.com/BLAST?q=bare+metal+immutable+cluster) (**B**are Meta**l** Immut**a**ble clu**st**er) for an immutable, low-cost Kuberetes Distribution, based on [Talos](https://www.talos.dev/), [Sidero](https://www.sidero.dev/) and the [Kubernetes Cluster API](https://cluster-api.sigs.k8s.io/).

## Vision and Goals

My vision is a cluster that can be composed of a variety of low end systems (Intel NUC like) that will leverage distributed technologies to provided a distributed, fault tolerant system.

## Architecture

### Network

Using Ubiquity EdgerouterX and Ubiquity Unifi wireless for core network needs (DHCP, DNS, Routing)

### Server

- **[Talos](https://www.talos.dev/):**  Purpose build immutable OS for Kubernetes, with support for the [Kubernetes Cluster API](https://cluster-api.sigs.k8s.io/) for management
- **[Sidero](https://www.sidero.dev/):**  Bare metal provisioning of talos
- **[Klum](https://github.com/ibuildthecloud/klum):**  Easy way to manage users/kubeconfigs
- **Storage** 
  - **Longhorn** or **Rook** Distributed storage.  Would rather avoid centralized NAS/storage for primary storage
  - **hostdir** for large or IO intensive storage.  Backup would have to be one-off jobs.
- **Backup:** Built in backup in Longhorn.   

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

