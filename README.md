# solana-dev-docker

A docker container for Solana development, which already installed most essential tools for you.

It includes:
- Rust v1.68
- Solana-cli v1.14.17
- Node v18.16.0, with NPM/YARN
- Anchor v0.27.0

--------

# Pre-requisite
- Docker already installed and running

--------

# Command to start/stop dev container

Start:
```
./start.sh
```

Stop:
```
./stop.sh
```

# Command to open shell of container 

```
./shell.sh
```

--------

# Remark

## The first time you build the docker image may take quite some time.

It would take some times to download solana-cli & anchor build warm up. The time required depends, but even 30 min or more in some computer/env is not surprise.

