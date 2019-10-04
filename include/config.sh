RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
SKYBLUE='\033[0;36m'
PLAIN='\033[0m'
REDB='\033[0;41m'
GREENB='\033[0;42m'
YELLOWB='\033[0;43m'
BLUEB='\033[0;44m'
PURPLEB='\033[0;45m'
SKYBLUEB='\033[0;46m'
GRAYB='\033[0;7m'
# https://en.wikipedia.org/wiki/ANSI_escape_code

load_config(){

#Install location
apache_location=/etc/httpd

#Web root location
web_root_dir=/home/bbashop/www

}

get_opsy(){
    [ -f /etc/redhat-release ] && awk '{print ($1,$3~/^[0-9]/?$3:$4)}' /etc/redhat-release && return
    [ -f /etc/os-release ] && awk -F'[= "]' '/PRETTY_NAME/{print $3,$4,$5}' /etc/os-release && return
    [ -f /etc/lsb-release ] && awk -F'[="]+' '/DESCRIPTION/{print $2}' /etc/lsb-release && return
}

os_info()
{
    cname=$( awk -F: '/model name/ {name=$2} END {print name}' /proc/cpuinfo | sed 's/^[ \t]*//;s/[ \t]*$//' )
    cores=$( awk -F: '/model name/ {core++} END {print core}' /proc/cpuinfo )
    freq=$( awk -F: '/cpu MHz/ {freq=$2} END {print freq}' /proc/cpuinfo | sed 's/^[ \t]*//;s/[ \t]*$//' )
    tram=$( free -m | awk '/Mem/ {print $2}' )
    swap=$( free -m | awk '/Swap/ {print $2}' )
    up=$( awk '{a=$1/86400;b=($1%86400)/3600;c=($1%3600)/60;d=$1%60} {printf("%ddays, %d:%d:%d\n",a,b,c,d)}' /proc/uptime )
    load=$( w | head -1 | awk -F'load average:' '{print $2}' | sed 's/^[ \t]*//;s/[ \t]*$//' )
    opsy=$( get_opsy )
    arch=$( uname -m )
    lbit=$( getconf LONG_BIT )
    host=$( hostname )
    kern=$( uname -r )
    ipaddr=$(ip addr | grep global | awk '{print $2}' | cut -d/ -f1)
    ramsum=$( expr $tram + $swap )
    httpd_dir=$(httpd -V | egrep "(HTTPD\_ROOT|SERVER\_CONFIG\_FILE)")
    httpd_ver=$(httpd -v)
    php_ini=$(php --ini | grep php.ini)
    php_ver=$(php -v)
    centos=$(grep . /etc/*-release)
    iptable=$(iptables -nL)
}

serverinfo()
{
os_info
echo
echo -e "${BLUEB}+-------------------------------------------------------------------------------------+"
echo "| Auto Install LAMP(Linux + Apache + MySQL + PHP )                                            |"
echo "| Website: https://github.com/ParkSangMyung/lamp                                    |"
echo "| Author : PSM <parksang1603@naver.com>                                               |"
echo -e "+-------------------------------------------------------------------------------------+${PLAIN}"
echo
echo
echo -e "${GREEN}|--------------------------------Server Information-----------------------------------|"
echo -e "|                                                                                     |${PLAIN}"
echo -e "${YELLOW}CPU model            : ${cname}${PLAIN}"
echo -e "${BLUE}Number of cores      : ${cores}${PLAIN}"
echo -e "${PURPLE}CPU frequency        : ${freq} MHz${PLAIN}"
echo -e "${SKYBLUE}Total amount of ram  : ${tram} MB${PLAIN}"
echo -e "${RED}Total amount of swap : ${swap} MB${PLAIN}"
echo -e "${GREEN}System uptime        : ${up}${PLAIN}"
echo -e "${YELLOW}Load average         : ${load}${PLAIN}"
echo -e "${REDB}OS                   : ${opsy}${PLAIN}"
echo -e "${PURPLE}Arch                 : ${arch} (${lbit} Bit)${PLAIN}"
echo -e "${SKYBLUE}Kernel               : ${kern}${PLAIN}"
echo -e "${PURPLE}Hostname             : ${host}${PLAIN}"
echo -e "${REDB}IP address           : $(ip addr | grep global | awk '{print $2}' | cut -d/ -f1)${PLAIN}"
echo -e "${REDB}Web Root Dir         : /home/bbashop/www${PLAIN}"
echo "|                                                                                     |"
echo -e "${GREEN}|--------------------------------Server Information-----------------------------------|${PLAIN}"
echo
echo -e "${YELLOW}|--------------------------------Centos Information-----------------------------------|"
echo "|                                                                                     |"
echo -e "${centos}"
echo "|                                                                                     |"
echo -e "|--------------------------------Centos Information-----------------------------------|${PLAIN}"
echo
echo -e "${RED}|--------------------------------Apache Information-----------------------------------|"
echo "|                                                                                     |"
echo -e "${httpd_ver}"
echo
echo -e "${httpd_dir}"
echo
echo "|                                                                                     |"
echo -e "|--------------------------------Apache Information-----------------------------------|${PLAIN}"
echo
echo -e "${PURPLE}|--------------------------------PHP Information--------------------------------------|"
echo "|                                                                                     |"
echo -e "${php_ver}"
echo
echo -e "${php_ini}"
echo
echo "|                                                                                     |"
echo -e "|--------------------------------PHP Information--------------------------------------|${PLAIN}"
echo
echo -e "${SKYBLUE}|--------------------------------iptables---------------------------------------------|"
echo "|                                                                                     |"
echo -e "${iptable}"
echo "|                                                                                     |"
echo -e "|--------------------------------iptables---------------------------------------------|${PLAIN}"
echo
}
