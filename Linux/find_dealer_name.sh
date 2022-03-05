#!/bin/bash
# $1 is number of line/row entry. type in the row number 1, 2, 3, 4 or 5
#as ocurring in the Notes_Player_Analysis file (timing when loss occurred) 
time_of_loss=$(sed -n $1p Notes_Player_Analysis)
name_of_dealer=$(grep $time_of_loss Dealers_working_during_losses | awk '{print $2, $3}')
echo name of dealer working at $time_of_loss = $name_of_dealer
