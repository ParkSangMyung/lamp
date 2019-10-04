Installation
============
```bash
yum -y install wget screen git
git clone https://github.com/ParkSangMyung/lamp.git
cd lamp
chmod 755 *.sh
screen -S lamp
source ./lamp.sh
```

Server Information
============
```bash
cd /lamp
./serverinfo.sh
```

VM VirtualBox Installation 
============
```bash
Server : Linux
version : Red Hat (64bit)
network : 어댑터에 브리지
controller : CentOS-7-x86_64-DVD-1810.iso 실행
download : http://isoredirect.centos.org/centos/7/isos/x86_64/CentOS-7-x86_64-DVD-1810.iso
```
```bash
centos 설치 완료 후 
vi /etc/sysconfig/network-scripts/ifcfg-enp03
ONBOOT=no => ONBOOT=yes 로 변경

현재 세션 종료 후 
설정 > 저장소 > 컨트롤러 > VBoxGuestAdditions.iso 선택 후 시작
```

Default Installation Location
=============================
| Apache Location            | Path                          | Symbolic Link                     |
|----------------------------|-----------------------------  |-----------------------------------|
| Install Prefix             | /etc/httpd/                   |                                   |
| Web root location          | /home/shop/www                |                                   |
| Main Configuration File    | /etc/httpd/conf/httpd.conf    | /usr/local/apache/conf/httpd.conf |

| PHP Location               | Path                          | Symbolic Link                     |
|----------------------------|-------------------------------|-----------------------------------|
| Install Prefix             | /usr/bin/php                  |                                   |
| Configuration File         | /etc/php.ini                  | /usr/local/php/php.ini            |


Uninstall
=============================
```bash
./remove.sh
```

Process Management
=============================
| Process   | Command                   |
|-----------|---------------------------|
| Apache    | service httpd restart     |
| network   | service network restart   |
| iptables  | systemctl restart iptables|


VM VirtualBox mount
=============================
```bash
mkdir /mnt/cdrom
mount -t auto /dev/cdrom /mnt/cdrom
cd /mnt/cdrom
./VBoxLinuxAdditions.run
mount -t vboxsf 머신폴더(관리자 설정 > 공유폴더 > 머신폴더 추가) 공유설정디렉토리
ex) mount -t vboxsf local_source /home/bbashop/www

부팅 시 자동 mount
/etc/profile 에 mount 적용
```

Window Installation
=============================
```bash
cd lamp
./window.sh
reboot
```
