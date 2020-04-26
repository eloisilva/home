#! /bin/bash
#################################################################################
#     File Name           :     default.sh
#     Created By          :     Eloi Silva
#     Creation Date       :     [2020-04-26 16:40]
#     Last Modified       :     [2020-04-26 17:21]
#     Description         :     Bash default aliases
#################################################################################

#=-=-=-= Python =-=-=-=#
alias py='/usr/bin/python'
alias py3='/usr/local/bin/python3'


#=-=-=-= GIT =-=-=-=#
alias ga='git add'
alias gm='git commit -m'
alias gs='git status'
alias gd='git diff'
alias gl='git log --oneline'
alias gla='git log --stat --graph --summary --oneline'


#=-=-=-= Others =-=-=-=#
# PSQL Connect
alias psql_conn='psql -U postgres'

# Performance
alias load='clear && while : ;do uptime |cut -d, -f3- ;sleep 5 ;done'

# grep color
alias grep='/usr/bin/grep --color'

# display ipv4
alias ips='ifconfig |egrep -o "([0-9]{1,3}\.){1,3}[0-9]{1,3}" --color'


#=-=-=-= SSH =-=-=-=#
alias ec2='ssh -l ec2-user'
alias admin='ssh -l admin'
alias ubuntu='ssh -l ubuntu'
alias centos='ssh -l centos'
alias maloy='ssh -l maloy'
alias debian='ssh -l maloy'


# Instances connect
alias debold='admin 34.240.190.197'
alias deb='admin 34.249.15.165' 
alias al2='ec2 52.51.252.173'
alias al='ec2 63.34.47.245'
