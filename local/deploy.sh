#! /bin/bash
# This is the localhost part of the main deploy lib





#configuration file needs to be added with the url
CONFIG=$1;
#We can also add whatever we want to be executed on the server after deployment in $2


SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd .. && pwd)";


VARS="$SCRIPTDIR/lib/vars.sh"
VARSSTR="$VARS $CONFIG"
#echo $VARSSTR


chmod u+x $VARS
eval `$VARSSTR`


CUSTOM_VARS="$SCRIPTDIR/lib/vars-custom.sh"
CUSTOM_VARSSTR="$CUSTOM_VARS $CONFIG"

chmod u+x $CUSTOM_VARS
eval `$CUSTOM_VARSSTR`



#SSH in, and change dir
#Example:
#See also http://serverfault.com/questions/167416/change-directory-automatically-on-ssh-login

SCRIPT="$REPODIR/scripts/server/deploy.sh"

echo $SCRIPT $CONFIG


# this is doing the following:
# 1. ssh into the server
# 2. making the deploy script executeable
# 3. running the deploy script - WITH the specific config
# 4. running additional commands - if needed


ssh $CUSTOM_SSHCONNECTIONSTR -t "chmod u+x $SCRIPT;$SCRIPT $CONFIG; $2"

