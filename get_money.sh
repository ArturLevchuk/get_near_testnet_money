#!/bin/bash

NUM_ITERATIONS=1000
YOUR_ACCOUNT_ID="arturlevchukkk.testnet"
DELAY_SECONDS=40

for ((i=1; i<=$NUM_ITERATIONS; i++))
do
  echo "Iteration $i"

  # Deploy the contract
  echo ">> Deploying contract"
  CONTRACT_ADDRESS=$(contract/deploy.sh)
  echo "Contract address: $CONTRACT_ADDRESS"


  # Delete the contract and get money
  near account delete-account $CONTRACT_ADDRESS beneficiary $YOUR_ACCOUNT_ID network-config testnet sign-with-keychain send

  # Wait for a while to avoid hitting the rate limit
  sleep $DELAY_SECONDS
done
