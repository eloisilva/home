#!/bin/bash

if [ $# -gt 0 ] ;then
   tmux rename-window $1
fi

tmux send-keys 'clear' C-m
tmux split-window -v -p 18
tmux send-keys 'clear' C-m
tmux select-pane -t 0
tmux send-keys 'clear' C-m
