cur_dir=$(pwd)

. ${cur_dir}/include/config.sh
load_config

#apache 관련 삭제
yum remove -y net-tools bind-utils gcc kernel-devel make bzip2 vim vsftpd ipvsadm
yum remove -y httpd
rm -rf /etc/httpd/conf
rm -rf /home/shop/www

#php 삭제
rpm -e epel-release-latest-7.noarch
rpm -e webtatic-release

yum remove -y php70w
yum remove -y php70w-mysql php70w-pdo php70w-pgsql php70w-odbc php70w-mbstring php70w-mcrypt php70w-gd php70w-pear php70w-pdo_dblib php70w-imagick php70w-pecl-imagick-devel php70w-xml php70w-xmlrpc php70w-soap php70w-opcache
rm -f /etc/php.ini

#iptable 삭제
yum remove -y iptables

rm -rf /lamp
rm -f ~/.vimrc
sed -i '8,15d' ~/.bashrc

yum remove -y kde-workspace
yum remove -y gdm
yum remove -y fonts-korean
