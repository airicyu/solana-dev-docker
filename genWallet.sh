#! /bin/bash
solana-keygen new --outfile ./solana-config/id.json --no-bip39-passphrase
solana airdrop 2 --keypair ./solana-config/id.json