# centos window 버전으로 변경 설정
yum groupinstall -y "Development Tools"
yum groupinstall -y "X Window System"
yum groupinstall -y "Fonts"
yum install -y kde-workspace
yum install -y gdm
yum install fonts-korean
unlink /etc/systemd/system/default.target
ln -sf /lib/systemd/system/graphical.target /etc/systemd/system/default.target
shutdown -r now