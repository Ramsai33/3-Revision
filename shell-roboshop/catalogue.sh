source common.sh

print_head "Disable Repo"
yum module disable nodejs -y &>>${log}
status

print_head "Enable Nodejs"
yum module enable nodejs:18 -y &>>${log}
status

print_head "InstallNodejs"
yum install nodejs -y &>>${log}
status

AppPre_req

print_head "Chnge dir"
cd /app &>>${log}
status
print_head "NPM Install"
npm install &>>${log}
status

print_head "Copy File"
cp ${script_location}/files/catalogue.conf /etc/systemd/system/catalogue.service &>>${log}
status

print_head "Demon freload"
systemctl daemon-reload &>>${log}
status

print_head "Enable service"
systemctl enable catalogue &>>${log}
status

print_head "start service"
systemctl start catalogue &>>${log}
status

print_head "Copy Mongo repo"
cp ${script_location}/files/mongo.conf /etc/yum.repos.d/mongo.repo &>>${log}
status

print_head "Install Mongo"
yum install mongodb-org-shell -y &>>${log}
status

print_head "Load Schema"
mongo --host 172.31.40.164 </app/schema/catalogue.js &>>${log}
status
