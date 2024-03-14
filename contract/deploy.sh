#!/bin/sh

# ./build.sh

# Define a temporary file to capture stdout and stderr
tmp_file=$(mktemp)

# Execute the command, redirecting both stdout and stderr to the temporary file
cargo-near near create-dev-account use-random-account-id autogenerate-new-keypair save-to-legacy-keychain network-config testnet create > "$tmp_file" 2>&1

# Extract the account name using grep and store it in a variable
account_name=$(grep -oE 'create account:\s+([[:alnum:]\.-]+)' "$tmp_file" | awk '{print $NF}')

# Remove the temporary file
rm "$tmp_file"

# Deploy the contract
near contract deploy "$account_name" use-file target/wasm32-unknown-unknown/release/hello_near.wasm without-init-call network-config testnet sign-with-keychain send > /dev/null 2>&1

# Retrieve the account name
echo "$account_name"