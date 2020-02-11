#!/bin/bash
# michon <lesnoh@gmx.de> 2020

while getopts rl option
do
case "${option}"
in
l) ACTION="-1";;
r) ACTION="+1";;
?) echo "($0): Wrong parameter, use -l or -r" && exit 1
esac
done

focused_num=`i3-msg -t get_workspaces | jq '.[] | select(.focused==true).num'`
unfocused_num=`i3-msg -t get_workspaces | jq '.[] | select(.focused==false).num'`

#echo ${unfocused_num[@]}

chosen_ws=$(($focused_num $ACTION))
#echo $chosen_ws

if [[ " ${unfocused_num[@]} " =~ $chosen_ws ]]; then
	echo "worksapce already created, switching to it.."

	if [[ $ACTION == "-1" ]]; then
		echo	i3-msg workspace prev
		i3-msg workspace prev
	else
		echo	i3-msg workspace next
		i3-msg workspace next
	fi

else

#	echo "workspace not there, creating it.."
#	echo "i3-msg workspace $chosen_ws"
	i3-msg workspace $chosen_ws
fi
