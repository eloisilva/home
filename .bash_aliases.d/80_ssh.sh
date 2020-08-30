#! /bin/bash
#################################################################################
#     File Name           :     80_ssh.sh
#     Created By          :     Eloi Silva
#     Creation Date       :     [2020-08-30 13:02]
#     Description         :     SSH aliases
#################################################################################

#=-=-=-= SSH Default users =-=-=-=#
alias ec2='ssh -l ec2-user'
alias admin='ssh -l admin'
alias ubuntu='ssh -l ubuntu'
alias centos='ssh -l centos'
alias maloy='ssh -l maloy'
alias debian='ssh -l debian'
alias toor='ssh -l toor'


#=-=-=-= SSH EC2 =-=-=-=#
alias deb='admin 1.1.1.1' 
alias debold='admin 2.2.2.2'
alias al2='ec2 3.3.3.3'
alias al='ec2 4.4.4.4'
