# Blast core configuration

The "core" of blast, an system to auto-provision hardware.  A few notes:

- Assumes you wish to run a proxy DHCP, with another primary DHCP server
  used for most activity
- The hostname for "matchbox.<domain>.<tld>" must be resovlable by the DNS
  provided by your primary DHCP server.  You could leverage DNS by your primary
  cluster, depending on your home equipment.  For a unifi system the following command
  can be used to forward requests:

```sh
configure
set service dns forwarding options server=/r15cookie.lan/172.18.110.81
commit
save
```

## Virtualbox testing

The build in iPXE system didn't appear to work with Matchbox's changed iPXE.  To get around

1. Download [iPXE ISO](http://boot.ipxe.org/ipxe.iso)
2. Boot from ISO
3. Break into iPXE command line, and enter the following commands:

```sh
dhcp
chain http://matchbox.r15cookie.lan/ipxe
```
## Notes

- [Matchbox Concepts](https://matchbox.psdn.io/matchbox/)
