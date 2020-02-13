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

WORKSPACE_MAX=10


focused_num=`i3-msg -t get_workspaces | jq '.[] | select(.focused==true).num'`
jq_workspaces=`i3-msg -t get_workspaces | jq '.[] | select(.focused==false).num'`
unfocused_array=`echo $jq_workspaces | tr ' ' ','`

IFS=$',' read -ra unfocused_array<<<"$unfocused_array"

chosen_ws=$(($focused_num $ACTION))

# If a workspace higher than $WORKSPACE_MAX would be the next,
# the script will switch to workspace number one and exit successfully
if [[ $chosen_ws -gt $WORKSPACE_MAX ]]; then
	i3-msg workspace number 1
	exit 0
fi



#if the next higher/lower workspace already exists, the script will use
#built-in prev and next commands and exit successfully

if [[ " ${unfocused_array[@]} " =~ $chosen_ws ]]; then

	if [[ $ACTION == "-1" ]]; then
		i3-msg workspace prev
		exit 0
	else
		i3-msg workspace next
		exit 0
	fi

#if the next lower workspace would be workspace 0 the script
#will change to the highest already created workspace

else
	if [[ $chosen_ws -eq 0 ]];then
		max=${unfocused_array[0]}
		for n in "${unfocused_array[@]}" ; do
		    if [ "$n" -gt "$max" ]; then max=$n; fi;
		done
		i3-msg workspace number $max
		exit 0;
	else
#and finally, if the desired worksapce does not exist it will
#be created and switched to.
		i3-msg workspace number $chosen_ws
	fi
fi
