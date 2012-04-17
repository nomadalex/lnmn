apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10

cp conf/mongodb.list /etc/apt/sources.list.d/

apt-get update
apt-get install mongodb-10gen
