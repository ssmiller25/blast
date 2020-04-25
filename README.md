# Immutable Home Lab

The configuration and documentation for my immutable homelab.  

## Vision and Goals

My vision is a homelab that I can throw random hardware at, and that hardware will be installed and 
configured for use.  The hardware itself can be cheap, or high-end.  Broken out, other goals are:

* **Stability on the network layer:**  Make sure the family can continue to work and play to the best extent possible!  
* **Backup and redundancy:**  Reduce and eliminate any single points of failure
* **Ability to experiment with newer technologies:**  It is a home lab
* **Ability to run older OSes for specific purposes:**  Should be able to spin up as wide a variety of OS architectures as necessary.

## Architecture

### Network

Using Ubiquity EdgerouterX and Ubiquity Unifi wireless for core network needs (DHCP, DNS, Routing)

### Server

* **k3os:**  [Readme for k3os](https://github.com/rancher/k3os#sample-configyaml) indicates kvm is available (shown in example), so going to try to use this as basis 
[Kubernetes Cluster API](https://github.com/kubernetes-sigs/cluster-api)
* **k3s:**  Looking for lightweight, and want to be able to include Raspberry Pi's in my architecture. 
* **[Matchbox](https://github.com/poseidon/matchbox):** PXE Provisioning.  Would be nice to be install-less, but for now it'll just host the Ubuntu Network boot and ISOs for network installation
* **[Klum](https://github.com/ibuildthecloud/klum):**  Easy way to manage users/kubeconfigs
* **Longhorn** Distributed storage.  Would rather avoid
* **[NFS Server](https://estl.tech/multi-writer-file-storage-on-gke-6d044ec96a46)** for RWM volumes if necessary
* **Backup: ** Built in backup in Longhorn.   Might need to run quick NFS server, attached to USB drive, to "receive" backup. Or <https://restic.net/> could be used to get good deduplication. 
* **Kube-virt** for virtualization outside of docker/linux
* GitOps workflow
  * Gitea for version control of local manifests
  * [Harbor](https://github.com/goharbor/harbor) for local docker images, including [pass through configuration](https://github.com/goharbor/harbor/blob/master/contrib/Configure_mirror.md)
  * Flux for deployment
  * Tekton for workflow/job needs

### Applications/Resource
* Pi-hole on Kubernetes: https://github.com/MoJo2600/pihole-kubernetes
  * [And configure for local DNS resolution!] - Detailed in Helm Chart details
* Plex
* HomeAssistant
* General Fileserver 
* Ubiquity management (UNMS)
* [Skydive](https://github.com/skydive-project/skydive): Might be a great network visualization tool. . . 
* [Online Dev with Eclipse Che](https://www.eclipse.org/che/docs/che-7/introduction-to-eclipse-che/)
* Local static page with all available management links (and services hosted by network)
* Website for captive portal for guests
* apt-cacher-ng: Mostly for existing Debian/Ubuntu based systems.  Might not be necessary in later builds


Source Info:
https://kauri.io/build-your-very-own-self-hosting-platform-with-raspberry-pi-and-kubernetes/5e1c3fdc1add0d0001dff534/c

