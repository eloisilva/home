# Create SSH tunnel and open wiki & dokuwiki

BROWSER="/Applications/Firefox.app/Contents/MacOS/firefox --new-tab"
WIKI="admin@2.2.2.2"
DWIKI="admin@2.2.2.2"

wiki(){
   IP="${WIKI:-$1}"
   if ! lsof -nPiTCP:8080 -sTCP:LISTEN > /dev/null 2>&1 ;then
      ssh -fNL 8080:localhost:8000 $WIKI
   fi
   $BROWSER http://localhost:8080
   unset IP
}

dwiki(){
   IP="${DWIKI:-$1}"
   if ! lsof -nPiTCP:8443 -sTCP:LISTEN >/dev/null 2>&1 ;then
      ssh -fNL 8443:localhost:443 $DWIKI
   fi
   $BROWSER https://localhost:8443
   unset IP
}
