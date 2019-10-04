# move web root - /home/bbashop/www
cd ${web_root_dir}

# git setting
git config --global user.name "PSM"
git config --global user.email "parksang1603@naver.com"

git init
git remote add origin https://github.com/ParkSangMyung/lamp/source.git
git remote update
git fetch
#git branch --set-upstream-to=origin/master master
git checkout master
git pull

# change folder authority
chmod -R 777 ${web_root_dir}/_compile
chmod -R 777 ${web_root_dir}/data
chmod -R 777 ${web_root_dir}/ep
chmod -R 777 ${web_root_dir}/excel_download

# ssh auto connection key 
#rm -f ~/.ssh/authorized_keys
#cp -f /lamp/lamp-data/authorized_keys ~/.ssh/authorized_keys
