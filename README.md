# DNSDist Docker for RouterOS on armv7 (32bit)

This repository contains a Docker image for running DNSDist on RouterOS devices with armv7 (32bit) architecture like the [RB4011](https://mikrotik.com/product/rb4011igs_rm).

## Table of Contents

- [Installation](#install-container)
- [Build Yourself](build-yourself)
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


## Configuration

You can configure DNSDist by modifying the `dnsdist.conf` file in the repository. After making changes, rebuild the Docker image and restart the container.
See configuration examples from [Denis Machard's blog](https://dmachard.github.io/posts/0054-dnsdist-config-examples/).

