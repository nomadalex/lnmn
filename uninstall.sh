#!/bin/bash

# Check if user is root
if [ $(id -u) != "0" ]; then
    echo "Error: You must be root to run this script, use sudo sh $0"
    exit 1
fi

clear
echo "========================================================================="
echo "LNMN V0.1 for Linux VPS  Written by ifreedom "
echo "========================================================================="
cur_dir=$(pwd)

echo ""
echo "Please backup your data first!!!!!"

get_char()
{
	SAVEDSTTY=`stty -g`
	stty -echo
	stty cbreak
	dd if=/dev/tty bs=1 count=1 2> /dev/null
	stty -raw
	stty echo
	stty $SAVEDSTTY
}
echo ""
echo "Press any key to start uninstall LNMP , please wait ......"
char=`get_char`

cd $cur_dir
source ./uninstall/nginx.sh

cd $cur_dir
source ./uninstall/nodejs.sh

cd $cur_dir
source ./uninstall/mongodb.sh

rm /root/vhost.sh
rm /root/lnmn

echo "Lnmn Uninstall completed."

echo "========================================================================="
echo "LNMN V0.1 for Linux VPS  Written by ifreedom "
echo "========================================================================="
