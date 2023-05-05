FROM ubuntu:22.04

RUN apt-get update && apt-get -y upgrade

# Install base utilities.
RUN apt-get update -y && apt-get upgrade -y && apt-get install -y \
build-essential git curl wget \
libssl-dev libudev-dev pkg-config zlib1g-dev llvm clang cmake make libprotobuf-dev protobuf-compiler

RUN mkdir -p /tmp
WORKDIR /tmp

ENV LIB_SSL_VERSION=2.18
RUN wget "http://nz2.archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1f-1ubuntu${LIB_SSL_VERSION}_amd64.deb"
RUN dpkg -i "libssl1.1_1.1.1f-1ubuntu${LIB_SSL_VERSION}_amd64.deb"

# Install rust.
RUN curl "https://sh.rustup.rs" -sfo rustup.sh && \
    sh rustup.sh -y 
RUN /bin/bash -c "source \"$HOME/.cargo/env\" rustup component add rustfmt clippy"

# Install solana-cli
ENV SOLANA_CLI_VERSION="v1.14.17"
WORKDIR /tmp
RUN curl -L "https://github.com/solana-labs/solana/releases/download/$SOLANA_CLI_VERSION/solana-release-x86_64-unknown-linux-gnu.tar.bz2" -o "solana-cli.tar.bz2"
RUN tar jxf "solana-cli.tar.bz2"
RUN mv solana-release /usr/bin/solana-release
RUN rm "solana-cli.tar.bz2"
ENV PATH /usr/bin/solana-release/bin:$PATH

# Install NVM, NodeJS
ENV NVM_VERSION="v0.39.1"
ENV NODE_VERSION="18/*"

RUN mkdir /usr/local/nvm
ENV NVM_DIR /usr/local/nvm
RUN curl https://raw.githubusercontent.com/nvm-sh/nvm/$NVM_VERSION/install.sh | bash \
    && . $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm use $NODE_VERSION \
    && npm i -g yarn

ENV TYPESCRIPT_VERSION="^5.0.0"
# Install typescript
RUN /bin/bash -c "source $NVM_DIR/nvm.sh && npm i -g typescript@${TYPESCRIPT_VERSION}"

# Install ts-node
RUN /bin/bash -c "source $NVM_DIR/nvm.sh && npm i -g ts-node"

# Install Anchor
ENV ANCHOR_VERSION="0.27.0"
RUN /bin/bash -c "source $NVM_DIR/nvm.sh && npm i -g @coral-xyz/anchor-cli@${ANCHOR_VERSION}"

# Build a dummy program to bootstrap the BPF SDK (doing this speeds up builds).
WORKDIR /tmp
RUN /bin/bash -c "source $NVM_DIR/nvm.sh && anchor init dummy --no-git"
WORKDIR /tmp/dummy
RUN /bin/bash -c "source \"$HOME/.cargo/env\" && source $NVM_DIR/nvm.sh && anchor build"

# Install amman
RUN mkdir -p /amman
WORKDIR /amman
RUN git clone -b fix/build-issue-client-v0.2.4 https://github.com/karlvlam/amman.git .
RUN /bin/bash -c "source $NVM_DIR/nvm.sh && yarn install && yarn build"

# Clear temp files
RUN rm -rf /tmp/*

WORKDIR /workspace
ENTRYPOINT ["tail", "-f", "/dev/null"]