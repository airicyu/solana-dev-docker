FROM ubuntu:22.04

RUN apt-get update && apt-get -y upgrade

# Install base utilities.
RUN apt-get update -y && apt-get upgrade -y && apt-get install -y \
build-essential git curl wget \
libssl-dev libudev-dev pkg-config zlib1g-dev llvm clang cmake make libprotobuf-dev protobuf-compiler

RUN mkdir -p /tmp
WORKDIR /tmp

ENV LIB_SSL_VERSION=2.19
RUN wget "http://nz2.archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1f-1ubuntu${LIB_SSL_VERSION}_amd64.deb"
RUN dpkg -i "libssl1.1_1.1.1f-1ubuntu${LIB_SSL_VERSION}_amd64.deb"

# Install rust.
ENV RUST_VERSION="1.72.0"
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs/ | sh -s -- --default-toolchain=$RUST_VERSION -y
RUN /bin/bash -c "source \"$HOME/.cargo/env\" rustup component add rustfmt clippy"

# Install solana-cli
ENV SOLANA_CLI_VERSION="v1.14.26"
WORKDIR /tmp
RUN curl -L "https://github.com/solana-labs/solana/releases/download/$SOLANA_CLI_VERSION/solana-release-x86_64-unknown-linux-gnu.tar.bz2" -o "solana-cli.tar.bz2"
RUN tar jxf "solana-cli.tar.bz2"
RUN mv solana-release /usr/bin/solana-release
RUN rm "solana-cli.tar.bz2"
ENV PATH /usr/bin/solana-release/bin:$PATH

# Install NVM, NodeJS
ENV NVM_VERSION="v0.39.5"
ENV NODE_VERSION="18/*"

RUN mkdir /usr/local/nvm
ENV NVM_DIR /usr/local/nvm
RUN curl https://raw.githubusercontent.com/nvm-sh/nvm/$NVM_VERSION/install.sh | bash \
    && . $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm use $NODE_VERSION \
    && npm i -g yarn

# Install typescript
ENV TYPESCRIPT_VERSION="^5.2.2"
RUN /bin/bash -c "source $NVM_DIR/nvm.sh && npm i -g typescript@${TYPESCRIPT_VERSION}"

# Install ts-node
RUN /bin/bash -c "source $NVM_DIR/nvm.sh && npm i -g ts-node"

# Install Anchor
ENV ANCHOR_VERSION="~0.28.0"
RUN /bin/bash -c "source $NVM_DIR/nvm.sh && npm i -g @coral-xyz/anchor-cli@${ANCHOR_VERSION}"

# Install amman
RUN mkdir -p /amman
WORKDIR /amman
RUN git clone -b fix/build-issue-client-v0.2.4 https://github.com/karlvlam/amman.git .
RUN /bin/bash -c "source $NVM_DIR/nvm.sh && yarn install && yarn build"

# Clear temp files
RUN rm -rf /tmp/*

WORKDIR /workspace
CMD ["tail", "-f", "/dev/null"]