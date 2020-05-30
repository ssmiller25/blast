# PiHole Kustomize

Based on Helm chart https://mojo2600.github.io/pihole-kubernetes/ but migrated
to Kustomize.  The helmOperator used by k3s does not handle config changes and helm
redeployment well, so moving away from that methodology.
