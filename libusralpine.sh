#!/bin/sh

#########################################################################################
# MODULE 
#########################################################################################

PROGRAM_DIR=/usr/bin

WHITE="\e[97m"
LIGHT_BLUE="\e[94m"
LIGHT_RED="\e[91m"
LIGHT_YELLOW="\e[93m"
ENDCOLOR="\e[0m"

header()
{
    echo -e "${LIGHT_BLUE}"
    echo "#########################################################################################"
    echo "# $1"   
    echo "#########################################################################################"
    echo -e "${ENDCOLOR}"
}

die()
{
    echo -e "${LIGHT_RED}* $1${ENDCOLOR}"
    exit 1
}

warn()
{
    echo -e "${LIGHT_YELLOW}* $1${ENDCOLOR}"
}

task()
{
    echo -e "${LIGHT_BLUE}-- $1${ENDCOLOR}"   
}

step()
{
    echo -e "${WHITE}-> $1${ENDCOLOR}"   
}

footer_start()
{
    echo
    echo 
    echo -e "${LIGHT_BLUE}# note:${ENDCOLOR}"
}

footer_text()
{
    echo -e "${LIGHT_BLUE}# $1${ENDCOLOR}"
}

footer_end()
{
    echo
    echo
}