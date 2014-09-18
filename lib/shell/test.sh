#!/bin/sh

DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi



VARS="$DIR/vars.sh"
#eval `$VARS project-settings.yml`



#show variables:
$VARS;

#evaluate variables:
eval `$VARS`


echo $Servers_Live_Host;