#! /bin/bash
#################################################################################
#     File Name           :     90_amazon.sh
#     Created By          :     Eloi Silva
#     Creation Date       :     [2020-04-27 15:26]
#     Last Modified       :     [2021-05-24 00:17]
#     Description         :      
#################################################################################

# Rename new Certificates
renameCerts(){
   if [[ ! -z $1 ]] ;then
      (
         cd ~/Documents/Trainings/Certificates/
         mv -v certificate.pdf "Certificate - $1.pdf"
      )
   else
      echo "Please provide the new name for the certificate"
      echo "$0: $1 -- $@"
   fi
}

macvnc(){
   MACUSER="ec2-user"
   args=("$@")
   IP="${args[1]}"
   VNCPORT="5900"
   if ! lsof -nPiTCP:$VNCPORT -sTCP:LISTEN > /dev/null 2>&1 ;then
      echo "ssh -fNL $VNCPORT:localhost:5900 $MACUSER@$IP ${args[@]:1}"
      ssh -fNL $VNCPORT:localhost:5900 $MACUSER@$IP ${args[@]:1}
   fi
   open vnc://localhost:$VNCPORT
   unset IP MACUSER VNCPORT args
}
