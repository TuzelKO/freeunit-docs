:orphan:

####################
Unit 1.35.3 Released
####################

FreeUnit 1.35.3 migrates the contrib package mirror to FreeUnit infrastructure,
upgrades dependencies, and improves CI build performance.

**Infrastructure**

- Contrib package mirror migrated from ``packages.nginx.org`` to
  ``packages.freeunit.org``; all dependency tarballs are now served from
  FreeUnit infrastructure.

- ``unitctl`` Dockerfile GPG key URL migrated to ``freeunit.org``.

**Dependency upgrades**

- njs updated to 0.9.6 from the FreeUnit fork
  (`github.com/freeunitorg/njs <https://github.com/freeunitorg/njs>`_).

- libunit-wasm updated to 0.5.0 from the FreeUnit fork
  (`github.com/freeunitorg/freeunit-wasm <https://github.com/freeunitorg/freeunit-wasm>`_).

- wasmtime 43.0.0, wasi-sysroot 27.0.

- Rust toolchain bumped to 1.94.1 in all Docker images.

**Java**

- Java 11 (EOL) removed from the CI matrix and Docker images; replaced with
  Java 17 and Java 21 based on Eclipse Temurin (Ubuntu Noble).

**CI**

- Docker CI split into native AMD64 and ARM64 build jobs with a separate
  manifest-merge step, eliminating QEMU emulation overhead for ARM64 builds.

**Docker**

- Added :file:`pkg/docker/build-local.sh` script for convenient local image
  building and testing.

**************
Full Changelog
**************

.. code-block:: none

  Changes with FreeUnit 1.35.3                                     07 Apr 2026

      *) Feature: migrate contrib package mirror from packages.nginx.org to
         packages.freeunit.org; all dependency tarballs are now served from
         FreeUnit infrastructure.

      *) Feature: upgrade contrib dependencies — njs 0.9.6, libunit-wasm 0.5.0,
         wasmtime 43.0.0, wasi-sysroot 27.0.

      *) Feature: replace EOL jsc11 Docker image with jsc17 and jsc21 based on
         Eclipse Temurin (Ubuntu Noble).

      *) Feature: split Docker CI into native AMD64 and ARM64 build jobs with a
         separate manifest-merge step; eliminates QEMU emulation overhead.

      *) Change: bump Rust toolchain to 1.94.1 in all Docker images.

      *) Change: unitctl Dockerfile GPG key URL migrated to freeunit.org.
