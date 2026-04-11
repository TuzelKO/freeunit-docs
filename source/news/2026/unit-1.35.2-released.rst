:orphan:

####################
Unit 1.35.2 Released
####################

FreeUnit 1.35.2 is a bug-fix release addressing PHP 8.5 worker shutdown
and build compatibility issues.

**PHP**

- Fixed graceful shutdown for PHP workers running in TrueAsync mode. Workers
  now exit cleanly when Unit delivers a quit signal instead of blocking
  indefinitely in the event loop.

- Guarded ``pre_request_init`` SAPI callback registration with
  ``NXT_PHP_PRE_REQUEST_INIT`` to fix builds against PHP versions that do not
  expose this callback.

**CI**

- Fixed Ruby language module build in the ``clang-ast`` workflow on
  ``debian:testing``: resolved a Debian multiarch library path mismatch and
  suppressed ``-Wdefault-const-init-field-unsafe`` from clang 21 on Ruby 3.3
  headers.

**************
Full Changelog
**************

.. code-block:: none

  Changes with FreeUnit 1.35.2                                     04 Apr 2026

      *) Bugfix: fix graceful shutdown for PHP workers running in TrueAsync
         mode; workers now exit cleanly when Unit delivers a quit signal
         instead of blocking indefinitely in the event loop.

      *) Bugfix: guard pre_request_init SAPI callback registration with
         NXT_PHP_PRE_REQUEST_INIT to fix builds against PHP versions that
         do not expose this callback.

      *) CI: fix Ruby language module build in clang-ast workflow on
         debian:testing — resolve Debian multiarch library path mismatch
         and suppress -Wdefault-const-init-field-unsafe from clang 21 on
         Ruby 3.3 headers.
