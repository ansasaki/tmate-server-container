# SPDX-License-Identifier: MIT
# The builder stage which uses the latest Fedora minimal image to build the
# server
FROM registry.fedoraproject.org/fedora-minimal AS builder

# Packaged dependencies
RUN microdnf install -y \
    autoconf \
    automake \
    gcc \
    git \
    libevent-devel \
    libssh-devel \
    make \
    msgpack-devel \
    ncurses-devel \
    openssh

RUN git clone https://github.com/tmate-io/tmate-ssh-server.git && cd tmate-ssh-server && \
    ./create_keys.sh && \
    ./autogen.sh && \
    ./configure && make

# Build server image using a fedora minimal base image
FROM registry.fedoraproject.org/fedora-minimal
ARG VERSION=latest
LABEL org.opencontainers.image.authors="Anderson Toshiyuki Sasaki <ansasaki@redhat.com>"
LABEL org.opencontainers.image.version="$VERSION"
LABEL org.opencontainers.image.title="Tmate server"
LABEL org.opencontainers.image.description="Tmate server"
LABEL org.opencontainers.image.url="https://github.com/ansasaki/tmtate-server-container"
LABEL org.opencontainers.image.source="https://github.com/ansasaki/tmtate-server-container"
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.vendor="Anderson Toshiyuki Sasaki"

LABEL name="Tmate server"
LABEL version="$VERSION"
LABEL license="MIT"
LABEL vendor="Anderson Toshiyuki Sasaki"

RUN microdnf makecache && \
    microdnf -y install libssh libevent msgpack ncurses glibc-langpack-en && \
    microdnf clean all && \
    rm -rf /var/cache/dnf/*

# Copy server from the builder
COPY --from=builder /tmate-ssh-server/tmate-ssh-server /bin/tmate-ssh-server

ENTRYPOINT ["/bin/tmate-ssh-server"]

ENV SSH_PORT_LISTEN=2222
EXPOSE 2222
