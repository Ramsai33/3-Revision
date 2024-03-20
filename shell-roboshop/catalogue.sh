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

print_head "User add"
id roboshop
if [ $? -ne 0 ]; then
  useradd roboshop &>>${log}
fi
status

print_head "creating app"
mkdir -p /app &>>${log}
status

print_head "Download Catalogue content"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>${log}
status

print_head "remove app content"
rm -rf /app/*
status

cd /app &>>${log}

print_head "UnZip"
unzip /tmp/catalogue.zip &>>${log}
status

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
