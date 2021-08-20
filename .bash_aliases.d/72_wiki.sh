#################################################################################
#     File Name           :     tmux.sh
#     Created By          :     Eloi Silva
#     Creation Date       :     [2020-08-30 13:11]
#     Description         :     Bash TMUX aliases & functions
#################################################################################

#=-=-=-= Wiki Variables =-=-=-=#

# Default browser binary
BROWSER="/Applications/Firefox.app/Contents/MacOS/firefox --new-tab"

# VimWiki home
VIMWIKI_HOME="~/Documents/wiki"


#=-=-=-= Wiki Functions =-=-=-=#

# Create SSH tunnel and open wiki
wiki(){
   WIKI="admin@2.2.2.2"
   IP="${WIKI:-$1}"
   if ! lsof -nPiTCP:8080 -sTCP:LISTEN > /dev/null 2>&1 ;then
      ssh -fNL 8080:localhost:8000 $WIKI
   fi
   $BROWSER http://localhost:8080
   unset IP
}

# Create SSH tunnel and open dokuwiki
dwiki(){
   DWIKI="admin@2.2.2.2"
   IP="${DWIKI:-$1}"
   if ! lsof -nPiTCP:8443 -sTCP:LISTEN >/dev/null 2>&1 ;then
      ssh -fNL 8443:localhost:443 $DWIKI
   fi
   $BROWSER https://localhost:8443
   unset IP
}


#=-=-=-= Wiki  Aliases =-=-=-=#

# Change directory to VimWiki home
alias cdw="cd $VIMWIKI_HOME"
alias sme="view $VIMWIKI_HOME/sme/ec2_linux/index.md"
