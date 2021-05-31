# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## Changed

### Overall

- Major cleanup away from k3os/Matchbox to Talos/Sideo.  Talos more fully supports [Cluster API](https://cluster-api.sigs.k8s.io/).  Also has a [fully documented process for bootstrapping bare metal](https://www.sidero.dev/docs/v0.2/guides/bootstrapping/), a primary usecase for this cluster.

### deploy/base/*
  
- Moved most actual apps to [blast-apps](https://github.com/ssmiller25/blast-apps/)

## [0.1.0] - 2021-05-31

The "Original" version of blast:

- k3OS/k3s based
- Matchbox PXE 
- Longhorn or hostdir for Storage
