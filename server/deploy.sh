#! /bin/bash
#title.dk's deploy script (server part)
#This needs the environment provided in the url ($1)
#E.g. Live, Test, Dev...

#Run like this:
#./deploy.sh Live


MODULEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd .. && pwd )";

ENV=$1


#Getting environment specific vars
VARS="$MODULEDIR/lib/shell/vars-for-env.sh $ENV"

#evaluate variables:
eval `$VARS`





echo '--------------------------------------------------------'
echo "Now running deploymet on $ENV($ENV_HOST)"
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



#if [ "$COMPOSER" = "1" ]
#then
#	if [ "$DEPLOY_NOSUDO" == "" ]; then
#		echo "Updating Composer";
#		sudo $COMPOSERSTR self-update;
#	fi
#	echo "Checking for/Installing Composer depencencies";
	cd public; $COMPOSERSTR install;
	cd ..;	
#fi

echo "Rebuilding database"
php public/framework/cli-script.php /dev/build flush=1


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
echo 'Deployment script has run.'
echo '--------------------------------------------------------'

