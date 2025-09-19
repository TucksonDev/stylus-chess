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

if [ -z "$PRINT_LOGS" ] || [ "$PRINT_LOGS" != "true" ]
then
    echo "PRINT_LOGS is not set to true, so no logs will be printed in the node"
    echo "You can run the script by setting the variables at the beginning: PRINT_LOGS=true $0"
    exit 0
fi

# Get current game number
gameNumber=$(cast call --rpc-url $RPC_URL $CONTRACT_ADDRESS "totalGames() (uint256)")
echo "Print state of game number: $gameNumber"

# Get game status
gameStatus=$(cast call --rpc-url $RPC_URL $CONTRACT_ADDRESS "getGameStatus(uint256) (uint8)" $gameNumber)
if [ "$gameStatus" -eq 0 ] ||  [ "$gameStatus" -eq 1 ]
then
    echo "Game status: Playing"
    # Get turn color
    turnColor=$(cast call --rpc-url $RPC_URL $CONTRACT_ADDRESS "getTurnColor(uint256) (uint256)" $gameNumber)
    if [ "$turnColor" -eq 0 ]
    then
        echo "(It's white's turn)"
    else
        echo "(It's black's turn)"
    fi
elif [ "$gameStatus" -eq 3 ]
then
    echo "Game status: Stalemate"
elif [ "$gameStatus" -eq 4 ]
then
    echo "Game status: Finished"
    # Get victor
    victor=$(cast call --rpc-url $RPC_URL $CONTRACT_ADDRESS "getVictor(uint256) (uint8)" $gameNumber)
    if [ "$victor" -eq 0 ]
    then
        echo "White is the victor!"
    else
        echo "Black is the victor!"
    fi
fi

# Print game state
cast call --rpc-url $RPC_URL $CONTRACT_ADDRESS "printGameState(uint256) ()" $gameNumber > /dev/null
echo "State of game $gameNumber should be now displayed in the node logs"
