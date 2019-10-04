# Required before installing php
rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm

yum install -y php70w

# Install php library
yum install -y php70w-mysql php70w-pdo php70w-pgsql php70w-odbc php70w-mbstring php70w-mcrypt php70w-gd php70w-pear php70w-pdo_dblib php70w-imagick php70w-pecl-imagick-devel php70w-xml php70w-xmlrpc php70w-soap php70w-opcache

# basic php.ini backup
cp -f /etc/php.ini /etc/php.ini.bak

# Change option of php.ini
sed -i 's/short_open_tag = Off/short_open_tag = On/g' /etc/php.ini
sed -i 's/; max_input_vars = 1000/max_input_vars = 10000/g' /etc/php.ini
sed -i 's/memory_limit = 128M/memory_limit = 256M/g' /etc/php.ini
sed -i 's/display_errors = Off/display_errors = On/g' /etc/php.ini
sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 20M/g' /etc/php.ini
sed -i '877a\date.timezone = Asia/Seoul' /etc/php.ini

# Change option of opcache.ini
sed -i 's/opcache.memory_consumption=128/opcache.memory_consumption=1024/g' /etc/php.d/opcache.ini
sed -i 's/opcache.interned_strings_buffer=8/opcache.interned_strings_buffer=4/g' /etc/php.d/opcache.ini
sed -i 's/;opcache.revalidate_freq=2/opcache.revalidate_freq=0/g' /etc/php.d/opcache.ini
sed -i 's/;opcache.revalidate_path=0/opcache.revalidate_path=1/g' /etc/php.d/opcache.ini
sed -i 's/;opcache.save_comments=1/opcache.save_comments=0/g' /etc/php.d/opcache.ini

service httpd restart

# Add symbolic link
mkdir /usr/local/php/
ln -s /etc/php.ini /usr/local/php/php.ini

# Change web root authority
chmod -R 755 /home/shop
chmod -R 755 /home/shop/www
