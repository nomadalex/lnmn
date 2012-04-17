NODE_VERSION="v0.6.15"

apt-get install -y openssl libssl-dev

node_tar_name="node-$NODE_VERSION"
tarball="$node_tar_name.tar.gz"
check_file $tarball "http://nodejs.org/dist/$NODE_VERSION/$tarball"

tar zxvf $tarball
cd $node_tar_name
./configure --prefix=/usr/local/node
make && make install
cd ..

cp conf/node.sh /usr/bin/node.sh
ln -s /usr/local/node/npm /usr/bin/npm
