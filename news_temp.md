1.35.3
FreeUnit v1.35.2
## ✅ LGTM! Build successfully verified

Thanks for the PR! All changes have been tested locally, no issues found.

### Verified:
- ✅ **njs** — version 0.9.6 from fork https://github.com/freeunitorg/njs
- ✅ **libunit-wasm** — version 0.5.0 from fork https://github.com/freeunitorg/freeunit-wasm
- ✅ **Local build of all containers** — successfully built 21 environments:
    - minimal, wasm, go1.24, go1.25, jsc17, jsc21, node20, node22, perl5.38, perl5.40, php8.3, php8.4, php8.5
    - python3.12, python3.12-slim, python3.13, python3.13-slim, python3.14, python3.14-slim, ruby3.3, ruby3.4
- ✅ **Contrib mirror** — successfully built locally with `CONTRIB_FREEUNIT := https://packages.freeunit.org`

### Key improvements:
- Eliminated QEMU emulation for ARM64 — significant CI speedup
- Upgraded Java 11 (EOL) → Java 17/21 (Eclipse Temurin, Ubuntu Noble)
- Updated dependencies: wasmtime 35→43, wasi-sysroot 24→27, Rust 1.89→1.94
- Added `build-local.sh` and README — convenient for local testing


1.35.2
FreeUnit v1.35.2
fix: upgrade to OpenSSL 3.6 across all builds
Replace deprecated OpenSSL 3.6 APIs:

nxt_cert.c: EVP_PKEY_asn1_find_str/get0_info → OBJ_sn2nid
nxt_openssl.c, auto/ssltls: SSLeay/SSLeay_version → OpenSSL_version_num/OpenSSL_version
Docker images: switch all bookworm base images to trixie (ships OpenSSL 3.6);
eclipse-temurin upgraded jammy→noble (best available without custom build).
ci.yml: build and cache OpenSSL 3.6.0 from source on ubuntu-latest runners
so -Werror -Wdeprecated-declarations catches regressions in all CI jobs.
TODO added with 5 checklist items:
Validate openssl-3.x branch compatibility
Confirm CI matrix (amd64 + arm64) with the new OpenSSL build step
Verify clang-ast passes end-to-end
Smoke-test TLS in the Docker image - Decide what to do about eclipse-temurin (the one image that only reaches OpenSSL 3.3)


v1.35.1
FreeUnit v1.35.1: PHP 8.5, Python 3.14, OTel
Add nxt_php_quit_handler to handle Unit shutdown signal
Register quit callback in async mode initialization
Call ZEND_ASYNC_SHUTDOWN() to trigger graceful coroutine shutdown
Fixes worker processes hanging on server termination
Original author: EdmondDantes
Original commit: 052afd8


1.35.0
Unit 1.35.0 release.
rebrand as FreeUnit community fork
- Update copyright in version file to FreeUnit Community
- Rewrite README.md, CONTRIBUTING.md, SECURITY.md for the fork
- Add PHP 8.4 and PHP 8.5 to CI matrix
- Add --otel to CI build flags
- Switch Docker base images from bookworm to trixie
- Add Dockerfile.php8.5
- Update pkg/docker/Makefile: add php 8.5, trixie variant
- Fix Dockerfile labels and git clone URLs to point to freeunitorg/freeunit- 