#!/bin/bash

# ------------- #
# Configuration #
# ------------- #

# Load variables from .env file
set -o allexport
source scripts/.env
set +o allexport

# -------------- #
# Initial checks #
# -------------- #
if [ -z "$CONTRACT_ADDRESS" ] 
then
    echo "CONTRACT_ADDRESS is not set"
    echo "You can run the script by setting the variables at the beginning: CONTRACT_ADDRESS=0x $0"
    exit 0
fi

# Get total games
totalGames=$(cast call --rpc-url $RPC_URL $CONTRACT_ADDRESS "totalGames() (uint256)")
echo "Total games: $totalGames"
