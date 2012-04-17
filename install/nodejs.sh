cd $cur_dir
apt-get install -y openssl libssl-dev

tar zxvf $node_tarball
cd "node-$NODE_VERSION"
./configure --prefix=/usr/local/node
make && make install
