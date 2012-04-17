if [ -s /usr/local/nginx ] && [ -s /usr/local/node ] && [ -s /etc/init.d/mongodb ]; then

echo "Install LNMN V0.1 completed! enjoy it."
echo "========================================================================="
echo "LNMN V0.1 for Debian VPS , Written by ifreedom "
echo "========================================================================="
echo ""
echo "lnmn status manage: /root/lnmn {start|stop|reload|restart|kill|status}"
echo ""
echo "The path of some dirs:"
echo "mongodb dir:   /var/lib/mongodb"
echo "node dir:     /usr/local/node"
echo "nginx dir:   /usr/local/nginx"
echo "web dir :     /home/wwwroot"
echo ""
echo "========================================================================="
/root/lnmn status
netstat -ntl
else
  echo "Sorry,Failed to install LNMN!"
fi
