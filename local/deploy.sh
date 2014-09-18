#! /bin/bash
#This is the localhost part of the main deploy lib
#It needs the environment provided in the url ($1)
#E.g. Live, Test, Dev...

#Run like this:
#./ssh.sh Live


MODULEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd .. && pwd )";

ENV=$1


#Getting environment specific vars
VARS="$MODULEDIR/lib/shell/vars-for-env.sh $ENV"


#evaluate variables:
eval `$VARS`





#SSH in, and change dir
#Example:
#See also http://serverfault.com/questions/167416/change-directory-automatically-on-ssh-login

SCRIPT="$ENV_REPODIR/deployment/server/deploy.sh"

#echo $SCRIPT $ENV

#exit;


# this is doing the following:
# 1. ssh into the server
# 2. Updating git repoUpdating sub modules (e.g. in order to make sure the deploy lib is available)
# 3. making the deploy script executeable
# 4. running the deploy script - WITH the specific config
# 5. running additional commands - if needed

GITCOMMANDS="cd $ENV_REPODIR; git pull; git submodule init; git submodule sync; git submodule update; echo 'Now initiating deploy script on server...';" 

echo "Starting deployment to $ENV_HOST ($ENV)...";
echo "--------------------------------------------------------";
echo "Updating git repo, and syncing sub modules:";

ssh $ENV_CUSTOM_SSHCONNECTIONSTR -t "$GITCOMMANDS chmod u+x $SCRIPT;$SCRIPT $ENV; $2"

