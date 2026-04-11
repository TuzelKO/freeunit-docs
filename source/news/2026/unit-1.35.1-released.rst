:orphan:

####################
Unit 1.35.1 Released
####################

FreeUnit 1.35.1 is the first release under the FreeUnit community fork,
continued after the original NGINX Unit project was archived in October 2025.

**Docker images**

- Docker images for PHP 8.5, PHP 8.4, and Python 3.14 are now published to
  GitHub Container Registry (GHCR) for ``linux/amd64`` and ``linux/arm64``.

- All Docker base images have been switched from ``debian:bookworm`` to
  ``debian:trixie``.

**PHP**

- Added ``pre_request_init`` SAPI callback support for PHP 8.5
  (``nxt_php_sapi.c``).

- PHP 8.4 and PHP 8.5 added to the CI test matrix.

**CI**

- CI now builds against OpenSSL 3.6.

**Project**

- Forked from ``nginx/unit`` as FreeUnit — community LTS continuation of the
  Unit application server. Security issues should be reported to
  `team@freeunit.org <mailto:team@freeunit.org>`__.

**************
Full Changelog
**************

.. code-block:: none

  Changes with FreeUnit 1.35.1                                     03 Apr 2026

      *) Feature: Docker images for PHP 8.5, PHP 8.4, and Python 3.14
         published to GitHub Container Registry (GHCR) for linux/amd64
         and linux/arm64.

      *) Feature: switch all Docker base images from debian:bookworm to
         debian:trixie.

      *) Feature: add PHP 8.5 pre_request_init SAPI callback support
         (nxt_php_sapi.c).

      *) Feature: add PHP 8.4 and PHP 8.5 to CI test matrix.

      *) Feature: build CI against OpenSSL 3.6.

      *) Change: fork from nginx/unit as FreeUnit — community LTS
         continuation of the Unit application server.
