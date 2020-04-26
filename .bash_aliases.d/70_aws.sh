#! /bin/bash
#################################################################################
#     File Name           :     awscli.sh
#     Created By          :     Eloi Silva
#     Creation Date       :     [2020-04-26 16:40]
#     Last Modified       :     [2020-04-26 17:33]
#     Description         :     BASH AWSCLI aliases & functions
#################################################################################

AWSCLI="${HOME}/awscli/"

#=-=-=-= AWSCLI config =-=-=-=
if [ ! -x "$(command -v aws)" ] ;then
   aws() {
      if [ $# -gt 0 ] ;then
         ${AWSCLI}/bin/aws $@
      else
         source ${AWSCLI}/bin/activate
         unset aws
      fi
   }
fi


#=-=-=-= AWSCLI functions =-=-=-=#

# Search AMI
amiSearch() {
   args=("$@")
   [[ ${args[0]} =~ ^"ami-" ]] || args[0]="ami-${args[0]}"
   aws ec2 describe-images --image-ids ${args[@]}
}

# Start Instance
ec2start() {
   args=("$@")
   [[ ${args[0]} =~ ^"i-" ]] || args[0]="i-${args[0]}"
   aws ec2 start-instances --instance-ids ${args[@]}
}

# Stop Instance
ec2stop() {
   args=("$@")
   [[ ${args[0]} =~ ^"i-" ]] || args[0]="i-${args[0]}"
   aws ec2 stop-instances --instance-ids ${args[@]}
}

# List instance IP address (if its running)
ec2ip() {
   args=("$@")
   IP=$(aws ec2 describe-instances --filters "Name=instance-state-code,Values=16" "Name=tag:Name,Values=${args[0]}*" --query 'Reservations[*].Instances[*].PublicIpAddress' --output text ${args[@]:1} |egrep -wo "([0-9]{1,3}\.){3}[0-9]{1,3}" --color=none)
   if [ -z $IP ] ;then
      [[ ${args[0]} =~ ^"i-" ]] || args[0]="i-${args[0]}"
      IP=$(aws ec2 describe-instances --filters "Name=instance-state-code,Values=16" "Name=instance-id,Values=${args[0]}*" --query 'Reservations[*].Instances[*].PublicIpAddress' --output text ${args[@]:1} |egrep -wo "([0-9]{1,3}\.){3}[0-9]{1,3}" --color=none)
   fi
   echo $IP
}

# If instance not stopped return 0 else start instance and return 1
ec2up() {
   args=("$@")
   [[ ${args[0]} =~ ^"i-" ]] || args[0]="i-${args[0]}"

   QUERY="Reservations[].Instances[].State.[Name]"
   if [ ! `aws ec2 describe-instances --query "$QUERY" --output text --instance-ids ${args[@]}` == "stopped" ] ;then
      return 0
   else 
      ec2start ${args[@]} > /dev/null 2>&1
      return 1
   fi
}


#=-=-=-= AWSCLI Aliases =-=-=-=#
# List running instances. Fields = {InstanceID, Name, PublicIPAddress}
alias ec2run="aws ec2 describe-instances --filters 'Name=instance-state-code,Values=16' --query 'Reservations[*].Instances[*].[InstanceId,State.Name,PublicIpAddress]'"

# List instance id
alias ec2id="aws ec2 describe-network-interfaces --filters Name=addresses.association.public-ip,Values=$1 --query NetworkInterfaces[].Attachment.InstanceId --output text"
