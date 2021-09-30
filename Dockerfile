# Mono alpine dockerfile (work in progress)
# Parts of this dockerfile are taken from the mono package APKBUILD <https://git.alpinelinux.org/aports/tree/testing/mono/APKBUILD>

FROM alpine:3.12

ENV MONO_VERSION=6.12.0.122
ENV PREFIX=/src/build

RUN mkdir /src && cd /src && \
    wget -O mono.tar.xz https://download.mono-project.com/sources/mono/mono-$MONO_VERSION.tar.xz && \
    echo "Extracting mono.tar.xz (verbose disabled).." && \
	tar xf mono.tar.xz && \
    cd mono-$MONO_VERSION && \
    # Install build deps
    echo "@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    apk add --no-cache libgdiplus-dev@testing zlib-dev linux-headers git autoconf libtool automake build-base gettext cmake python3 curl && \
	# Set env variables (from APKBUILD)
	# Based on Fedora and SUSE package.
	export CFLAGS="$CFLAGS -fno-strict-aliasing" && \
    # Run configure
    ./configure --prefix=$PREFIX && \
	# Run make commands
	make && \
	make install && \
	# cd into build dir and remove unnecessary files (from APKBUILD)
	cd /src/build && \
	# > Remove .la files.
	rm ./usr/lib/*.la && \
	# > Remove Windows-only stuff.
	rm -r ./usr/lib/mono/*/Mono.Security.Win32* && \
	rm ./usr/lib/libMonoSupportW.*
    # Sanity check: run mono -V
    #mono -V
    # next, make smol img with mono