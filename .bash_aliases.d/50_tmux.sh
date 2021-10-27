#! /bin/bash
#################################################################################
#     File Name           :     tmux.sh
#     Created By          :     Eloi Silva
#     Creation Date       :     [2020-04-26 17:12]
#     Description         :     Bash TMUX aliases & functions
#################################################################################

TMUX_DEFAULT_SESSION="Maloy"
TMUX_NEW_SESSION="Lab"

#=-=-=-= Tmux Functions =-=-=-=#

# New TMUX session
tmn() {
   if [ -z $2 ] ;then
      tmux new -s $TMUX_NEW_SESSION -n $1
   else
      tmux new -s $1 -n $2
   fi
}

# Tmux Default
tmd() {
   if tmux ls 2> /dev/null ;then
      tmux a
   else
      tmux new -s $TMUX_DEFAULT_SESSION -n lab1
   fi
}

# Create new TMUX session or attach to current session
tm() {
   if [ -z $1 ] ;then
      tmd
   else
      tmn $@
   fi
}


#=-=-=-= TMUX Aliases =-=-=-=#
alias pydev="tmux new-session -s IDE -n py3 \; source-file ~/.tmux/pydev.conf"
