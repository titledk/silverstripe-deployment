#! /bin/bash
#title.dk's deploy script, September 2013

#This needs the server provided in the url ($1)
#E.g. Live, Test, Dev...


MODULEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd .. && pwd )";


SERVER=$1
echo $SERVER;
#TODO: die if no server/environment has been provided


VARS="$MODULEDIR/lib/shell/vars.sh"

#show variables:
$VARS;

#evaluate variables:
eval `$VARS`


PRE="Servers_$SERVER"

host=$PRE"_Host"
sshuser=$PRE"_Sshuser"
repodir=$PRE"_Repodir"
echo ${!host}
echo ${!sshuser}
echo ${!repodir}




echo '--------------------------------------------------------'
echo "Now deploying $SERVER(${!host})"
echo ''
echo 'Directory:'
echo ${!repodir}
echo ''

#exit;

SCRIPTNAME="$MODULEDIR/deployment/server/deploy.sh"


cd ${!repodir}
#we need to make git ignore file mode changes, as this script needs to be executeable
#in order to be executed
git config core.filemode false
git pull;
#we do the same in the "deployment" repo (as this is where this file is called)
cd deployment;
git config core.filemode false
cd ..


echo "Updating Git Submodules";
git submodule init;
git submodule sync;
git submodule update;


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

