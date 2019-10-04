StartDate=$(date "+%Y-%m-%d %H:%M:%S")
StartDateSecond=$(date +%s)

service network restart


yum update -y

# install basic library
yum install -y net-tools bind-utils gcc kernel-devel make bzip2 vim ipvsadm

# install depends library
yum install -y libjpeg* libpng* freetype* gd-* gcc-c++ gdbm-devel

# setting vi editor
cat >> ~/.vimrc <<EOF
set nu                  "줄번호
set ruler               "현재 커서 위치 표시
set hlsearch            "검색어 하이라이팅
set showmatch           "일치하는 괄호 하이라이팅
set encoding=utf8       "파일인코딩
set shiftwidth=4        "자동 들여쓰기 너비 설정
set tabstop=4           "tab 4칸이동
set ai                  "자동들여쓰기(윗라인맞춤)
set si                  "자동들여쓰기(if 나 for문 다음 라인 이동시)
set paste               "붙여넣기 들여쓰기 계단현상 방지
set title               "제목표시
set ignorecase          "검색 대소문자 구분안함
set warn                "문서 저장하지 않으면 경고
:colo koehler
syntax on
filetype on
EOF

sed -i '7a\alias vi=vim' ~/.bashrc
sed -i "8a\alias server='. /lamp/serverinfo.sh'" ~/.bashrc
sed -i "9a\alias restart='service httpd restart'" ~/.bashrc
sed -i "10a\alias start='service httpd start'" ~/.bashrc
sed -i "11a\alias stop='service httpd stop'" ~/.bashrc
sed -i "12a\alias status='service httpd status'" ~/.bashrc
sed -i "13a\alias home='cd /home/bbashop/www; ls -al'" ~/.bashrc
. ~/.bashrc

yum install -y httpd

# add user, authorization
#useradd bbashop
#echo 'free0428**zx' | passwd --stdin bbashop

# make directory web root
mkdir -p ${web_root_dir}
chmod 755 ${web_root_dir}

# copy httpd.conf
cp -f /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.conf.bak
rm -f /etc/httpd/conf/httpd.conf
cp -f /lamp/lamp-data/httpd.conf /etc/httpd/conf/httpd.conf

# make symbolic link apache
mkdir /usr/local/apache/
ln -s /etc/httpd/conf/ /usr/local/apache/

# setting connection ftp
#cp -f /etc/vsftpd/vsftpd.conf.bak
#sed -i 's/anonymous_enable=YES/anonymous_enable=no/g' /etc/vsftpd/vsftpd.conf
#sed -i 's/listen=NO/listen=YES/g' /etc/vsftpd/vsftpd.conf
#sed -i 's/connect_from_port_20=YES/#connect_from_port_20=YES/g' /etc/vsftpd/vsftpd.conf
#sed -i '129a\pasv_enable=YES' /etc/vsftpd/vsftpd.conf
#sed -i '130a\pasv_min_port=50090' /etc/vsftpd/vsftpd.conf
#sed -i '131a\pasv_max_port=50100' /etc/vsftpd/vsftpd.conf
#sed -i '132a\allow_writeable_chroot=YES' /etc/vsftpd/vsftpd.conf
#service vsftpd restart

rm -f /etc/httpd/logs
mkdir /var/log/httpd
ln -s ../../var/log/httpd /etc/httpd/logs


service httpd start


# selinux 폴더 보안 설정
# sestatus : 상태확인

# 모든 폴더 제한 해제
# service httpd stop
# chcon -R -t unconfined_exec_t /home/bbshop/www/*
# service httpd start