# Boostrap Instructions

Overall theory is to bootstrap the first "master" node, then apply enough configs to allow for the automated configuration of future nodes.  Might eventually
streamline this portion to be a bit more automated (preseed slipstreamed with ISO perhaps...)  Although future automation might occur once we migrate to an OS
that supports cluster API, and then focus on that mechanism for bootstrap configuration.

*Note:* Physical, in this context, refers to either an actual "physical" box, or a virtual machine that supports nested virtualization
*Note2:* Does not assume an air-gapped installation.  May attempt to build such a thing later

## Physical Server Installation - Master

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

# Initial Master Configuration

* Install k3s
* Install Longhorn
* Install apt-cacher-ng
* Install Matchbox