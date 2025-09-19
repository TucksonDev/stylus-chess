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
if [ -z "$PRIVATE_KEY" ]
then
    echo "You need to provide the PRIVATE_KEY of the deployer"
    exit 0
fi

# -------------------------- #
# Deployment of Stylus chess #
# -------------------------- #
echo ""
echo "----------------------"
echo "Deploying Stylus chess"
echo "----------------------"

# Deploy contract
cargo stylus deploy -e $RPC_URL --private-key $PRIVATE_KEY
