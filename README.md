# solana-dev-docker

A docker container for Solana development, which already installed most essential tools for you.

It includes:
- Rust v1.68
- Solana-cli v1.14.17
- Node v18.16.0, with NPM/YARN
- Anchor v0.27.0

( Default config is using Solana **Devnet** )

--------

# Pre-requisite
- Docker already installed and running


# Command: start/stop dev container

Start:
```
./start.sh
```

Stop:
```
./stop.sh
```

# Command: open shell 

```
./shell.sh
```

--------

# Solana Config Dir

This project's `./solana-config` is the dir for putting solana config stuffs.

The `./solana-config/cli/config.yml` is mounted as `/root/.config/solana/cli/config.yml` inside container, which is the config yml file.

The `./solana-config/id.json` is mounted as `/root/.config/solana/id.json` inside container, which is the default Keypair path.

--------

# Workspace Dir

`./workspace` is an empty dir mounted as `/workspace` inside the container. You may feel free to put your projects under this dir to play around.

--------

# Remarks

## The first time you build the docker image may take quite some time.

It would take some times to download solana-cli & anchor build warm up. The time required depends, but even 30 min or more in some computer/env is not surprise.

