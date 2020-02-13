# i3wm-wsswitch

__Use at your own risk...__

i3wm-wsswitch is a script that will cycle through your workspaces.

If you have two created workspaces "1" and "3" and "1" is focused then "i3wm-wsswitch.sh -r" will create an empty workspace "2" and switch to it. If the script is directly executed again it will change the focus to the existing workspace "3".

If you are on workspace 1 and move to the left, the highest already created workspace will be choosen.

If you are moving right the script will create new workspaces up to $WORKSPACE_MAX.
If you have reached $WORKSPACE_MAX it will move to workspace 1.

__this has not been tested on multi monitor setups__

# config
XF86Forward and XF86Back can for example be found on Thinkpad T61 above the left and right arrow keys. Change it to your demands.

Currently the script only works with bash.

__Add somthing like this to your i3 config__

```
# move to prev / next workspace
bindsym $mod+XF86Forward workspace next
bindsym $mod+XF86Back workspace prev

# move to prev / next workspace number and create it if it does not exist
bindsym XF86Forward exec "bash ~/src/i3wm-workspaceswitch/i3wm-wsswitch.sh -r"
bindsym XF86Back exec "bash ~/src/i3wm-workspaceswitch/i3wm-wsswitch.sh -l"
```
