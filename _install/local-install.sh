#! /bin/sh

#colors
NORMAL=`echo "\033[m"`
MENU=`echo "\033[36m"` #Blue
NUMBER=`echo "\033[33m"` #yellow
FGRED=`echo "\033[41m"`
RED_TEXT=`echo "\033[31m"`
ENTER_LINE=`echo "\033[33m"`


echo "${ENTER_LINE} _   _ _   _          _ _     "
echo '| |_(_) |_| |___   __| | |__  '
echo '|  _| |  _| / -_)_/ _` | / /  '
echo " \__|_|\__|_\___(_)__,_|_\_\  "
echo ''
echo "SilverStripe Deployment Installer"
echo ''    
echo "${MENU}***********************************************${NORMAL}"



#cd ../..;


echo "Now creating your first config file.";
echo "NOTE: Make sure that your project has been checked out on the server, before initiating this installation.";



echo "";

echo "Please enter the host name of the server you want to deploy to:"
read HOST

echo "Please enter your SSH user:"
read SSHUSER

echo "Please enter the path that your repository is checked out to on the server:"
read REPODIR





#creation of config, based on input


echo "Environments:
Projectname: \"My project\"
AvailableEnvironments: \"Live, Test, Dev\"
  Live:
    #required
    Host: \"$HOST\"
    Sshuser: \"$SSHUSER\"
    Repodir: \"$REPODIR\"

    #additional settings
    Sshport: \"\"
    Composerdir: \"\" #not yet implemented

  Test:
    #here goes data for a test server
  Dev:
    #here goes data for dev server - you can add as many servers as you want

" > deployment-config.yml;


#creating the "deploy" script, and setting permissions

echo "#!/bin/sh
./deployment/local/menu.sh \"$@\"" > d;
chmod u+x d;

echo "";
echo "Installation is done. You can now deploy by running \"./d\"";
echo "Remember to commit the changed to your repo."
echo ""

echo "${MENU}***********************************************${NORMAL}"

echo ""
