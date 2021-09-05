# Blast Apps

Application that can be referenced by a core [Blast](https://github.com/ssmiller25/blast) cluster.  Although customized for Blast, can be leveraged in most Kubernetes environments.  Some assumptions will be made:

- PV provided by longhorn (although not hard-coded, but an operational dynamic PVC provision system will be expected)
- Ingress available.

Generally will leverage Kustomize exclusively for deployment.  If a Helm chart is ported, a local Makefile will be responsible.


## TODO:

- **[NFS Server](https://estl.tech/multi-writer-file-storage-on-gke-6d044ec96a46)** for RWM volumes if necessary
- **External Backups:** A <https://restic.net/> server to get good deduplication.
- **Kubevirt** for virtualization outside of docker/linux
  - [OKD Dashboard for KubeVirt](https://kubevirt.io/2020/OKD-web-console-install.html)
- **[Kubebox](https://github.com/astefanutti/kubebox):**  Terminal/Web Console for k8s
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
- Local static page with all available management links (and services hosted by network)
- Website for captive portal for guests
- apt-cacher-ng: Mostly for existing Debian/Ubuntu based systems.  Might not be necessary in later builds


### Aditional Research

Source Info:
<https://kauri.io/build-your-very-own-self-hosting-platform-with-raspberry-pi-and-kubernetes/5e1c3fdc1add0d0001dff534/c>

Origianl repo (private): [Blast-apps](https://github.com/ssmiller25/blast-apps)