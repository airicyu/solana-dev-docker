# solana-dev-docker

A docker container for Solana development, which already installed most essential tools for you.

Base image is ubuntu:22.04, and it installed:
- [Rust stable](https://www.rust-lang.org/)
- [Solana-cli v1.14.17](https://github.com/solana-labs/solana)
- NodeJS stack
  - [NVM v0.39.1](https://github.com/nvm-sh/nvm)
  - [Node v18.x.x](https://nodejs.org/en)
  - [NPM](https://www.npmjs.com/) & [YARN](https://www.npmjs.com/package/yarn)
  - [typescript ^5.0.0](https://www.npmjs.com/package/typescript)
  - [ts-node](https://www.npmjs.com/package/ts-node)
- [Anchor v0.27.0](https://www.npmjs.com/package/@coral-xyz/anchor-cli)
- [Amman (forked with fix)](https://github.com/karlvlam/amman/tree/fix/build-issue-client-v0.2.4)

( Default config is using Solana **Devnet** )

--------

# Pre-requisite
- Docker installed in your environment

--------

# How to run it?

1) Checkout the code.
2) (Optional) Run `./genWallet.sh` to generate wallet.
3) Run `./start.sh` to start the container. (It may take some time to build the first time. Be patient.)
4) Run `./shell.sh` to open Shell.
5) Done. Feel free to play with the environment!


P.S. When you wanna stop it, just run `./stop.sh` .

# Wanna mount project files to the container?

The `workspace` dir is already mounted to the container's `/workspace` dir. You can freely put anythings under this directory.

--------

# Commands

## Start docker container

```
./start.sh
```

## Stop docker container

```
./stop.sh
```

## Open shell

```
./shell.sh
```

## Rebuild template image

Only need to run this when the `Dockerfile` template updated so you need to rebuild the image.
```
./build.sh
```

## Generate wallet

This script will generate new wallet and save private key in `./solana-config/id.json`. (Will not override file)

That's the default wallet inside the container.

```
./genWallet.sh
```

--------

# Solana Config Dir

This project's `./solana-config` is the dir for putting solana config stuffs.

The `./solana-config/cli/config.yml` is mounted as `/root/.config/solana/cli/config.yml` inside container, which is the config yml file.

The `./solana-config/id.json` is mounted as `/root/.config/solana/id.json` inside container, which is the default Keypair path.

