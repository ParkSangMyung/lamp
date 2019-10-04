yum install -y iptables-services

# not use firewalld
systemctl stop firewalld
systemctl mask firewalld

# basic policy ACCEPT
iptables -P INPUT ACCEPT

# defines policy delete
iptables -F

# basic policy setting
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT

# accept TCP port 22 SSH connection
iptables -A INPUT -p tcp -m tcp --dport 22 -j ACCEPT

# accept localhost packet
iptables -A INPUT -i lo -j ACCEPT

# accept ESTABLISHED, RELATED
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# accept apache 80 port
iptables -A INPUT -p tcp -m tcp --dport 80 -j ACCEPT
#iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 443 -j ACCEPT

# accept ftp passive mode
#iptables -A INPUT -p tcp -m tcp --dport 21 -j ACCEPT
#iptables -A INPUT -p tcp -m tcp --dport 50090:50100 -j ACCEPT

# save setting
/sbin/service iptables save

# iptables check/start
chkconfig iptables on
systemctl start iptables
#systemctl enable iptables

chmod -R 755 /home/bbashop/www/

# release security setting of seLinux 
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
setenforce 0
#ls -lZ /home/bbashop/www
#chcon -R -t httpd_sys_content_t /home/bbashop/www
#service vsftpd restart

service sshd restart
systemctl restart httpd

# https://webdir.tistory.com/170