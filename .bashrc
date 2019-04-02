# ~/.bashrc: executed by bash(1) for non-login shells.

# Note: PS1 and umask are already set in /etc/profile. You should not
# need this unless you want different defaults for root.
# PS1='${debian_chroot:+($debian_chroot)}\h:\w\$ '
# umask 022

# You may uncomment the following lines if you want `ls' to be colorized:
# export LS_OPTIONS='--color=auto'
# eval "`dircolors`"
# alias ls='ls $LS_OPTIONS'
# alias ll='ls $LS_OPTIONS -l'
# alias l='ls $LS_OPTIONS -lA'
#
# Some more alias to avoid making mistakes:
# alias rm='rm -i'
# alias cp='cp -i'
# alias mv='mv -i'

export HISTFILESIZE=999999
export HISTSIZE=999999
export HISTCONTROL="ignoreboth:erasedups"
export PYTHONPATH='/root/scripts/Python/Modules'

# Python alias
alias py='/usr/bin/python'
alias py3='/usr/bin/python3'
alias pydev='tmux new -s IDE -n py3 \; source-file ~/.tmux/pydev.conf'

# PSQL Connect
alias psql_conn='psql -U postgres'

# Performance
alias load='clear && while : ;do uptime |cut -d, -f3- ;sleep 5 ;done'

lsi(){
   ls -l --color $1 |awk '{print $1, $9, $10, $11}'
}

# PS1 byMaloy
get_branch ()
{
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
PS1='\[\033[31m\]${debian_chroot:+($debian_chroot)}\h:\[\033[0m\] (\w)\n[\A]\[\033[33m\]$(get_branch)\[\033[96m\]\$ \[\033[0m\]'
PROMPT_COMMAND="echo"

# Terminal colorized
export TERM='screen-256color'
