source common.sh

print_head "Copying Mongo file"
cp ${script_location}/files/mongo.conf /etc/yum.repos.d/mongo.repo &>>${log}
status

print_head "Install Mongodb"
yum install mongodb-org -y &>>${log}
status

print_head "Enable Mongo"
systemctl enable mongod &>>${log}
status

print_head "Start Mongo"
systemctl start mongod &>>${log}
status

print_head "Change Port"
sed -i -e 's/127.0.0.1/0.0.0.0/gi' /etc/mongod.conf &>>${log}
status

print_head "Restart"
systemctl restart mongod &>>${log}
status