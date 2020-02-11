#!/bin/bash

while getopts rl option
do
case "${option}"
in
l) ACTION="-1";;
r) ACTION="+1";;
?) echo "($0): Ein Fehler bei der Optionsangabe" && exit 1
esac
done


CURRENTWS=`i3-msg -t get_workspaces | jq '.[] | select(.focused==true).num'`

echo $CURRENTWS

i3-msg workspace $(($CURRENTWS $ACTION))
