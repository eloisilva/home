#! /bin/bash
#################################################################################
#     File Name           :     awscli.sh
#     Created By          :     Eloi Silva
#     Creation Date       :     [2020-04-26 16:40]
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

# Terminate Instance
ec2terminate() {
   args=("$@")
   [[ ${args[0]} =~ ^"i-" ]] || args[0]="i-${args[0]}"
   aws ec2 terminate-instances --instance-ids ${args[@]}
}

ec2run() {
   args=("$@")
   SG="sg-0590e441933a35413"
   INSTANCETYPE="t3.medium"
   SSHKEY="Dublin-eu-west-1"
   [[ ${args[0]} =~ ^"ami-" ]] || args[0]="ami-${args[0]}"
   aws ec2 run-instances --instance-type $INSTANCETYPE --security-group-ids $SG --key-name $SSHKEY --image-id ${args[@]}
   # Usage: ec2run ami-xxx --user-data file://UserDataScript.sh --region eu-west-1
}

ec2tag(){
   args=("$@")
   if [ ${#args[*]} -lt 2 ] ;then
      echo "Use: ec2tag tagname:tagvalue instance_id1 instance_id2"
      return 1
   fi
   read NAME VALUE <<< `echo ${args[0]} |tr ':' ' '`
   aws ec2 create-tags --tags "Key=$NAME,Value=$VALUE" --resources ${args[@]:1}
   # Usage: ec2tag Name:Debian10 i-xxx --region eu-west-1
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

# List instance id
ec2id(){
   aws ec2 describe-network-interfaces --filters Name=addresses.association.public-ip,Values=$1 --query NetworkInterfaces[].Attachment.InstanceId --output text
}

# Attach IAM Instance Profile to instance
ec2profile-association(){
   args=("$@")
   [[ ${args[1]} =~ ^"i-" ]] || args[1]="i-${args[1]}"
   aws ec2 associate-iam-instance-profile --iam-instance-profile "Name=${args[0]}" --instance-id ${args[@]:1}
   # Usage: ec2profile SSMCoreOnly i-xxx
}

ec2list-tags(){
   args=("$@")
   [[ ${args[0]} =~ ^"i-" ]] || args[0]="i-${args[0]}"
   aws ec2 describe-instances --query "Reservations[].Instances[].[InstanceId,Tags]" --instance-ids ${args[@]}
}

ec2profile-list(){
   args=("$@")
   [[ ${args[0]} =~ ^"i-" ]] || args[0]="i-${args[0]}"
   aws ec2 describe-iam-instance-profile-associations --filters "Name=instance-id,Values=${args[0]}" ${args[@]:1}
}

ec2userData() {
   args=("$@")
   [[ ${args[0]} =~ ^"i-" ]] || args[0]="i-${args[0]}"
   aws ec2 modify-instance-attribute --instance-id ${args[0]} --attribute userData --value file://${args[@]:1}
}

ec2userData-list() {
   args=("$@")
   [[ ${args[0]} =~ ^"i-" ]] || args[0]="i-${args[0]}"
   printf $(aws ec2 describe-instance-attribute --instance-id ${args[0]} --attribute userData --query 'UserData.Value' ${args[@]:1} |cut -d'"' -f2 ) |base64 -D
}

ec2stopall() {
   (describe_ec2.py |awk -F'|' '{if($3 ~ "i-" && $4 ~ "running") print $3, $7}' |tr -s " ") |while read -r instance ;do
      instance=($instance) ;i=${instance[0]} ;r=${instance[1]: -1}; ec2stop $i --region $r
   done
}

#=-=-=-= AWSCLI Aliases =-=-=-=#
# List running instances. Fields = {InstanceID, Name, PublicIPAddress}
#alias ec2run="aws ec2 describe-instances --filters 'Name=instance-state-code,Values=16' --query 'Reservations[*].Instances[*].[InstanceId,State.Name,PublicIpAddress]'"
alias ec2iam-instance-profiles='aws iam list-instance-profiles --query "InstanceProfiles[].Roles[].RoleName"'
