:orphan:

####################
Unit 1.35.2 Released
####################

FreeUnit 1.35.2 upgrades to OpenSSL 3.6 across all builds,
replacing deprecated APIs and updating Docker base images.

**OpenSSL 3.6**

- Replaced deprecated OpenSSL APIs:

  - :file:`nxt_cert.c`: :func:`EVP_PKEY_asn1_find_str` /
    :func:`get0_info` replaced with :func:`OBJ_sn2nid`.

  - :file:`nxt_openssl.c`, :file:`auto/ssltls`: :func:`SSLeay` /
    :func:`SSLeay_version` replaced with :func:`OpenSSL_version_num` /
    :func:`OpenSSL_version`.

- CI now builds and caches OpenSSL 3.6.0 from source on
  :command:`ubuntu-latest` runners so that
  :option:`-Werror -Wdeprecated-declarations` catches regressions
  in all CI jobs.

**Docker images**

- All remaining bookworm base images switched to trixie (ships OpenSSL 3.6).

- Eclipse Temurin upgraded from jammy to noble.

**************
Full Changelog
**************

.. code-block:: none

  Changes with Unit 1.35.2                                          05 Apr 2026

      *) Change: upgraded to OpenSSL 3.6; replaced deprecated EVP and
         SSLeay APIs in nxt_cert.c, nxt_openssl.c, and auto/ssltls.

      *) Change: CI builds OpenSSL 3.6.0 from source; -Wdeprecated-
         declarations enabled as a hard error across all jobs.

      *) Change: Docker bookworm images switched to trixie (OpenSSL 3.6);
         eclipse-temurin upgraded jammy → noble.
