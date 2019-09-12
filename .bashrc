### History configuration
# append to the history file, don't overwrite it
shopt -s histappend

# HISTORY VARs
export HISTFILESIZE=999999
export HISTSIZE=999999
export HISTCONTROL="ignoreboth:erasedups"
export PYTHONPATH='/root/scripts/Python/Modules'

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize


#-=-=-=-=- SHELL aliases -=-=-=-=-#
# Python alias
alias py='/usr/bin/python'
alias py3='/usr/bin/python3'
alias pydev='tmux new -s IDE -n py3 \; source-file ~/.tmux/pydev.conf'

# PSQL Connect
alias psql_conn='psql -U postgres'

# Performance
alias load='clear && while : ;do uptime |cut -d, -f3- ;sleep 5 ;done'

# grep color
alias grep='/usr/bin/grep --color'


#-=-=-=-=- SHELL functions -=-=-=-=-#
# ls -l simple
lsi(){
   ls -l --color $1 |awk '{print $1, $9, $10, $11}'
}

# Tmux Session Alias
tm() {
   if tmux ls 2> /dev/null ;then
      tmux a
   else
      tmux new -s Amazon -n aws
   fi
}

# PS1 byMaloy
get_branch ()
{
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
#PS1='\[\033[31m\]${debian_chroot:+($debian_chroot)}\h:\[\033[0m\] (\w)\n[\A]\[\033[33m\]$(get_branch)\[\033[96m\]\$ \[\033[0m\]'
PS1='\[\033[31m\]${debian_chroot:+($debian_chroot)}\h:\[\033[0m\] (\w)\n[\A]\[\033[33m\]$(get_branch)\[\033[35m\]${SSH_CLIENT:+ <SSH> }\[\033[96m\]\$ \[\033[0m\]'
PROMPT_COMMAND="echo"


#-=-=-=-=- Others configuration -=-=-=-=-#
# Terminal colorized
export TERM='screen-256color'


#-=-=-=-=- Autocompletion -=-=-=-=-#
# BASH Autocomplete
if [ -f /etc/bash_completion ] ;then
   source /etc/bash_completion
elif [ -f /usr/local/etc/bash_completion ] ;then
   source /usr/local/etc/bash_completion
fi

if [ -e "${HOME}/.iterm2_shell_integration.bash" ] ;then
   source "${HOME}/.iterm2_shell_integration.bash"
fi

#-=-=-=-=- AWS alias -=-=-=-=-#
# Autocomplete for awscli
complete -C aws_completer aws

# Load AWS configuration file
source /Users/eloisilv/.aws/activate.sh

# List running instances. Fields = {InstanceID, Name, PublicIPAddress}
alias ec2run="aws ec2 describe-instances --filters 'Name=instance-state-code,Values=16' --query 'Reservations[*].Instances[*].[InstanceId, State.Name, PublicIpAddress]'"

# Load current case variables
alias activate_case="source /Users/eloisilv/Documents/cases/current.sh"

# vim to current case
alias vic='vi $CASE'
