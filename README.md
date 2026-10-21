# DNSDist Docker for armv7 (32bit)

This repository contains a Docker image for running DNSDist on devices with armv7 (32bit) architecture like the Mikrotik [RB4011](https://mikrotik.com/product/rb4011igs_rm).

## Table of Contents

- [Installation](#install-container)
- [Build Yourself](#build-yourself)
- [Cross-compile and install for MikroTik routers](#cross-compile-and-install-for-mikrotik-routers)
- [Configuration](#configuration)


## Install Container

- Pull & Run the container:

    ```sh
    docker run -d --name dnsdist -p 53:53 -v dnsdist:/etc/dnsdist.conf ghcr.io/karoltheguy/dnsdist-container-armv7:main
    ```


## Build yourself

To build and run the Docker image, follow these steps:

- Clone, build and run:

    ```sh
    git clone https://github.com/karoltheguy/dnsdist-container-armv7.git
    cd dnsdist-container-armv7
    docker build -t dnsdist-armv7 .
    docker run -d --name dnsdist -p 53:53/udp -p 53:53/tcp dnsdist-armv7
    ```

## Cross-compile and install for MikroTik routers

- On the host system, install the qemu-base ARM emulation, build the ARM image and export a tar file:

    ```sh
    git clone https://github.com/karoltheguy/dnsdist-container-armv7.git
    cd dnsdist-container-armv7
    docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
    docker build --platform linux/arm/v7 -t dnsdist-armv7 .
    docker image save dnsdist-armv7 > dnsdist-armv7.tar
    ```

- Copy the image to `/docker/dnsdist-armv7.tar` and your config to `/docker/dnsdist-conf/dnsdist.conf` on the MikroTik router and provision the container according to [MikroTik documentation](https://manual.mikrotik.com/docs/containers/):

    ```sh
    /container mounts
    add dst=/etc/dnsdist list=MOUNT_DNSDIST_CONF mode=ro src=/docker/dnsdist-conf/
    /container
    add file=docker/dnsdist-armv7.tar interface=veth3 layer-dir="" \
        mountlists=MOUNT_DNSDIST_CONF name=dnsdist root-dir=/docker/images/dnsdist \
        start-on-boot=yes
    ```

## Configuration

You can configure DNSDist by modifying the `dnsdist.conf` file in the repository. After making changes, rebuild the Docker image and restart the container.
See configuration examples from [Denis Machard's blog](https://dmachard.github.io/posts/0054-dnsdist-config-examples/).

