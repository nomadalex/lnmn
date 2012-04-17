groupadd www
useradd -s /sbin/nologin -g www www

mkdir -p /home/wwwroot
chmod +w /home/wwwroot
mkdir -p /home/wwwlogs
chmod 777 /home/wwwlogs
touch /home/wwwlogs/nginx_error.log

chown -R www:www /home/wwwroot

# nginx
tarball="pcre-8.12.tar.gz"
check_file $tarball "http://soft.vpser.net/web/pcre/$tarball"

tarball="nginx-1.0.10.tar.gz"
check_file $tarball "http://soft.vpser.net/web/nginx/$tarball"

tar zxvf pcre-8.12.tar.gz
cd pcre-8.12/
./configure
make && make install
cd ..

tar zxvf nginx-1.0.10.tar.gz
cd nginx-1.0.10/
./configure --user=www --group=www --prefix=/usr/local/nginx --with-http_stub_status_module --with-http_ssl_module --with-http_gzip_static_module --with-ipv6
make && make install
cd ..

rm -f /usr/local/nginx/conf/nginx.conf
cp conf/nginx.conf /usr/local/nginx/conf/nginx.conf
cp conf/proxy.conf /usr/local/nginx/conf/proxy.conf
sed -i 's/www.lnmp.org/'$domain'/g' /usr/local/nginx/conf/nginx.conf

cp conf/init.d.nginx /etc/init.d/nginx
chmod +x /etc/init.d/nginx
update-rc.d -f nginx defaults
