#! /bin/bash
#################################################################################
#     File Name           :     workdir.sh
#     Created By          :     Eloi Silva
#     Creation Date       :     [2020-04-26 18:20]
#     Last Modified       :     [2020-04-26 18:24]
#     Description         :     Workdir aliases & functions
#################################################################################

#-=-=-=-=- Workdir -=-=-=-=-#
CASEDIR="${HOME}/Documents/cases/"

# Search for string in commits inside Workdir
caseSearch() {
   CASEDIR="${CASEDIR}/notes/"
   for year in `ls -1 $CASEDIR` ;do
      for d in `ls -1 $CASEDIR/$year |grep .` ;do
         ( cd $CASEDIR/$year/$d ; git log --oneline |grep -i $1 )
      done
   done
}

# Grep recursivelly inside Workdir
grepcf(){
   CASEDIR="${CASEDIR}/notes/"
   if [ ! -z $2 ] ;then
      grep -ril $1 $2
   else
      grep -ril $1 $CASEDIR
   fi
}

# Grep recursivelly inside Workdir and only show files
grepc(){
   CASEDIR="${CASEDIR}/notes/"
   if [ ! -z $2 ] ;then
      grep -ri $1 $2
   else
      grep -ri $1 $CASEDIR
   fi
}

# List files which match search
lsc(){
   CASEDIR="${CASEDIR}/notes/"
   find $CASEDIR -iname \*$1\*
}


#=-=-=-= Workdir Aliases =-=-=-=#
alias activate_case="source ${CASEDIR}/current.sh"
alias cdc='cd $CaseDIR'
alias vic='vi +":set filetype=markdown" $CASE'
