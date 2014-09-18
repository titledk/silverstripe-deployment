# SilverStripe Deployment

A deployment Proof of Concept by Title Web Solutions.

Licesensed under the MIT license.



**IMPORTANT: This is COMPLETE work in progress (18th September 2014)**



## How this works

TODO: Write this

This is pretty opinionated...




## Prerequisites

At the moment the system assumes the following

* You're using git
* You're using Composer for managing dependencies
* You're not adding the libraries managed by Compposer to git - instead you ignore them using `.gitignore` (TODO rewrite this to make it clearer to understand)
* You have Composer and git installed on your server(s)
* You have ssh access to your server, and know a little bit about how to configure a web server via the command line    
_This is only needed for setting it up, not for using it_


## Installation

Run the following command. This module will be added to your project as a sub module.

	git submodule add git@github.com:titledk/silverstripe-deployment.git deployment;./deployment/_install/local-install.sh;


## Known issues

* The color coding in the installer doesn't work very well on Linux, is only being used at OSX    
_This should be pretty straight forward to amend_





