:orphan:

####################
Unit 1.35.0 Released
####################

We are pleased to announce the release of FreeUnit 1.35.0,
the first release under the FreeUnit community fork,
continued after the original NGINX Unit project was archived in October 2025.

**New language runtime support**

- PHP 8.4 and PHP 8.5 are now supported and included in the CI matrix.

- Ruby 3.4 is now supported. Ruby 3.2 has been removed from the CI matrix
  as it reached end-of-life in March 2025 and its headers are incompatible
  with GCC 13+.

**Docker images**

- All Docker base images have been updated from Debian bookworm to trixie.

- A new :file:`Dockerfile.php8.5` image variant is available.

**Build**

- OpenTelemetry (:option:`--otel`) is now included in the standard CI
  build flags.

**Project**

- Copyright and versioning updated to FreeUnit Community.

- :file:`README.md`, :file:`CONTRIBUTING.md`, and :file:`SECURITY.md`
  rewritten for the community fork.
  Security issues should be reported to
  `team@freeunit.org <mailto:team@freeunit.org>`__.

**************
Full Changelog
**************

.. code-block:: none

  Changes with Unit 1.35.0                                          03 Apr 2026

      *) Feature: PHP 8.4 and PHP 8.5 language module support.

      *) Feature: Ruby 3.4 language module support.

      *) Change: Docker base images updated from bookworm to trixie;
         new php8.5 image variant added.

      *) Change: OpenTelemetry (--otel) added to default CI build.

      *) Change: Ruby 3.2 removed from CI (EOL March 2025; incompatible
         with GCC 13+ headers).

      *) Misc: rebranded as FreeUnit community fork; updated copyright,
         README, CONTRIBUTING, SECURITY.
