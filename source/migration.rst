.. meta::
 :og:description: Migrate from archived Unit installations or community packages
 to the community-maintained FreeUnit fork.

.. include:: include/replace.rst

#########
Migration
#########

This guide helps you migrate from archived Unit installations
or community-maintained packages to **FreeUnit**,
the community-maintained LTS fork.

.. note::
 FreeUnit is ABI-compatible with previous Unit builds.
 In most cases, migration requires only switching to a new build source
 — no configuration changes needed.

.. warning::
 **Official RPM/DEB packages for FreeUnit are coming soon.**
 As of April 2026, FreeUnit is distributed via:

 - :ref:`Docker official images <migration-docker>`
 - :ref:`Source builds <migration-source>`
 - Pre-built ``unitctl`` binaries from GitHub Releases

 Native package manager support (APT/YUM) is in active development.
 Track progress at: https://github.com/freeunitorg/freeunit/milestone/2

You can migrate to FreeUnit in three alternative ways:

- Run our :ref:`Docker official images <migration-docker>`,
 prepackaged with varied language combinations.

- To fine-tune FreeUnit to your goals,
 download the :ref:`sources <migration-source>`,
 install the :ref:`toolchain <source-prereqs>`,
 and :ref:`build <migration-source-build>` a custom binary from scratch.

- For RHEL/Fedora users who want to keep Remi's PHP packages,
 try the :ref:`hybrid approach <migration-remi-hybrid>`
 (FreeUnit core + Remi PHP modules).

