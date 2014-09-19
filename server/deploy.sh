#! /bin/bash
#title.dk's deploy script (server part)
#This needs the environment provided in the url ($1)
#E.g. Live, Test, Dev...

#Run like this:
#./deploy.sh Live


MODULEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd .. && pwd )";

ENV=$1

#at the moment options are only for sudo mode, but can be extended in the future
OPTIONS=$2

#defining sudo mode
SUDO_MODE=0

if [[ $OPTIONS == 'sudo' ]]; then
	SUDO_MODE=1;
fi


#Getting environment specific vars
VARS="$MODULEDIR/lib/shell/vars-for-env.sh $ENV"

#evaluate variables:
eval `$VARS`





echo '--------------------------------------------------------'
echo "Now running deployment on $ENV($ENV_HOST)"
echo ''
echo 'Directory:'
echo $ENV_REPODIR
echo ''

#exit;

SCRIPTNAME="$MODULEDIR/server/deploy.sh"


cd $ENV_REPODIR
#we need to make git ignore file mode changes, as this script needs to be executeable
#in order to be executed
git config core.filemode false

#we do the same in the "deployment" repo (as this is where this file is called)
cd deployment;
git config core.filemode false
cd ..



#Composer

COMPOSERSTR="composer";

#TODO: This is where composer will be configurable
#if [ "$DEPLOY_COMPOSERPHAR" == "1" ]; then
#	COMPOSERSTR="./composer.phar";
#fi


if [[ $SUDO_MODE -eq 1 ]]; then
	echo "Sudo mode: updating Composer";
	sudo $COMPOSERSTR self-update;
fi

echo "Installing Composer depencencies";
cd public; $COMPOSERSTR install;
cd ..;	


if [[ $SUDO_MODE -eq 1 ]]; then
	echo "Sudo mode: Rebuilding database"
	php public/framework/cli-script.php /dev/build flush=1
	
	echo "Sudo mode: Clearing/resetting \"silverstripe-cache\" directory"
	sudo rm -rf public/silverstripe-cache
	mkdir public/silverstripe-cache
	chmod 777 public/silverstripe-cache
	
fi

#Change owner
#
#This is completely taken out for now
#The public dir SHOULD be owned by another user than the web user - unless assets
#(which are not touched by this script) 
#
#if ! [ "$DEPLOY_DONTCHOWN" = "1" ]
#then
#	chown -R $WEBUSERANDGROUP public
#fi

#making this script executeable again
chmod u+x $SCRIPTNAME
echo ''
echo 'Deployment on $ENV($ENV_HOST)" has run.'
echo '--------------------------------------------------------'

