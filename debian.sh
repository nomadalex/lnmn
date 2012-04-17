#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

NODE_VERSION="v0.6.15"
node_tarball="node-$NODE_VERSION.tar.gz"

# Check if user is root
if [ $(id -u) != "0" ]; then
    echo "Error: You must be root to run this script, please use root to install lnmp"
    exit 1
fi

clear
echo "========================================================================="
echo "LNMN V0.1 for Debian VPS ,  Written by ifreedom "
echo "========================================================================="
echo "A tool to auto-compile & install Nginx+Mongodb+nodejs on Linux "
echo "Thanks to lnmp ( www.lnmp.org )"
echo ""
echo "========================================================================="
cur_dir=$(pwd)

if [ "$1" == "--help" ]; then
	exit
fi

#set main domain name
domain="www.lnmp.org"
echo "Please input domain:"
read -p "(Default domain: www.lnmp.org):" domain
if [ "$domain" = "" ]; then
	domain="www.lnmp.org"
fi
echo "==========================="
echo "domain=$domain"
echo "==========================="

#set area

area="america"
echo "Where are your servers located? asia,america,europe,oceania or africa "
read -p "(Default area: america):" area
if [ "$area" = "" ]; then
	area="america"
fi
echo "==========================="
echo  "area=$area"
echo "==========================="

#pause for start
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
echo "Press any key to start..."
char=`get_char`

source ./install/optimize.sh

echo "============================check files=================================="
function check_file {
  if [ -s $1 ]; then
    echo "$1 [found]"
  else
    echo "Error: $1 not found!!!download now......"
    wget -c "$2"
  fi
}

tarball="$node_tarball"
check_file $tarball "http://nodejs.org/dist/$NODE_VERSION/$tarball"

echo "============================check files=================================="

echo "========================== nginx install ==============================="
cd $cur_dir
source ./install/nginx.sh
echo "==================== nginx install completed ==========================="

echo "==================== nodejs install ===================================="
cd $cur_dir
source ./install/nodejs.sh
echo "==================== nodejs install completed ==========================="

echo "==================== mongodb install ===================================="
cd $cur_dir
source ./install/mongodb.sh
echo "==================== mongodb install completed ==========================="

cp conf/index.html /home/wwwroot/index.html

cd $cur_dir
cp lnmn /root/lnmn
chmod +x /root/lnmn
cp vhost.sh /root/vhost.sh
chmod +x /root/vhost.sh
/etc/init.d/nginx start
echo "========================== Check install ================================"
clear
#source ./install/check_install.sh
