#!/bin/bash

NUM_ITERATIONS=5000
YOUR_ACCOUNT_ID="flutterchaindev.testnet"
DELAY_SECONDS=40

for ((i=1; i<=$NUM_ITERATIONS; i++))
do
  echo "Iteration $i"

  # Deploy the contract
  DEPLOY_OUTPUT=$(npm run deploy)
  echo "$DEPLOY_OUTPUT"

  # Extract the deployed contract address
  CONTRACT_ADDRESS=$(echo "$DEPLOY_OUTPUT" | grep -oP '(?<=Done deploying to )\S+')
  echo "Contract address: $CONTRACT_ADDRESS"

  # Delete the contract and automatically answer 'y' when prompted
  yes | near delete "$CONTRACT_ADDRESS" "$YOUR_ACCOUNT_ID"

  # Remove the cached contract
  rm -rf contract/neardev

  # Wait for a while to avoid hitting the rate limit
  sleep $DELAY_SECONDS
done
