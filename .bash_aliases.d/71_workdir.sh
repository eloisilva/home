#! /bin/bash
#################################################################################
#     File Name           :     workdir.sh
#     Created By          :     Eloi Silva
#     Creation Date       :     [2020-04-26 18:20]
#     Description         :     Workdir aliases & functions
#################################################################################

#-=-=-=-=- Workdir -=-=-=-=-#
PROJECTDIR="${HOME}/Documents/project"
WORKLOGDIR="${HOME}/Documents/worklog"
CASEDIR="${WORKLOGDIR}/cases"
TICKETDIR="${WORKLOGDIR}/tickets"
INTERVIEWDIR="${WORKLOGDIR}/interview"

# Search for string in commits inside Workdir
caseSearch() {
   for year in `ls -1 $CASEDIR` ;do
      for d in `ls -1 $CASEDIR/$year |grep .` ;do
         ( cd $CASEDIR/$year/$d ; git log --oneline |grep -i $1 )
      done
   done
}

# Grep recursivelly inside Workdir
grepcf(){
   if [ ! -z $2 ] ;then
      grep -ril $1 $2
   else
      grep -ril $1 $CASEDIR
   fi
}

# Grep recursivelly inside Workdir and only show files
grepc(){
   if [ ! -z $2 ] ;then
      grep -ri $1 $2
   else
      grep -ri $1 $CASEDIR
   fi
}

# List files which match search
lsc(){
   find $CASEDIR -iname \*$1\*
}

# List git unstaged/untracked files
lsg(){
   Untracked_files="`git status |grep -o CaseID-.* |sort -t '-' -k5 |tr '\n' ' '`"
   ls -1th $Untracked_files
}

# caseGrep -- Search for word/sentences into case directory
caseGrep(){
   args="$@"
   grep -rli "$args" $CASEDIR |grep [0-9]$ |xargs echo -n
   unset args
}


#=-=-=-= Workdir Aliases =-=-=-=#
alias activate_case="source ${CASEDIR}/current.sh"
alias cdc='cd $CaseDIR'
alias vic='vi +":set filetype=markdown" $CASE'

alias activate_ticket="source ${TICKETDIR}/current.sh"
alias cdt='cd $TicketDIR'
alias vit='vi +":set filetype=markdown" $TICKET'

alias cdd="cd $WORKLOGDIR"
alias cdn="cd $CASEDIR"
alias cdo="cd $TICKETDIR"
alias cdp="cd $PROJECTDIR"
alias cdi="cd $INTERVIEWDIR"

# List case links
#grep -r "\[[0-9][0-9]\]" . |awk '{if($3 ~ "^http") print $1, $3}' |grep -i ami"
#grep -rih "^\[[0-9].*http" . |grep -ow "http.*" |sort -u |grep -i eip
