# Linux From Scratch bootstrap

Scripts to bootstrap a Linux From Scratch environment system image
to use under [WSL2](https://en.wikipedia.org/wiki/Windows_Subsystem_for_Linux).

We use [LFS v12.0-systemd](https://www.linuxfromscratch.org/lfs/view/12.0-systemd/).

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
sudo ./stage4.bash

# Chapters 9, 10, and 11 plus some BLFS
sudo ./stage5.bash
```
