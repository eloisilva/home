# If not running interactively, don't do anything
case $- in
   *i*) ;;
     *) return;;
esac

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

### Bash PATH
PATH="$HOME/scripts/bin:$HOME/.local/bin:$PATH"

### History configuration
export HISTFILESIZE=999999
export HISTSIZE=999999
export HISTCONTROL="ignoreboth:erasedups"
export PYTHONPATH='/root/scripts/Python/Modules'


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
      tmux new -s Maloy -n lab1
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


#=-=-=-= Load aliases =-=-=-=#
if [ -d $HOME/.bash_aliases.d ] ;then
   for f in $(ls -1 $HOME/.bash_aliases.d/*.sh) ;do
      source $f
   done
fi
