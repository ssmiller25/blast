# Boostrap Instructions

Overall theory is to bootstrap the first "master" node, then apply enough configs to allow for the automated configuration of future nodes.  Might eventually
streamline this portion to be a bit more automated (preseed slipstreamed with ISO perhaps...)  Although future automation might occur once we migrate to an OS
that supports cluster API, and then focus on that mechanism for bootstrap configuration.

*Note:* Physical, in this context, refers to either an actual "physical" box, or a virtual machine that supports nested virtualization
*Note2:* Does not assume an air-gapped installation.  May attempt to build such a thing later


## Automated Server Installation - Master

* Boot x86 system form k3os ISO image
* At the grub boot prompt, press e to edit the first option.  On the line that **starts** with Linux
  * Edit k3os.mode and change to "install"
  * Add the following to the **end** of the line that starts with "linux"

```
k3os.install.device=/dev/sda k3os.install.config_url=https://raw.githubusercontent.com/ssmiller25/blast/main/bootstrap/bnode.yaml
```
* Press Ctrl-X to boot
* Confirm formatting the disk.
* System will install and reboot automatically

Note: Only the users specified in the config.yaml will be able to access the "rancher" user on the system

## Phase 1 - Master Bootstrap Secrets

Make sure your desktop environemnt is setup correctly.  [Check out arkade](https://github.com/alexellis/arkade) to help with this:

```sh
curl -sLS https://dl.get-arkade.dev | sudo sh
arkade get kubectl
arkade get kubectx
arkade get kubeseal
```

Setup temporary authentication with cluster-admin

```sh
scp rancher@<ip of node>:/etc/rancher/k3s/k3s.yaml kubeconfig.blast
# Edit server IP in kubeconfig.blast to represent cluster itself
export KUBECONFIG=$(pwd)/kubeconfig.blast
kubectl get nodes -o wide  # Verify nodes are working and in place
```

Install phase1

```sh
cd deploy/phase1/
kubectl apply -k .
```

Longhorn may take a while to come up.  Wait for `kubectl get all -n longhorn-system` to come back clean.

Once done, will need to generate a TLS certificate
for matchbox (based on <https://coreos.com/matchbox/docs/latest/deployment.html#generate-tls-credentials>)

**Note:** Will eventually be replaced by a far more k8s centric approach/not attached to my cluster info.  Perhaps a quick job in a light-weight container.

Might also look at moving to cfssl instead of openssl

Also, remember that sealedscrets's encryption **is tied to the namespace**

```sh
cd scripts/matchbox-tls/
export SAN=DNS.1:matchbox-rpc.r15cookie.lan,IP.1:172.18.110.81
./cert-gen
kubectl create secret generic matchbox-rpc -n blast --from-file=ca.crt --from-file=server.crt --from-file=server.key --dry-run -o yaml | kubeseal -o yaml > ../../deploy/base/blast/matchbox-rpc-secret.yaml
kubectl create secret generic 
cd base/blast/
kubectl create secret generic mysecret --dry-run --from-file=foo=/dev/stdin -o json \
  | kubeseal > mysealedsecret.json
```

## Phase 2 - Master Required Services

Apply deploy/example-homelab/bootstrap-phase2/ configs to master.  Should be enough to allow user
interaction and to permit bootstraping additional nodes.  )

```sh
cd deploy/example-homelab/bootstrap-phase2/
kubectl apply -k .
```


## Matchbox - Prep Images

*TODO* Move to some sort of startup/bootstrap container - or somehow better integrated into system
Also meet to move matchbox container to using soemthing like hostDir for a LITTLE perssitent before storage layer up.

Inspired by (https://github.com/rancher/k3os/issues/56#issuecomment-557799651
Also by https://github.com/leigh-j/k3os-ipxe/blob/master/boot.ipxe 
Also...do I need matchbox.  Should I just you plain nginx container?

  - Looks like images themsevles expect to be in assets...so going with that
  - In container, /var/lib/matchbox/assets
```sh
mkdir /var/lib/matchbox/assets/k3os-v0.10.2; cd /var/lib/matchbox/assets/k3os-v0.10.2
wget https://github.com/rancher/k3os/releases/download/v0.10.2/sha256sum-amd64.txt
wget https://github.com/rancher/k3os/releases/download/v0.10.2/k3os-vmlinuz-amd64
wget https://github.com/rancher/k3os/releases/download/v0.10.2/k3os-initrd-amd64
wget https://github.com/rancher/k3os/releases/download/v0.10.2/k3os-amd64.iso
```
  - Using <https://github.com/poseidon/matchbox/tree/master/examples> as an example for json configs.  Eventually
    will wrap into a configmap of some sort...
    - profiles/k3os.json (of my own creation)

## OLD/DONOTUSE Manual Server Installation - Master

* Boot x86 system from k3os ISO Image
* Login with rancher
* Run installation command

```sh
sudo k3os install
```

** 1 - Install Server
** Config system with cloud-init file: N
** Authorize Github users with SSH: N
** Password to rancher: my usual root password
** Configure Wifi?: N
** Run as server or agent:  1 - Server
** Token or cluster secret: Leave blank
** Format Disk: Y

Once booted, put k3s-master/config.yaml into the /var/lib/rancher/k3os/ directory on the server

*TODO:* Bootstrap parameters to pull config from github and/or local repo directly?

# Initial Master Configuration

* Configure k3s
* Install Longhorn
* Install apt-cacher-ng
* Install Matchbox

## Older - Physical Server Installation - Master

* Boot x86 system from Ubuntu Server LiveCD
* Installation Language: English
* Update new installer if prompted
* Keep English keyboard layout
* Network: Specify static IP for network interface
* Proxy: No Mirror
* Disk Layout: Use entire disk, no LVM
* Setup appropriate hostname and username/password
* Install OpenSSH Server
* Leave all other snaps unselected
* Wait for Installation

*DONE:*  Below still to do

