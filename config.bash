# TOPDIR is the top directory.
export TOPDIR=$(dirname $(readlink -f $0))

# LFS is the destination directory
export LFS=$TOPDIR/rootfs

# make sure the umask is okay
umask 022

# make sure we're using the correct locale
export LC_ALL=POSIX

# LFS_TGT is the target for which we are compiling
export LFS_TGT=$(uname -m)-lfs-linux-gnu

# include tools in path
export PATH="$LFS/tools/bin:$PATH"

# use a CONFIG_SITE
export CONFIG_SITE=$LFS/usr/share/config.site

# disable shell hashing to use the new built tools right away
set +h

# make sure we have MAKEFLAGS set
export MAKEFLAGS=-j$(nproc)

# possibly honour a config-local.bash file
if [[ -f config-local.bash ]]; then
	. config-local.bash
fi
