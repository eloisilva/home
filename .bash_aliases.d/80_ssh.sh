#! /bin/bash
#################################################################################
#     File Name           :     80_ssh.sh
#     Created By          :     Eloi Silva
#     Creation Date       :     [2020-08-30 13:02]
#     Description         :     SSH aliases
#################################################################################

#=-=-=-= SSH Function =-=-=-=#
function connect_ssh() {
   SSHBIN="/usr/bin/ssh"
   sshtimewait=3
   args=($*)
   until $SSHBIN ${args[@]} ;do
      echo "[ERR] connecting: $SSHBIN ${args[@]} - reconnecting in $sshtimewait seconds"
      sleep $sshtimewait
   done
}

#=-=-=-= SSH Default users =-=-=-=#
alias ec2='connect_ssh -l ec2-user'
alias admin='connect_ssh -l admin'
alias ubuntu='connect_ssh -l ubuntu'
alias centos='connect_ssh -l centos'
alias maloy='connect_ssh -l maloy'
alias debian='connect_ssh -l debian'
alias toor='connect_ssh -l toor'


#=-=-=-= SSH EC2 =-=-=-=#
alias deb='admin 1.1.1.1' 
alias debold='admin 2.2.2.2'
alias al2='ec2 3.3.3.3'
alias al='ec2 4.4.4.4'
