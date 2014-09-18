#! /bin/bash
#Getting environment specific variables

DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi

source $DIR/inc.sh;

ENV=$1
#echo $ENV;

env_check $ENV



VARS="$DIR/vars.sh"

#show variables:
#$VARS;

#evaluate variables:
eval `$VARS`


PRE="Environments_$ENV"

host=$PRE"_Host"
sshuser=$PRE"_Sshuser"
repodir=$PRE"_Repodir"
sshport=$PRE"_Sshport"


#These are the variables that are exported:

echo "HOST=${!host}"
echo "SSHUSER=${!sshuser}"
echo "REPODIR=${!repodir}"
echo "SSHPORT=${!sshport}"


# Based on these, the folling variables are defined
#testing on server
if [ "${!host}" != "" ]; then

	#defining custom_sshconnectionstr
	PORTSTR="";
	if [ "${!sshport}" != "" ]; then
	  PORTSTR="-p ${!sshport}"
	fi
	echo "CUSTOM_SSHPORTSTR=\"$PORTSTR\"";

	CUSTOM_SSHCONNECTIONSTR="$PORTSTR ${!sshuser}@${!host}";
	echo "CUSTOM_SSHCONNECTIONSTR=\"$CUSTOM_SSHCONNECTIONSTR\"";


fi
