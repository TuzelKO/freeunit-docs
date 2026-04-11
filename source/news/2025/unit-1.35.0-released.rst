:orphan:

####################
Unit 1.35.0 Released
####################

We are pleased to announce the release of NGINX Unit 1.35.0.

**Security**

- CVE-2025-1695: when the Java language module is in use, undisclosed requests
  could trigger an infinite loop and cause excessive CPU usage due to missing
  WebSocket payload length validation. Both issues affect Unit 1.11.0–1.34.2;
  users of the Java module with WebSockets should upgrade.

  `F5 SIRT advisory K000149959 <https://my.f5.com/manage/s/article/K000149959>`__.

**New features**

- HTTP response compression is now supported natively.

- PHP 8.5 compatibility.

- Ruby 3.4 compatibility.

- Django 5.x compatibility.

- Python Litestar WebSockets compatibility.

- GCC 15 compatibility.

**Changes**

- If building with njs, version 0.9.0 or later is now required.

**Bug fixes**

- ``SERVER_PORT`` is now set to the actual port value.

- Fixed duplicate headers in Node.js responses.

- Fixed WebSocket connectivity with Firefox.

- Fixed instability in OpenTelemetry (OTEL) support.

- Fixed build issues with OpenTelemetry on various platforms including macOS.

**************
Full Changelog
**************

.. code-block:: none

  Changes with Unit 1.35.0                                         03 Sep 2025

      *) Security: fix missing websocket payload length validation in the Java
         language module which could lead to Java language module processes
         consuming excess CPU. (CVE-2025-1695).

      *) Change: if building with njs, version 0.9.0 or later is now required.

      *) Feature: HTTP compression.

      *) Feature: PHP 8.5 compatibility.

      *) Feature: Ruby 3.4 compatibility.

      *) Feature: Django 5.x compatibility.

      *) Feature: Python Litestar WebSockets compatibility.

      *) Feature: GCC 15 compatibility.

      *) Bugfix: set SERVER_PORT to the actual value.

      *) Bugfix: fix issue in node.js with duplicate headers in response.

      *) Bugfix: fix WebSockets with Firefox.

      *) Bugfix: fix incorrect websocket payload length calculation in the
         Java language module.

      *) Bugfix: fix instability issues due to OpenTelemetry (OTEL) support.

      *) Bugfix: fix issues with building OpenTelemetry (OTEL) support on
         various platforms, including macOS.