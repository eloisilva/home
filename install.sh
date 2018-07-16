#!/bin/bash

PACKAGES="/root/home/packages.txt"
GITHOME="https://github.com/eloisilva/home.git"
INSTALL_DIR="$HOME/home/install/"

check(){
   [ -f $PACKAGES ] && echo "[OK] Package file $PACKAGES found" || ERROR="[Error] Package file not found" error
}

error(){
   echo $ERROR
   exit 1
}

install_packages(){
   ALL=`grep -v ^"#" $PACKAGES |grep . |xargs -n1000`
   apt install -y $ALL
}

install_dir(){
   for file in `ls -1 $INSTALL_DIR` ;do
      file=${INSTALL_DIR}${file}
      if [ -x ${file} ] ;then
         log=${file}.log
         echo "[Installing] `basename $file`..."
         $file > $log 2>&1 && echo "[OK] `basename $file`" || echo "[Error] `basename $file`"
      fi
   done
}

main(){
   check
   install_packages
   install_dir
}

main
