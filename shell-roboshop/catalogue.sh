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

systemd

schema_load
