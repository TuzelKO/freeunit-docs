:orphan:

####################
Unit 1.35.4 Released
####################

FreeUnit 1.35.4 fixes a router CPU spin and connection hang under port
scanning load, reduces the default HTTP keep-alive idle timeout, and
ships a Docker seccomp profile mitigating CVE-2026-31431.

**Router**

- Fixed CPU spin and connection hang under port scanning load: CLOSE-WAIT
  sockets are now cleaned up properly on client FIN, idle connection queue
  iteration fixed, systemd file descriptor limit increased to 65535.

**HTTP**

- Default HTTP keep-alive ``idle_timeout`` reduced from 180 to 30 seconds.

**Dependencies**

- wasmtime upgraded to 43.0.1; wasi-sysroot SHA512 checksum updated.

**Security**

- **CVE-2026-31431** (`copy.fail <https://copy.fail/>`_): all official Docker
  images now ship ``/usr/share/unit/seccomp-no-af-alg.json``, a seccomp
  profile that blocks ``socket(AF_ALG, ...)`` (domain 38).

  CVE-2026-31431 is a local privilege escalation (CVSS 7.8) in the Linux
  kernel ``algif_aead`` component, reachable via the ``AF_ALG`` socket
  interface.  A 732-byte Python proof-of-concept achieves root from any
  unprivileged user, including inside a container, without race conditions.
  Affected: kernels 4.14–present on Ubuntu 24.04, Amazon Linux 2023, RHEL 10,
  SUSE 16, and others.

  Apply the mitigation:

  .. code-block:: console

     # docker run --security-opt seccomp=pkg/docker/seccomp-no-af-alg.json \
           ghcr.io/freeunitorg/freeunit:latest-php8.4

  See the :ref:`security guide <security-seccomp-docker>` for extraction
  instructions, host-level workaround (``modprobe.d``), and verification.
- Vendor strings and documentation URLs updated in all Debian module
  packaging files (``NGINX Unit`` → ``FreeUnit``,
  ``unit.nginx.org`` → ``docs.freeunit.org``).

**Tests**

- Replaced removed ``cgi`` module with ``email.parser`` in Python upload
  test fixture; fixes test suite on Python 3.13.

**************
Full Changelog
**************

.. code-block:: none

  Changes with FreeUnit 1.35.4                                     30 Apr 2026

      *) Bugfix: fix router process CPU spin and connection hang under port
         scanning load; CLOSE-WAIT sockets are now cleaned up properly on
         client FIN, idle connection queue iteration fixed, systemd file
         descriptor limit increased to 65535.

      *) Change: default HTTP keep-alive idle_timeout reduced from 180 to 30
         seconds.

      *) Change: upgrade wasmtime to 43.0.1; update wasi-sysroot SHA512
         checksum.

      *) Bugfix: replace removed cgi module with email.parser in Python
         upload test fixture; fixes test suite compatibility with Python 3.13.
