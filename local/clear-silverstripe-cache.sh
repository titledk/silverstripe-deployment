#! /bin/bash
echo "Clearing silverstripe-cache"
echo "Please enter environment ('live' or 'test')"
read input_variable


SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd ../.. && pwd )";

CONFIG="";
if [ $input_variable = 'live' ] ; then
	CONFIG="live-site.yml"	
fi

if [ $input_variable = 'test' ] ; then
	CONFIG="test-site.yml"
fi




SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd ../.. && pwd)";


VARS="$SCRIPTDIR/lib/vars.sh"
VARSSTR="$VARS $CONFIG"
#echo $VARSSTR


chmod u+x $VARS
eval `$VARSSTR`


CUSTOM_VARS="$SCRIPTDIR/lib/vars-custom.sh"
CUSTOM_VARSSTR="$CUSTOM_VARS $CONFIG"

chmod u+x $CUSTOM_VARS
eval `$CUSTOM_VARSSTR`






ssh -t $CUSTOM_SSHCONNECTIONSTR bash -c "'


cd $REPODIR; 
sudo rm -rf public/silverstripe-cache
mkdir public/silverstripe-cache
chmod 777 public/silverstripe-cache


'"



