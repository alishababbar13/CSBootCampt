#!/bin/bash

echo "---Dealer finder by Game, Date and Time---"

echo "Select game:"
echo "Press 1 for BlackJack"
echo "Press 2 for Roulette"
echo "Press 3 for Texas Hold Em"
read game

echo "Enter date in MMDD format"
read date

echo "Enter time as HH (12 hour format) only (results for both AM and PM will be displayed)"
read time_played

if [[ $game = 1 ]]; then
    echo "Game: BlackJack"
elif [[ $game = 2 ]]; then
    echo "Game: Roulette"
elif [[ $game = 3 ]]; then
    echo "Game: Texas Hold Em"
else
    echo "Game: Not selected"
fi

echo "Date: $date"
echo "Time (AM/PM) and Dealer names:"

if [[ $game = 1 ]]; then
    grep -i $time_played $date* | awk '{print $1, $2, $3, $4}'
elif [[ $game = 2 ]]; then
    grep -i $time_played $date* | awk '{print $1, $2, $5, $6}'
elif [[ $game = 3 ]]; then
    grep -i $time_played $date* | awk '{print $1, $2, $7, $8}'
else
    echo " ERROR: trouble reading user input"
fi

