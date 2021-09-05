# Roadmap

General feature roadmap for the Blast Cluster

- *v0.2.0* - MVP
  - Kind Cluster Buildout
  - Minimal Development Frontend (cdr/code-server)
  - Enough tooling to build out Civo k3s clusters in cloud
  - Testing framework
- *v0.3.0* - Refinement
  - TalosOS cluster-api deployable to a cloud provider of some sort
- *v1.0.0* - Bare Metal Enabled
  - Full bootstrap to install bare-metal clusters easily
  - Management of multiple Cloud Providers through ClusterAPI
- *v1.5.0* - AirGap!
  - Airgap installation possible
  - Local Repo (Gitea) - For overlay configuration, and secrets NOT stores accessibly
  - Docker Image repository (solutino should support a pass through configuration for partial air-gapped configuration)
