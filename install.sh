#!/bin/bash

PACKAGES="/root/packages.txt"

check(){
   [ -f $PACKAGES ] && echo "[OK] Package file $PACKAGES found" || ERROR="[Error] Package file not found" error
}

error(){
   echo $ERROR
   exit 1
}

install(){
   ALL=`grep -v ^"#" $PACKAGES |grep . |xargs -n1000`
   apt install -y $ALL
}

main(){
   check
   install
}

main
