#screen -X quit
service httpd restart
. ~/.bashrc

serverinfo

echo
echo -e "${REDB}L${PLAIN}${BLUEB}A${PLAIN}${GREENB}M${PALIN}${YELLOWB}P${PLAIN} ${PURPLEB}install${PLAIN} ${SKYBLUEB}completed!${PLAIN}"
echo
echo -e "${BLUEB}Completion time: $(date "+%Y-%m-%d %H:%M:%S")${PALIN} ${REDB}(Use: $[($(date +%s)-StartDateSecond)/60] minutes)${PLAIN}"
echo

screen -X quit
. ~/.bashrc