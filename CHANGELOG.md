# Changelog

All notable user-visible changes to the mStream TOS application package.

## 6.33.1-1 — 2026-11-15

### Added
- First release. mStream (`linuxserver/mstream:6.33.1`, Docker Hub official image, unmodified)
  packaged as a TOS 7 Docker application, published on port 8171 and running
  as a non-root user (1000:1000).
- Persistent data is kept under `/Volume1/DockerAppData/mstreamdocker/`.
