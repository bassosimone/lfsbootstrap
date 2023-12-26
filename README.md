# Linux From Scratch bootstrap

Scripts to bootstrap a Linux From Scratch environment.

These scripts use [LFS v12.0-systemd](https://www.linuxfromscratch.org/lfs/view/12.0-systemd/).

## Installing dependencies

### Debian bookworm

```sh
sudo apt-get install bison build-essential gawk flex git \
	libgmp-dev libmpc-dev libmpfr-dev texinfo
```

## Building LFS rootfs

```sh
# Chapters 5 and 6
./stage1.bash

# Chapter 7
sudo ./stage2.bash

# Chapter 8
sudo ./stage3.bash
```
