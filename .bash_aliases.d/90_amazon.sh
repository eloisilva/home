#! /bin/bash
#################################################################################
#     File Name           :     90_amazon.sh
#     Created By          :     Eloi Silva
#     Creation Date       :     [2020-04-27 15:26]
#     Description         :      
#################################################################################

# Rename new Certificates
renameCerts(){
   if [[ ! -z $1 ]] ;then
      (
         cd ~/Documents/KNETs/Certificates/
         mv -v certificate.pdf "Certificate - $1.pdf"
      )
   else
      echo "Please provide the new name for the certificate"
      echo "$0: $1 -- $@"
   fi
}
