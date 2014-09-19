#!/bin/sh



MODULEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd .. && pwd )";
#echo $MODULEDIR;

source $MODULEDIR/lib/shell/inc.sh;


VARS="$MODULEDIR/lib/shell/vars.sh"

#show variables:
#$VARS;

#evaluate variables:
eval `$VARS`



#Environments
IFS=', ' read -a ENV_ARRAY <<< "$AvailableEnvironments"


#Script command
SCRIPT_COMMAND="./d";





#colors
NORMAL=`echo "\033[m"`
MENU=`echo "\033[36m"` #Blue
NUMBER=`echo "\033[33m"` #yellow
FGRED=`echo "\033[41m"`
RED_TEXT=`echo "\033[31m"`
ENTER_LINE=`echo "\033[33m"`



show_menu(){

	echo "${ENTER_LINE} _   _ _   _          _ _     "
	echo '| |_(_) |_| |___   __| | |__  '
	echo '|  _| |  _| / -_)_/ _` | / /  '
	echo " \__|_|\__|_\___(_)__,_|_\_\  "
	echo ''
	echo "Deployment scripts for ${NORMAL}$Projectname${NORMAL}"
	echo ''    
	echo "${ENTER_LINE}Please choose environment.${NORMAL}"
	echo "${MENU}***********************************************${NORMAL}"
	
	

	i=1;

	for element in "${ENV_ARRAY[@]}"
	do
		echo "${MENU}${NUMBER} $i)${MENU} $element ($SCRIPT_COMMAND $element)${NORMAL}"
		
		let i++;
	done


	echo "${MENU}${NUMBER} help)${MENU} Get help ${NORMAL}"


	echo "${MENU}***********************************************${NORMAL}"
	echo "${ENTER_LINE}Please enter a menu option and enter or ${RED_TEXT}enter to exit. ${NORMAL}"
	echo "${RED_TEXT}NOTE: ${ENTER_LINE}This should only be run from your local environment. ${NORMAL}"
	read opt
}
function option_picked() {
	COLOR='\033[01;31m' # bold red
	RESET='\033[00;00m' # normal white
	#MESSAGE=${@:-"${RESET}Error: No message passed"}
	echo "${COLOR}${MESSAGE}${RESET}"
}









#Checking if any parameters have been supplied
#if not, show the menu
if [ -n "$1" ]
then

	#we expect the script to be called with the environment
    #echo 'we do some execution:'
    #$MODULEDIR/local/deploy.sh $1
    

	# Reset all variables that might be set
	verbose=0
	
	MODE_SSH=0
	MODE_PUSH=0
	MODE_SUDO=0
	
	
	
	# handling command line arguments, see http://mywiki.wooledge.org/BashFAQ/035
	while :; do
	
		#echo $1;
	
		#Environments
		i=1
		
		envtest=$1
		
		#Environments
		i=1
		for element in "${ENV_ARRAY[@]}"
		do
			if [ $element == $1 ]
			then
				CMD="$SCRIPT_COMMAND $element";
				echo "executing $CMD...";
				#$CMD;
			fi
			
			let i++;
		done
	
	
	
		case $1 in
		
			ssh)
				echo 'ssh mode'
				MODE_SSH=1
				;;
			sudo)
				echo 'sudo mode'
				MODE_SUDO=1
				;;
			push)
				echo 'push mode'
				MODE_PUSH=1
				;;
		
			-h|-\?|--help)   # Call a "show_help" function to display a synopsis, then exit.
				show_help
				exit
				;;
			-v|--verbose)
				verbose=$((verbose + 1)) # Each -v argument adds 1 to verbosity.
				;;
			--)              # End of all options.
				shift
				break
				;;
			-?*)
				printf 'WARN: Unknown option (ignored): %s\n' "$1" >&2
				;;
			*) # Default case: If no more options then break out of the loop.
				break
		esac
	
		shift
	done
	
	
	
	#echo $MODE_SSH;
	#echo $MODE_SUDO;
	#echo $MODE_PUSH;
	
	
	
	
	#If "push" is added, the first thing to do is to push the repo
	if [ $MODE_PUSH -eq 1 ]
	then
		#It's the branch that we're currently on that will be pushed
		#TODO
		echo "":
	fi
	
	
	
	
	# Based on the different modes we'll perform different actions
	if [ $MODE_SSH -eq 1 ]
	then
		#SSH mode: can't be combined with other modes
		echo "this is the ssh mode"
	elif [ $MODE_SUDO -eq 1 ]
	then
		echo "this is the SUDO mode (yet to be implemented"
	else
		echo "just deploying"
	fi
    
else
    	
	clear
	show_menu
	while [ opt != '' ]
		do
		if [[ $opt = "" ]]; then 
				exit;
		else
			case $opt in
			#1) clear;
			#option_picked "Option 1 Picked";
			##sudo mount /dev/sdh1 /mnt/DropBox/; #The 3 terabyte
			#echo test tst
			#show_menu;
			#;;
	
			x)exit;
			;;
	
			\n)exit;
			;;
	
			*)clear;
	
			#Environments
			i=1
			for element in "${ENV_ARRAY[@]}"
			do
	
				if (( $i == $opt ))
				then
					CMD="$SCRIPT_COMMAND $element";
					echo "executing $CMD...";
					$CMD;
				fi
				
				let i++;
			done
	
			
			option_picked "Pick an option from the menu";
			show_menu;
			;;
		esac
	fi
	done
fi



###The script can be called with a few shortcuts
#case "$1" in
#
#help)  echo "Help"
#	
#	;;
#
#Live) echo 'testing'
#
#
#	;;
#	
#*) echo "Please choose environment:"
#	
#	
#	;;
#esac
#

