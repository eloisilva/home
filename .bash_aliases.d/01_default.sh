#! /bin/bash
#################################################################################
#     File Name           :     default.sh
#     Created By          :     Eloi Silva
#     Creation Date       :     [2020-04-26 16:40]
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
alias gl='git log --oneline --graph --all'
alias gla='git log --stat --graph --summary --oneline --all'


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
alias debian='ssh -l debian'


# Instances connect
alias debold='admin 34.240.190.197'
alias deb='admin 34.249.15.165' 
alias al2='ec2 52.51.252.173'
alias al='ec2 63.34.47.245'


#=-=-=-= functions =-=-=-=#

# Return BGP AS Number for IP address
ans(){
   whois -h whois.cymru.com "-v $1"
}

killp(){
   [ -z $1 ] && echo "Use: killp {tcp_port_number}" && return 1
   PID=$(lsof -nPiTCP:$1 -sTCP:LISTEN -t)
   if [[ ! -z $PID ]] ;then
      kill $PID && \
         echo "[OK] - Killed: $PID" || \
         echo "[Fail] - Failled to kill PID(s) $PID"
   else
      echo "[ERR] - No PID found for TCP PORT $1"
   fi
   unset PID
}
