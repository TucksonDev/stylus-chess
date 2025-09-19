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

printLogs=true
if [ -z "$PRINT_LOGS" ] || [ "$PRINT_LOGS" != "true" ]
then
    printLogs=false
fi

# Get current game number
gameNumber=$(cast call --rpc-url $RPC_URL $CONTRACT_ADDRESS "totalGames() (uint256)")

# Play move 1 (white - e4)
echo ""
echo "------------------------------------"
echo "Play move 1 (white - e4) on game $gameNumber"
cast send --rpc-url $RPC_URL --private-key $PRIVATE_KEY $CONTRACT_ADDRESS "playMove(uint256,uint256,uint256,uint256,uint256)()" $gameNumber 1 4 3 4

# Print game state
if [ "$printLogs" = true ] ; then
    ./scripts/printGameState.sh
fi
echo "------------------------------------"

# Play move 2 (black - e5)
echo ""
echo "------------------------------------"
echo "Play move 2 (black - e5) on game $gameNumber"
cast send --rpc-url $RPC_URL --private-key $PRIVATE_KEY $CONTRACT_ADDRESS "playMove(uint256,uint256,uint256,uint256,uint256)()" $gameNumber 6 4 4 4

# Print game state
if [ "$printLogs" = true ] ; then
    ./scripts/printGameState.sh
fi
echo "------------------------------------"

# Play move 3 (white - Nf3)
echo ""
echo "------------------------------------"
echo "Play move 3 (white - Nf3) on game $gameNumber"
cast send --rpc-url $RPC_URL --private-key $PRIVATE_KEY $CONTRACT_ADDRESS "playMove(uint256,uint256,uint256,uint256,uint256)()" $gameNumber 0 6 2 5

# Print game state
if [ "$printLogs" = true ] ; then
    ./scripts/printGameState.sh
fi
echo "------------------------------------"