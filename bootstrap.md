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
k3os.install.device=/dev/sda k3os.install.config_url=https://raw.githubusercontent.com/ssmiller25/blast/master/k3s-master/config.yaml
```
* Press Ctrl-X to boot
* Confirm formatting the disk.
* System will install and reboot automatically

Note: Only the users specified in the config.yaml will be able to access the "rancher" user on the system

## Phase 1 - Master Bootstrap

Apply deploy/k3s-master-phase1/ configs to master.  Should be enough to allow user
interaction and to permit bootstraping additional nodes.

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