.. note::
 The commands in this document starting with a hash (#) must be run as root or
 with superuser privileges.

.. _migration-community-repos:

******************************
Community Repositories
******************************

.. warning::
 These distributions are maintained by their respective communities,
 not the FreeUnit project.
 Packages may be outdated or lack security updates.

.. tabs::
 :prefix: community
 :toc:

 .. tab:: Alpine

 .. warning::
  Alpine's Unit packages may be outdated.
  For security updates and PHP 8.3+ support,
  migrating to the latest FreeUnit build is recommended.

 To migrate from Alpine's Unit packages to FreeUnit:

 #. **Remove existing Unit packages**

    .. code-block:: console

     # apk del unit unit-openrc unit-perl unit-php* unit-python* unit-ruby

 #. **Build FreeUnit from source**

    .. code-block:: console

     # apk add build-base openssl-dev pcre2-dev libxslt-dev
     # git clone https://github.com/freeunitorg/freeunit
     # cd freeunit
     # ./configure --openssl --modules=php:8.4,python:3.13,nodejs:22
     # make
     # make install

 #. **Set up OpenRC service**

    .. code-block:: console

     # cp pkg/openrc/unit /etc/init.d/
     # rc-update add unit
     # rc-service unit restart

 Runtime details:

 .. list-table::

  * - Control :ref:`socket`
    - **/run/control.unit.sock**

  * - Log :ref:`file`
    - **/var/log/unit.log**

  * - Non-privileged :ref:`user and group`
    - **unit**

 .. tab:: ALT

 .. warning::
  ALT Linux's Unit packages may be outdated.
  For security updates and PHP 8.3+ support,
  migrating to the latest FreeUnit build is recommended.

 To migrate from ALT's Unit packages to FreeUnit:

 #. **Remove existing Unit packages**

    .. code-block:: console

     # apt-get remove unit unit-perl unit-php unit-python3 unit-ruby

 #. **Build FreeUnit from source**

    .. code-block:: console

     # apt-get install build-essential libssl-dev libpcre2-dev libxslt1-dev
     # git clone https://github.com/freeunitorg/freeunit
     # cd freeunit
     # ./configure --openssl --modules=php:8.4,python:3.13,nodejs:22
     # make
     # make install

 #. **Set up systemd service**

    .. code-block:: console

     # cp pkg/systemd/unit.service /etc/systemd/system/
     # systemctl daemon-reload
     # systemctl enable --now unit

 Runtime details:

 .. list-table::

  * - Control :ref:`socket`
    - **/run/unit/control.sock**

  * - Log :ref:`file`
    - **/var/log/unit/unit.log**

  * - Non-privileged :ref:`user and group`
    - **_unit** (mind the **_** prefix)

 .. tab:: Arch

 .. warning::
  Arch AUR Unit packages may be outdated.
  For security updates and PHP 8.3+ support,
  migrating to the latest FreeUnit build is recommended.

 To migrate from Arch's Unit packages to FreeUnit:

 #. **Remove existing AUR package**

    .. code-block:: console

     # pacman -R unit

 #. **Build FreeUnit from source**

    .. code-block:: console

     # pacman -S base-devel openssl pcre2 libxslt
     # git clone https://github.com/freeunitorg/freeunit
     # cd freeunit
     # ./configure --openssl --modules=php:8.4,python:3.13,nodejs:22
     # make
     # make install

 #. **Set up systemd service**

    .. code-block:: console

     # cp pkg/systemd/unit.service /etc/systemd/system/
     # systemctl daemon-reload
     # systemctl enable --now unit

 Runtime details:

 .. list-table::

  * - Control :ref:`socket`
    - **/run/unit/control.sock**

  * - Log :ref:`file`
    - **/var/log/unit/unit.log**

  * - Non-privileged :ref:`user and group`
    - **nobody**

 .. tab:: FreeBSD

 .. warning::
  FreeBSD ports/packages for Unit may be outdated.
  For security updates and PHP 8.3+ support,
  migrating to the latest FreeUnit build is recommended.

 To migrate from FreeBSD's Unit packages to FreeUnit:

 #. **Remove existing packages**

    .. code-block:: console

     # pkg remove unit libunit unit-php* unit-python* unit-ruby*

 #. **Build FreeUnit from source**

    .. code-block:: console

     # pkg install git openssl pcre2 libxslt
     # git clone https://github.com/freeunitorg/freeunit
     # cd freeunit
     # ./configure --openssl --modules=php:8.4,python:3.13,nodejs:22
     # make
     # make install

 #. **Set up service**

    .. code-block:: console

     # cp pkg/freebsd/unitd /usr/local/etc/rc.d/
     # sysrc unitd_enable=YES
     # service unitd restart

 Runtime details:

 .. list-table::

  * - Control :ref:`socket`
    - **/var/run/unit/control.unit.sock**

  * - Log :ref:`file`
    - **/var/log/unit/unit.log**

  * - Non-privileged :ref:`user and group`
    - **www**

 .. tab:: Gentoo

 .. warning::
  Gentoo ebuilds for Unit may be outdated.
  For security updates and PHP 8.3+ support,
  migrating to the latest FreeUnit build is recommended.

 To migrate from Gentoo's Unit packages to FreeUnit:

 #. **Remove existing package**

    .. code-block:: console

     # emerge --deselect www-servers/unit
     # emerge --depclean

 #. **Build FreeUnit from source**

    .. code-block:: console

     # emerge dev-vcs/git dev-libs/openssl dev-libs/libpcre2 dev-libs/libxslt
     # git clone https://github.com/freeunitorg/freeunit
     # cd freeunit
     # ./configure --openssl --modules=php:8.4,python:3.13,nodejs:22
     # make
     # make install

 #. **Set up OpenRC service**

    .. code-block:: console

     # cp pkg/openrc/unit /etc/init.d/
     # rc-update add unit
     # rc-service unit restart

 Runtime details:

 .. list-table::

  * - Control :ref:`socket`
    - **/run/unit.sock**

  * - Log :ref:`file`
    - **/var/log/unit.log**

  * - Non-privileged :ref:`user and group`
    - **nobody**

 .. tab:: NetBSD

 .. warning::
  NetBSD packages for Unit may be outdated.
  For security updates and PHP 8.3+ support,
  migrating to the latest FreeUnit build is recommended.

 To migrate from NetBSD's Unit packages to FreeUnit:

 #. **Remove existing packages**

    .. code-block:: console

     # pkg_delete unit libunit unit-perl unit-python* unit-ruby*

 #. **Build FreeUnit from source**

    .. code-block:: console

     # pkg_add git openssl pcre2 libxslt
     # git clone https://github.com/freeunitorg/freeunit
     # cd freeunit
     # ./configure --openssl --modules=php:8.4,python:3.13,nodejs:22
     # make
     # make install

 #. **Set up service**

    .. code-block:: console

     # cp pkg/netbsd/unit /etc/rc.d/
     # echo "unit=YES" >> /etc/rc.conf
     # service unit restart

 Runtime details:

 .. list-table::

  * - Control :ref:`socket`
    - **/var/run/unit/control.unit.sock**

  * - Log :ref:`file`
    - **/var/log/unit/unit.log**

  * - Non-privileged :ref:`user and group`
    - **unit**

 .. tab:: Nix

 .. warning::
  Nix packages for Unit may be outdated.
  For security updates and PHP 8.3+ support,
  migrating to the latest FreeUnit build is recommended.

 To migrate from Nix's Unit packages to FreeUnit:

 #. **Remove existing package**

    .. code-block:: console

     $ nix-env -e unit

 #. **Build FreeUnit from source**

    .. code-block:: console

     $ nix-env -iA nixpkgs.git nixpkgs.openssl nixpkgs.pcre2
     $ git clone https://github.com/freeunitorg/freeunit
     $ cd freeunit
     $ ./configure --openssl --modules=php:8.4,python:3.13,nodejs:22
     $ make
     $ sudo make install

 #. **Set up systemd service**

    .. code-block:: console

     # cp pkg/systemd/unit.service /etc/systemd/system/
     # systemctl daemon-reload
     # systemctl enable --now unit

 Runtime details:

 .. list-table::

  * - Control :ref:`socket`
    - **/run/unit/control.unit.sock**

  * - Log :ref:`file`
    - **/var/log/unit/unit.log**

  * - Non-privileged :ref:`user and group`
    - **unit**

 .. tab:: OpenBSD

 .. warning::
  OpenBSD packages/ports for Unit may be outdated.
  For security updates and PHP 8.3+ support,
  migrating to the latest FreeUnit build is recommended.

 To migrate from OpenBSD's Unit packages to FreeUnit:

 #. **Remove existing packages**

    .. code-block:: console

     # pkg_delete unit unit-perl unit-php* unit-python unit-ruby

 #. **Build FreeUnit from source**

    .. code-block:: console

     # pkg_add git openssl pcre2 libxslt
     # git clone https://github.com/freeunitorg/freeunit
     # cd freeunit
     # ./configure --openssl --modules=php:8.4,python:3.13,nodejs:22
     # make
     # make install

 #. **Set up rcctl service**

    .. code-block:: console

     # cp pkg/openbsd/unit /etc/rc.d/
     # rcctl enable unit
     # rcctl restart unit

 Runtime details:

 .. list-table::

  * - Control :ref:`socket`
    - **/var/run/unit/control.unit.sock**

  * - Log :ref:`file`
    - **/var/log/unit/unit.log**

  * - Non-privileged :ref:`user and group`
    - **_unit**

 .. tab:: Remi's RPM

 .. warning::
  Remi's repository may provide outdated Unit packages.
  For security updates and PHP 8.3+ support,
  migrating to the latest FreeUnit build is recommended.

 To migrate from Remi's Unit packages to FreeUnit:

 #. **Keep Remi's PHP packages** (optional but recommended)

    FreeUnit's core is fully compatible with Remi's
    ``phpXX-unit-php`` modules. You can continue using Remi
    for PHP runtime packages while running FreeUnit as the core.

 #. **Disable Unit from Remi's repo**

    Prevent conflicts by excluding Unit packages from Remi:

    .. code-block:: ini
     :caption: /etc/yum.repos.d/remi.repo

     [remi]
     name=Remi's RPM repository
     ...
     exclude=unit*

 #. **Build FreeUnit core**

    .. code-block:: console

     # yum install git openssl-devel pcre2-devel libxslt-devel
     # git clone https://github.com/freeunitorg/freeunit
     # cd freeunit
     # ./configure --openssl --prefix=/usr --modules=php:8.4,python:3.13
     # make
     # make install

    .. note::
     Using ``--prefix=/usr`` ensures paths match Remi's package layout
     (``/usr/sbin/unitd``, ``/usr/lib64/unit/modules/``, etc.).

 #. **Verify the installation**

    .. code-block:: console

     # /usr/sbin/unitd --version
     freeunit/X.Y.Z   # Example format; actual version may differ

 #. **Restart FreeUnit**

    .. code-block:: console

     # systemctl restart unit

 Runtime details:

 .. list-table::

  * - Control :ref:`socket`
    - **/run/unit/control.sock**

  * - Log :ref:`file`
    - **/var/log/unit/unit.log**

  * - Non-privileged :ref:`user and group`
    - **nobody**

.. _migration-docker:

****************
Docker Migration
****************

FreeUnit provides official Docker images for easy deployment.

.. _migration-docker-steps:

====
Steps
====

#. **Use FreeUnit's official image**

 Reference the image in your ``Dockerfile`` or ``docker-compose.yml``:

 .. code-block:: docker
  :caption: Example usage

  FROM ghcr.io/freeunitorg/freeunit:latest

 .. note::
  FreeUnit images are hosted on GitHub Container Registry:
  https://github.com/freeunitorg/freeunit/pkgs/container/freeunit

  Available tags:

  - ``latest`` — Full-featured image with all language modules
  - ``minimal`` — Base image without language modules
  - ``php`` — PHP-only variant
  - ``python`` — Python-only variant
  - ``nodejs`` — Node.js-only variant
  - ``go`` — Go-only variant
  - ``ruby`` — Ruby-only variant
  - ``perl`` — Perl-only variant
  - ``wasm`` — WebAssembly (WASI 0.2) support

  Version-pinned tags (examples):
  - ``1.35.3``, ``1.35``, ``1`` — Core version only
  - ``1.35.3-php``, ``1.35-php`` — PHP variant with version pin
  - ``1.35.3-python``, ``1.35-python`` — Python variant

  Each tag is available for both ``amd64`` and ``arm64`` architectures.
  Multi-arch manifests are automatically created on release.

#. **Verify the image**

 .. code-block:: console

  $ docker run --rm ghcr.io/freeunitorg/freeunit:latest unitd --version
  freeunit/X.Y.Z   # Example format; actual version may differ

 .. note::
  The ``freeunit/`` prefix confirms the community fork.

#. **Deploy**

 Pull the image and start your containers:

 .. code-block:: console

  # docker-compose pull
  # docker-compose up -d

.. _migration-docker-custom:

====
Custom Images
====

If you build custom images, use FreeUnit as your base:

.. code-block:: docker
 :caption: Dockerfile

 FROM ghcr.io/freeunitorg/freeunit:minimal AS unit-base

 # Your custom layers below
 COPY --from=unit-base /usr/lib/unit/modules /usr/lib/unit/modules
 # ... rest of your Dockerfile

.. note::
 All runtime paths, environment variables, and entrypoint behavior
 remain unchanged. Your existing Docker configuration works as-is.

.. _migration-source:

****************
Build FreeUnit from Source
****************

For bare-metal deployments or when you need maximum control,
build FreeUnit from source.

.. _migration-source-prereqs:

====
Prerequisites
====

FreeUnit compiles and runs on various Unix-like operating systems, including:

- FreeBSD || 10 or later
- Linux || 2.6 or later
- macOS || 10.6 or later
- Solaris || 11

App languages and platforms that FreeUnit can run:

- Go || 1.24 or later
- Java || 17 or later (via JSC)
- Node.js || 20 or later
- PHP || 8.3, 8.4, 8.5
- Perl || 5.38 or later
- Python || 3.12, 3.13, 3.14
- Ruby || 3.3 or later
- WebAssembly Components WASI || 0.2

Optional dependencies:

- OpenSSL 1.0.1 or later for :ref:`TLS` support
- PCRE (8.0+) or PCRE2 (10.23+) for :ref:`regex`
- Wasmtime for WebAssembly support

.. _migration-source-build:

====
Build and Install FreeUnit
====

#. **Clone the FreeUnit repository**

 .. code-block:: console

  $ git clone https://github.com/freeunitorg/freeunit
  $ cd freeunit

#. **Configure the FreeUnit build**

 Enable the modules you need:

 .. code-block:: console

  $ ./configure --openssl --otel \
       --modules=php:8.4,python:3.13,nodejs:22,go1.25,ruby3.4,perl5.40

 .. note::
  Run ``./configure --help`` to see all available options.
  For PHP, you can specify multiple versions: ``php:8.3,php:8.4,php:8.5``.
  Supported language versions as of April 2026:

  - **PHP**: 8.3, 8.4, 8.5
  - **Python**: 3.12, 3.13, 3.14
  - **Node.js**: 20, 22, 24
  - **Go**: 1.24, 1.25, 1.26
  - **Ruby**: 3.3, 3.4
  - **Perl**: 5.38, 5.40
  - **Java (JSC)**: 17, 21 (OpenJDK LTS for .war/.jsp applications)
  - **WebAssembly**: WASI 0.2

#. **Compile and install FreeUnit**

 .. code-block:: console

  $ make
  # make install   # or: sudo make install

 This installs:
 - ``unitd`` to ``/usr/local/sbin/``
 - ``unitctl`` to ``/usr/local/bin/``
 - Modules to ``/usr/local/lib/unit/modules/``
 - Default config directory: ``/usr/local/etc/unit/``

#. **Set up systemd service** (optional but recommended)

 Copy the provided unit file:

 .. code-block:: console

  # cp pkg/systemd/unit.service /etc/systemd/system/
  # systemctl daemon-reload
  # systemctl enable --now unit

#. **Verify the FreeUnit installation**

 .. code-block:: console

  $ unitd --version
  freeunit/X.Y.Z

.. _migration-runtime-compatibility:

*********************
Runtime Compatibility
*********************

FreeUnit preserves full compatibility with previous Unit builds:

.. list-table::

 * - Control socket
   - ``/run/unit/control.sock`` (unchanged)
 * - Log file
   - ``/var/log/unit/unit.log`` (unchanged)
 * - Configuration path
   - ``/etc/unit/config.json`` (unchanged)
 * - State directory
   - ``/var/lib/unit/`` (unchanged)
 * - User/group defaults
   - ``unit:unit`` or distribution default (unchanged)
 * - Systemd service name
   - ``unit.service`` (unchanged)

.. _migration-troubleshooting:

****************
Troubleshooting FreeUnit
****************

.. nxt_details:: FreeUnit fails to start after migration
 :hash: migration-start-fail

 If FreeUnit doesn't start after updating:

 #. Check the log:

    .. code-block:: console

     # journalctl -u unit -n 50
     # tail -f /var/log/unit/unit.log

 #. Verify module compatibility:

    .. code-block:: console

     # ls -la /usr/lib64/unit/modules/  # RHEL/Fedora
     # ls -la /usr/lib/unit/modules/    # Debian/Ubuntu

 #. Ensure matching versions:

    .. code-block:: console

     $ unitd --version
     $ rpm -qa | grep unit  # or: dpkg -l | grep unit

    All ``unit-*`` components should share the same version.

 #. Restart with debug output:

    .. code-block:: console

     # systemctl stop unit
     # unitd --no-daemon --control /run/unit/control.sock --log /var/log/unit/unit.log

.. nxt_details:: PHP module not detected in FreeUnit
 :hash: migration-php-module

 If your PHP application isn't recognized by FreeUnit:

 #. Confirm the module is installed or built:

    .. code-block:: console

     # rpm -qa | grep unit-php  # RHEL/Fedora (Remi packages)
     # ./configure --help | grep php  # Source build check

 #. Check module loading:

    .. code-block:: console

     # unitd --test-config /etc/unit/config.json

 #. Restart FreeUnit to reload modules:

    .. code-block:: console

     # systemctl restart unit

 #. Verify PHP SAPI in your app config:

    .. code-block:: json
     :caption: Example application config

     {
       "type": "php",
       "root": "/var/www/myapp",
       "index": "index.php",
       "script": "index.php"
     }

.. _migration-roll-back:

****************
Rollback Procedure
****************

If you need to revert to the previous setup:

#. **Stop FreeUnit**

 .. code-block:: console

  # systemctl stop unit

#. **Restore previous binary or image**

 .. tabs::
  :prefix: rollback-method

  .. tab:: Docker

   Revert the image tag in your ``docker-compose.yml`` or ``Dockerfile``:

   .. code-block:: docker

    FROM ghcr.io/freeunitorg/freeunit:1.35.0   # Previous pinned version

   Then redeploy:

   .. code-block:: console

    # docker-compose pull
    # docker-compose up -d

  .. tab:: Source build

   Rebuild the previous version from source:

   .. code-block:: console

    $ git clone https://github.com/freeunitorg/freeunit
    $ cd freeunit
    $ git checkout 1.35.0   # Or your previous version tag
    $ ./configure --openssl
    $ make
    # make install

  .. tab:: Community repositories

   Reinstall the original package from your distribution:

   .. tabs::
    :prefix: rollback-reinstall

    .. tab:: Alpine

     .. code-block:: console

      # apk add unit

    .. tab:: Arch

     .. code-block:: console

      $ yay -S unit

    .. tab:: FreeBSD

     .. code-block:: console

      # pkg install unit

    .. tab:: Gentoo

     .. code-block:: console

      # emerge www-servers/unit

    .. tab:: Remi's RPM

     .. code-block:: console

      # dnf downgrade unit
      # or: dnf install unit-1.35.0-1.remi

#. **Restart**

 .. code-block:: console

  # systemctl start unit

.. note::
 Configuration files in ``/etc/unit/`` and application data
 in ``/var/lib/unit/`` are preserved during binary changes.

.. _migration-faq:

***
FAQ
***

**Q: Will my config.json break after migrating to FreeUnit?**

No. FreeUnit maintains 100% compatibility with previous Unit builds.
Your ``config.json`` works as-is.

**Q: Can I mix FreeUnit core with Remi's PHP modules?**

Yes. FreeUnit's core binary is ABI-compatible with Remi's
``phpXX-unit-php`` modules. This is the basis of the
:ref:`hybrid approach <migration-remi-hybrid>`.

**Q: How do I verify I'm running FreeUnit?**

Check the version string:

.. code-block:: console

 $ unitd --version
 freeunit/X.Y.Z   # Example format; actual version may differ

The ``freeunit/`` prefix confirms the community fork.

**Q: What if I need PHP 8.2 or older?**

FreeUnit provides modules for PHP 8.3, 8.4, and 8.5.
For older PHP versions, consider:

- Using Remi's modules with FreeUnit core (compatible)
- Building legacy modules from source with custom ``./configure`` flags
- Containerizing legacy apps with Docker using pinned base images

**Q: Is there a migration script for FreeUnit?**

A helper script is planned for a future release.
Track progress on our roadmap:
https://github.com/freeunitorg/freeunit/milestone/3

Until then, follow the manual steps above — they take <5 minutes.

**Q: Where is the GPG key for FreeUnit package verification?**

Official RPM/DEB packages for FreeUnit are not yet available.
When they are released, the public key will be published at:
http://freeunit.org/media/keys/6C68B7AA.asc

For source builds, verify commits via GitHub signatures:
https://github.com/freeunitorg/freeunit/commits/main

.. seealso::

 - :doc:`installation` — Install FreeUnit from scratch
 - :doc:`configuration` — Application configuration reference
 - :ref:`community` — Get help from the FreeUnit community