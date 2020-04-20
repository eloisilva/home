# If not running interactively, don't do anything
case $- in
   *i*) ;;
     *) return;;
esac

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

# Git alias
alias ga='git add'
alias gm='git commit -m'
alias gs='git status'
alias gd='git diff'
alias gl='git log --oneline'
alias gla='git log --stat --graph --summary --oneline'


#-=-=-=-=- SHELL functions -=-=-=-=-#
# ls -l simple
lsi(){
   ls -l --color $1 |awk '{print $1, $9, $10, $11}'
}

# Tmux New Session
tmn() {
   tmux new -s Lab -n $1
}

# Tmux Default
tmd() {
   if tmux ls 2> /dev/null ;then
      tmux a
   else
      tmux new -s Amazon -n aws
   fi
}

# Tmux - Attach current session or create a new session
tm() {
   if [ -z $1 ] ;then
      tmd
   else
      tmn $1
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

# Autocomplete for awscli
complete -C aws_completer aws


#-=-=-=-=- Others configuration -=-=-=-=-#
# Terminal colorized
export TERM='screen-256color'


#-=-=-=-=- AWS alias -=-=-=-=-#
# Workdir
CASEDIR="${HOME}/Documents/cases/"

# Load AWS configuration file
source ${HOME}/.aws/activate.sh

# Workdir aliases
alias activate_case="source ${CASEDIR}/current.sh"
alias cdc='cd $CaseDIR'
alias vic='vi +":set filetype=markdown" $CASE'

# AWSCLI config for virtualenv
# Required: Add the same function to the virtualenv deactivate function
aws() {
   AWSCLI="${HOME}/aws-cli/"
   if [ $# -gt 0 ] ;then
      ${AWSCLI}/bin/aws $@
   else
      source ${AWSCLI}/bin/activate
      unset aws
   fi
}

# List running instances. Fields = {InstanceID, Name, PublicIPAddress}
alias ec2run="aws ec2 describe-instances --filters 'Name=instance-state-code,Values=16' --query 'Reservations[*].Instances[*].[InstanceId, State.Name, PublicIpAddress]'"


#-=-=-=-=- AWS functions -=-=-=-=-#
amiSearch() {
   aws ec2 describe-images --image-ids $@
}

ec2start() {
   aws ec2 start-instances --instance-ids $@
}

ec2stop() {
   aws ec2 stop-instances --instance-ids $@
}

caseSearch() {
   CASEDIR="${CASEDIR}/notes/"
   for year in `ls -1 $CASEDIR` ;do
      for d in `ls -1 $CASEDIR/$year |grep .` ;do
         ( cd $CASEDIR/$year/$d ; git log --oneline |grep -i $1 )
      done
   done
}

grepcf(){
   CASEDIR="${CASEDIR}/notes/"
   if [ ! -z $2 ] ;then
      grep -ril $1 $2
   else
      grep -ril $1 $CASEDIR
   fi
}

grepc(){
   CASEDIR="${CASEDIR}/notes/"
   if [ ! -z $2 ] ;then
      grep -ri $1 $2
   else
      grep -ri $1 $CASEDIR
   fi
}

lsc(){
   CASEDIR="${CASEDIR}/notes/"
   find $CASEDIR -iname \*$1\*
}
