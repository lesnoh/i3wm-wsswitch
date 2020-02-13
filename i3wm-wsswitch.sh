#!/bin/bash -x
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
list_unfocused_num=`i3-msg -t get_workspaces | jq '.[] | select(.focused==false).num'`
unfocused_num=`echo $list_unfocused_num | tr ' ' ','`

IFS=$',' read -ra unfocused_num<<<"$unfocused_num"

chosen_ws=$(($focused_num $ACTION))

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
	if [[ $chosen_ws -eq 0 ]];then
		max=${unfocused_num[0]}
		for n in "${unfocused_num[@]}" ; do
		    if [ "$n" -gt "$max" ]; then max=$n; fi;
			echo Wert $n;
			echo $max;
		done
		i3-msg workspace number $max
		exit 0;
	else
		i3-msg workspace number $chosen_ws
	fi
fi
