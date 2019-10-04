# now directory
cur_dir=$(pwd)

# setting
. ${cur_dir}/include/config.sh
load_config

# Install and Setting for Apache
. ${cur_dir}/include/apache.sh

# Install and Setting for PHP
. ${cur_dir}/include/php.sh

# Install and Setting for Firewall
. ${cur_dir}/include/firewall.sh

# Install and Setting for Git
. ${cur_dir}/include/git.sh

# LAMP Finish
. ${cur_dir}/include/finish.sh

# Setting mount
#. ${cur_dir}/include/mount.sh

# make ssh-keygen 
# https://stove99.tistory.com/172

# Loading the pem file into ssh-keygen
# https://docs.aws.amazon.com/ko_kr/AWSEC2/latest/UserGuide/putty.html