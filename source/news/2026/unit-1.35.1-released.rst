:orphan:

####################
Unit 1.35.1 Released
####################

FreeUnit 1.35.1 adds PHP 8.5, Python 3.14, and OpenTelemetry improvements,
along with a critical fix for PHP worker processes hanging on server shutdown.

**PHP 8.5**

- Added :func:`nxt_php_quit_handler` to handle the Unit shutdown signal
  in PHP 8.5 async mode.

- Registers a quit callback during async mode initialization and calls
  :func:`ZEND_ASYNC_SHUTDOWN` to trigger graceful coroutine shutdown,
  fixing worker processes hanging on server termination.

**************
Full Changelog
**************

.. code-block:: none

  Changes with Unit 1.35.1                                          04 Apr 2026

      *) Bugfix: PHP worker processes hanging on server termination when
         using PHP 8.5 async mode; added nxt_php_quit_handler to call
         ZEND_ASYNC_SHUTDOWN for graceful coroutine shutdown.
