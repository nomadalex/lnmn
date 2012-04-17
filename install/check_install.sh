if [ -s /usr/local/nginx ] && [ -s /usr/local/php ] && [ -s /usr/local/mysql ]; then

echo "Install LNMP V0.8 completed! enjoy it."
echo "========================================================================="
echo "LNMP V0.8 for Debian VPS , Written by Licess "
echo "========================================================================="
echo ""
echo "For more information please visit http://www.lnmp.org/"
echo ""
echo "lnmp status manage: /root/lnmp {start|stop|reload|restart|kill|status}"
echo "default mysql root password:$mysqlrootpwd"
echo "phpinfo : http://$domain/phpinfo.php"
echo "phpMyAdmin : http://$domain/phpmyadmin/"
echo "Prober : http://$domain/p.php"
echo ""
echo "The path of some dirs:"
echo "mysql dir:   /usr/local/mysql"
echo "php dir:     /usr/local/php"
echo "nginx dir:   /usr/local/nginx"
echo "web dir :     /home/wwwroot"
echo ""
echo "========================================================================="
/root/lnmp status
netstat -ntl
else
  echo "Sorry,Failed to install LNMP!"
  echo "Please visit http://bbs.vpser.net/forum-25-1.html feedback errors and logs."
fi
