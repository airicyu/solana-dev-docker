FROM rust:1.68

RUN apt-get update && apt-get -y upgrade

# Install base utilities.
RUN apt-get update -qq && apt-get upgrade -qq && apt-get install -qq \
    build-essential git curl wget pkg-config libssl-dev libudev-dev

RUN mkdir -p /tmp

# install solana-cli
ENV SOLANA_CLI_VERSION="v1.14.17"
WORKDIR /tmp
RUN curl -L "https://github.com/solana-labs/solana/releases/download/$SOLANA_CLI_VERSION/solana-release-x86_64-unknown-linux-gnu.tar.bz2" -o "$SOLANA_CLI.tar.bz2"
RUN tar jxf "$SOLANA_CLI.tar.bz2"
RUN mv solana-release /usr/bin/solana-release
RUN rm "$SOLANA_CLI.tar.bz2"
ENV PATH /usr/bin/solana-release/bin:$PATH

# install nvm, node, npm
ENV NODE_VERSION="v18.16.0"

RUN mkdir /usr/local/nvm
ENV NVM_DIR /usr/local/nvm
RUN curl https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash \
    && . $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default \
    && npm install -g yarn

ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

# install Anchor
ENV ANCHOR_VERSION="v0.27.0"
RUN cargo install --git https://github.com/coral-xyz/anchor --tag ${ANCHOR_VERSION} anchor-cli --locked

# Build a dummy program to bootstrap the BPF SDK (doing this speeds up builds).
RUN mkdir -p /tmp && cd /tmp
WORKDIR /tmp
RUN /bin/bash -c "source $NVM_DIR/nvm.sh && anchor init dummy && cd ./dummy && anchor build"

WORKDIR /workspace
ENTRYPOINT ["tail", "-f", "/dev/null"]