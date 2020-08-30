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


#=-=-=-= Others =-=-=-=#
# PSQL Connect
alias psql_conn='psql -U postgres'

# Performance
alias load='clear && while : ;do uptime |cut -d, -f3- ;sleep 5 ;done'

# grep color
alias grep='/usr/bin/grep --color'

# display ipv4
alias ips='ifconfig |egrep -o "([0-9]{1,3}\.){1,3}[0-9]{1,3}" --color'


#=-=-=-= functions =-=-=-=#

# Return BGP AS Number for IP address
ans(){
   whois -h whois.cymru.com "-v $1"
}

# Kill process based on TCP port
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
