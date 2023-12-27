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

### LFS

You should already have all the required packages installed.

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

## Importing the LFS tarball

```console
mkdir lfs-12.0
wsl.exe --import lfs-12.0 .\lfs-12.0 .\stage5.tar
```

## Deploying security fixes

Periodically check [security advisories](https://www.linuxfromscratch.org/blfs/advisories/consolidated.html).

Download tarballs and install them at `/usr/src` using `install -m644 -v`.

Update the corresponding `pkg-build-XXX` script.

As root, run `bash pkg-build-XXX` to recompile and install.

You cannot reinstall `glibc`. The install script will fail and leave under `/tmp` a
`DESTDIR` installation from which you can pick files to manually install.

Remember to update the [VERSION](VERSION) file with the correct patch level.

Remember to check for `/etc` files to merge:

```sh
find /etc -type f -name \*.new
```

## Upgrading

Update the scripts and re-run the whole procedure to obtain `stage5.tar`, then
archive your home directory as `home.tar` and start a new WSL distro.

## Removing a distro

```console
wsl.exe --unregister DISTRO
```
