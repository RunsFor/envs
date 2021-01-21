Docker Environments for CI
---

# Available versions

centos: `7`, `8`

cartridge: `2.4.0`

tarantool: `2.2`, `2.3`, `2.4`, `2.5`, `2.6`

image type: `base`, `build`

# Image

Image is build using following template:

- `registry.gitlab.com/runfor/envs/centos:<centos>-<image_type>`
- `registry.gitlab.com/runfor/envs/cartridge:<centos>-<cartridge>-<image_type>`
- `registry.gitlab.com/runfor/envs/cartridge-dind:<cartridge>`
- `registry.gitlab.com/runfor/envs/tarantool:<centos>-<tarantool>-<image_type>`

Example:

```bash
$ docker run --rm -it registry.gitlab.com/runfor/envs/tarantool:8-2.6-base
[root@e320efd841b8 /]# tarantool --version | head -2
Tarantool 2.6.1-0-gcfe0d1a55
Target: Linux-x86_64-RelWithDebInfo
[root@e320efd841b8 /]# cat /etc/*release | head -2
CentOS Linux release 8.2.2004 (Core)
NAME="CentOS Linux"
[root@e320efd841b8 /]# cartridge version
Tarantool Cartridge CLI v2.4.0 linux/amd64 commit: 2079d9b
```

# Installed software

## Tarantool

Tarantool image includes version specified by the tag and it has [cartridge-cli](https://github.com/tarantool/cartridge-cli) installed

## Base

- git
- cmake
- which
- wget
- zip
- unzip
- docker-ce-cli
- python3-pip
- awscli

## Build

- make
- gcc
- gcc-c++
- glibc-devel
- libstdc++-devel
- lua-devel
- autoconf
- automake
- libtool
- curl-devel
