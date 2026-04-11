:orphan:

####################
Unit 1.35.3 Released
####################

FreeUnit 1.35.3 focuses on CI infrastructure improvements,
dependency upgrades, and ARM64 build optimizations.

**CI and build**

- Eliminated QEMU emulation for ARM64 builds — significant CI speedup.

- njs updated to version 0.9.6 from the FreeUnit fork
  (`github.com/freeunitorg/njs <https://github.com/freeunitorg/njs>`_).

- libunit-wasm updated to version 0.5.0 from the FreeUnit fork
  (`github.com/freeunitorg/freeunit-wasm <https://github.com/freeunitorg/freeunit-wasm>`_).

- Dependencies updated: wasmtime 35 → 43, wasi-sysroot 24 → 27,
  Rust 1.89 → 1.94.

**Java**

- Java 11 (EOL) removed from the CI matrix; replaced with
  Java 17 and Java 21 (Eclipse Temurin on Ubuntu Noble).

**Docker**

- Successfully builds and verifies 21 image variants:
  minimal, wasm, go1.24, go1.25, jsc17, jsc21, node20, node22,
  perl5.38, perl5.40, php8.3, php8.4, php8.5,
  python3.12, python3.12-slim, python3.13, python3.13-slim,
  python3.14, python3.14-slim, ruby3.3, ruby3.4.

- Added :file:`build-local.sh` script and documentation for
  convenient local image testing.

**************
Full Changelog
**************

.. code-block:: none

  Changes with Unit 1.35.3                                          07 Apr 2026

      *) Change: eliminated QEMU emulation for ARM64 CI builds.

      *) Change: njs updated to 0.9.6 (freeunitorg/njs fork).

      *) Change: libunit-wasm updated to 0.5.0 (freeunitorg/freeunit-wasm).

      *) Change: wasmtime 35→43, wasi-sysroot 24→27, Rust 1.89→1.94.

      *) Change: Java 11 (EOL) removed; CI matrix now covers Java 17
         and Java 21 on Eclipse Temurin / Ubuntu Noble.

      *) Misc: added build-local.sh for local Docker image testing.
