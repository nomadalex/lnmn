#set timezone
rm -rf /etc/localtime
ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

#Disable SeLinux
if [ -s /etc/selinux/config ]; then
	sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
fi

if [ -s /etc/ld.so.conf.d/libc6-xen.conf ]; then
	sed -i 's/hwcap 1 nosegneg/hwcap 0 nosegneg/g' /etc/ld.so.conf.d/libc6-xen.conf
fi

#speed up source
apt-get install -y apt-spy
cp /etc/apt/sources.list /etc/apt/sources.list.bak
apt-spy update
apt-spy -d stable -a $area -t 5

grep null /etc/apt/sources.list.d/apt-spy.list
if [ $? -eq 0 ]; then
	cat >/etc/apt/sources.list.d/apt-spy.list<<EOF
deb http://mirror.peer1.net/debian/ stable main #contrib non-free
deb-src http://mirror.peer1.net/debian/ stable main #contrib non-free
deb http://security.debian.org/ stable/updates main
EOF
fi

apt-get update

#sync datetime
apt-get install -y ntpdate
ntpdate -u pool.ntp.org
date

#remove previous package
dpkg -l |grep mysql
dpkg -P libmysqlclient15off libmysqlclient15-dev mysql-common
dpkg -l |grep apache
dpkg -P apache2 apache2-doc apache2-mpm-prefork apache2-utils apache2.2-common
dpkg -l |grep php
dpkg -P php

killall apache2
apt-get remove -y apache2 apache2-doc apache2-utils apache2.2-common apache2.2-bin apache2-mpm-prefork apache2-doc apache2-mpm-worker mysql-client mysql-server mysql-common php

apt-get autoremove -y
apt-get -fy install

if [ `getconf WORD_BIT` = '32' ] && [ `getconf LONG_BIT` = '64' ] ; then
    ln -s /usr/lib/x86_64-linux-gnu/libpng* /usr/lib/
    ln -s /usr/lib/x86_64-linux-gnu/libjpeg* /usr/lib/
else
    ln -s /usr/lib/i386-linux-gnu/libpng* /usr/lib/
    ln -s /usr/lib/i386-linux-gnu/libjpeg* /usr/lib/
fi

ulimit -v unlimited

if [ ! `grep -l "/lib"    '/etc/ld.so.conf'` ]; then
	echo "/lib" >> /etc/ld.so.conf
fi

if [ ! `grep -l '/usr/lib'    '/etc/ld.so.conf'` ]; then
	echo "/usr/lib" >> /etc/ld.so.conf
fi

if [ -d "/usr/lib64" ] && [ ! `grep -l '/usr/lib64'    '/etc/ld.so.conf'` ]; then
	echo "/usr/lib64" >> /etc/ld.so.conf
fi

if [ ! `grep -l '/usr/local/lib'    '/etc/ld.so.conf'` ]; then
	echo "/usr/local/lib" >> /etc/ld.so.conf
fi

ldconfig

cat >>/etc/security/limits.conf<<EOF
* soft noproc 65535
* hard noproc 65535
* soft nofile 65535
* hard nofile 65535
EOF

cat >>/etc/sysctl.conf<<EOF
fs.file-max=65535
EOF

#install basic package
apt-get install -y build-essential gcc g++ make autoconf automake cmake
